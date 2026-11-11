import Foundation
import Testing
@testable import PatternsCore

/// Mirrors `test/usage_analytics_test.dart` and `lib/services/telemetry.dart`
/// so native queues, batches and funnel counters stay interchangeable with
/// Flutter's.
@MainActor
@Suite("Usage analytics")
struct UsageAnalyticsTests {
    final class Defaults {
        let name = "patterns-analytics-\(UUID().uuidString)"
        let defaults: UserDefaults
        init() { defaults = UserDefaults(suiteName: name)! }
        deinit { defaults.removePersistentDomain(forName: name) }
        var prefs: FlutterPreferences { FlutterPreferences(defaults: defaults) }
    }

    final class FakeTransport: AnalyticsTransport, @unchecked Sendable {
        var succeeds = true
        var bodies: [[String: Any]] = []
        func send(_ body: Data) async -> Bool {
            bodies.append((try? JSONSerialization.jsonObject(with: body) as? [String: Any]) ?? [:])
            return succeeds
        }
    }

    private func service(_ store: Defaults, consent: Bool = true, transport: FakeTransport = FakeTransport(),
                         now: Date = Date(timeIntervalSince1970: 1_787_571_700)) -> UsageAnalyticsService {
        UsageAnalyticsService(prefs: store.prefs, transport: transport, platform: "ios", appVersion: "2.0.0+100",
                              hasConsent: { consent }, now: { now })
    }

