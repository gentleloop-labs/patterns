import PatternsCore
import StoreKit
import StoreKitTest
import XCTest
@testable import Patterns

/// Runs `PurchaseStore` against the local `Patterns.storekit` configuration.
@MainActor
final class PurchaseStoreTests: XCTestCase {
    private var session: SKTestSession!
    private var defaults: UserDefaults!
    private var suiteName: String!

    override func setUp() async throws {
        session = try SKTestSession(configurationFileNamed: "Patterns")
        session.resetToDefaultState()
        session.clearTransactions()
        session.disableDialogs = true
        suiteName = "PurchaseStoreTests.\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)
    }

    override func tearDown() async throws {
        session.clearTransactions()
        defaults.removePersistentDomain(forName: suiteName)
    }

    private func makeStore(cached: Bool? = nil) -> (PurchaseStore, FlutterPreferences) {
        let prefs = FlutterPreferences(defaults: defaults)
        if let cached { prefs.set(cached, for: PreferenceKey.proUnlocked) }
        return (PurchaseStore(prefs: prefs), prefs)
    }

    /// `SKTestSession` can only simulate purchases when StoreKit testing is
    /// reachable; from `xcodebuild` on some simulator runtimes every session
    /// call fails with SKInternalErrorDomain 3. Tests that need it skip
    /// rather than hang on a real store sheet. Run them from Xcode.
    private func requireTestSession() async throws {
        do {
            try await session.buyProduct(identifier: PurchaseStore.tipProductIDs[0])
            session.clearTransactions()
        } catch {
            throw XCTSkip("StoreKit test session unavailable here: \(error)")
        }
    }

    private func waitUntil(_ condition: @MainActor () -> Bool, timeout: Duration = .seconds(10)) async {
        let deadline = ContinuousClock.now + timeout
        while !condition(), ContinuousClock.now < deadline {
            try? await Task.sleep(for: .milliseconds(100))
        }
    }

    func testLoadsProductAndTipsCheapestFirst() async throws {
        try await requireTestSession()
        let (store, _) = makeStore()
        let pro = try await store.loadProProduct()
        XCTAssertEqual(pro.id, PurchaseStore.proProductID)
        let tips = try await store.loadTips()
        XCTAssertEqual(tips.map(\.id), PurchaseStore.tipProductIDs)
    }

    /// A cached unlock is honoured with no store entitlement at all, as when
    /// the store is unreachable.
    func testCachedUnlockSurvivesMissingEntitlement() async {
        let (store, prefs) = makeStore(cached: true)
        store.start()
        await store.reconcile(force: true)
        XCTAssertTrue(store.proUnlocked)
        XCTAssertEqual(prefs.bool(PreferenceKey.proUnlocked), true)
    }

    /// A purchase made outside the app (the Flutter build, another device,
    /// an offer code) unlocks Pro, and a refund takes it away again.
    func testOutsidePurchaseUnlocksAndRefundRevokes() async throws {
        try await requireTestSession()
        let (store, prefs) = makeStore()
        store.start()
        XCTAssertFalse(store.proUnlocked)

        try await session.buyProduct(identifier: PurchaseStore.proProductID)
        await waitUntil { store.proUnlocked }
        XCTAssertTrue(store.proUnlocked)
        XCTAssertEqual(prefs.bool(PreferenceKey.proUnlocked), true)
        XCTAssertEqual(store.backgroundUnlockCount, 1)

        let transaction = try XCTUnwrap(session.allTransactions().first { $0.productIdentifier == PurchaseStore.proProductID })
        try session.refundTransaction(identifier: transaction.identifier)
        await waitUntil { !store.proUnlocked }
        XCTAssertFalse(store.proUnlocked)
        XCTAssertEqual(prefs.bool(PreferenceKey.proUnlocked), false)
    }

    /// An existing entitlement found at launch unlocks Pro, as after a
    /// reinstall or a wipe.
    func testLaunchReconciliationGrantsExistingEntitlement() async throws {
        try await requireTestSession()
        try await session.buyProduct(identifier: PurchaseStore.proProductID)
        let (store, _) = makeStore()
        store.start()
        await waitUntil { store.proUnlocked }
        XCTAssertTrue(store.proUnlocked)
    }

    func testRestoreFindsPurchase() async throws {
        try await requireTestSession()
        try await session.buyProduct(identifier: PurchaseStore.proProductID)
        let (store, _) = makeStore()
        let outcome = await store.restore()
        XCTAssertEqual(outcome, .restored)
        XCTAssertTrue(store.proUnlocked)
    }

    func testRestoreWithNothingToRestore() async throws {
        try await requireTestSession()
        let (store, _) = makeStore()
        let outcome = await store.restore()
        XCTAssertTrue(outcome == .notFound || outcome == .failed, "\(outcome)")
        XCTAssertFalse(store.proUnlocked)
    }

    func testPurchaseThroughTheAppUnlocks() async throws {
        try await requireTestSession()
        let (store, prefs) = makeStore()
        let product = try await store.loadProProduct()
        let result = try await product.purchase()
        let outcome = await store.completeProPurchase(result)
        XCTAssertEqual(outcome, .unlocked)
        XCTAssertTrue(store.proUnlocked)
        XCTAssertEqual(prefs.bool(PreferenceKey.proUnlocked), true)
    }

    func testTipIsFinishedAndUnlocksNothing() async throws {
        try await requireTestSession()
        let (store, _) = makeStore()
        let tip = try await store.loadTips()[0]
        let result = try await tip.purchase()
        let outcome = await store.completeTip(result)
        XCTAssertEqual(outcome, .unlocked)
        XCTAssertFalse(store.proUnlocked)
        var unfinished = 0
        for await _ in Transaction.unfinished { unfinished += 1 }
        XCTAssertEqual(unfinished, 0)
    }
}
