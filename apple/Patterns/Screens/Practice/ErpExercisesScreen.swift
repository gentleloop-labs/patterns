import PatternsCore
import SwiftUI

/// `ErpExerciseTemplate` from `lib/mobile/screens/erp_exercises_screen.dart`.
/// Plans store the template id and an English canonical title (kept for
/// existing backups); the UI always shows the localized title.
struct ErpTemplate: Identifiable, Hashable {
    let id: String
    let defaultSeconds: Int
    let systemImage: String

    static let all: [ErpTemplate] = [
        ErpTemplate(id: "delay_checking", defaultSeconds: 5 * 60, systemImage: "checklist"),
        ErpTemplate(id: "delay_reassurance", defaultSeconds: 10 * 60, systemImage: "bubble.left"),
        ErpTemplate(id: "delay_googling", defaultSeconds: 10 * 60, systemImage: "magnifyingglass"),
        ErpTemplate(id: "delay_rumination", defaultSeconds: 5 * 60, systemImage: "brain.head.profile"),
        ErpTemplate(id: "delay_washing", defaultSeconds: 3 * 60, systemImage: "drop"),
    ]

    /// `_templateForId`: unknown ids fall back to the first template.
    static func forID(_ id: String) -> ErpTemplate { known(id) ?? all[0] }
    static func known(_ id: String) -> ErpTemplate? { all.first { $0.id == id } }

    private var key: String {
        switch id {
        case "delay_checking": "delayChecking"
        case "delay_reassurance": "delayReassurance"
        case "delay_googling": "delayGoogling"
        case "delay_rumination": "delayRumination"
        case "delay_washing": "delayWashing"
        default: "other"
        }
    }

    var canonicalTitle: String {
        switch id {
        case "delay_checking": "Delay Checking"
        case "delay_reassurance": "Delay Reassurance Seeking"
        case "delay_googling": "Delay Googling"
        case "delay_rumination": "Delay Rumination"
        case "delay_washing": "Delay Washing"
        default: "Guided ERP"
        }
    }

    func title(_ s: Strings) -> String { s.erpTemplateTitle(template: key) }
    func subtitle(_ s: Strings) -> String { s.erpTemplateSubtitle(template: key) }
    func why(_ s: Strings) -> String { s.erpTemplateWhy(template: key) }
    func exposurePrompt(_ s: Strings) -> String { s.erpTemplatePrompt(key: "\(key)Exposure") }
    func predictionPrompt(_ s: Strings) -> String { s.erpTemplatePrompt(key: "\(key)Prediction") }
    func commitmentPrompt(_ s: Strings) -> String { s.erpTemplatePrompt(key: "\(key)Commitment") }
    func cues(_ s: Strings) -> [String] { (1...3).map { s.erpTemplateCue(key: "\(key)\($0)") } }

    /// `_localizedExerciseTitle`: a known template's localized title, or
    /// the stored title for anything else.
    static func displayTitle(exerciseID: String, stored: String, _ s: Strings) -> String {
        known(exerciseID)?.title(s) ?? stored
    }

    /// `_firstRunErpPlan`: the unsaved two-minute plan the first-run ERP
    /// path practises.
    static func firstRunPlan(_ s: Strings) -> ErpExercisePlan {
        let template = known("delay_reassurance") ?? all[0]
        let now = DartTimestamp.now()
        return ErpExercisePlan(exerciseId: template.id, exerciseTitle: template.canonicalTitle,
                               triggerOrExposure: template.subtitle(s), fearPrediction: s.erpFirstRunPrediction,
                               preventionCommitment: template.cues(s).joined(separator: " · "),
                               defaultSeconds: 2 * 60, createdAt: now, updatedAt: now)
    }
}

