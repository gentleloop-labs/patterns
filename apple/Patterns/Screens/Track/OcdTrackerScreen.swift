import PatternsCore
import SwiftUI

/// `OcdTrackerScreen` from `lib/mobile/screens/ocd_tracker_screen.dart`: the
/// log of obsessions and compulsions, newest first, with a type filter.
struct OcdTrackerScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    @State private var entries: Loadable<[OcdEntry]> = .loading
    @State private var filter: OcdType?
    @State private var movingForward = true
    @State private var deleting: OcdEntry?

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text(strings.trackerTitle)
                    .font(.custom(AppFont.sans, size: 28, relativeTo: .title).weight(.heavy))
                    .tracking(-0.5)
                    .foregroundStyle(AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                PauseUrgePill(label: strings.trackerPauseUrgeAction) {
                    navigation.push(.compulsionDelay)
                }
            }
            .padding(EdgeInsets(top: 18, leading: 20, bottom: 16, trailing: 20))

            TrackerFilterBar(selection: filter) { select($0) }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)

            content(strings)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(AppColors.surface)
        .liveQuery(model.database, into: $entries) { db in try OcdEntry.all().fetchAll(db) }
        .bottomPanel(item: $deleting) { entry in
            DeleteOcdEntryPanel {
                deleting = nil
            } onDelete: {
                deleting = nil
                delete(entry)
            }
        }
    }

    @ViewBuilder
    private func content(_ strings: Strings) -> some View {
        switch entries {
        case .loading:
            ProgressView()
                .tint(AppColors.accent)
                .accessibilityLabel(strings.trackerLoadingLabel)
        case .failed:
            Text(strings.trackerLoadError)
                .textRole(.bodyMedium, color: AppColors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(24)
        case let .loaded(all):
            let filtered = filter.map { type in all.filter { $0.type == type } } ?? all
            Group {
                if filtered.isEmpty {
                    TrackerEmptyState { navigation.push(.ocdEvent(entryID: nil, type: .obsession)) }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filtered, id: \.id) { entry in
                                OcdEventCard(entry: entry) {
                                    if let id = entry.id { navigation.push(.ocdEvent(entryID: id, type: entry.type ?? .obsession)) }
                                } onDelete: {
                                    deleting = entry
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 84, trailing: 20))
                    }
                    // Stops above the tab bar, as Flutter's Scaffold body does.
                    .clipped()
                }
            }
            .id(filter.map { "\($0.rawValue)" } ?? "all")
            .transition(.push(from: movingForward ? .trailing : .leading))
        }
    }

    private func select(_ type: OcdType?) {
        guard type != filter else { return }
        movingForward = order(type) >= order(filter)
        withAnimation(UIAccessibility.isReduceMotionEnabled ? nil : .easeInOut(duration: 0.26)) {
            filter = type
        }
    }

    private func order(_ type: OcdType?) -> Int { type.map { $0.rawValue + 1 } ?? 0 }

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

// MARK: - Filter

/// `_FilterBar` / `_TypeToggle`: a segmented row of chips in a soft surface.
struct TrackerChip: View {
    let label: String
    let selected: Bool
    let action: () -> Void
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote).weight(.heavy))
                .foregroundStyle(selected ? AppColors.onAccent : AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.vertical, 11)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(selected ? AppColors.accent : .clear, in: .rect(cornerRadius: 18))
                .animation(reduceMotion ? nil : .easeOut(duration: 0.16), value: selected)
                .contentShape(.rect(cornerRadius: 18))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

private struct TrackerFilterBar: View {
    let selection: OcdType?
    let onChange: (OcdType?) -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let chips: [(String, OcdType?)] = [
            (strings.trackerFilterAll, nil),
            (strings.trackerFilterObsessions, .obsession),
            (strings.trackerFilterCompulsions, .compulsion),
        ]
        Group {
            if typeSize >= .xxxLarge {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(chips, id: \.0) { label, type in
                            TrackerChip(label: label, selected: selection == type) { onChange(type) }
                                .frame(minWidth: 96)
                                .fixedSize()
                        }
                    }
                }
            } else {
                HStack(spacing: 0) {
                    ForEach(chips, id: \.0) { label, type in
                        TrackerChip(label: label, selected: selection == type) { onChange(type) }
                    }
                }
            }
        }
        .padding(4)
        .softSurface(radius: 22)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(strings.trackerFilterGroupLabel)
    }
}

// MARK: - Cards

