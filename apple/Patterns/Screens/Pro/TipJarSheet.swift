import StoreKit
import SwiftUI

/// `TipJarSheet` from `lib/widgets/tip_jar_sheet.dart`: three optional tips
/// that unlock nothing. Present it with `bottomPanel`.
struct TipJarSheet: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @Environment(\.purchase) private var purchase

    @State private var products: [Product] = []
    @State private var loadError: PurchaseStore.LoadError?
    @State private var loading = true
    @State private var purchaseInFlight = false

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                AccentIconBadge(systemImage: "heart")
                Text(strings.tipJarTitle)
                    .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text(strings.tipJarBody)
                .textRole(.bodyMedium, color: AppColors.textSecondary)
                .padding(.top, 12)
            choices(strings)
                .padding(.top, 20)
        }
        .task { await loadProducts() }
    }

    @ViewBuilder private func choices(_ strings: Strings) -> some View {
        if loading {
            ProgressView()
                .tint(AppColors.accent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .accessibilityLabel(strings.tipJarLoadingLabel)
        } else if let loadError {
            VStack(alignment: .leading, spacing: 16) {
                Text(message(for: loadError, strings))
                    .textRole(.bodyMedium, color: AppColors.textSecondary)
                Button(strings.tipJarTryAgainAction) { Task { await loadProducts() } }
                    .buttonStyle(SecondaryButtonStyle(fullWidth: true))
            }
        } else {
            VStack(spacing: 10) {
                ForEach(products, id: \.id) { product in
                    TipChoice(product: product, disabled: purchaseInFlight) {
                        Task { await tip(product) }
                    }
                }
            }
        }
    }

    private func message(for error: PurchaseStore.LoadError, _ strings: Strings) -> String {
        switch error {
        case .purchasesUnavailable: strings.tipJarPurchasesUnavailable
        case .productUnavailable: strings.tipJarOptionsUnavailable
        case .failed: strings.tipJarLoadFailed
        }
    }

    private func loadProducts() async {
        loading = true
        loadError = nil
        do {
            products = try await model.store.loadTips()
        } catch {
            products = []
            loadError = error
        }
        loading = false
    }

    private func tip(_ product: Product) async {
        guard !purchaseInFlight else { return }
        let strings = model.strings
        purchaseInFlight = true
        do {
            let result = try await purchase(product)
            switch await model.store.completeTip(result) {
            case .unlocked:
                purchaseInFlight = false
                dismiss()
                navigation.dialog = .tipThanks
            case .cancelled, .pending:
                purchaseInFlight = false
            case .failed:
                purchaseInFlight = false
                navigation.showToast(strings.tipJarPurchaseFailed, kind: .error)
            }
        } catch StoreKitError.userCancelled {
            purchaseInFlight = false
        } catch {
            purchaseInFlight = false
            navigation.showToast(strings.tipJarPurchaseFailed, kind: .error)
        }
    }

    /// The in-app title and description for each tip. The store supplies
    /// only the price, as in Flutter's `localizedCopy`.
    static func copy(for productID: String, _ strings: Strings) -> (title: String, description: String) {
        switch productID {
        case PurchaseStore.tipProductIDs[0]: (strings.tipSmallTitle, strings.tipSmallDescription)
        case PurchaseStore.tipProductIDs[1]: (strings.tipMediumTitle, strings.tipMediumDescription)
        default: (strings.tipLargeTitle, strings.tipLargeDescription)
        }
    }
}

/// `_TipChoice`: one tip with its price, stacking at large text sizes.
private struct TipChoice: View {
    let product: Product
    let disabled: Bool
    let action: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let copy = TipJarSheet.copy(for: product.id, strings)
        Button(action: action) {
            let details = VStack(alignment: .leading, spacing: 4) {
                Text(copy.title)
                    .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
                if !copy.description.isEmpty {
                    Text(copy.description)
                        .textRole(.bodySmall, size: 13, color: AppColors.textSecondary)
                }
            }
            let price = Text(product.displayPrice)
                .textRole(.titleMedium, weight: .heavy, color: AppColors.accent)
            Group {
                if typeSize >= .xxxLarge {
                    VStack(alignment: .leading, spacing: 10) {
                        details
                        price.frame(maxWidth: .infinity, alignment: .trailing)
                    }
                } else {
                    HStack(spacing: 12) {
                        details.frame(maxWidth: .infinity, alignment: .leading)
                        price
                    }
                }
            }
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
            .background(AppColors.card, in: .rect(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(AppColors.border))
        }
        .buttonStyle(PressScaleStyle(scale: 0.98))
        .disabled(disabled)
        .opacity(disabled ? 0.5 : 1)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.tipChoiceSemantics(title: copy.title, price: product.displayPrice, description: copy.description))
        .accessibilityHint(strings.tipChoiceHint)
        .accessibilityAddTraits(.isButton)
    }
}