    @Test("the vocabulary matches Flutter's wire names")
    func vocabulary() {
        #expect(Set(UsageAnalyticsEvent.allCases.map(\.rawValue)) == [
            "app_opened", "onboarding_started", "onboarding_completed", "journal_opened", "journal_entry_created",
            "erp_opened", "erp_session_started", "erp_session_completed", "compulsion_delay_started",
            "compulsion_delay_completed", "insights_opened", "paywall_viewed", "purchase_started",
            "purchase_completed", "analytics_consent_granted", "activation_completed", "pro_feature_tapped",
            "product_load_result", "purchase_canceled", "purchase_failed", "restore_started", "restore_completed",
            "restore_not_found", "restore_failed",
        ])
        #expect(UsageAnalyticsContext.allCases.count == 20)
        #expect(UsageAnalyticsContext.implementationIntentions.rawValue == "implementation_intentions")
    }

    @Test("queued events are stored as the exact text Dart's jsonEncode writes")
    func encoding() {
        let plain = QueuedAnalyticsEvent(event: .erpSessionCompleted, version: 1, timestamp: 1_787_571_700_000)
        #expect(plain.encode() == #"{"name":"erp_session_completed","version":1,"timestamp":1787571700000}"#)
        let withContext = QueuedAnalyticsEvent(event: .paywallViewed, version: 2, timestamp: 1_787_571_700_000,
                                               context: .exposureHierarchy)
        #expect(withContext.encode()
            == #"{"name":"paywall_viewed","version":2,"timestamp":1787571700000,"context":"exposure_hierarchy"}"#)
        #expect(QueuedAnalyticsEvent.decode(withContext.encode()) == withContext)
    }

    @Test("anything outside the closed schema is dropped on read", arguments: [
        #"{"name":"app_opened","version":3,"timestamp":1}"#,
        #"{"name":"app_opened","version":1,"timestamp":1.5}"#,
        #"{"name":"app_opened","version":1,"timestamp":"1"}"#,
        #"{"name":"something_else","version":1,"timestamp":1}"#,
        #"{"name":"app_opened","version":2,"timestamp":1,"context":"unknown"}"#,
        #"{"name":"app_opened","version":1,"timestamp":1,"note":"text"}"#,
        #"{"name":"app_opened","version":true,"timestamp":1}"#,
        "not json",
    ])
    func rejects(_ text: String) {
        #expect(QueuedAnalyticsEvent.decode(text) == nil)
    }

    @Test("a queue Flutter left behind is read and sent")
    func flutterQueue() async {
        let store = Defaults()
        store.defaults.set([
            #"{"name":"app_opened","version":1,"timestamp":1787571700000}"#,
            #"{"name":"bogus"}"#,
            #"{"name":"pro_feature_tapped","version":2,"timestamp":1787571700001,"context":"settings"}"#,
        ], forKey: "flutter.usageAnalyticsQueueV1")
        store.defaults.set("4f1c2b9e-0000-4000-8000-000000000001", forKey: "flutter.usageAnalyticsInstallIdV1")
        let transport = FakeTransport()
        let analytics = service(store, transport: transport)
        #expect(analytics.pendingEvents.count == 2)

        await analytics.flush()
        let body = try! #require(transport.bodies.first)
        #expect(body["installId"] as? String == "4f1c2b9e-0000-4000-8000-000000000001")
        #expect(body["platform"] as? String == "ios")
        #expect(body["appVersion"] as? String == "2.0.0+100")
        let events = body["events"] as? [[String: Any]] ?? []
        #expect(events.map { $0["name"] as? String } == ["app_opened", "pro_feature_tapped"])
        #expect(events.last?["context"] as? String == "settings")
        #expect(events.first?["context"] == nil)
        #expect(analytics.pendingEvents.isEmpty)
    }

    @Test("without consent nothing is queued and no install id is made")
    func noConsent() async {
        let store = Defaults()
        let transport = FakeTransport()
        let analytics = service(store, consent: false, transport: transport)
        analytics.track(.appOpened)
        await analytics.flush()
        #expect(analytics.pendingEvents.isEmpty)
        #expect(transport.bodies.isEmpty)
        #expect(!store.prefs.contains(PreferenceKey.usageAnalyticsInstallId))
    }

    @Test("v1 without a context, v2 with one, millisecond timestamps")
    func tracking() {
        let store = Defaults()
        let analytics = service(store)
        analytics.track(.journalOpened)
        analytics.track(.paywallViewed, context: .settings)
        #expect(analytics.pendingEvents == [
            QueuedAnalyticsEvent(event: .journalOpened, version: 1, timestamp: 1_787_571_700_000),
            QueuedAnalyticsEvent(event: .paywallViewed, version: 2, timestamp: 1_787_571_700_000, context: .settings),
        ])
        // Another service on the same storage sees the same queue.
        #expect(service(store).pendingEvents.count == 2)
    }

    @Test("a failed upload keeps the queue and the install id stays stable")
    func failedUpload() async {
        let store = Defaults()
        let transport = FakeTransport()
        transport.succeeds = false
        let analytics = service(store, transport: transport)
        analytics.track(.appOpened)
        await analytics.flush()
        #expect(analytics.pendingEvents.count == 1)
        transport.succeeds = true
        await analytics.flush()
        #expect(analytics.pendingEvents.isEmpty)
        let ids = transport.bodies.compactMap { $0["installId"] as? String }
        #expect(ids.count == 2 && ids[0] == ids[1])
        #expect(ids[0] == ids[0].lowercased() && UUID(uuidString: ids[0]) != nil)
    }

    @Test("uploads go out in batches of 50 and the queue keeps the newest 500")
    func limits() async {
        let store = Defaults()
        let transport = FakeTransport()
        transport.succeeds = false
        let analytics = service(store, transport: transport)
        for _ in 0..<520 { analytics.track(.insightsOpened) }
        #expect(analytics.pendingEvents.count == 500)
        transport.succeeds = true
        transport.bodies = []
        await analytics.flush()
        #expect((transport.bodies.first?["events"] as? [Any])?.count == 50)
        #expect(analytics.pendingEvents.count == 450)
    }

    @Test("opting out clears the queue and the install id")
    func optOut() async {
        let store = Defaults()
        let analytics = service(store, transport: { let t = FakeTransport(); t.succeeds = false; return t }())
        analytics.track(.appOpened)
        await analytics.flush()
        #expect(store.prefs.contains(PreferenceKey.usageAnalyticsInstallId))
        analytics.setCollectionEnabled(false)
        #expect(!store.prefs.contains(PreferenceKey.usageAnalyticsQueue))
        #expect(!store.prefs.contains(PreferenceKey.usageAnalyticsInstallId))
    }

    @Test("the batch goes to /v1/events/batch on the endpoint's origin")
    func endpoint() {
        let transport = HTTPAnalyticsTransport(endpoint: URL(string: "https://patterns-analytics.maskedsyntax.workers.dev")!)
        #expect(transport?.url.absoluteString == "https://patterns-analytics.maskedsyntax.workers.dev/v1/events/batch")
        let nested = HTTPAnalyticsTransport(endpoint: URL(string: "http://127.0.0.1:8787/some/path?x=1")!)
        #expect(nested?.url.absoluteString == "http://127.0.0.1:8787/v1/events/batch")
    }
}

