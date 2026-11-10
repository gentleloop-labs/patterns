import StoreKit
import SwiftUI

/// `PaywallSheet` from `lib/widgets/paywall_sheet.dart`: sells the one-time
/// Patterns Pro unlock, as a native sheet.
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
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Image(systemName: "lock.open.fill")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(AppColors.accent)
                        .frame(width: 72, height: 72)
                        .background(AppColors.accent.opacity(0.14), in: .rect(cornerRadius: 18))
                        .accessibilityHidden(true)
                    Text(strings.proPaywallTitle)
                        .textRole(.displaySmall, color: AppColors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                        .padding(.top, 16)
                    Text(entryPoint.headline(strings))
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .padding(.top, 8)
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(entryPoint.benefits(strings), id: \.self) { point in
                            Label {
                                Text(point)
                            } icon: {
                                Image(systemName: "checkmark.circle.fill").foregroundStyle(AppColors.accent)
                            }
                        }
                    }
                    .padding(.top, 22)
                    Text(strings.proPaywallIncludedTools)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.top, 18)
                    // Someone who already bought Pro and reinstalled arrives
                    // here looking at a price they have already paid. Say so
                    // before the price, not in a quiet button underneath it.
                    AlreadyPurchasedRow(disabled: purchaseInFlight) { Task { await restore() } }
                        .padding(.top, 22)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 20)
            }
            .safeAreaInset(edge: .bottom) {
                purchaseArea(strings)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    .background(.bar)
            }
            .background(AppColors.surface)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(strings.closeAction, systemImage: "xmark") { dismiss() }
                        .disabled(purchaseInFlight)
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
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
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .accessibilityLabel(strings.proPaywallLoadingLabel)
        } else if let loadError {
            VStack(spacing: 10) {
                Text(message(for: loadError, strings))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button { Task { await loadProduct() } } label: {
                    Text(strings.proPaywallTryAgainAction).frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                Button(strings.proPaywallRestorePurchasesAction) { Task { await restore() } }
                    .disabled(purchaseInFlight)
            }
        } else {
            VStack(spacing: 10) {
                Button { Task { await buy() } } label: {
                    Group {
                        if purchaseInFlight {
                            ProgressView().tint(AppColors.onAccent)
                        } else {
                            Text(product.map { strings.proPaywallUnlockWithPrice(price: $0.displayPrice) }
                                ?? strings.proPaywallUnlockAction)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.accentProminent)
                .controlSize(.large)
                .disabled(purchaseInFlight)
                Button(strings.proPaywallRestorePurchasesAction) { Task { await restore() } }
                    .font(.subheadline)
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

/// `_AlreadyPurchasedRow`: reassurance for a returning purchaser.
private struct AlreadyPurchasedRow: View {
    let disabled: Bool
    let onRestore: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 8) {
                Text(strings.proPaywallAlreadyPurchased)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(strings.proPaywallRestoreShortAction, action: onRestore)
                    .fontWeight(.semibold)
                    .disabled(disabled)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(strings.proPaywallAlreadyPurchased)
                    .foregroundStyle(.secondary)
                Button(strings.proPaywallRestoreShortAction, action: onRestore)
                    .fontWeight(.semibold)
                    .disabled(disabled)
            }
        }
        .font(.subheadline)
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.card, in: .rect(cornerRadius: 12))
    }
}
