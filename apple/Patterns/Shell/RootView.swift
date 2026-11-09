import PatternsCore
import SwiftUI

/// Mirrors `MobileShell`: welcome and first-run for new installs, otherwise
/// the main tabs. Everything sits behind the privacy gate.
struct RootView: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    var body: some View {
        @Bindable var navigation = navigation
        PrivacyGate {
            Group {
                if model.hasStarted {
                    MainShell()
                } else {
                    WelcomePlaceholder()
                }
            }
            .background(AppColors.surface.ignoresSafeArea())
            .overlay(alignment: .bottom) { ToastHost() }
            .sheet(item: $navigation.completion.identified) { item in
                CompletionSheet(kind: item.kind) {
                    navigation.completion = nil
                    navigation.returnToNeutralHome()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSLocale.currentLocaleDidChangeNotification)) { _ in
            model.refreshSystemLanguage()
        }
    }
}

private struct IdentifiedCompletion: Identifiable {
    let kind: CompletionKind
    var id: String { String(describing: kind) }
}

private extension Optional where Wrapped == CompletionKind {
    var identified: IdentifiedCompletion? {
        get { map(IdentifiedCompletion.init) }
        set { self = newValue?.kind }
    }
}

private struct ToastHost: View {
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            if let toast = navigation.toast {
                ToastView(toast: toast)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 96)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .id(toast.id)
                    .onTapGesture { navigation.dismissToast() }
            }
        }
        .animation(reduceMotion ? nil : .easeOut(duration: 0.22), value: navigation.toast)
    }
}

/// `MobileHome`: the tab pages, the floating tab bar and the add button.
/// Pushed pages cover the tab bar, as Flutter's routes do.
struct MainShell: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        @Bindable var navigation = navigation
        NavigationStack(path: $navigation.path) {
            ZStack {
                ForEach(AppTab.allCases) { tab in
                    // Pages stay alive across tab switches so scroll position
                    // and search text survive, as Riverpod state does.
                    page(tab)
                        .opacity(navigation.selectedTab == tab ? 1 : 0)
                        .allowsHitTesting(navigation.selectedTab == tab)
                        .accessibilityHidden(navigation.selectedTab != tab)
                }
            }
            .animation(reduceMotion ? nil : .easeInOut(duration: 0.2), value: navigation.selectedTab)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                FloatingTabBar(selected: navigation.selectedTab) { navigation.select($0) }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 8, trailing: 20))
            }
            .overlay(alignment: .bottomTrailing) { fab }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Route.self) { route in
                destination(route)
            }
        }
    }

    @ViewBuilder
    private func page(_ tab: AppTab) -> some View {
        switch tab {
        case .journal: JournalScreen()
        default: PlaceholderScreen(title: tab.title(model.strings))
        }
    }

    @ViewBuilder
    private func destination(_ route: Route) -> some View {
        switch route {
        case let .journalEntry(day): JournalEntryEditor(day: day).id(day)
        case .settings: PlaceholderScreen(title: model.strings.settingsTitle)
        }
    }

    /// The add button shows on Journal and Track below 200% text.
    private var fab: some View {
        let tab = navigation.selectedTab
        let show = (tab == .journal || tab == .track) && typeSize < .accessibility3
        return FloatingAddButton(
            systemImage: tab == .track ? "plus" : "pencil",
            label: tab == .track ? model.strings.trackerEmptyAction : model.strings.journalNewEntryAction
        ) {
            switch tab {
            case .journal: navigation.push(.journalEntry(day: JournalEntry.dayKey(for: Date())))
            default: break // Track's add flow arrives with the tracker port.
            }
        }
        .padding(.trailing, 16)
        .padding(.bottom, 74 + 8 + 16)
        .offset(y: show ? 0 : 160)
        .opacity(show ? 1 : 0)
        .allowsHitTesting(show)
        .animation(reduceMotion ? nil : .easeOut(duration: 0.26), value: show)
    }
}

extension AppTab {
    func title(_ strings: Strings) -> String {
        switch self {
        case .home: strings.navToday
        case .journal: strings.navJournal
        case .track: strings.navTrack
        case .erp: strings.navRecovery
        case .insights: strings.navInsights
        }
    }

    /// Closest SF Symbols to the Line Icons the Flutter dock uses.
    var systemImage: String {
        switch self {
        case .home: "house"
        case .journal: "book"
        case .track: "scope"
        case .erp: "figure.mind.and.body"
        case .insights: "chart.bar"
        }
    }
}

/// `_FloatingTabBar`: a frosted pill with five segments.
private struct FloatingTabBar: View {
    @Environment(AppModel.self) private var model
    let selected: AppTab
    let onSelect: (AppTab) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                TabSegment(tab: tab, title: tab.title(model.strings), active: tab == selected) { onSelect(tab) }
            }
        }
        .frame(height: 74)
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .overlay(RoundedRectangle(cornerRadius: 28).fill(AppColors.card.opacity(0.58)))
                .overlay(RoundedRectangle(cornerRadius: 28).strokeBorder(AppColors.border.opacity(0.5)))
                .shadow(color: .black.opacity(0.3), radius: 15, y: 14)
        }
        .clipShape(.rect(cornerRadius: 28))
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

private struct TabSegment: View {
    let tab: AppTab
    let title: String
    let active: Bool
    let action: () -> Void
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let accent = AppColors.accent
        let color = active ? accent : AppColors.textSecondary
        Button(action: action) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(active ? accent.opacity(0.14) : .clear)
                    .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(active ? accent.opacity(0.1) : .clear))
                    .padding(EdgeInsets(top: 5, leading: 4, bottom: 5, trailing: 4))
                UnevenRoundedRectangle(bottomLeadingRadius: 3, bottomTrailingRadius: 3)
                    .fill(accent)
                    .frame(height: 3)
                    .padding(.horizontal, active ? 18 : 28)
                    .opacity(active ? 1 : 0)
                VStack(spacing: 5) {
                    Image(systemName: tab.systemImage)
                        .font(.system(size: 20))
                        .scaleEffect(active ? 1.05 : 1)
                    Text(title)
                        .font(.custom(AppFont.sans, size: 10.5, relativeTo: .caption2).weight(active ? .black : .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
                .foregroundStyle(color)
                .padding(EdgeInsets(top: 9, leading: 4, bottom: 6, trailing: 4))
                .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(reduceMotion ? nil : .easeOut(duration: 0.24), value: active)
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityAddTraits(active ? [.isSelected, .isButton] : .isButton)
    }
}

/// `_FloatingPenButton`.
private struct FloatingAddButton: View {
    let systemImage: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(AppColors.onAccent)
                .contentTransition(.symbolEffect(.replace))
                .frame(width: 52, height: 52)
                .background(AppColors.accent, in: .circle)
                .shadow(color: .black.opacity(0.28), radius: 9, y: 8)
                .shadow(color: AppColors.accent.opacity(0.25), radius: 8, y: 4)
        }
        .buttonStyle(PressScaleStyle(scale: 0.9))
        .accessibilityLabel(label)
    }
}

private struct PlaceholderScreen: View {
    let title: String

    var body: some View {
        Text(title)
            .textRole(.headlineLarge, color: AppColors.textPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.surface)
            .toolbar(.hidden, for: .navigationBar)
    }
}

private struct WelcomePlaceholder: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(spacing: 24) {
            Text(model.strings.appTitle)
                .textRole(.displaySmall, color: AppColors.textPrimary)
            Button(model.strings.unlockAction) { model.markStarted() }
                .buttonStyle(PrimaryButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