@Suite("On-device telemetry")
struct LocalTelemetryTests {
    final class Defaults {
        let name = "patterns-telemetry-\(UUID().uuidString)"
        let defaults: UserDefaults
        init() { defaults = UserDefaults(suiteName: name)! }
        deinit { defaults.removePersistentDomain(forName: name) }
        var prefs: FlutterPreferences { FlutterPreferences(defaults: defaults) }
    }

    @Test("counters, categorical sub-counters and the log use Flutter's keys")
    func logging() {
        let store = Defaults()
        let telemetry = LocalTelemetry(prefs: store.prefs)
        telemetry.log("onboarding_completed", ["path": .string("urge"), "big": .int(500)])
        #expect(store.prefs.int("tel_count_onboarding_completed") == 1)
        #expect(store.prefs.int("tel_count_onboarding_completed.path:urge") == 1)
        #expect(store.prefs.int("tel_count_onboarding_completed.big:500") == nil)
        let line = store.prefs.stringList(PreferenceKey.telemetryLog)?.last ?? ""
        #expect(line.hasPrefix(#"{"t":""#))
        #expect(line.hasSuffix(#","e":"onboarding_completed","p":{"path":"urge","big":500}}"#))
    }

    @Test("logOnce fires once per installation")
    func once() {
        let store = Defaults()
        store.defaults.set(true, forKey: "flutter.tel_once_first_open") // set by Flutter before the upgrade
        let telemetry = LocalTelemetry(prefs: store.prefs)
        #expect(!telemetry.logOnce("first_open"))
        #expect(telemetry.logOnce("first_journal_entry_created"))
        #expect(!telemetry.logOnce("first_journal_entry_created"))
        #expect(store.prefs.int("tel_count_first_journal_entry_created") == 1)
    }

    @Test("session starts record day 0, then one retention marker per return day")
    func sessions() {
        let store = Defaults()
        let start = Date(timeIntervalSince1970: 1_787_571_700)
        LocalTelemetry(prefs: store.prefs, now: { start }).recordSessionStart()
        let installDay = store.prefs.int(PreferenceKey.telemetryInstallDay)
        #expect(installDay == LocalTelemetry.dayNumber(start))
        let later = Calendar.current.date(byAdding: .day, value: 3, to: start)!
        LocalTelemetry(prefs: store.prefs, now: { later }).recordSessionStart()
        LocalTelemetry(prefs: store.prefs, now: { later }).recordSessionStart()
        #expect(store.prefs.stringList(PreferenceKey.telemetryReturnedDays) == ["3"])
        #expect(store.prefs.int("tel_count_retention.day") == 1)
        #expect(store.prefs.int("tel_count_session.start") == 3)
    }

    @Test("slugs reduce anything to a short identifier", arguments: [
        ("Compulsion Delay", "compulsion_delay"), ("  urge!! ", "urge"), ("", "unknown"),
        ("a sentence that is far too long to be an identifier", "a_sentence_that_is_far_t"), ("Écrire", "crire"),
    ])
    func slug(_ input: String, _ expected: String) {
        #expect(LocalTelemetry.slug(input) == expected)
    }
}
