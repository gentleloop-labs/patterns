import Foundation
import PatternsCore

/// `AppEvents` from `lib/services/app_events.dart`: the funnel, named as on
/// the website and the analytics board.
///
/// Two sinks, as in Flutter:
/// - `LocalTelemetry`, on-device counters that never leave the phone.
/// - `UsageAnalyticsService`, a smaller closed set of events, sent only
///   after the user said yes to sharing anonymous usage.
///
/// No method takes free text. Every parameter is a bool, a small number or
/// a value from a closed set, so journal text, triggers, notes and the like
/// cannot reach either sink, even by mistake.
@MainActor
final class AppEvents {
    private let telemetry: LocalTelemetry
    private let analytics: UsageAnalyticsService?

    init(prefs: FlutterPreferences) {
        telemetry = LocalTelemetry(prefs: prefs)
        analytics = AnalyticsConfiguration.endpoint
            .flatMap { HTTPAnalyticsTransport(endpoint: $0) }
            .map { transport in
                UsageAnalyticsService(
                    prefs: prefs, transport: transport, platform: "ios", appVersion: AnalyticsConfiguration.appVersion,
                    hasConsent: { prefs.bool(PreferenceKey.usageAnalyticsEnabled) ?? false }
                )
            }
    }

    // MARK: Collection

    /// Uploads what is queued (on an interval, on backgrounding, and right
    /// after the user opts in).
    func flush() async { await analytics?.flush() }

    /// Opting out drops the queue and the anonymous install id.
    func setCollectionEnabled(_ enabled: Bool) { analytics?.setCollectionEnabled(enabled) }

    // MARK: Funnel

    /// Every launch: the session and retention counters, and `app_opened`.
    func appLaunched() {
        telemetry.recordSessionStart()
        telemetry.logOnce("first_open")
        track(.appOpened)
    }

    func onboardingStarted() {
        telemetry.log("onboarding.s1_shown")
        telemetry.logOnce("onboarding_started")
        track(.onboardingStarted)
    }

    func onboardingCompleted(path: FirstRunPath) {
        telemetry.log("onboarding.path_chosen", ["path": .string(path.rawValue)])
        telemetry.logOnce("onboarding_completed", ["path": .string(LocalTelemetry.slug(path.rawValue))])
        track(.onboardingCompleted)
    }

    func firstRunActivityStarted(_ path: FirstRunPath) {
        telemetry.log("activity.started", ["kind": .string(path.rawValue)])
        if path == .selfcheck { telemetry.log("selfcheck.started") }
    }

    func firstRunActivityCompleted(_ path: FirstRunPath) {
        telemetry.log("activity.completed", ["kind": .string(path.rawValue)])
        if path == .selfcheck {
            telemetry.log("selfcheck.completed")
            firstMeaningfulAction("self_check")
        }
    }

    /// A journal entry for a new day was saved. Its content is never passed.
    func journalEntryCreated() {
        telemetry.logOnce("first_journal_entry_created")
        track(.journalEntryCreated)
        firstMeaningfulAction("journal")
    }

    /// A compulsion-delay timer started. The urge's text is not a parameter.
    func compulsionDelayStarted() {
        telemetry.logOnce("first_compulsion_delay_started")
        track(.compulsionDelayStarted)
    }

    /// A compulsion-delay session was saved. Only whether the timer ran out
    /// is recorded; ratings and notes are not.
    func compulsionDelaySaved(ranToCompletion: Bool) {
        telemetry.logOnce("first_compulsion_delay_completed", ["completed": .bool(ranToCompletion)])
        if ranToCompletion { track(.compulsionDelayCompleted) }
        firstMeaningfulAction("compulsion_delay")
    }

    /// An exposure ladder was built. Only its step count, never its text.
    func exposureHierarchyCreated(stepCount: Int) {
        telemetry.logOnce("first_exposure_created", ["steps": .int(min(max(stepCount, 0), 60))])
    }

    func erpSessionStarted() { track(.erpSessionStarted) }

    /// An ERP practice was saved.
    func erpSessionSaved(ranToCompletion: Bool) {
        telemetry.logOnce("first_exposure_completed", ["completed": .bool(ranToCompletion)])
        if ranToCompletion { track(.erpSessionCompleted) }
        firstMeaningfulAction("exposure")
    }

    func journalOpened() { track(.journalOpened) }
    func erpOpened() { track(.erpOpened) }
    func insightsOpened() { track(.insightsOpened) }

    // MARK: Pro and purchases

