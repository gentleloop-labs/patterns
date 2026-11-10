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
            .sheet(item: $navigation.paywall) { entry in PaywallSheet(entryPoint: entry) }
            .sheet(item: $navigation.completion.identified) { item in
                CompletionSheet(kind: item.kind) {
                    navigation.completion = nil
                    navigation.returnToNeutralHome()
                }
            }
        }
        // The brand gold tints every system control, as an app accent colour.
        .tint(AppColors.accent)
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

/// `MobileHome`: the five tabs in a system tab bar, each with its own
/// navigation stack.
struct MainShell: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var didAppear = false
    @State private var askingAnalytics = false
    @State private var touring = false

    var body: some View {
        let strings = model.strings
        TabView(selection: Binding(get: { navigation.selectedTab }, set: { navigation.select($0) })) {
            ForEach(AppTab.allCases) { tab in
                NavigationStack(path: Binding(get: { navigation.paths[tab] ?? [] },
                                              set: { navigation.paths[tab] = $0 })) {
                    page(tab)
                        .navigationDestination(for: Route.self) { route in
                            destination(route)
                        }
                }
                .tabItem { Label(tab.title(strings), systemImage: tab.systemImage) }
                .tag(tab)
            }
        }
        .modifier(MinimizingTabBar())
        .onAppear(perform: onFirstAppear)
        .onChange(of: navigation.tourRequest) { startTour() }
        .sheet(isPresented: $touring) {
            TourSheet(steps: tourSteps(strings),
                      onShow: { step in navigation.select(step.tab ?? .home) },
                      onFinish: finishTour)
        }
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
        navigation.paths[.home] = []
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

    /// Outline symbols; the tab bar fills the selected one.
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

/// On iOS 26 the tab bar shrinks while scrolling down, as in Apple's apps.
private struct MinimizingTabBar: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.tabBarMinimizeBehavior(.onScrollDown)
        } else {
            content
        }
    }
}

private struct PlaceholderScreen: View {
    let title: String

    var body: some View {
        // Screens not ported yet (Phase 3 and 4).
        ContentUnavailableView(title, systemImage: "hammer")
            .background(AppColors.surface)
            .navigationTitle(title)
    }
}

