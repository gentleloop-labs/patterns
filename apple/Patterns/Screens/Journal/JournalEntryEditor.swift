import PatternsCore
import SwiftUI

/// `JournalEntryEditor`: writes the entry for one day.
struct JournalEntryEditor: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize

    let day: String

    @State private var controller = RichEditorController()
    @State private var entries: Loadable<[JournalEntry]> = .loading
    @State private var loaded = false
    @State private var saving = false
    @State private var savedSnapshot = ""
    @State private var confirmingClear = false

    private var date: Date { JournalEntry.date(forDayKey: day) ?? Date() }
    private var existing: JournalEntry? { entries.value?.first { $0.date == day } }
    private var saved: Bool { controller.stored == savedSnapshot }

    var body: some View {
        let strings = model.strings
        VStack(spacing: 0) {
            header(strings)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 16))
            RichTextEditor(controller: controller, placeholder: strings.journalStartWritingPlaceholder)
                .accessibilityLabel(strings.journalEditorLabel)
                .accessibilityHint(strings.journalEditorHint)
                .padding(EdgeInsets(top: 18, leading: 22, bottom: 22, trailing: 22))
            formatBar(strings)
        }
        .background(AppColors.surface)
        .toolbar(.hidden, for: .navigationBar)
        .liveQuery(model.database, into: $entries) { db in try JournalEntry.all().fetchAll(db) }
        .onChange(of: entries.value?.count, initial: true) { _, _ in loadIfReady() }
        .bottomPanel(isPresented: $confirmingClear) {
            ClearJournalDayPanel(date: date) {
                confirmingClear = false
            } onClear: {
                confirmingClear = false
                clear()
            }
        }
    }

    // MARK: Header

    @ViewBuilder
    private func header(_ strings: Strings) -> some View {
        let back = Button { navigation.pop() } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(AppColors.textPrimary)
                .frame(width: 44, height: 44)
        }
        .accessibilityLabel(strings.backAction)

        let title = VStack(alignment: .leading, spacing: 2) {
            Text(strings.dates.fullDate(date))
                .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
            Text(saving ? strings.journalSavingStatus : saved ? strings.journalSavedStatus : strings.journalUnsavedStatus)
                .font(.custom(AppFont.sans, size: 12, relativeTo: .caption))
                .foregroundStyle(AppColors.textSecondary)
                .contentTransition(.opacity)
                .animation(.easeOut(duration: 0.18), value: saved)
                .accessibilityAddTraits(.updatesFrequently)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        if typeSize > .xxLarge {
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 4) { back; title }
                HStack(spacing: 8) { actions(strings) }
            }
        } else {
            HStack(spacing: 4) {
                back
                title
                actions(strings)
            }
        }
    }

    @ViewBuilder
    private func actions(_ strings: Strings) -> some View {
        if existing != nil {
            Button { confirmingClear = true } label: {
                Image(systemName: "trash")
                    .font(.system(size: 17))
                    .foregroundStyle(AppColors.textSecondary)
                    .frame(width: 44, height: 44)
            }
            .disabled(saving)
            .accessibilityLabel(strings.journalClearDayAction)
        }
        Button(strings.journalSaveAction, action: save)
            .font(.custom(AppFont.sans, size: 14, relativeTo: .callout).weight(.semibold))
            .foregroundStyle(saving || saved ? AppColors.textSecondary.opacity(0.5) : AppColors.accent)
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal, 8)
            .disabled(saving || saved)
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
            .font(.custom(AppFont.sans, size: 11, relativeTo: .caption2))
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
        .padding(.vertical, 4)
        .overlay(alignment: .top) {
            Rectangle().fill(AppColors.border.opacity(0.6)).frame(height: 1)
        }
    }

    // MARK: Actions

    private func loadIfReady() {
        guard !loaded, let entries = entries.value else { return }
        let document = RichDocument(stored: entries.first { $0.date == day }?.content ?? "")
        controller.load(document)
        savedSnapshot = controller.stored
        loaded = true
    }

    private func save() {
        let strings = model.strings
        let document = controller.document
        guard !document.plainText.isEmpty else {
            navigation.showToast(strings.journalNothingToSaveMessage, kind: .info)
            return
        }
        saving = true
        let stored = document.stored
        do {
            let isNew = try model.database.saveJournalEntry(date: day, content: stored)
            if isNew {
                model.prefs.recordMeaningfulAction(.journal)
                // Phase 5: AppEvents.logFirstJournalEntryCreated (milestone only).
            }
            model.prefs.recordReviewJournalSaved()
            savedSnapshot = stored
            saving = false
            navigation.completeActivity(.journal)
        } catch {
            saving = false
            // No journal-specific save error exists in the ARB files yet.
            // Phase 5 adds one; until then this generic retry message shows.
            navigation.showToast(strings.journalLoadError, kind: .error)
        }
    }

    private func clear() {
        try? model.database.deleteJournalEntry(date: day)
        controller.load(RichDocument(stored: ""))
        savedSnapshot = controller.stored
        navigation.pop()
        navigation.showToast(model.strings.journalClearedMessage, kind: .success)
    }
}

/// `_FormatButton`: a 44pt toggle, tinted while its style is active.
private struct FormatButton<Label: View>: View {
    let label: String
    let hint: String
    let active: Bool
    let action: () -> Void
    @ViewBuilder var content: Label

    var body: some View {
        Button(action: action) {
            content
                .foregroundStyle(active ? AppColors.accent : AppColors.textPrimary.opacity(0.75))
                .frame(width: 44, height: 44)
                .background(active ? AppColors.accent.opacity(0.14) : .clear, in: .rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(active ? AppColors.accent : AppColors.border.opacity(0.7)))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
        .accessibilityHint(hint)
        .accessibilityAddTraits(active ? .isSelected : [])
    }
}