    /// The paywall appeared.
    func paywallShown(_ source: ProEntryPoint) {
        telemetry.log("paywall.shown", ["source": .string(source.wireName)])
        track(.proFeatureTapped, context: source.analyticsContext)
        telemetry.log("supporter_screen_viewed", ["source": .string(source.wireName)])
        track(.paywallViewed, context: source.analyticsContext)
    }

    func productLoadResult(_ result: UsageAnalyticsContext) { track(.productLoadResult, context: result) }

    func purchaseStarted(_ source: ProEntryPoint) {
        telemetry.log("supporter_purchase_started")
        track(.purchaseStarted, context: source.analyticsContext)
    }

    /// A purchase or restore succeeded. No price, receipt or account.
    func purchaseCompleted(restored: Bool, source: ProEntryPoint) {
        telemetry.log(restored ? "paywall.restore" : "paywall.purchase")
        telemetry.log("supporter_purchase_completed", ["restored": .bool(restored)])
        track(restored ? .restoreCompleted : .purchaseCompleted, context: source.analyticsContext)
    }

    func purchaseCanceled(_ source: ProEntryPoint) { track(.purchaseCanceled, context: source.analyticsContext) }
    func purchaseFailed(_ source: ProEntryPoint) { track(.purchaseFailed, context: source.analyticsContext) }
    func restoreStarted(_ source: ProEntryPoint) { track(.restoreStarted, context: source.analyticsContext) }
    func restoreNotFound(_ source: ProEntryPoint) { track(.restoreNotFound, context: source.analyticsContext) }
    func restoreFailed(_ source: ProEntryPoint) { track(.restoreFailed, context: source.analyticsContext) }

    /// The user agreed to share usage, from the prompt (with the action that
    /// made it due) or from Settings (without one).
    func analyticsConsentGranted(after action: MeaningfulAction? = nil) {
        track(.analyticsConsentGranted)
        guard let action else { return }
        let context: UsageAnalyticsContext = switch action {
        case .journal: .journal
        case .compulsionDelay: .compulsionDelay
        case .guidedErp: .guidedErp
        case .selfCheck: .selfCheck
        }
        track(.activationCompleted, context: context)
    }

    // MARK: Internals

    /// `first_meaningful_action`, once per install, with whichever primary
    /// action came first.
    private func firstMeaningfulAction(_ kind: String) {
        telemetry.logOnce("first_meaningful_action", ["kind": .string(LocalTelemetry.slug(kind))])
    }

    private func track(_ event: UsageAnalyticsEvent, context: UsageAnalyticsContext? = nil) {
        analytics?.track(event, context: context)
    }
}

/// `UsageAnalyticsConfiguration`. Release builds (TestFlight and the App
/// Store) send to the production worker, as Flutter's release builds do.
/// Debug builds send nothing unless `PATTERNS_ANALYTICS_DEV_ENDPOINT` is set
/// in the environment, which may be plain http for a local test server.
enum AnalyticsConfiguration {
    static let productionEndpoint = URL(string: "https://patterns-analytics.maskedsyntax.workers.dev")!

    static var endpoint: URL? {
        #if DEBUG
        guard let raw = ProcessInfo.processInfo.environment["PATTERNS_ANALYTICS_DEV_ENDPOINT"],
              let url = URL(string: raw), url.host?.isEmpty == false,
              url.scheme == "https" || url.scheme == "http"
        else { return nil }
        return url
        #else
        return productionEndpoint
        #endif
    }

    /// `version+build`, as `PackageInfo` reports it.
    static var appVersion: String {
        let info = Bundle.main.infoDictionary
        let version = info?["CFBundleShortVersionString"] as? String ?? "0"
        let build = info?["CFBundleVersion"] as? String ?? ""
        return build.isEmpty ? version : "\(version)+\(build)"
    }
}

extension ProEntryPoint {
    /// `_proContext`.
    var analyticsContext: UsageAnalyticsContext {
        switch self {
        case .settings: .settings
        case .todayNextStep: .todayNextStep
        case .recoveryMetrics: .recoveryMetrics
        case .exposureHierarchy: .exposureHierarchy
        case .exposureMaterials: .exposureMaterials
        case .structuredPrograms: .structuredPrograms
        case .actionPlanner: .actionPlanner
        case .implementationIntentions: .implementationIntentions
        case .urgeSurfing: .urgeSurfing
        case .responsePrevention: .responsePrevention
        case .uncertaintyTraining: .uncertaintyTraining
        case .behavioralExperiments: .behavioralExperiments
        case .reflectionJournal: .reflectionJournal
        }
    }
}
