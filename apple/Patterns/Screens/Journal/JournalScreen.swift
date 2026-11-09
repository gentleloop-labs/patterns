import PatternsCore
import SwiftUI

/// `JournalScreen` from `lib/mobile/screens/journal_screen.dart`: one entry
/// per day, a strip of the last ten days, search, and a date picker.
struct JournalScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize

    @State private var entries: Loadable<[JournalEntry]> = .loading
    @State private var isSearching = false
    @State private var query = ""
    @State private var pickingDate = false
    @State private var clearing: JournalDay?
    @FocusState private var searchFocused: Bool

    var body: some View {
        let strings = model.strings
        ScrollView {
            VStack(spacing: 0) {
                header(strings)
                    .padding(EdgeInsets(top: 18, leading: 20, bottom: 10, trailing: 20))
                if !isSearching {
                    dateStrip(strings)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
                content(strings)
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 28, trailing: 20))
            }
            .animation(.easeOut(duration: 0.18), value: isSearching)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(AppColors.surface)
        .liveQuery(model.database, into: $entries) { db in try JournalEntry.all().fetchAll(db) }
        .sheet(isPresented: $pickingDate) {
            JournalDatePickerSheet { date in
                pickingDate = false
                navigation.push(.journalEntry(day: JournalEntry.dayKey(for: date)))
            }
        }
        .bottomPanel(item: $clearing) { day in
            ClearJournalDayPanel(date: day.date) {
                clearing = nil
            } onClear: {
                clearing = nil
                try? model.database.deleteJournalEntry(date: day.key)
                navigation.showToast(strings.journalClearedMessage, kind: .success)
            }
        }
    }

    // MARK: Header

    @ViewBuilder
    private func header(_ strings: Strings) -> some View {
        if isSearching {
            searchBar(strings)
        } else if typeSize >= .accessibility1 {
            VStack(alignment: .leading, spacing: 12) {
                title(strings)
                HStack(spacing: 10) {
                    Spacer()
                    headerButtons(strings)
                }
            }
        } else {
            HStack(spacing: 10) {
                title(strings).frame(maxWidth: .infinity, alignment: .leading)
                headerButtons(strings)
            }
        }
    }

    private func title(_ strings: Strings) -> some View {
        Text(strings.journalTitle)
            .font(.custom(AppFont.sans, size: 28, relativeTo: .title).weight(.heavy))
            .tracking(-0.5)
            .foregroundStyle(AppColors.textPrimary)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .accessibilityAddTraits(.isHeader)
    }

    @ViewBuilder
    private func headerButtons(_ strings: Strings) -> some View {
        RoundIconButton(systemImage: "magnifyingglass", label: strings.journalSearchAction) {
            isSearching = true
            searchFocused = true
        }
        RoundIconButton(systemImage: "calendar", label: strings.journalChooseDateAction) {
            pickingDate = true
        }
    }

    private func searchBar(_ strings: Strings) -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundStyle(AppColors.textSecondary)
                TextField("", text: $query, prompt: Text(strings.journalSearchHint).foregroundStyle(AppColors.textSecondary.opacity(0.7)))
                    .textRole(.bodyLarge, color: AppColors.textPrimary)
                    .focused($searchFocused)
                    .submitLabel(.search)
                    .padding(.vertical, 12)
                if !query.isEmpty {
                    Button { query = "" } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(AppColors.textSecondary)
                            .frame(width: 44, height: 44)
                    }
                    .accessibilityLabel(strings.journalClearSearchAction)
                }
            }
            .padding(.leading, 14)
            .frame(minHeight: 44)
            .softSurface(radius: 18)
            Button(strings.cancelAction) {
                searchFocused = false
                query = ""
                isSearching = false
            }
            .font(.custom(AppFont.sans, size: 14, relativeTo: .callout).weight(.semibold))
            .foregroundStyle(AppColors.accent)
            .frame(minWidth: 44, minHeight: 44)
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
            .padding(.horizontal, 20)
        }
    }

    // MARK: Entries

    @ViewBuilder
    private func content(_ strings: Strings) -> some View {
        switch entries {
        case .loading:
            ProgressView()
                .tint(AppColors.accent)
                .padding(.top, 48)
                .accessibilityLabel(strings.journalLoadingLabel)
        case .failed:
            Text(strings.journalLoadError)
                .textRole(.bodyMedium, color: AppColors.textPrimary)
                .padding(.top, 48)
        case let .loaded(all):
            entryList(all, strings)
        }
    }

    private func entryList(_ all: [JournalEntry], _ strings: Strings) -> some View {
        let todayKey = JournalEntry.dayKey(for: Date())
        let hasToday = all.contains { $0.date == todayKey }
        let searchText = isSearching ? query.lowercased() : ""
        let visible = all
            .filter { entry in
                searchText.isEmpty
                    || entry.body.plainText.lowercased().contains(searchText)
                    || entry.date.contains(searchText)
            }
            .sorted { $0.date > $1.date }
        let showNoMatches = isSearching && !query.isEmpty

        return LazyVStack(spacing: 12) {
            if !isSearching && !hasToday {
                TodayEntryCard {
                    navigation.push(.journalEntry(day: todayKey))
                }
                .padding(.bottom, 4)
            }
            if visible.isEmpty {
                EmptyStateView(
                    systemImage: showNoMatches ? "magnifyingglass" : "pencil",
                    title: showNoMatches ? strings.journalNoMatchesTitle : strings.journalEmptyTitle,
                    message: showNoMatches ? strings.journalNoMatchesBody(query: query) : strings.journalEmptyBody
                )
            } else {
                ForEach(visible) { entry in
                    JournalListCard(entry: entry) {
                        navigation.push(.journalEntry(day: entry.date))
                    } onLongPress: {
                        if let date = JournalEntry.date(forDayKey: entry.date) {
                            clearing = JournalDay(key: entry.date, date: date)
                        }
                    }
                }
            }
        }
    }
}

