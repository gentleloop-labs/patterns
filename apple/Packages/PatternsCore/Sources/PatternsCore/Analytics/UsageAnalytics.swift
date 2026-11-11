import Foundation

/// The anonymous, opt-in usage analytics from
/// `lib/services/usage_analytics.dart`, wire-compatible with the Flutter app
/// and the `patterns-analytics` worker: the same event and context names,
/// the same batch body, and the same queue and install-id preferences (so a
/// queue Flutter left behind is sent by native, and the reverse).
///
/// The vocabulary is closed. There is no raw-string method and no free-form
/// properties, so no journal text, trigger or note can ever be sent.
public enum UsageAnalyticsEvent: String, CaseIterable, Sendable {
    case appOpened = "app_opened"
    case onboardingStarted = "onboarding_started"
    case onboardingCompleted = "onboarding_completed"
    case journalOpened = "journal_opened"
    case journalEntryCreated = "journal_entry_created"
    case erpOpened = "erp_opened"
    case erpSessionStarted = "erp_session_started"
    case erpSessionCompleted = "erp_session_completed"
    case compulsionDelayStarted = "compulsion_delay_started"
    case compulsionDelayCompleted = "compulsion_delay_completed"
    case insightsOpened = "insights_opened"
    case paywallViewed = "paywall_viewed"
    case purchaseStarted = "purchase_started"
    case purchaseCompleted = "purchase_completed"
    case analyticsConsentGranted = "analytics_consent_granted"
    case activationCompleted = "activation_completed"
    case proFeatureTapped = "pro_feature_tapped"
    case productLoadResult = "product_load_result"
    case purchaseCanceled = "purchase_canceled"
    case purchaseFailed = "purchase_failed"
    case restoreStarted = "restore_started"
    case restoreCompleted = "restore_completed"
    case restoreNotFound = "restore_not_found"
    case restoreFailed = "restore_failed"
}

public enum UsageAnalyticsContext: String, CaseIterable, Sendable {
    case journal
    case compulsionDelay = "compulsion_delay"
    case guidedErp = "guided_erp"
    case selfCheck = "self_check"
    case success
    case unavailable
    case error
    case settings
    case todayNextStep = "today_next_step"
    case recoveryMetrics = "recovery_metrics"
    case exposureHierarchy = "exposure_hierarchy"
    case exposureMaterials = "exposure_materials"
    case structuredPrograms = "structured_programs"
    case actionPlanner = "action_planner"
    case implementationIntentions = "implementation_intentions"
    case urgeSurfing = "urge_surfing"
    case responsePrevention = "response_prevention"
    case uncertaintyTraining = "uncertainty_training"
    case behavioralExperiments = "behavioral_experiments"
    case reflectionJournal = "reflection_journal"
}

/// `QueuedAnalyticsEvent`: one queued event, stored as the exact JSON text
/// Dart's `jsonEncode` writes.
public struct QueuedAnalyticsEvent: Equatable, Sendable {
    public var event: UsageAnalyticsEvent
    /// 1 without a context, 2 with one.
    public var version: Int
    /// Milliseconds since the epoch.
    public var timestamp: Int64
    public var context: UsageAnalyticsContext?

    public init(event: UsageAnalyticsEvent, version: Int, timestamp: Int64, context: UsageAnalyticsContext? = nil) {
        self.event = event
        self.version = version
        self.timestamp = timestamp
        self.context = context
    }

    /// Key order and spacing match `jsonEncode(toJson())`. Wire names never
    /// need escaping.
    public func encode() -> String {
        var json = #"{"name":"\#(event.rawValue)","version":\#(version),"timestamp":\#(timestamp)"#
        if let context { json += #","context":"\#(context.rawValue)""# }
        return json + "}"
    }

    var jsonObject: [String: Any] {
        var object: [String: Any] = ["name": event.rawValue, "version": version, "timestamp": timestamp]
        if let context { object["context"] = context.rawValue }
        return object
    }

    /// `decode`: anything unexpected (unknown keys or names, a version other
    /// than 1 or 2, a non-integer timestamp) is dropped, as in Dart.
    public static func decode(_ text: String) -> QueuedAnalyticsEvent? {
        guard let data = text.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              Set(json.keys).isSubset(of: ["name", "version", "timestamp", "context"]),
              let version = integer(json["version"]), version == 1 || version == 2,
              let timestamp = integer(json["timestamp"]),
              let name = json["name"] as? String,
              let event = UsageAnalyticsEvent(rawValue: name)
        else { return nil }
        var context: UsageAnalyticsContext?
        if let raw = json["context"], !(raw is NSNull) {
            guard let string = raw as? String, let value = UsageAnalyticsContext(rawValue: string) else { return nil }
            context = value
        }
        return QueuedAnalyticsEvent(event: event, version: Int(version), timestamp: timestamp, context: context)
    }

    private static func integer(_ value: Any?) -> Int64? {
        guard let number = value as? NSNumber,
              !FlutterPreferences.isBoolean(number), !FlutterPreferences.isFloatingPoint(number) else { return nil }
        return number.int64Value
    }
}

/// `AnalyticsBatchTransport`: sends one JSON batch, true on a 2xx.
public protocol AnalyticsTransport: Sendable {
    func send(_ body: Data) async -> Bool
}

/// `HttpAnalyticsBatchTransport`: `POST <origin>/v1/events/batch`, 8 seconds.
public struct HTTPAnalyticsTransport: AnalyticsTransport {
    public let url: URL

