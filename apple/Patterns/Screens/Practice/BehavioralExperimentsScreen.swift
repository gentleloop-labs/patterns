import PatternsCore
import SwiftUI

/// `BehavioralExperimentsScreen` from
/// `lib/mobile/screens/behavioral_experiments_screen.dart`: write down what
/// OCD predicts and how sure you are, test it, then record what happened.
/// Pro.
struct BehavioralExperimentsScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var experiments: Loadable<[BehavioralExperiment]> = .loading
    @State private var editing: ExperimentEditorItem?
    @State private var deleting: BehavioralExperiment?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.behavioralExperimentText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "behavioralExperiments")
            switch experiments {
            case .loading:
                ProgressView().frame(maxWidth: .infinity).listRowBackground(Color.clear)
            case .failed:
                Text(text("loadError")).foregroundStyle(AppColors.textSecondary).listRowBackground(AppColors.card)
            case let .loaded(items) where items.isEmpty:
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "flask").font(.title2).foregroundStyle(AppColors.accent).accessibilityHidden(true)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(AppColors.textSecondary)
                        Button(text("emptyAction")) { editing = ExperimentEditorItem(existing: nil) }
                            .buttonStyle(.accentProminent)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                }
                .listRowBackground(AppColors.card)
            case let .loaded(items):
                // One section per experiment, so a planned one can carry its
                // "record what happened" button.
                ForEach(items, id: \.id) { experiment in
                    Section {
                        ExperimentRow(experiment: experiment) { editing = ExperimentEditorItem(existing: experiment) }
                            .swipeActions {
                                Button(text("deleteAction"), systemImage: "trash") { deleting = experiment }
                                    .tint(.red)
                            }
                            .contextMenu {
                                Button(text("deleteTooltip"), systemImage: "trash", role: .destructive) { deleting = experiment }
                            }
                    }
                    .listRowBackground(AppColors.card)
                }
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(text("newAction"), systemImage: "plus") { editing = ExperimentEditorItem(existing: nil) }
            }
        }
        .liveQuery(model.database, into: $experiments) { db in try BehavioralExperiment.all().fetchAll(db) }
        .sheet(item: $editing) { item in ExperimentEditor(existing: item.existing) }
        .alert(text("deleteTitle"), isPresented: Binding(
            get: { deleting != nil }, set: { if !$0 { deleting = nil } }
        ), presenting: deleting) { experiment in
            Button(text("cancel"), role: .cancel) {}
            Button(text("deleteAction"), role: .destructive) { delete(experiment) }
        } message: { _ in
            Text(text("deleteBody"))
        }
    }

    private func delete(_ experiment: BehavioralExperiment) {
        guard let id = experiment.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteBehavioralExperiment(id: id)
            navigation.showToast(strings.behavioralExperimentText(key: "deleteSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.behavioralExperimentText(key: "deleteError"), kind: .error)
        }
    }
}

/// A new experiment, or a planned one to record the outcome for.
private struct ExperimentEditorItem: Identifiable {
    let existing: BehavioralExperiment?
    var id: String { existing?.id.map(String.init) ?? "new" }
}

private struct ExperimentRow: View {
    let experiment: BehavioralExperiment
    let onRecord: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.behavioralExperimentText(key: key) }
        let completed = experiment.status == .completed
        let status = text(completed ? "statusCompleted" : "statusPlanned")
        let confidence = strings.behavioralExperimentConfidence(percent: strings.dates.wholePercent(experiment.confidence))
        let date = experiment.datetime.date().map(strings.dates.monthDay) ?? ""
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Label(status, systemImage: completed ? "checkmark.circle" : "clock")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppColors.accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(AppColors.accent.opacity(0.14), in: .capsule)
                    Text(confidence).font(.caption.weight(.semibold))
                    Text(date).font(.caption).foregroundStyle(AppColors.textSecondary)
                }
                Text(experiment.fearPrediction).font(.headline)
                Text(experiment.experiment).font(.subheadline).foregroundStyle(AppColors.textSecondary)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(strings.behavioralExperimentCardSummary(
                status: status, date: date, confidence: confidence,
                prediction: experiment.fearPrediction, experiment: experiment.experiment))
            if completed {
                block(text("outcomeLabel"), experiment.outcome ?? "")
                if let learning = experiment.learning, !learning.trimmingCharacters(in: .whitespaces).isEmpty {
                    block(text("learningLabel"), learning)
                }
            } else {
                Button(action: onRecord) {
                    Text(text("recordAction")).frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 6)
    }

    private func block(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption2.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(AppColors.textSecondary)
            Text(value).font(.subheadline)
        }
        .accessibilityElement(children: .combine)
    }
}

