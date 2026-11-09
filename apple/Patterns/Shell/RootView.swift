import PatternsCore
import SwiftUI

/// Mirrors `MobileShell`: welcome and first-run for new installs, otherwise
/// the main tabs. Everything sits behind the privacy gate.
struct RootView: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        @Bindable var navigation = navigation
        PrivacyGate {
            Group {
                if model.hasStarted && !model.hasSeenCurrentRelease {
                    WhatsNewScreen(onShowHome: { model.markReleaseSeen(showHome: true) },
                                   onContinue: { model.markReleaseSeen(showHome: false) })
                } else if model.hasStarted {
                    MainShell()
                } else {
                    WelcomeScreen(
                        onChoosePath: { path in
                            model.completeOnboarding(path: path)
                            navigation.pendingFirstRun = path
                        },
                        onImport: {
                            // Returning users with a backup land on a normal
                            // home and go straight to Settings to import.
                            model.completeOnboarding(path: .explore)
                            navigation.push(.settings)
                        }
                    )
                }
            }
            .background(AppColors.surface.ignoresSafeArea())
            .overlay(alignment: .bottom) { ToastHost() }
            .overlay { DialogHost() }
            .bottomPanel(item: $navigation.paywall) { entry in PaywallSheet(entryPoint: entry) }
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
        .onChange(of: scenePhase) { _, phase in
            // `_ProLifecycleObserver`: re-check the Pro entitlement on resume.
            if phase == .active { Task { await model.store.reconcile() } }
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

/// `MobileHome`: the tab pages, the floating tab bar and the add button.
/// Pushed pages cover the tab bar, as Flutter's routes do.
struct MainShell: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var didAppear = false
    @State private var askingAnalytics = false
    @State private var touring = false

    var body: some View {
        @Bindable var navigation = navigation
        let strings = model.strings
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
            .overlayPreferenceValue(TabAnchorKey.self) { anchors in
                if touring {
                    SpotlightTour(steps: tourSteps(strings), anchors: anchors,
                                  onShow: { step in navigation.select(step.tab ?? .home) },
                                  onFinish: finishTour)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Route.self) { route in
                destination(route)
            }
        }
        .onAppear(perform: onFirstAppear)
        .onChange(of: navigation.tourRequest) { startTour() }
        .alert(strings.analyticsPromptTitle, isPresented: $askingAnalytics) {
            Button(strings.notNowAction, role: .cancel) { model.setUsageAnalytics(false) }
            Button(strings.shareAnonymousUsageAction) { model.setUsageAnalytics(true) }
        } message: {
            Text(strings.analyticsPromptBody)
        }
    }

    @ViewBuilder
    private func page(_ tab: AppTab) -> some View {
        switch tab {
        case .journal: JournalScreen()
        case .track: OcdTrackerScreen()
        case .home: TodayScreen()
        default: PlaceholderScreen(title: tab.title(model.strings))
        }
    }

    @ViewBuilder
    private func destination(_ route: Route) -> some View {
        switch route {
        case let .journalEntry(day): JournalEntryEditor(day: day).id(day)
        case let .ocdEvent(entryID, type): OcdEventFlow(entryID: entryID, initialType: type)
        case .compulsionDelay: PlaceholderScreen(title: model.strings.trackerPauseUrgeAction)
        case .settings: SettingsScreen()
        case .selfCheck: PlaceholderScreen(title: model.strings.todaySelfCheckTitle)
        case .exposureHierarchy: PlaceholderScreen(title: model.strings.todayNextHierarchyTitle)
        case .erpExercises: PlaceholderScreen(title: model.strings.todayStartErp)
        case .exposureReflection: PlaceholderScreen(title: model.strings.todayNextReflectTitle)
        case let .firstRunActivity(path): firstRunActivity(path)
        case let .firstRunResult(path): FirstRunResultScreen(kind: path)
        }
    }

    /// `_pushFirstRunFlow`. The delay, ERP and self-check flows arrive with
    /// the Pro tools port.
    @ViewBuilder
    private func firstRunActivity(_ path: FirstRunPath) -> some View {
        switch path {
        case .journal: OcdEventFlow(entryID: nil, initialType: .obsession, firstRun: true)
        case .urge: PlaceholderScreen(title: model.strings.todayDelayUrgeTitle)
        case .erp: PlaceholderScreen(title: model.strings.todayPracticeErpTitle)
        case .selfcheck: PlaceholderScreen(title: model.strings.todaySelfCheckTitle)
        case .explore: EmptyView()
        }
    }

    /// Runs once when the home first appears: the chosen first-run activity
    /// for a brand-new user, otherwise the analytics question when it is due.
    private func onFirstAppear() {
        guard !didAppear else { return }
        didAppear = true
        if let path = navigation.pendingFirstRun {
            navigation.pendingFirstRun = nil
            if path != .explore { navigation.push(.firstRunActivity(path)) }
            return
        }
        // Eligibility is captured once per launch, so an action recorded
        // later in this session only makes the question due next time.
        let eligible = model.analyticsConsentUndecided
            && (model.prefs.int(PreferenceKey.meaningfulActionCount) ?? 0) > 0
        guard eligible else { return }
        Task {
            try? await Task.sleep(for: .milliseconds(450))
            if model.analyticsConsentUndecided { askingAnalytics = true }
        }
    }

    /// `_startTour(force: true)`: replayed from Settings once the pop has
    /// settled.
    private func startTour() {
        guard !touring else { return }
        navigation.select(.home)
        Task {
            try? await Task.sleep(for: .milliseconds(350))
            touring = true
        }
    }

    private func finishTour(runCta: Bool) {
        touring = false
        model.prefs.set(true, for: PreferenceKey.tabTourSeen)
        navigation.select(.home)
        if runCta { navigation.push(.selfCheck) }
    }

    /// `_buildTourSteps`: one step per tab, then a closing card that offers
    /// the self-check.
    private func tourSteps(_ strings: Strings) -> [TourStep] {
        [
            TourStep(tab: .home, title: strings.navToday, points: [strings.shellText(key: "sectionTodayBody")]),
            TourStep(tab: .journal, title: strings.navJournal, points: [strings.shellText(key: "sectionJournalBody")]),
            TourStep(tab: .track, title: strings.navTrack, points: [strings.shellText(key: "sectionTrackBody")]),
            TourStep(tab: .erp, title: strings.navRecovery, points: [strings.shellText(key: "sectionRecoveryBody")]),
            TourStep(tab: .insights, title: strings.navInsights, points: [strings.shellText(key: "sectionInsightsBody")]),
            TourStep(tab: nil, title: strings.shellText(key: "tourFinalTitle"),
                     points: [strings.shellText(key: "tourFinalBody")], cta: strings.shellText(key: "takeSelfCheck")),
        ]
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
            case .track: navigation.push(.ocdEvent(entryID: nil, type: .obsession))
            default: break
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
                    .anchorPreference(key: TabAnchorKey.self, value: .bounds) { [tab: $0] }
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