    public init?(endpoint: URL) {
        // Dart's `endpoint.resolve('/v1/events/batch')`: an absolute path on
        // the endpoint's origin.
        guard var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false) else { return nil }
        components.path = "/v1/events/batch"
        components.query = nil
        components.fragment = nil
        guard let url = components.url else { return nil }
        self.url = url
    }

    public func send(_ body: Data) async -> Bool {
        var request = URLRequest(url: url, timeoutInterval: 8)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = body
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let status = (response as? HTTPURLResponse)?.statusCode else { return false }
            return (200..<300).contains(status)
        } catch {
            return false
        }
    }
}

/// `CloudflareAnalyticsService`. Runs on the main actor, which serialises
/// queue access the way Dart's `_synchronized` does. Analytics never throws
/// into, or waits up, a user-facing action.
@MainActor
public final class UsageAnalyticsService {
    public static let maxQueueSize = 500
    public static let uploadBatchSize = 50
    public static let flushThreshold = 10

    private let prefs: FlutterPreferences
    private let transport: any AnalyticsTransport
    private let platform: String
    private let appVersion: String
    private let hasConsent: () -> Bool
    private let now: () -> Date
    private var flushInProgress = false

    public init(prefs: FlutterPreferences, transport: any AnalyticsTransport, platform: String, appVersion: String,
                hasConsent: @escaping () -> Bool, now: @escaping () -> Date = Date.init) {
        self.prefs = prefs
        self.transport = transport
        self.platform = platform
        self.appVersion = appVersion
        self.hasConsent = hasConsent
        self.now = now
    }

    public var isCollectionEnabled: Bool { hasConsent() }
    public var pendingEvents: [QueuedAnalyticsEvent] { load() }

    /// Queues an event. Crossing the threshold triggers one upload attempt;
    /// a failure waits for the next interval or background flush rather
    /// than retrying per event.
    public func track(_ event: UsageAnalyticsEvent, context: UsageAnalyticsContext? = nil) {
        guard isCollectionEnabled else { return }
        var queued = load()
        queued.append(QueuedAnalyticsEvent(
            event: event, version: context == nil ? 1 : 2,
            timestamp: Int64((now().timeIntervalSince1970 * 1000).rounded(.down)), context: context
        ))
        if queued.count > Self.maxQueueSize {
            queued.removeFirst(queued.count - Self.maxQueueSize)
        }
        save(queued)
        if queued.count == Self.flushThreshold {
            Task { await flush() }
        }
    }

    /// Sends up to 50 queued events. They are removed only if the upload
    /// succeeded and they are still at the front of the queue.
    public func flush() async {
        guard isCollectionEnabled, !flushInProgress else { return }
        flushInProgress = true
        defer { flushInProgress = false }
        let snapshot = Array(load().prefix(Self.uploadBatchSize))
        guard !snapshot.isEmpty else { return }
        let body: [String: Any] = [
            "installId": installationID(),
            "platform": platform,
            "appVersion": appVersion,
            "events": snapshot.map(\.jsonObject),
        ]
        guard let data = try? JSONSerialization.data(withJSONObject: body) else { return }
        let succeeded = await transport.send(data)
        guard succeeded, isCollectionEnabled else { return }
        var current = load()
        let uploaded = snapshot.map { $0.encode() }
        if current.count >= uploaded.count, Array(current.prefix(uploaded.count)).map({ $0.encode() }) == uploaded {
            current.removeFirst(uploaded.count)
            save(current)
        }
    }

    /// Turning collection off drops the queue and the install id, so events
    /// on either side of an opt-out can never be linked.
    public func setCollectionEnabled(_ enabled: Bool) {
        guard !enabled else { return }
        prefs.remove(PreferenceKey.usageAnalyticsQueue)
        prefs.remove(PreferenceKey.usageAnalyticsInstallId)
    }

    private func load() -> [QueuedAnalyticsEvent] {
        (prefs.stringList(PreferenceKey.usageAnalyticsQueue) ?? []).compactMap(QueuedAnalyticsEvent.decode)
    }

    private func save(_ events: [QueuedAnalyticsEvent]) {
        prefs.set(events.map { $0.encode() }, for: PreferenceKey.usageAnalyticsQueue)
    }

    private func installationID() -> String {
        if let existing = prefs.string(PreferenceKey.usageAnalyticsInstallId) { return existing }
        // Random v4, lowercase like Dart's `_uuidV4`.
        let created = UUID().uuidString.lowercased()
        prefs.set(created, for: PreferenceKey.usageAnalyticsInstallId)
        return created
    }
}
