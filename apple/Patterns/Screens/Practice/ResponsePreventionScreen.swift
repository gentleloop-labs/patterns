import PatternsCore
import SwiftUI

extension ResponseOutcome {
    func label(_ s: Strings) -> String {
        switch self {
        case .resisted: s.responsePreventionText(key: "outcomeResisted")
        case .delayed: s.responsePreventionText(key: "outcomeDelayed")
        case .partial: s.responsePreventionText(key: "outcomePartial")
        case .performed: s.responsePreventionText(key: "outcomePerformed")
        }
    }

    /// `_outcomeColor`.
    var color: Color {
        switch self {
        case .resisted: AppColors.positive
        case .delayed: AppColors.accent
        case .partial: AppColors.compulsionChip
        case .performed: AppColors.negative
        }
    }
}

/// `ResponsePreventionScreen` from `lib/mobile/screens/response_prevention_screen.dart`:
/// a log of what was done instead of a compulsion. Pro.
struct ResponsePreventionScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var logs: Loadable<[ResponsePreventionLog]> = .loading
    @State private var logging = false
    @State private var deleting: ResponsePreventionLog?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.responsePreventionText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "responsePrevention")
            Section {
                switch logs {
                case .loading:
                    ProgressView().frame(maxWidth: .infinity)
                case .failed:
                    Text(text("loadError")).foregroundStyle(.secondary)
                case let .loaded(items) where items.isEmpty:
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "shield").font(.title2).foregroundStyle(AppColors.accent)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        Button(text("emptyAction")) { logging = true }
                            .buttonStyle(.accentProminent)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                case let .loaded(items):
                    ForEach(items, id: \.id) { log in
                        LogRow(log: log)
                            .swipeActions {
                                Button(text("deleteAction"), systemImage: "trash") { deleting = log }
                                    .tint(.red)
                            }
                            .contextMenu {
                                Button(text("deleteTooltip"), systemImage: "trash", role: .destructive) { deleting = log }
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
                Button(text("logAction"), systemImage: "plus") { logging = true }
            }
        }
        .liveQuery(model.database, into: $logs) { db in try ResponsePreventionLog.all().fetchAll(db) }
        .sheet(isPresented: $logging) { LogEditor() }
        .alert(text("deleteTitle"), isPresented: Binding(
            get: { deleting != nil }, set: { if !$0 { deleting = nil } }
        ), presenting: deleting) { log in
            Button(text("cancel"), role: .cancel) {}
            Button(text("deleteAction"), role: .destructive) { delete(log) }
        } message: { _ in
            Text(text("deleteBody"))
        }
    }

    private func delete(_ log: ResponsePreventionLog) {
        guard let id = log.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteResponsePreventionLog(id: id)
            navigation.showToast(strings.responsePreventionText(key: "deleteSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.responsePreventionText(key: "deleteError"), kind: .error)
        }
    }
}

private struct LogRow: View {
    let log: ResponsePreventionLog
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let outcome = log.outcome ?? .resisted
        let date = log.datetime.date().map(strings.dates.monthDay) ?? ""
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text(outcome.label(strings))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(outcome.color, in: .capsule)
                Text(date).font(.footnote).foregroundStyle(Color(.secondaryLabel))
            }
            Text(log.situation).font(.headline)
            Text(strings.responsePreventionDistress(value: log.anxietyLevel))
                .font(.subheadline)
                .foregroundStyle(Color(.secondaryLabel))
            if let note = log.note, !note.trimmingCharacters(in: .whitespaces).isEmpty {
                Text(note).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.responsePreventionLogSummary(outcome: outcome.label(strings), date: date,
                                                                 distress: log.anxietyLevel, situation: log.situation))
    }
}

/// `ResponsePreventionLogScreen` as a native sheet.
private struct LogEditor: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var situation = ""
    @State private var outcome = ResponseOutcome.resisted
    @State private var anxiety: Double = 5
    @State private var note = ""
    @State private var saving = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.responsePreventionText(key: key) }
        NavigationStack {
            Form {
                Section(text("situationLabel")) {
                    TextField(text("situationLabel"), text: $situation, prompt: Text(text("situationHint")), axis: .vertical)
                        .lineLimit(2...5)
                }
                .listRowBackground(AppColors.card)
                Section(text("outcomeQuestion")) {
                    Picker(text("outcomeQuestion"), selection: $outcome) {
                        ForEach(ResponseOutcome.allCases, id: \.self) { value in
                            Label {
                                Text(value.label(strings))
                            } icon: {
                                Circle().fill(value.color).frame(width: 10, height: 10)
                            }
                            .tag(value)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
                .listRowBackground(AppColors.card)
                ScaleSliderSection(label: text("distressLabel"), value: $anxiety) {
                    strings.responsePreventionDistress(value: $0)
                }
                Section(text("noteLabel")) {
                    TextField(text("noteLabel"), text: $note, prompt: Text(text("noteHint")), axis: .vertical)
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
        .interactiveDismissDisabled(!situation.isEmpty || !note.isEmpty)
    }

    private func save() {
        let strings = model.strings
        let text = { (key: String) in strings.responsePreventionText(key: key) }
        let trimmedSituation = situation.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedSituation.isEmpty else { return navigation.showToast(text("situationValidation"), kind: .info) }
        saving = true
        let now = DartTimestamp.now()
        let trimmedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)
        let log = ResponsePreventionLog(datetime: now, situation: trimmedSituation, outcome: outcome,
                                        anxietyLevel: Int(anxiety.rounded()),
                                        note: trimmedNote.isEmpty ? nil : trimmedNote, createdAt: now)
        do {
            try model.database.insertResponsePreventionLog(log)
        } catch {
            saving = false
            navigation.showToast(text("saveError"), kind: .error)
            return
        }
        dismiss()
        navigation.showToast(text("saveSuccess"), kind: .success)
    }
}
