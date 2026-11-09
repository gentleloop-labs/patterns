import Foundation
import Observation
import PatternsCore
import StoreKit

/// `ProService` and `TipJarService` on StoreKit 2.
///
/// The Pro unlock is cached in `flutter.proUnlocked` and honoured offline, as
/// the Flutter app does, so a paying user is never locked out because the
/// store is unreachable. The cache is granted only from a store-signed
/// transaction, and cleared only when the store explicitly revokes the
/// purchase (a refund) and no other valid Pro entitlement remains. Purchases
/// made by the Flutter build are ordinary App Store transactions, so StoreKit
/// 2 sees them too.
@MainActor
@Observable
final class PurchaseStore {
    static let proProductID = "com.maskedsyntax.patterns.pro"
    static let tipProductIDs = [
        "com.maskedsyntax.patterns.tip.small",
        "com.maskedsyntax.patterns.tip.medium",
        "com.maskedsyntax.patterns.tip.large",
    ]

    private(set) var proUnlocked: Bool
    /// Bumped whenever a Pro unlock arrives outside a purchase the app
    /// started, such as a redeemed offer code. Settings watches it to
    /// confirm a redemption.
    private(set) var backgroundUnlockCount = 0

    /// The last products loaded this session, used as a fallback when a
    /// later load fails.
    private(set) var cachedTips: [Product]?

    private let prefs: FlutterPreferences
    private var updatesTask: Task<Void, Never>?
    private var lastReconciliation: Date?

    init(prefs: FlutterPreferences) {
        self.prefs = prefs
        proUnlocked = prefs.bool(PreferenceKey.proUnlocked) ?? false
    }

    /// Re-reads the cache after a wipe cleared the preferences.
    func reloadCachedUnlock() {
        proUnlocked = prefs.bool(PreferenceKey.proUnlocked) ?? false
    }

    /// Call once at launch: finishes transactions left over from earlier
    /// sessions (including ones the Flutter build never completed), listens
    /// for new ones, and checks the current entitlements.
    func start() {
        guard updatesTask == nil else { return }
        updatesTask = Task { [weak self] in
            for await update in Transaction.updates {
                await self?.handle(update)
            }
        }
        Task { [weak self] in
            for await unfinished in Transaction.unfinished {
                await self?.handle(unfinished)
            }
            await self?.reconcile(force: true)
        }
    }

    /// Grants Pro if the device holds a valid store-signed entitlement.
    /// Reads StoreKit's local copy, so it needs no network and never prompts.
    /// A missing entitlement never clears the cache: the store may simply
    /// not have synced. Throttled to every 15 minutes, as in Flutter.
    func reconcile(force: Bool = false) async {
        let now = Date()
        if !force, let last = lastReconciliation, now.timeIntervalSince(last) < 15 * 60 { return }
        lastReconciliation = now
        if await hasProEntitlement() { setUnlocked(true) }
    }

    // MARK: Pro

    enum LoadError: Error {
        case purchasesUnavailable, productUnavailable, failed
    }

    enum PurchaseOutcome {
        case unlocked, cancelled, pending, failed
    }

    enum RestoreOutcome {
        case restored, notFound, cancelled, failed
    }

    /// Loads the Pro product, retrying three times with a short backoff to
    /// ride out transient store failures, as the Flutter paywall does.
    func loadProProduct() async throws(LoadError) -> Product {
        guard AppStore.canMakePayments else { throw .purchasesUnavailable }
        let products = try await loadWithRetry([Self.proProductID])
        guard let product = products.first else { throw .productUnavailable }
        return product
    }

    /// Applies the result of `PurchaseAction` for the Pro product.
    func completeProPurchase(_ result: Product.PurchaseResult) async -> PurchaseOutcome {
        switch result {
        case let .success(.verified(transaction)):
            setUnlocked(true)
            await transaction.finish()
            return .unlocked
        case let .success(.unverified(transaction, _)):
            // Flutter refuses purchases without verification data.
            await transaction.finish()
            return .failed
        case .userCancelled:
            return .cancelled
        case .pending:
            return .pending
        @unknown default:
            return .failed
        }
    }