/// `BehavioralExperimentEditScreen`: a new plan, or, for a planned one,
/// what happened and what you learned.
private struct ExperimentEditor: View {
    let existing: BehavioralExperiment?

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var prediction = ""
    @State private var experiment = ""
    @State private var confidence: Double = 70
    @State private var outcome = ""
    @State private var learning = ""
    @State private var saving = false

    private var outcomeMode: Bool { existing != nil }

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.behavioralExperimentText(key: key) }
        NavigationStack {
            Form {
                if let existing {
                    Section {
                        summary(text("predictedLabel"), existing.fearPrediction)
                        summary(text("testActionLabel"), existing.experiment)
                    }
                    .listRowBackground(AppColors.card)
                    field(text("outcomeInputLabel"), text("outcomeInputHint"), $outcome)
                    field(text("learningInputLabel"), text("learningInputHint"), $learning)
                } else {
                    field(text("predictionInputLabel"), text("predictionInputHint"), $prediction)
                    Section(text("confidenceQuestion")) {
                        let label = strings.behavioralExperimentConfidence(
                            percent: strings.dates.wholePercent(Int(confidence.rounded())))
                        VStack(alignment: .leading, spacing: 6) {
                            Text(label)
                                .font(.headline.monospacedDigit())
                                .foregroundStyle(AppColors.accent)
                                .accessibilityHidden(true)
                            Slider(value: $confidence, in: 0...100, step: 5)
                                .accessibilityLabel(text("confidenceQuestion"))
                                .accessibilityValue(label)
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(AppColors.card)
                    field(text("experimentInputLabel"), text("experimentInputHint"), $experiment)
                }
            }
            .appListBackground()
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(text(outcomeMode ? "outcomeEditorTitle" : "newEditorTitle"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(text("cancel")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(text(outcomeMode ? "saveOutcome" : "saveExperiment"), action: save)
                        .fontWeight(.semibold)
                        .disabled(saving)
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .interactiveDismissDisabled(![prediction, experiment, outcome, learning].allSatisfy(\.isEmpty))
    }

    private func summary(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption2.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(AppColors.textSecondary)
            Text(value)
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }

    private func field(_ label: String, _ hint: String, _ value: Binding<String>) -> some View {
        Section(label) {
            TextField(label, text: value, prompt: Text(hint), axis: .vertical)
                .lineLimit(2...5)
                .listRowBackground(AppColors.card)
        }
    }

    private func save() {
        let strings = model.strings
        let text = { (key: String) in strings.behavioralExperimentText(key: key) }
        let trim = { (value: String) in value.trimmingCharacters(in: .whitespacesAndNewlines) }
        if let existing {
            guard !trim(outcome).isEmpty else { return navigation.showToast(text("outcomeValidation"), kind: .info) }
            saving = true
            var updated = existing
            updated.outcome = trim(outcome)
            updated.learning = trim(learning)
            updated.statusIndex = ExperimentStatus.completed.rawValue
            finish { try model.database.updateBehavioralExperiment(updated) } success: { text("outcomeSaveSuccess") }
        } else {
            guard !trim(prediction).isEmpty, !trim(experiment).isEmpty else {
                return navigation.showToast(text("planValidation"), kind: .info)
            }
            saving = true
            let now = DartTimestamp.now()
            let record = BehavioralExperiment(datetime: now, fearPrediction: trim(prediction),
                                              confidence: Int(confidence.rounded()), experiment: trim(experiment),
                                              status: .planned, createdAt: now)
            finish { try model.database.insertBehavioralExperiment(record) } success: { text("planSaveSuccess") }
        }
    }

    private func finish(_ write: () throws -> Void, success: () -> String) {
        do {
            try write()
        } catch {
            saving = false
            navigation.showToast(model.strings.behavioralExperimentText(key: "saveError"), kind: .error)
            return
        }
        dismiss()
        navigation.showToast(success(), kind: .success)
    }
}
