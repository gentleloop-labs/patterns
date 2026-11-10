import PatternsCore
import SwiftUI

/// `JournalScreen` from `lib/mobile/screens/journal_screen.dart`: one entry
/// per day, the last ten days for quick access, search and a date picker,
/// as a native list.
struct JournalScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    @State private var entries: Loadable<[JournalEntry]> = .loading
    @State private var query = ""
    @State private var pickingDate = false
    @State private var clearing: JournalDay?

    var body: some View {
        let strings = model.strings
        content(strings)
            .appListBackground()
            .navigationTitle(strings.journalTitle)
            .searchable(text: $query, prompt: strings.journalSearchHint)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(strings.journalChooseDateAction, systemImage: "calendar") { pickingDate = true }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(strings.journalNewEntryAction, systemImage: "square.and.pencil") {
                        navigation.push(.journalEntry(day: JournalEntry.dayKey(for: Date())))
                    }
                }
            }
            .liveQuery(model.database, into: $entries) { db in try JournalEntry.all().fetchAll(db) }
            .sheet(isPresented: $pickingDate) {
                JournalDatePickerSheet { date in
                    pickingDate = false
                    navigation.push(.journalEntry(day: JournalEntry.dayKey(for: date)))
                }
            }
            .confirmationDialog(strings.journalClearDayTitle, isPresented: Binding(
                get: { clearing != nil }, set: { if !$0 { clearing = nil } }
            ), titleVisibility: .visible, presenting: clearing) { day in
                Button(strings.journalClearDayAction, role: .destructive) {
                    try? model.database.deleteJournalEntry(date: day.key)
                    navigation.showToast(strings.journalClearedMessage, kind: .success)
                }
                Button(strings.journalKeepEntryAction, role: .cancel) {}
            } message: { day in
                Text(strings.journalClearDayBody(date: strings.dates.fullDate(day.date)))
            }
    }

    @ViewBuilder
    private func content(_ strings: Strings) -> some View {
        switch entries {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .accessibilityLabel(strings.journalLoadingLabel)
        case .failed:
            ContentUnavailableView(strings.journalLoadError, systemImage: "exclamationmark.triangle")
        case let .loaded(all):
            entryList(all, strings)
        }
    }

    private func entryList(_ all: [JournalEntry], _ strings: Strings) -> some View {
        let todayKey = JournalEntry.dayKey(for: Date())
        let hasToday = all.contains { $0.date == todayKey }
        let searchText = query.trimmingCharacters(in: .whitespaces).lowercased()
        let searching = !searchText.isEmpty
        let visible = all
            .filter { entry in
                !searching
                    || entry.body.plainText.lowercased().contains(searchText)
                    || entry.date.contains(searchText)
            }
            .sorted { $0.date > $1.date }

        return List {
            if !searching {
                Section {
                    dateStrip(strings)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }
                Section {
                    if !hasToday {
                        NavigationLink(value: Route.journalEntry(day: todayKey)) {
                            Label(strings.journalTodayEntry, systemImage: "square.and.pencil")
                                .font(.body.weight(.semibold))
                        }
                        .accessibilityHint(strings.journalOpenEntryHint(date: strings.dates.fullDate(Date())))
                        .listRowBackground(AppColors.card)
                    }
                }
            }
            if !visible.isEmpty {
                Section {
                    ForEach(visible) { entry in
                        JournalRow(entry: entry) { clear(entry) }
                            .listRowBackground(AppColors.card)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .overlay {
            if visible.isEmpty {
                if searching {
                    ContentUnavailableView(strings.journalNoMatchesTitle, systemImage: "magnifyingglass",
                                           description: Text(strings.journalNoMatchesBody(query: query)))
                } else {
                    ContentUnavailableView(strings.journalEmptyTitle, systemImage: "book",
                                           description: Text(strings.journalEmptyBody))
                        .padding(.top, 160)
                }
            }
        }
    }

    private func clear(_ entry: JournalEntry) {
        if let date = JournalEntry.date(forDayKey: entry.date) {
            clearing = JournalDay(key: entry.date, date: date)
        }
    }

    // MARK: Date strip

    private func dateStrip(_ strings: Strings) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<10, id: \.self) { offset in
                    let date = Calendar.current.date(byAdding: .day, value: -offset, to: Date()) ?? Date()
                    DatePill(date: date, isToday: offset == 0) {
                        navigation.push(.journalEntry(day: JournalEntry.dayKey(for: date)))
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollClipDisabled()
    }
}

/// A day pending the clear-entry confirmation.
struct JournalDay: Identifiable {
    let key: String
    let date: Date
    var id: String { key }
}

// MARK: - Rows

private struct JournalRow: View {
    @Environment(AppModel.self) private var model
    let entry: JournalEntry
    let onClear: () -> Void

    var body: some View {
        let date = JournalEntry.date(forDayKey: entry.date) ?? Date()
        let strings = model.strings
        NavigationLink(value: Route.journalEntry(day: entry.date)) {
            VStack(alignment: .leading, spacing: 4) {
                Text(strings.dates.monthDay(date))
                    .font(.headline)
                RichPreviewText(content: entry.body)
                    .lineLimit(2)
            }
            .padding(.vertical, 4)
        }
        .accessibilityHint(strings.journalOpenEntryHint(date: strings.dates.fullDate(date)))
        .swipeActions {
            Button(strings.journalClearDayAction, systemImage: "trash", role: .destructive, action: onClear)
        }
        .contextMenu {
            Button(strings.journalClearDayAction, systemImage: "trash", role: .destructive, action: onClear)
        }
    }
}

/// `richPreviewSpan`: a read-only preview that keeps bold and italic.
struct RichPreviewText: View {
    let content: JournalContent
    var style: Font.TextStyle = .subheadline
    var color: Color = .secondary

    var body: some View {
        content.richRuns.reduce(Text("")) { text, run in
            var piece = Text(run.text)
            if run.bold { piece = piece.fontWeight(.bold) }
            if run.italic { piece = piece.italic() }
            return text + piece
        }
        .font(.system(style))
        .foregroundStyle(color)
    }
}

private struct DatePill: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize
    let date: Date
    let isToday: Bool
    let onTap: () -> Void

    var body: some View {
        let strings = model.strings
        let dates = strings.dates
        let accent = AppColors.accent
        Button(action: onTap) {
            VStack(spacing: 2) {
                Text(isToday ? strings.navToday : dates.shortWeekday(date))
                    .font(.caption2.weight(.semibold))
                    .textCase(.uppercase)
                    .foregroundStyle(isToday ? accent : .secondary)
                Text(dates.monthDay(date))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(isToday ? accent : .primary)
            }
            .lineLimit(1)
            .padding(.horizontal, 10)
            .frame(minWidth: 76, minHeight: 56)
            .background(isToday ? accent.opacity(0.16) : AppColors.card, in: .rect(cornerRadius: 12))
        }
        .buttonStyle(.plain)
        .dynamicTypeSize(...DynamicTypeSize.accessibility2)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isToday ? strings.journalTodayEntry : dates.fullDate(date))
        .accessibilityHint(strings.journalOpenEntryHint(date: dates.fullDate(date)))
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Sheets

/// `_DatePickerSheet`: any day from 2000 up to today, in a native sheet.
private struct JournalDatePickerSheet: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    let onOpen: (Date) -> Void
    @State private var date = Date()

    var body: some View {
        let strings = model.strings
        NavigationStack {
            DatePicker(strings.journalChooseDateAction, selection: $date, in: Self.firstDate...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
                .environment(\.locale, strings.locale)
                .padding(.horizontal, 16)
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationTitle(strings.journalChooseDateAction)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(strings.cancelAction) { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(strings.journalOpenEntryAction) { onOpen(date) }
                            .fontWeight(.semibold)
                    }
                }
        }
        .presentationDetents([.medium, .large])
    }

    private static let firstDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? .distantPast
}
