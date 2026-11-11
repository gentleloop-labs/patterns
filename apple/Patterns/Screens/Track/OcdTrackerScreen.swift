import PatternsCore
import SwiftUI

/// `OcdTrackerScreen` from `lib/mobile/screens/ocd_tracker_screen.dart`: the
/// log of obsessions and compulsions, newest first, with a type filter.
struct OcdTrackerScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    @State private var entries: Loadable<[OcdEntry]> = .loading
    @State private var filter: OcdType?
    @State private var deleting: OcdEntry?

    var body: some View {
        let strings = model.strings
        content(strings)
            .appListBackground()
            .navigationTitle(strings.trackerTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(strings.trackerEmptyAction, systemImage: "plus") {
                        navigation.push(.ocdEvent(entryID: nil, type: .obsession))
                    }
                }
            }
            .liveQuery(model.database, into: $entries) { db in try OcdEntry.all().fetchAll(db) }
            .confirmationDialog(strings.trackerDeleteTitle, isPresented: Binding(
                get: { deleting != nil }, set: { if !$0 { deleting = nil } }
            ), titleVisibility: .visible, presenting: deleting) { entry in
                Button(strings.trackerDeleteAction, role: .destructive) { delete(entry) }
                Button(strings.cancelAction, role: .cancel) {}
            } message: { _ in
                Text(strings.trackerDeleteBody)
            }
    }

    @ViewBuilder
    private func content(_ strings: Strings) -> some View {
        switch entries {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .accessibilityLabel(strings.trackerLoadingLabel)
        case .failed:
            ContentUnavailableView(strings.trackerLoadError, systemImage: "exclamationmark.triangle")
        case let .loaded(all):
            let filtered = filter.map { type in all.filter { $0.type == type } } ?? all
            List {
                Section {
                    Button {
                        navigation.push(.compulsionDelay)
                    } label: {
                        Label(strings.trackerPauseUrgeAction, systemImage: "hourglass")
                            .font(.body.weight(.semibold))
                    }
                    .listRowBackground(AppColors.card)
                }
                Section {
                    Picker(strings.trackerFilterGroupLabel, selection: $filter.animation()) {
                        Text(strings.trackerFilterAll).tag(OcdType?.none)
                        Text(strings.trackerFilterObsessions).tag(OcdType?.some(.obsession))
                        Text(strings.trackerFilterCompulsions).tag(OcdType?.some(.compulsion))
                    }
                    .adaptiveSegmented()
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                if !filtered.isEmpty {
                    Section {
                        ForEach(filtered, id: \.id) { entry in
                            OcdEventRow(entry: entry) { deleting = entry }
                                .listRowBackground(AppColors.card)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(16)
            .overlay {
                if filtered.isEmpty {
                    ContentUnavailableView {
                        Label(strings.trackerEmptyTitle, systemImage: "scope")
                    } description: {
                        Text(strings.trackerEmptyBody)
                    } actions: {
                        Button(strings.trackerEmptyAction) { navigation.push(.ocdEvent(entryID: nil, type: .obsession)) }
                            .buttonStyle(.accentProminent)
                    }
                    .padding(.top, 140)
                }
            }
        }
    }

    private func delete(_ entry: OcdEntry) {
        guard let id = entry.id else { return }
        do {
            try model.database.deleteOcdEntry(id: id)
            navigation.showToast(model.strings.trackerDeletedMessage, kind: .success)
        } catch {
            navigation.showToast(model.strings.trackerDeleteError, kind: .error)
        }
    }
}

/// `_distressColor`: calm green up to 3, accent up to 7, then red.
func distressColor(_ level: Int) -> Color {
    if level <= 3 { return AppColors.positive }
    if level <= 7 { return AppColors.accent }
    return AppColors.negative
}

// MARK: - Rows

private struct OcdEventRow: View {
    let entry: OcdEntry
    let onDelete: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let type = entry.type ?? .obsession
        // Side by side normally; stacked at accessibility sizes so the chip
        // and the distress line keep whole words.
        let pair = typeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 4))
            : AnyLayout(HStackLayout(alignment: .firstTextBaseline, spacing: 8))
        let typeLabel = type == .obsession ? strings.trackerTypeObsession : strings.trackerTypeCompulsion
        let date = entry.datetime.date.map(strings.dates.monthDayTime) ?? ""
        let response = entry.response.isEmpty ? strings.trackerNoStrategy : entry.response
        let row = VStack(alignment: .leading, spacing: 6) {
            pair {
                OcdTypeChip(type: type)
                Text(date)
                    .font(.footnote)
                    .foregroundStyle(AppColors.textSecondary)
            }
            Text(entry.content)
                .font(.headline)
                .lineLimit(2)
            pair {
                Text(strings.trackerDistressValue(value: entry.distressLevel))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(distressColor(entry.distressLevel))
                    .fixedSize(horizontal: false, vertical: true)
                Text(response)
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.trackerEventSummary(type: typeLabel, date: date, distress: entry.distressLevel,
                                                        content: entry.content, response: response))

        if let id = entry.id {
            NavigationLink(value: Route.ocdEvent(entryID: id, type: type)) { row }
                .swipeActions {
                    // No destructive role: that would hide the row before the
                    // confirmation, and keep it hidden after Cancel.
                    Button(strings.trackerDeleteTooltip, systemImage: "trash", action: onDelete)
                        .tint(.red)
                }
                .contextMenu {
                    NavigationLink(value: Route.ocdEvent(entryID: id, type: type)) {
                        Label(strings.trackerEditTooltip, systemImage: "square.and.pencil")
                    }
                    Button(strings.trackerDeleteTooltip, systemImage: "trash", role: .destructive, action: onDelete)
                }
        } else {
            row
        }
    }
}

/// `_TypeChip`.
struct OcdTypeChip: View {
    let type: OcdType
    @Environment(AppModel.self) private var model

    var body: some View {
        Text(type == .obsession ? model.strings.trackerTypeObsession : model.strings.trackerTypeCompulsion)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .lineLimit(1)
            .fixedSize()
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(type == .obsession ? AppColors.obsessionChip : AppColors.compulsionChip, in: .capsule)
    }
}
