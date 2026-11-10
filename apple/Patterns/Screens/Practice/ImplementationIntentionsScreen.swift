import PatternsCore
import SwiftUI

/// `ImplementationIntentionsScreen` from
/// `lib/mobile/screens/implementation_intentions_screen.dart`: "if this
/// happens, then I will..." plans. Pro.
struct ImplementationIntentionsScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var intentions: Loadable<[ImplementationIntention]> = .loading
    @State private var creating = false
    @State private var deleting: ImplementationIntention?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.implementationIntentionText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "implementationIntentions")
            Section {
                switch intentions {
                case .loading:
                    ProgressView().frame(maxWidth: .infinity)
                case .failed:
                    Text(text("loadError")).foregroundStyle(.secondary)
                case let .loaded(items) where items.isEmpty:
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "lightbulb").font(.title2).foregroundStyle(AppColors.accent)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        Button(text("emptyAction")) { creating = true }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                case let .loaded(items):
                    ForEach(items, id: \.id) { intention in
                        Text(strings.implementationIntentionStatement(trigger: intention.trigger, response: intention.response))
                            .font(.body)
                            .padding(.vertical, 4)
                            .swipeActions {
                                Button(text("deleteAction"), systemImage: "trash") { deleting = intention }
                                    .tint(.red)
                            }
                            .contextMenu {
                                Button(text("deleteTooltip"), systemImage: "trash", role: .destructive) { deleting = intention }
                            }
                    }
                }
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(text("newAction"), systemImage: "plus") { creating = true }
            }
        }
        .liveQuery(model.database, into: $intentions) { db in try ImplementationIntention.all().fetchAll(db) }
        .sheet(isPresented: $creating) { IntentionEditor() }
        .alert(text("deleteTitle"), isPresented: Binding(
            get: { deleting != nil }, set: { if !$0 { deleting = nil } }
        ), presenting: deleting) { intention in
            Button(text("cancel"), role: .cancel) {}
            Button(text("deleteAction"), role: .destructive) { delete(intention) }
        } message: { _ in
            Text(text("deleteBody"))
        }
    }

    private func delete(_ intention: ImplementationIntention) {
        guard let id = intention.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteImplementationIntention(id: id)
            navigation.showToast(strings.implementationIntentionText(key: "deleteSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.implementationIntentionText(key: "deleteError"), kind: .error)
        }
    }
}

private struct IntentionEditor: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var trigger = ""
    @State private var response = ""
    @State private var saving = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.implementationIntentionText(key: key) }
        NavigationStack {
            Form {
                Section(text("triggerLabel")) {
                    TextField(text("triggerLabel"), text: $trigger, prompt: Text(text("triggerHint")), axis: .vertical)
                        .lineLimit(1...4)
                        // Both halves read inside one sentence.
                        .textInputAutocapitalization(.never)
                }
                .listRowBackground(AppColors.card)
                Section(text("responseLabel")) {
                    TextField(text("responseLabel"), text: $response, prompt: Text(text("responseHint")), axis: .vertical)
                        .lineLimit(1...4)
                        // Both halves read inside one sentence.
                        .textInputAutocapitalization(.never)
                }
                .listRowBackground(AppColors.card)
            }
            .appListBackground()
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(text("editorTitle"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(text("cancel")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(text("saveAction"), action: save)
                        .fontWeight(.semibold)
                        .disabled(saving)
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .interactiveDismissDisabled(!trigger.isEmpty || !response.isEmpty)
    }

    private func save() {
        let strings = model.strings
        let trim = { (value: String) in value.trimmingCharacters(in: .whitespacesAndNewlines) }
        guard !trim(trigger).isEmpty, !trim(response).isEmpty else {
            return navigation.showToast(strings.implementationIntentionText(key: "validation"), kind: .info)
        }
        saving = true
        do {
            try model.database.insertImplementationIntention(ImplementationIntention(
                trigger: trim(trigger), response: trim(response), createdAt: DartTimestamp.now()))
        } catch {
            saving = false
            navigation.showToast(strings.implementationIntentionText(key: "saveError"), kind: .error)
            return
        }
        dismiss()
        navigation.showToast(strings.implementationIntentionText(key: "saveSuccess"), kind: .success)
    }
}