/// A day pending the clear-entry confirmation.
struct JournalDay: Identifiable {
    let key: String
    let date: Date
    var id: String { key }
}

// MARK: - Cards

private struct JournalListCard: View {
    @Environment(AppModel.self) private var model
    let entry: JournalEntry
    let onTap: () -> Void
    let onLongPress: () -> Void

    var body: some View {
        let date = JournalEntry.date(forDayKey: entry.date) ?? Date()
        let dates = model.strings.dates
        Button(action: onTap) {
            SoftCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text(dates.monthDay(date))
                        .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
                    RichPreviewText(content: entry.body, size: 14)
                        .lineLimit(2)
                        .lineSpacing(14 * 0.25)
                }
            }
        }
        .buttonStyle(PressScaleStyle())
        .simultaneousGesture(LongPressGesture().onEnded { _ in onLongPress() })
        .accessibilityHint(model.strings.journalOpenEntryHint(date: dates.fullDate(date)))
        .accessibilityAction(named: model.strings.journalClearDayAction, onLongPress)
    }
}

/// `richPreviewSpan`: a read-only preview that keeps bold and italic.
struct RichPreviewText: View {
    let content: JournalContent
    var size: CGFloat = 14
    var color: Color = AppColors.textSecondary

    var body: some View {
        content.richRuns.reduce(Text("")) { text, run in
            var piece = Text(run.text)
            if run.bold { piece = piece.fontWeight(.bold) }
            if run.italic { piece = piece.italic() }
            return text + piece
        }
        .font(.custom(AppFont.sans, size: size, relativeTo: .callout))
        .foregroundStyle(color)
    }
}

private struct TodayEntryCard: View {
    @Environment(AppModel.self) private var model
    let onTap: () -> Void

    var body: some View {
        let strings = model.strings
        Button(action: onTap) {
            SoftCard {
                HStack(spacing: 14) {
                    Image(systemName: "pencil")
                        .foregroundStyle(AppColors.accent)
                    Text(strings.journalTodayEntry)
                        .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityHint(strings.journalOpenEntryHint(date: strings.dates.fullDate(Date())))
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
                    .font(.custom(AppFont.sans, size: 10, relativeTo: .caption2).weight(.bold))
                    .tracking(0.6)
                    .foregroundStyle(isToday ? accent.opacity(0.85) : AppColors.textPrimary.opacity(0.55))
                Text(dates.monthDay(date))
                    .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote).weight(.bold))
                    .tracking(-0.2)
                    .foregroundStyle(isToday ? accent : AppColors.textPrimary)
            }
            .lineLimit(1)
            .padding(.horizontal, 6)
            .frame(minWidth: 88, minHeight: 64)
            .background(isToday ? accent.opacity(0.18) : Color.white.opacity(0.04), in: .rect(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(isToday ? accent.opacity(0.55) : AppColors.border.opacity(0.6)))
        }
        .buttonStyle(PressScaleStyle())
        .dynamicTypeSize(...DynamicTypeSize.accessibility2)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isToday ? strings.journalTodayEntry : dates.fullDate(date))
        .accessibilityHint(strings.journalOpenEntryHint(date: dates.fullDate(date)))
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Sheets

/// `confirmClearJournalDay`'s panel.
struct ClearJournalDayPanel: View {
    @Environment(AppModel.self) private var model
    let date: Date
    let onKeep: () -> Void
    let onClear: () -> Void

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 0) {
            Text(strings.journalClearDayTitle)
                .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
            Text(strings.journalClearDayBody(date: strings.dates.fullDate(date)))
                .font(.custom(AppFont.sans, size: 14, relativeTo: .callout))
                .lineSpacing(4)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 10)
            PanelActions(secondaryTitle: strings.journalKeepEntryAction, primaryTitle: strings.journalClearDayAction,
                         onSecondary: onKeep, onPrimary: onClear)
                .padding(.top, 20)
        }
    }
}

/// `_DatePickerSheet`: any day from 2000 up to today.
private struct JournalDatePickerSheet: View {
    @Environment(AppModel.self) private var model
    let onOpen: (Date) -> Void
    @State private var date = Date()

    var body: some View {
        let strings = model.strings
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(strings.journalChooseDateAction)
                    .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                DatePicker("", selection: $date, in: Self.firstDate...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .tint(AppColors.accent)
                    .environment(\.locale, strings.locale)
                Button(strings.journalOpenEntryAction) { onOpen(date) }
                    .buttonStyle(PrimaryButtonStyle(fullWidth: true))
            }
            .padding(20)
        }
        .presentationDetents([.fraction(0.78)])
        .presentationBackground(AppColors.card)
        .presentationCornerRadius(28)
    }

    private static let firstDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? .distantPast
}