private struct OcdEventCard: View {
    let entry: OcdEntry
    let onEdit: () -> Void
    let onDelete: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let type = entry.type ?? .obsession
        let typeLabel = type == .obsession ? strings.trackerTypeObsession : strings.trackerTypeCompulsion
        let date = entry.datetime.date.map(strings.dates.monthDayTime) ?? ""
        let response = entry.response.isEmpty ? strings.trackerNoStrategy : entry.response

        VStack(alignment: .leading, spacing: 0) {
            let meta = typeSize >= .accessibility1
                ? AnyLayout(VStackLayout(alignment: .leading, spacing: 6))
                : AnyLayout(HStackLayout(spacing: 6))
            meta {
                OcdTypeChip(type: type)
                Text(date)
                    .font(.custom(AppFont.sans, size: 12, relativeTo: .caption))
                    .foregroundStyle(AppColors.textSecondary)
                    .padding(.trailing, 4)
                HStack(spacing: 0) {
                    iconButton("square.and.pencil", strings.trackerEditTooltip, action: onEdit)
                    iconButton("trash", strings.trackerDeleteTooltip, action: onDelete)
                }
            }
            Text(entry.content)
                .font(.custom(AppFont.sans, size: 16, relativeTo: .body).weight(.bold))
                .tracking(-0.2)
                .lineSpacing(16 * 0.38 / 2)
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(2)
                .padding(.top, 14)
            Text(strings.trackerDistressValue(value: entry.distressLevel))
                .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote).weight(.heavy))
                .foregroundStyle(distressColor(entry.distressLevel))
                .padding(.top, 12)
            Text(response)
                .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote))
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(1)
                .padding(.top, 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .softSurface(radius: 22)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.trackerEventSummary(type: typeLabel, date: date, distress: entry.distressLevel,
                                                        content: entry.content, response: response))
        .accessibilityActions {
            if entry.id != nil {
                Button(strings.trackerEditTooltip, action: onEdit)
                Button(strings.trackerDeleteTooltip, action: onDelete)
            }
        }
    }

    private func iconButton(_ systemImage: String, _ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 16))
                .foregroundStyle(AppColors.textSecondary)
                .frame(width: 44, height: 44)
                .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .disabled(entry.id == nil)
        .accessibilityLabel(label)
    }
}

/// `_TypeChip`.
struct OcdTypeChip: View {
    let type: OcdType
    @Environment(AppModel.self) private var model

    var body: some View {
        Text(type == .obsession ? model.strings.trackerTypeObsession : model.strings.trackerTypeCompulsion)
            .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote).weight(.bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(type == .obsession ? AppColors.obsessionChip : AppColors.compulsionChip, in: .rect(cornerRadius: 8))
    }
}

/// `_PauseUrgePill`: a tinted capsule that opens the compulsion delay flow.
private struct PauseUrgePill: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 7) {
                // `hourglass` would otherwise read as "Duration" in VoiceOver.
                Image(systemName: "hourglass")
                    .font(.system(size: 14, weight: .semibold))
                    .accessibilityHidden(true)
                Text(label)
                    .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote).weight(.heavy))
            }
            .foregroundStyle(AppColors.accent)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .frame(minHeight: 44)
            .background(AppColors.accent.opacity(0.12), in: .capsule)
            .overlay(Capsule().strokeBorder(AppColors.accent.opacity(0.24)))
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
    }
}

/// `_EmptyTrackState`.
private struct TrackerEmptyState: View {
    let onAdd: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        ScrollView {
            VStack(spacing: 0) {
                Image(systemName: "scope")
                    .font(.system(size: 40))
                    .foregroundStyle(AppColors.accent.opacity(0.8))
                    .accessibilityHidden(true)
                Text(strings.trackerEmptyTitle)
                    .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                Text(strings.trackerEmptyBody)
                    .textRole(.bodyMedium, color: AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                Button(strings.trackerEmptyAction, action: onAdd)
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.top, 22)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 48, leading: 32, bottom: 84, trailing: 32))
        }
    }
}

/// The delete confirmation from `_confirmDelete`.
private struct DeleteOcdEntryPanel: View {
    let onCancel: () -> Void
    let onDelete: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 0) {
            Text(strings.trackerDeleteTitle)
                .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
            Text(strings.trackerDeleteBody)
                .textRole(.bodyMedium, color: AppColors.textSecondary)
                .padding(.top, 10)
            PanelActions(secondaryTitle: strings.cancelAction, primaryTitle: strings.trackerDeleteAction,
                         onSecondary: onCancel, onPrimary: onDelete)
                .padding(.top, 20)
        }
    }
}
