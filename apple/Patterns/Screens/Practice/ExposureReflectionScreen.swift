import PatternsCore
import SwiftUI

/// `ExposureReflectionScreen` from `lib/mobile/screens/exposure_reflection_screen.dart`:
/// what happened in an exposure, what OCD predicted, what actually
/// happened, and what to carry forward. Pro.
struct ExposureReflectionScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var reflections: Loadable<[ExposureReflection]> = .loading
    @State private var writing = false
    @State private var deleting: ExposureReflection?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureReflectionText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "exposureReflection")
            Section {
                switch reflections {
                case .loading:
                    ProgressView().frame(maxWidth: .infinity)
                case .failed:
                    Text(text("loadError")).foregroundStyle(.secondary)
                case let .loaded(items) where items.isEmpty:
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "book").font(.title2).foregroundStyle(AppColors.accent)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        Button(text("emptyAction")) { writing = true }
                            .buttonStyle(.accentProminent)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                case let .loaded(items):
                    ForEach(items, id: \.id) { reflection in
                        ReflectionRow(reflection: reflection)
                            .swipeActions {
                                Button(text("deleteAction"), systemImage: "trash") {
                                    deleting = reflection
                                }
                                .tint(.red)
                            }
                            .contextMenu {
                                Button(text("deleteTooltip"), systemImage: "trash", role: .destructive) {
                                    deleting = reflection
                                }
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
                Button(text("newAction"), systemImage: "plus") { writing = true }
            }
        }
        .liveQuery(model.database, into: $reflections) { db in try ExposureReflection.all().fetchAll(db) }
        .sheet(isPresented: $writing) { ReflectionEditor() }
        .alert(text("deleteTitle"), isPresented: Binding(
            get: { deleting != nil }, set: { if !$0 { deleting = nil } }
        ), presenting: deleting) { reflection in
            Button(text("cancel"), role: .cancel) {}
            Button(text("deleteAction"), role: .destructive) { delete(reflection) }
        } message: { _ in
            Text(text("deleteBody"))
        }
    }

    private func delete(_ reflection: ExposureReflection) {
        guard let id = reflection.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteExposureReflection(id: id)
            navigation.showToast(strings.exposureReflectionText(key: "deleteSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.exposureReflectionText(key: "deleteError"), kind: .error)
        }
    }
}

private struct ReflectionRow: View {
    let reflection: ExposureReflection
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let date = reflection.datetime.date().map(strings.dates.monthDay) ?? ""
        VStack(alignment: .leading, spacing: 4) {
            Text(reflection.whatHappened).font(.headline)
            Text(date).font(.footnote).foregroundStyle(Color(.secondaryLabel))
            if !reflection.whatILearned.trimmingCharacters(in: .whitespaces).isEmpty {
                Text(reflection.whatILearned)
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(strings.exposureReflectionCardSummary(date: date, whatHappened: reflection.whatHappened))
    }
}

/// `ExposureReflectionEditScreen` as a native sheet.
private struct ReflectionEditor: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var whatHappened = ""
    @State private var predicted = ""
    @State private var actual = ""
    @State private var learned = ""
    @State private var nextTime = ""
    @State private var saving = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureReflectionText(key: key) }
        NavigationStack {
            Form {
                field(text("whatHappenedLabel"), text("whatHappenedHint"), $whatHappened)
                field(text("predictionLabel"), text("predictionHint"), $predicted)
                field(text("actualLabel"), text("actualHint"), $actual)
                field(text("learningLabel"), text("learningHint"), $learned)
                field(text("nextTimeLabel"), text("nextTimeHint"), $nextTime)
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
        .interactiveDismissDisabled(![whatHappened, predicted, actual, learned, nextTime].allSatisfy(\.isEmpty))
    }

    private func field(_ label: String, _ hint: String, _ value: Binding<String>) -> some View {
        Section(label) {
            TextField(label, text: value, prompt: Text(hint), axis: .vertical)
                .lineLimit(2...6)
                .listRowBackground(AppColors.card)
        }
    }

    private func save() {
        let strings = model.strings
        let trim = { (value: String) in value.trimmingCharacters(in: .whitespacesAndNewlines) }
        guard !trim(whatHappened).isEmpty else {
            return navigation.showToast(strings.exposureReflectionText(key: "validation"), kind: .info)
        }
        saving = true
        let now = DartTimestamp.now()
        let reflection = ExposureReflection(datetime: now, whatHappened: trim(whatHappened), ocdPredicted: trim(predicted),
                                            actuallyHappened: trim(actual), whatILearned: trim(learned),
                                            doDifferently: trim(nextTime), createdAt: now)
        do {
            try model.database.insertExposureReflection(reflection)
        } catch {
            saving = false
            navigation.showToast(strings.exposureReflectionText(key: "saveError"), kind: .error)
            return
        }
        dismiss()
        navigation.showToast(strings.exposureReflectionText(key: "saveSuccess"), kind: .success)
    }
}
