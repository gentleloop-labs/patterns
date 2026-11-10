import PatternsCore
import SwiftUI

/// `ActionPlannerScreen` from `lib/mobile/screens/action_planner_screen.dart`:
/// plans for a situation you expect, ticked off when done. Pro.
struct ActionPlannerScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var plans: Loadable<[ActionPlan]> = .loading
    @State private var creating = false
    @State private var deleting: ActionPlan?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.actionPlanText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "actionPlanner")
            Section {
                switch plans {
                case .loading:
                    ProgressView().frame(maxWidth: .infinity)
                case .failed:
                    Text(text("loadError")).foregroundStyle(.secondary)
                case let .loaded(items) where items.isEmpty:
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "list.bullet.rectangle").font(.title2).foregroundStyle(AppColors.accent)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        Button(text("emptyAction")) { creating = true }
                            .buttonStyle(.accentProminent)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                case let .loaded(items):
                    ForEach(items, id: \.id) { plan in
                        PlanRow(plan: plan) { setCompleted(plan, $0) }
                            .swipeActions {
                                Button(text("deleteAction"), systemImage: "trash") { deleting = plan }
                                    .tint(.red)
                            }
                            .contextMenu {
                                Button(text("deleteTooltip"), systemImage: "trash", role: .destructive) { deleting = plan }
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
        .liveQuery(model.database, into: $plans) { db in try ActionPlan.all().fetchAll(db) }
        .sheet(isPresented: $creating) { ActionPlanEditor() }
        .alert(text("deleteTitle"), isPresented: Binding(
            get: { deleting != nil }, set: { if !$0 { deleting = nil } }
        ), presenting: deleting) { plan in
            Button(text("cancel"), role: .cancel) {}
            Button(text("deleteAction"), role: .destructive) { delete(plan) }
        } message: { _ in
            Text(text("deleteBody"))
        }
    }

    private func setCompleted(_ plan: ActionPlan, _ completed: Bool) {
        guard let id = plan.id else { return }
        let strings = model.strings
        do {
            try model.database.setActionPlanCompleted(id: id, completed)
            UIAccessibility.post(notification: .announcement, argument: strings.actionPlanText(
                key: completed ? "toggleSuccessComplete" : "toggleSuccessIncomplete"))
        } catch {
            navigation.showToast(strings.actionPlanText(key: "toggleError"), kind: .error)
        }
    }

    private func delete(_ plan: ActionPlan) {
        guard let id = plan.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteActionPlan(id: id)
            navigation.showToast(strings.actionPlanText(key: "deleteSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.actionPlanText(key: "deleteError"), kind: .error)
        }
    }
}

/// Plan dates are stored as `yyyy-MM-dd`.
private enum PlanDate {
    static func parse(_ value: String?) -> Date? {
        guard let value else { return nil }
        let parts = value.split(separator: "-").compactMap { Int($0) }
        guard parts.count == 3 else { return nil }
        return Calendar.current.date(from: DateComponents(year: parts[0], month: parts[1], day: parts[2]))
    }

    static func format(_ date: Date) -> String {
        let parts = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
    }
}

private struct PlanRow: View {
    let plan: ActionPlan
    let onToggle: (Bool) -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let done = plan.completed
        // A stored date that does not parse shows as written, as in Flutter.
        let date = plan.date.map { raw in PlanDate.parse(raw).map(strings.dates.fullDateWithWeekday) ?? raw }
        HStack(alignment: .top, spacing: 12) {
            Button { onToggle(!done) } label: {
                Image(systemName: done ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(done ? AppColors.accent : Color(.tertiaryLabel))
            }
            .buttonStyle(.borderless)
            .accessibilityLabel(strings.actionPlanText(key: done ? "toggleMarkIncomplete" : "toggleMarkComplete"))
            .accessibilityAddTraits(done ? .isSelected : [])
            VStack(alignment: .leading, spacing: 4) {
                Text(plan.situation)
                    .font(.headline)
                    .strikethrough(done, color: Color(.secondaryLabel))
                    .foregroundStyle(done ? Color(.secondaryLabel) : Color(.label))
                Text(plan.plannedAction).font(.subheadline)
                if let date {
                    Label(date, systemImage: "calendar")
                        .font(.footnote)
                        .foregroundStyle(Color(.secondaryLabel))
                        .accessibilityLabel(strings.actionPlanDateSummary(date: date))
                }
                if let notes = plan.notes, !notes.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text(notes).font(.footnote).foregroundStyle(Color(.secondaryLabel))
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(strings.actionPlanCardSummary(
                status: strings.actionPlanText(key: done ? "stateCompleted" : "statePlanned"),
                situation: plan.situation, action: plan.plannedAction))
        }
        .padding(.vertical, 4)
    }
}

/// `ActionPlanEditScreen` as a native sheet.
private struct ActionPlanEditor: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var situation = ""
    @State private var action = ""
    @State private var hasDate = false
    @State private var date = Date()
    @State private var notes = ""
    @State private var saving = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.actionPlanText(key: key) }
        let now = Date()
        let calendar = Calendar.current
        let range = (calendar.date(byAdding: .year, value: -1, to: now) ?? now)...(calendar.date(byAdding: .year, value: 2, to: now) ?? now)
        NavigationStack {
            Form {
                Section(text("situationLabel")) {
                    TextField(text("situationLabel"), text: $situation, prompt: Text(text("situationHint")), axis: .vertical)
                        .lineLimit(1...4)
                }
                .listRowBackground(AppColors.card)
                Section(text("actionLabel")) {
                    TextField(text("actionLabel"), text: $action, prompt: Text(text("actionHint")), axis: .vertical)
                        .lineLimit(1...4)
                }
                .listRowBackground(AppColors.card)
                Section {
                    Toggle(text("dateLabel"), isOn: $hasDate.animation())
                    if hasDate {
                        DatePicker(text("pickDate"), selection: $date, in: range, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .environment(\.locale, strings.locale)
                    }
                }
                .listRowBackground(AppColors.card)
                Section(text("notesLabel")) {
                    TextField(text("notesLabel"), text: $notes, prompt: Text(text("notesHint")), axis: .vertical)
                        .lineLimit(2...5)
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
        .interactiveDismissDisabled(!situation.isEmpty || !action.isEmpty || !notes.isEmpty)
    }

    private func save() {
        let strings = model.strings
        let trim = { (value: String) in value.trimmingCharacters(in: .whitespacesAndNewlines) }
        guard !trim(situation).isEmpty, !trim(action).isEmpty else {
            return navigation.showToast(strings.actionPlanText(key: "validation"), kind: .info)
        }
        saving = true
        let plan = ActionPlan(situation: trim(situation), plannedAction: trim(action),
                              date: hasDate ? PlanDate.format(date) : nil,
                              notes: trim(notes).isEmpty ? nil : trim(notes), createdAt: DartTimestamp.now())
        do {
            try model.database.insertActionPlan(plan)
        } catch {
            saving = false
            navigation.showToast(strings.actionPlanText(key: "saveError"), kind: .error)
            return
        }
        dismiss()
        navigation.showToast(strings.actionPlanText(key: "saveSuccess"), kind: .success)
    }
}
