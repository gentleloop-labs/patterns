import PatternsCore
import SwiftUI

/// `JournalEntryEditor`: writes the entry for one day.
struct JournalEntryEditor: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.scenePhase) private var scenePhase

    let day: String

    @State private var controller = RichEditorController()
    @State private var entries: Loadable<[JournalEntry]> = .loading
    @State private var loaded = false
    @State private var saving = false
    @State private var savedSnapshot = ""
    @State private var confirmingClear = false
    /// Pending autosave after a pause in typing.
    @State private var autosaveTask: Task<Void, Never>?
    /// The review counter moves once per visit, not on every autosave.
    @State private var countedReview = false
    /// Set once the day is cleared, so a late autosave cannot recreate it.
    @State private var cleared = false

    /// How long typing must pause before the entry saves itself.
    static let autosaveDelay: Duration = .seconds(2)

    private var date: Date { JournalEntry.date(forDayKey: day) ?? Date() }
    private var existing: JournalEntry? { entries.value?.first { $0.date == day } }
    private var saved: Bool { controller.stored == savedSnapshot }

    var body: some View {
        let strings = model.strings
        VStack(spacing: 0) {
            RichTextEditor(controller: controller, placeholder: strings.journalStartWritingPlaceholder)
                .accessibilityLabel(strings.journalEditorLabel)
                .accessibilityHint(strings.journalEditorHint)
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 16, trailing: 20))
            formatBar(strings)
        }
        .background(AppColors.surface)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 0) {
                    Text(strings.dates.fullDate(date))
                        .font(.headline)
                    Text(saving ? strings.journalSavingStatus : saved ? strings.journalSavedStatus : strings.journalUnsavedStatus)
                        .font(.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .contentTransition(.opacity)
                        .animation(.easeOut(duration: 0.18), value: saved)
                        .accessibilityAddTraits(.updatesFrequently)
                }
                .accessibilityElement(children: .combine)
            }
            ToolbarItemGroup(placement: .primaryAction) {
                if existing != nil {
                    Button(strings.journalClearDayAction, systemImage: "trash") { confirmingClear = true }
                        .disabled(saving)
                }
                Button(strings.journalSaveAction, action: save)
                    .fontWeight(.semibold)
                    .disabled(saving || saved)
            }
        }
        .liveQuery(model.database, into: $entries) { db in try JournalEntry.all().fetchAll(db) }
        .onChange(of: entries.value?.count, initial: true) { _, _ in loadIfReady() }
        // Autosave: Flutter dropped unsaved writing on Back; native keeps it.
        .onChange(of: controller.stored) { _, _ in scheduleAutosave() }
        .onChange(of: scenePhase) { _, phase in if phase != .active { autosaveNow() } }
        .onDisappear { autosaveNow() }
        .confirmationDialog(strings.journalClearDayTitle, isPresented: $confirmingClear, titleVisibility: .visible) {
            Button(strings.journalClearDayAction, role: .destructive, action: clear)
            Button(strings.journalKeepEntryAction, role: .cancel) {}
        } message: {
            Text(strings.journalClearDayBody(date: strings.dates.fullDate(date)))
        }
    }

    // MARK: Format bar

    private func formatBar(_ strings: Strings) -> some View {
        let toolbar = HStack(spacing: 4) {
            FormatButton(label: strings.formatBold, hint: strings.formatToggleHint, active: controller.isBold,
                         action: controller.toggleBold) {
                Text("B").font(.system(size: 16, weight: .heavy))
            }
            FormatButton(label: strings.formatItalic, hint: strings.formatToggleHint, active: controller.isItalic,
                         action: controller.toggleItalic) {
                Text("I").font(.system(size: 16, weight: .semibold)).italic()
            }
            FormatButton(label: strings.formatBulletedList, hint: strings.formatToggleHint, active: controller.isBullet,
                         action: controller.toggleBullet) {
                Image(systemName: "list.bullet").font(.system(size: 16))
            }
        }
        let guidance = Text(strings.journalFormatSelectionHint)
            .font(.system(.caption2))
            .foregroundStyle(AppColors.textSecondary)

        return Group {
            if typeSize > .xxLarge {
                VStack(alignment: .leading, spacing: 4) { toolbar; guidance }
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                HStack {
                    toolbar
                    Spacer(minLength: 8)
                    guidance.multilineTextAlignment(.trailing)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
        .background(.bar)
        .overlay(alignment: .top) { Divider() }
    }

    // MARK: Actions

    private func loadIfReady() {
        guard !loaded, let entries = entries.value else { return }
        let document = RichDocument(stored: entries.first { $0.date == day }?.content ?? "")
        controller.load(document)
        savedSnapshot = controller.stored
        loaded = true
    }

    /// The Save button: saves now and marks the activity complete.
    private func save() {
        autosaveTask?.cancel()
        guard !controller.document.plainText.isEmpty else {
            navigation.showToast(model.strings.journalNothingToSaveMessage, kind: .info)
            return
        }
        if persist() { navigation.completeActivity(.journal) }
    }

    private func scheduleAutosave() {
        guard loaded, !cleared, !saved else { return }
        autosaveTask?.cancel()
        autosaveTask = Task {
            try? await Task.sleep(for: Self.autosaveDelay)
            guard !Task.isCancelled else { return }
            autosaveNow()
        }
    }

    /// Saves quietly: no toast for an empty page (an emptied entry keeps its
    /// stored text until Save or Clear) and no completion sheet.
    private func autosaveNow() {
        autosaveTask?.cancel()
        autosaveTask = nil
        guard loaded, !cleared, !saving, !saved, !controller.document.plainText.isEmpty else { return }
        persist()
    }

    @discardableResult
    private func persist() -> Bool {
        let stored = controller.document.stored
        saving = true
        defer { saving = false }
        do {
            let isNew = try model.database.saveJournalEntry(date: day, content: stored)
            if isNew {
                model.prefs.recordMeaningfulAction(.journal)
                model.events.journalEntryCreated()
            }
            if !countedReview {
                countedReview = true
                model.prefs.recordReviewJournalSaved()
            }
            savedSnapshot = stored
            return true
        } catch {
            navigation.showToast(model.strings.journalSaveError, kind: .error)
            return false
        }
    }

    private func clear() {
        autosaveTask?.cancel()
        cleared = true
        try? model.database.deleteJournalEntry(date: day)
        controller.load(RichDocument(stored: ""))
        savedSnapshot = controller.stored
        navigation.pop()
        navigation.showToast(model.strings.journalClearedMessage, kind: .success)
    }
}

/// A 44pt format toggle, filled like the Notes format buttons and tinted
/// while its style is active.
private struct FormatButton<Label: View>: View {
    let label: String
    let hint: String
    let active: Bool
    let action: () -> Void
    @ViewBuilder var content: Label

    var body: some View {
        Button(action: action) {
            content
                .foregroundStyle(active ? AppColors.accent : Color.primary)
                .frame(width: 44, height: 44)
                .background(active ? AppColors.accent.opacity(0.16) : Color(.tertiarySystemFill), in: .rect(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
        .accessibilityHint(hint)
        .accessibilityAddTraits(active ? .isSelected : [])
    }
}
