import StoreKit
import SwiftUI

/// `TipJarSheet` from `lib/widgets/tip_jar_sheet.dart`: three optional tips
/// that unlock nothing, as a native sheet.
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
        NavigationStack {
            List {
                Section {
                    choices(strings)
                } header: {
                    Text(strings.tipJarBody)
                        .font(.body)
                        .foregroundStyle(Color(.secondaryLabel))
                        .textCase(nil)
                        .padding(.bottom, 8)
                }
            }
            .appListBackground()
            .navigationTitle(strings.tipJarTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(strings.closeAction, systemImage: "xmark") { dismiss() }
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .presentationDetents([.medium, .large])
        .task { await loadProducts() }
    }

    @ViewBuilder private func choices(_ strings: Strings) -> some View {
        if loading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .accessibilityLabel(strings.tipJarLoadingLabel)
                .listRowBackground(AppColors.card)
        } else if let loadError {
            Text(message(for: loadError, strings))
                .foregroundStyle(.secondary)
                .listRowBackground(AppColors.card)
            Button(strings.tipJarTryAgainAction) { Task { await loadProducts() } }
                .listRowBackground(AppColors.card)
        } else {
            ForEach(products, id: \.id) { product in
                TipChoice(product: product, disabled: purchaseInFlight) {
                    Task { await tip(product) }
                }
                .listRowBackground(AppColors.card)
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

/// `_TipChoice`: one tip, with its price on a capsule button as the App
/// Store shows prices.
private struct TipChoice: View {
    let product: Product
    let disabled: Bool
    let action: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let copy = TipJarSheet.copy(for: product.id, strings)
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(copy.title).font(.headline)
                if !copy.description.isEmpty {
                    Text(copy.description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button(product.displayPrice, action: action)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .fontWeight(.semibold)
                .disabled(disabled)
                .accessibilityLabel(strings.tipChoiceSemantics(title: copy.title, price: product.displayPrice,
                                                               description: copy.description))
                .accessibilityHint(strings.tipChoiceHint)
        }
        .padding(.vertical, 4)
    }
}
