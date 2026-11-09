import StoreKit
import SwiftUI

/// `PaywallSheet` from `lib/widgets/paywall_sheet.dart`: sells the one-time
/// Patterns Pro unlock. Present it with `bottomPanel`.
struct PaywallSheet: View {
    var entryPoint: ProEntryPoint = .settings

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @Environment(\.purchase) private var purchase

    @State private var product: Product?
    @State private var loadError: PurchaseStore.LoadError?
    @State private var loading = true
    @State private var purchaseInFlight = false

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                AccentIconBadge(systemImage: "lock.open")
                Text(strings.proPaywallTitle)
                    .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text(entryPoint.headline(strings))
                .textRole(.bodyMedium, color: AppColors.textSecondary)
                .padding(.top, 12)
            // Someone who already bought Pro and reinstalled arrives here
            // looking at a price they have already paid. Say so before the
            // price, not in a quiet button underneath it.
            AlreadyPurchasedRow(disabled: purchaseInFlight) { Task { await restore() } }
                .padding(.top, 12)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(entryPoint.benefits(strings), id: \.self) { point in
                    ProPoint(text: point)
                }
            }
            .padding(.top, 18)
            Text(strings.proPaywallIncludedTools)
                .textRole(.bodySmall, color: AppColors.textSecondary)
                .padding(.top, 16)
            purchaseArea(strings)
                .padding(.top, 10)
        }
        .task { await loadProduct() }
        .onChange(of: model.store.backgroundUnlockCount) {
            // An Ask to Buy approval or a purchase finished on another
            // device can land while the sheet is open.
            if model.proUnlocked { finish(restored: false) }
        }
    }

    @ViewBuilder private func purchaseArea(_ strings: Strings) -> some View {
        if loading {
            ProgressView()
                .tint(AppColors.accent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .accessibilityLabel(strings.proPaywallLoadingLabel)
        } else if let loadError {
            VStack(alignment: .leading, spacing: 0) {
                Text(message(for: loadError, strings))
                    .textRole(.bodyMedium, color: AppColors.textSecondary)
                Button(strings.proPaywallTryAgainAction) { Task { await loadProduct() } }
                    .buttonStyle(SecondaryButtonStyle(fullWidth: true))
                    .padding(.top, 16)
                Button(strings.proPaywallRestorePurchasesAction) { Task { await restore() } }
                    .buttonStyle(TextLinkButtonStyle())
                    .frame(maxWidth: .infinity)
                    .disabled(purchaseInFlight)
                    .padding(.top, 8)
            }
        } else {
            VStack(spacing: 8) {
                Button { Task { await buy() } } label: {
                    if purchaseInFlight {
                        ProgressView().tint(AppColors.onAccent)
                    } else {
                        Text(product.map { strings.proPaywallUnlockWithPrice(price: $0.displayPrice) }
                            ?? strings.proPaywallUnlockAction)
                    }
                }
                .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                .disabled(purchaseInFlight)
                Button(strings.proPaywallRestorePurchasesAction) { Task { await restore() } }
                    .buttonStyle(TextLinkButtonStyle())
                    .disabled(purchaseInFlight)
            }
        }
    }

    private func message(for error: PurchaseStore.LoadError, _ strings: Strings) -> String {
        switch error {
        case .purchasesUnavailable: strings.proPaywallPurchasesUnavailable
        case .productUnavailable: strings.proPaywallProductUnavailable
        case .failed: strings.proPaywallProductLoadFailed
        }
    }

    private func loadProduct() async {
        loading = true
        loadError = nil
        do {
            product = try await model.store.loadProProduct()
        } catch {
            product = nil
            loadError = error
        }
        loading = false
    }

    private func buy() async {
        guard let product, !purchaseInFlight else { return }
        let strings = model.strings
        purchaseInFlight = true
        do {
            let result = try await purchase(product)
            switch await model.store.completeProPurchase(result) {
            case .unlocked:
                finish(restored: false)
            case .cancelled, .pending:
                purchaseInFlight = false
            case .failed:
                purchaseInFlight = false
                navigation.showToast(strings.proPaywallPurchaseFailed, kind: .error)
            }
        } catch StoreKitError.userCancelled {
            purchaseInFlight = false
        } catch is Product.PurchaseError {
            // Refused before the store sheet opened.
            purchaseInFlight = false
            navigation.showToast(strings.proPaywallPurchaseStartFailed, kind: .error)
        } catch {
            purchaseInFlight = false
            navigation.showToast(strings.proPaywallPurchaseFailed, kind: .error)
        }
    }

    private func restore() async {
        guard !purchaseInFlight else { return }
        let strings = model.strings
        purchaseInFlight = true
        let outcome = await model.store.restore()
        purchaseInFlight = false
        switch outcome {
        case .restored:
            finish(restored: true)
        case .notFound:
            navigation.showToast(strings.proPaywallRestoreNotFound, kind: .info)
        case .failed:
            navigation.showToast(strings.proPaywallRestoreFailed, kind: .error)
        case .cancelled:
            break
        }
    }

    private func finish(restored: Bool) {
        purchaseInFlight = false
        dismiss()
        navigation.dialog = .proUnlocked(restored: restored)
    }
}

/// `_AlreadyPurchasedRow`: reassurance for a returning purchaser, above the
/// price.
private struct AlreadyPurchasedRow: View {
    let disabled: Bool
    let onRestore: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize
    @State private var width: CGFloat = 320

    var body: some View {
        let strings = model.strings
        let message = Text(strings.proPaywallAlreadyPurchased)
            .textRole(.bodySmall, size: 13, color: AppColors.textSecondary)
        let button = Button(strings.proPaywallRestoreShortAction, action: onRestore)
            .buttonStyle(TextLinkButtonStyle())
            .disabled(disabled)
        Group {
            if typeSize >= .xxxLarge || width < 300 {
                VStack(alignment: .leading, spacing: 4) {
                    message
                    button.frame(maxWidth: .infinity, alignment: .trailing)
                }
            } else {
                HStack(spacing: 8) {
                    message.frame(maxWidth: .infinity, alignment: .leading)
                    button
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(AppColors.border))
        .onGeometryChange(for: CGFloat.self) { $0.size.width - 24 } action: { width = $0 }
    }
}

/// `_ProPoint`: a check mark and one benefit.
private struct ProPoint: View {
    let text: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Image(systemName: "checkmark")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.accent)
                .accessibilityHidden(true)
            Text(text)
                .textRole(.bodyMedium, color: AppColors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