    /// Restore purchases. Asks the App Store to sync (which may prompt the
    /// user to sign in), then checks the entitlements. Flutter gave a
    /// restore 12 seconds before saying nothing was found; a sync that hangs
    /// gets the same deadline.
    func restore() async -> RestoreOutcome {
        let sync = await syncWithDeadline(seconds: 12)
        lastReconciliation = Date()
        if await hasProEntitlement() {
            setUnlocked(true)
            return .restored
        }
        switch sync {
        case .finished, .timedOut: return .notFound
        case .cancelled: return .cancelled
        case .failed: return .failed
        }
    }

    // MARK: Tip jar

    /// Loads the three tips, cheapest first. Falls back to the last loaded
    /// list when the store fails, as the Flutter tip sheet does.
    func loadTips() async throws(LoadError) -> [Product] {
        guard AppStore.canMakePayments else { throw .purchasesUnavailable }
        do throws(LoadError) {
            let products = try await loadWithRetry(Self.tipProductIDs)
                .filter { Self.tipProductIDs.contains($0.id) }
                .sorted { $0.price < $1.price }
            if !products.isEmpty {
                cachedTips = products
                return products
            }
            if let cachedTips, !cachedTips.isEmpty { return cachedTips }
            throw LoadError.productUnavailable
        } catch {
            if let cachedTips, !cachedTips.isEmpty { return cachedTips }
            throw error
        }
    }

    /// Tips are consumables: nothing to grant, only the transaction to
    /// finish.
    func completeTip(_ result: Product.PurchaseResult) async -> PurchaseOutcome {
        switch result {
        case let .success(.verified(transaction)):
            await transaction.finish()
            return .unlocked
        case let .success(.unverified(transaction, _)):
            await transaction.finish()
            return .failed
        case .userCancelled:
            return .cancelled
        case .pending:
            return .pending
        @unknown default:
            return .failed
        }
    }

    // MARK: Private

    private func handle(_ result: VerificationResult<Transaction>) async {
        switch result {
        case let .verified(transaction):
            if transaction.productID == Self.proProductID {
                if transaction.revocationDate != nil {
                    // A refund. Keep Pro if another valid entitlement exists.
                    if await !hasProEntitlement() { setUnlocked(false) }
                } else {
                    let wasUnlocked = proUnlocked
                    setUnlocked(true)
                    if !wasUnlocked { backgroundUnlockCount += 1 }
                }
            }
            await transaction.finish()
        case let .unverified(transaction, _):
            // Never grant from an unverified transaction.
            await transaction.finish()
        }
    }

    private func hasProEntitlement() async -> Bool {
        for await result in Transaction.currentEntitlements {
            if case let .verified(transaction) = result,
               transaction.productID == Self.proProductID,
               transaction.revocationDate == nil {
                return true
            }
        }
        return false
    }

    private func setUnlocked(_ unlocked: Bool) {
        guard unlocked != proUnlocked else { return }
        prefs.set(unlocked, for: PreferenceKey.proUnlocked)
        proUnlocked = unlocked
    }

    private func loadWithRetry(_ ids: [String]) async throws(LoadError) -> [Product] {
        let maxAttempts = 3
        for attempt in 1...maxAttempts {
            do {
                let products = try await Product.products(for: ids)
                if !products.isEmpty || attempt == maxAttempts { return products }
            } catch {
                if attempt == maxAttempts { throw .failed }
            }
            try? await Task.sleep(for: .milliseconds(400 * attempt))
        }
        return []
    }

    private enum SyncResult {
        case finished, timedOut, cancelled, failed
    }

    /// `AppStore.sync()` raced against a deadline. The losing task is left
    /// to finish on its own, since StoreKit's sync does not support
    /// cancellation.
    private func syncWithDeadline(seconds: Int) async -> SyncResult {
        let gate = ResumeOnce()
        return await withCheckedContinuation { continuation in
            Task { @MainActor in
                let result: SyncResult
                do {
                    try await AppStore.sync()
                    result = .finished
                } catch StoreKitError.userCancelled {
                    result = .cancelled
                } catch {
                    result = .failed
                }
                if gate.claim() { continuation.resume(returning: result) }
            }
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(seconds))
                if gate.claim() { continuation.resume(returning: .timedOut) }
            }
        }
    }
}

@MainActor
private final class ResumeOnce {
    private var claimed = false

    func claim() -> Bool {
        if claimed { return false }
        claimed = true
        return true
    }
}