/// `ErpExercisesScreen`: saved practice plans and recent practice.
struct ErpExercisesScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    @State private var plans: Loadable<[ErpExercisePlan]> = .loading
    @State private var sessions: Loadable<[ErpExerciseSession]> = .loading
    @State private var editing: PlanEditorItem?
    @State private var archiving: ErpExercisePlan?

    var body: some View {
        let strings = model.strings
        List {
            // An intro paragraph as a header: a row would clip it to the
            // rounded corners.
            Section {
            } header: {
                Text(strings.erpPlanText(key: "subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "guidedErp")
            plansSection(strings)
            recentSection(strings)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(strings.erpPlanText(key: "title"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(strings.erpPlanText(key: "newAction"), systemImage: "plus") { editing = PlanEditorItem(plan: nil) }
            }
        }
        .liveQuery(model.database, into: $plans) { db in try ErpExercisePlan.active().fetchAll(db) }
        .liveQuery(model.database, into: $sessions) { db in try ErpExerciseSession.all().limit(4).fetchAll(db) }
        .sheet(item: $editing) { item in ErpPlanEditor(plan: item.plan) }
        .confirmationDialog(strings.erpPlanText(key: "archiveTitle"), isPresented: Binding(
            get: { archiving != nil }, set: { if !$0 { archiving = nil } }
        ), titleVisibility: .visible, presenting: archiving) { plan in
            Button(strings.erpPlanText(key: "archiveAction"), role: .destructive) {
                if let id = plan.id { try? model.database.archiveErpPlan(id: id) }
            }
            Button(strings.erpPlanText(key: "keepAction"), role: .cancel) {}
        } message: { _ in
            Text(strings.erpPlanText(key: "archiveBody"))
        }
    }

    @ViewBuilder
    private func plansSection(_ strings: Strings) -> some View {
        Section(strings.erpPlanText(key: "myPlans")) {
            switch plans {
            case .loading:
                ProgressView().frame(maxWidth: .infinity)
            case .failed:
                Text(strings.erpPlanText(key: "plansError")).foregroundStyle(.secondary)
            case let .loaded(items) where items.isEmpty:
                VStack(alignment: .leading, spacing: 6) {
                    Text(strings.erpPlanText(key: "emptyTitle")).font(.headline)
                    Text(strings.erpPlanText(key: "emptyBody"))
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                    Button(strings.erpPlanText(key: "createAction")) { editing = PlanEditorItem(plan: nil) }
                        .buttonStyle(.accentProminent)
                        .buttonBorderShape(.capsule)
                        .padding(.top, 6)
                }
                .padding(.vertical, 6)
            case let .loaded(items):
                ForEach(items, id: \.id) { plan in
                    PlanRow(plan: plan)
                        .swipeActions {
                            Button(strings.erpPlanText(key: "archivePlanAction"), systemImage: "archivebox") { archiving = plan }
                                .tint(.orange)
                            Button(strings.erpPlanText(key: "editAction"), systemImage: "pencil") {
                                editing = PlanEditorItem(plan: plan)
                            }
                        }
                        .contextMenu {
                            Button(strings.erpPlanText(key: "editAction"), systemImage: "pencil") {
                                editing = PlanEditorItem(plan: plan)
                            }
                            Button(strings.erpPlanText(key: "archivePlanAction"), systemImage: "archivebox") { archiving = plan }
                        }
                }
            }
        }
        .listRowBackground(AppColors.card)
    }

    @ViewBuilder
    private func recentSection(_ strings: Strings) -> some View {
        Section(strings.erpPlanText(key: "recentPractice")) {
            switch sessions {
            case .loading:
                ProgressView().frame(maxWidth: .infinity)
            case .failed:
                Text(strings.erpPlanText(key: "historyError")).foregroundStyle(.secondary)
            case let .loaded(items) where items.isEmpty:
                Text(strings.erpPlanText(key: "historyEmpty"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
            case let .loaded(items):
                ForEach(items, id: \.id) { session in
                    RecentPracticeRow(session: session)
                }
            }
        }
        .listRowBackground(AppColors.card)
    }
}

/// A plan to edit, or nil for a new one.
private struct PlanEditorItem: Identifiable {
    let plan: ErpExercisePlan?
    var id: String { plan?.id.map(String.init) ?? "new" }
}

private struct PlanRow: View {
    let plan: ErpExercisePlan
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let template = ErpTemplate.forID(plan.exerciseId)
        let content = HStack(alignment: .top, spacing: 14) {
            Image(systemName: template.systemImage)
                .font(.title3)
                .foregroundStyle(AppColors.accent)
                .frame(width: 30)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(ErpTemplate.displayTitle(exerciseID: plan.exerciseId, stored: plan.exerciseTitle, strings))
                        .font(.headline)
                    Spacer()
                    Text(strings.delayMinutes(count: Int((Double(plan.defaultSeconds) / 60).rounded(.up))))
                        .font(.subheadline.monospacedDigit())
                        .foregroundStyle(Color(.secondaryLabel))
                }
                Text(plan.triggerOrExposure)
                    .font(.subheadline)
                    .lineLimit(2)
                Text(strings.erpPlanResist(response: plan.preventionCommitment))
                    .font(.footnote)
                    .foregroundStyle(Color(.secondaryLabel))
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
        if let id = plan.id {
            NavigationLink(value: Route.erpPractice(planID: id)) { content }
        } else {
            content
        }
    }
}

private struct RecentPracticeRow: View {
    let session: ErpExerciseSession
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(ErpTemplate.displayTitle(exerciseID: session.exerciseId, stored: session.exerciseTitle, strings))
                    .font(.headline)
                Spacer()
                Text(strings.erpPlanRatingChange(before: session.anxietyBefore, after: session.anxietyAfter))
                    .font(.subheadline.weight(.semibold).monospacedDigit())
                    .foregroundStyle(AppColors.accent)
            }
            Text(session.learning.isEmpty ? session.triggerOrExposure : session.learning)
                .font(.subheadline)
                .foregroundStyle(Color(.secondaryLabel))
                .lineLimit(2)
            Text(session.createdAt.date().map(strings.dates.monthDayTime) ?? "")
                .font(.footnote)
                .foregroundStyle(Color(.tertiaryLabel))
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Editor

/// `ErpPlanEditorScreen` as a native sheet with Cancel and Save.
struct ErpPlanEditor: View {
    let plan: ErpExercisePlan?

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss

    @State private var template: ErpTemplate
    @State private var defaultSeconds: Int
    @State private var custom: Bool
    @State private var customMinutes: Double
    @State private var exposure: String
    @State private var prediction: String
    @State private var commitment: String
    @State private var saving = false

    init(plan: ErpExercisePlan?) {
        self.plan = plan
        let template = plan.map { ErpTemplate.forID($0.exerciseId) } ?? ErpTemplate.all[0]
        let seconds = plan?.defaultSeconds ?? template.defaultSeconds
        _template = State(initialValue: template)
        _defaultSeconds = State(initialValue: seconds)
        _custom = State(initialValue: ![60, 300, 900].contains(seconds))
        _customMinutes = State(initialValue: min(max(Double(seconds) / 60, 1), 60))
        _exposure = State(initialValue: plan?.triggerOrExposure ?? "")
        _prediction = State(initialValue: plan?.fearPrediction ?? "")
        _commitment = State(initialValue: plan?.preventionCommitment ?? "")
    }

    private var isEditing: Bool { plan != nil }

    var body: some View {
        let strings = model.strings
        NavigationStack {
            Form {
                Section {
                    Picker(strings.erpPlanText(key: "exerciseType"), selection: templateSelection) {
                        ForEach(ErpTemplate.all) { template in
                            Label(template.title(strings), systemImage: template.systemImage).tag(template)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text(strings.erpPlanText(key: "exerciseType"))
                } footer: {
                    Text(template.subtitle(strings))
                }
                .listRowBackground(AppColors.card)

                Section(strings.erpPlanText(key: "practiceGuide")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(template.why(strings)).font(.subheadline)
                        ForEach(template.cues(strings), id: \.self) { cue in
                            Label(cue, systemImage: "checkmark")
                                .font(.subheadline)
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listRowBackground(AppColors.card)

                field(strings.erpPlanText(key: "exposureTarget"), text: $exposure, prompt: template.exposurePrompt(strings))
                field(strings.erpPlanText(key: "ocdPrediction"), text: $prediction, prompt: template.predictionPrompt(strings))
                field(strings.erpPlanText(key: "preventionCommitment"), text: $commitment,
                      prompt: template.commitmentPrompt(strings))

                Section(strings.erpPlanText(key: "defaultDuration")) {
                    Picker(strings.delayDurationGroupLabel, selection: durationSelection) {
                        ForEach([60, 300, 900], id: \.self) { seconds in
                            Text(strings.delayMinutes(count: seconds / 60)).tag(seconds)
                        }
                        Text(strings.delayCustomAction).tag(-1)
                    }
                    .pickerStyle(.segmented)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    if custom {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(strings.delayCustomTitle)
                                Spacer()
                                Text(strings.delayMinutes(count: Int(customMinutes.rounded())))
                                    .font(.headline.monospacedDigit())
                                    .foregroundStyle(AppColors.accent)
                            }
                            .accessibilityHidden(true)
                            Slider(value: $customMinutes, in: 1...60, step: 1)
                                .accessibilityLabel(strings.delayCustomTitle)
                                .accessibilityValue(strings.delayCustomMinutesValue(count: Int(customMinutes.rounded())))
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(AppColors.card)
                    }
                }
            }
            .appListBackground()
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(strings.erpPlanText(key: isEditing ? "editTitle" : "createTitle"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(strings.cancelAction) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(strings.erpPlanText(key: saving ? "saving" : isEditing ? "saveAction" : "createAction"),
                           action: save)
                        .fontWeight(.semibold)
                        .disabled(saving)
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .interactiveDismissDisabled(hasChanges)
    }

    private func field(_ label: String, text: Binding<String>, prompt: String) -> some View {
        Section(label) {
            TextField(label, text: text, prompt: Text(prompt), axis: .vertical)
                .lineLimit(2...5)
                .listRowBackground(AppColors.card)
        }
    }

    /// `_selectTemplate`: a preset duration follows the template.
    private var templateSelection: Binding<ErpTemplate> {
        Binding(get: { template }, set: { value in
            template = value
            if !custom { defaultSeconds = value.defaultSeconds }
            customMinutes = min(max(Double(defaultSeconds) / 60, 1), 60)
        })
    }

    private var durationSelection: Binding<Int> {
        Binding(get: { custom ? -1 : defaultSeconds }, set: { value in
            if value == -1 {
                custom = true
            } else {
                custom = false
                defaultSeconds = value
            }
        })
    }

    private var hasChanges: Bool {
        exposure != (plan?.triggerOrExposure ?? "") || prediction != (plan?.fearPrediction ?? "")
            || commitment != (plan?.preventionCommitment ?? "")
    }

    private func save() {
        let strings = model.strings
        let exposure = exposure.trimmingCharacters(in: .whitespacesAndNewlines)
        let commitment = commitment.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !exposure.isEmpty else {
            navigation.showToast(strings.erpPlanText(key: "exposureValidation"), kind: .info)
            return
        }
        guard !commitment.isEmpty else {
            navigation.showToast(strings.erpPlanText(key: "commitmentValidation"), kind: .info)
            return
        }
        saving = true
        let now = DartTimestamp.now()
        let record = ErpExercisePlan(
            id: plan?.id, exerciseId: template.id, exerciseTitle: template.canonicalTitle,
            triggerOrExposure: exposure,
            fearPrediction: prediction.trimmingCharacters(in: .whitespacesAndNewlines),
            preventionCommitment: commitment,
            defaultSeconds: custom ? Int(customMinutes.rounded()) * 60 : defaultSeconds,
            archived: plan?.archived ?? false, createdAt: plan?.createdAt ?? now, updatedAt: now
        )
        do {
            if isEditing { try model.database.updateErpPlan(record) } else { try model.database.insertErpPlan(record) }
        } catch {
            saving = false
            navigation.showToast(strings.erpPlanText(key: "saveError"), kind: .error)
            return
        }
        dismiss()
        navigation.showToast(strings.erpPlanText(key: isEditing ? "updated" : "created"), kind: .success)
    }
}
