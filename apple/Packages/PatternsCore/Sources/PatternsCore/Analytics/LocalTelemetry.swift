import Foundation

/// `Telemetry` from `lib/services/telemetry.dart`: an on-device funnel that
/// never leaves the phone. It keeps counters (`tel_count_<event>`), one-time
/// markers (`tel_once_<event>`), a 250-line log and day-N retention markers,
/// under the same keys Flutter writes, so an upgraded install carries on
/// counting where it left off.
public struct LocalTelemetry {
    static let countPrefix = "tel_count_"
    static let oncePrefix = "tel_once_"
    static let maxLogEntries = 250

    /// A categorical property value: a bool, a short string or a small int.
    public enum Value: Sendable, Equatable {
        case bool(Bool)
        case string(String)
        case int(Int)
    }

    private let prefs: FlutterPreferences
    private let now: () -> Date

    public init(prefs: FlutterPreferences, now: @escaping () -> Date = Date.init) {
        self.prefs = prefs
        self.now = now
    }

    /// Records an event. `props` keeps its order, as Dart's map literal does.
    public func log(_ event: String, _ props: KeyValuePairs<String, Value> = [:]) {
        increment(event)
        for (key, value) in props where Self.isCategorical(value) {
            increment("\(event).\(key):\(Self.counterText(value))")
        }
        var line = #"{"t":"\#(DartTimestamp(now()).raw)","e":\#(Self.jsonString(event))"#
        if !props.isEmpty {
            line += #","p":{"# + props.map { "\(Self.jsonString($0.key)):\(Self.json($0.value))" }.joined(separator: ",") + "}"
        }
        line += "}"
        var log = prefs.stringList(PreferenceKey.telemetryLog) ?? []
        log.append(line)
        if log.count > Self.maxLogEntries { log.removeFirst(log.count - Self.maxLogEntries) }
        prefs.set(log, for: PreferenceKey.telemetryLog)
    }

    /// Logs once per installation. Returns whether it logged.
    @discardableResult
    public func logOnce(_ event: String, _ props: KeyValuePairs<String, Value> = [:]) -> Bool {
        let key = Self.oncePrefix + event
        if prefs.bool(key) ?? false { return false }
        prefs.set(true, for: key)
        log(event, props)
        return true
    }

    /// `recordSessionStart`: day 0 on first launch, then one retention
    /// marker per day number the user comes back on (capped at 60).
    public func recordSessionStart() {
        let today = Self.dayNumber(now())
        guard let installDay = prefs.int(PreferenceKey.telemetryInstallDay) else {
            prefs.set(today, for: PreferenceKey.telemetryInstallDay)
            log("session.start", ["day": .int(0)])
            return
        }
        let dayN = today - installDay
        log("session.start", ["day": .int(min(max(dayN, 0), 60))])
        if dayN > 0 {
            var returned = prefs.stringList(PreferenceKey.telemetryReturnedDays) ?? []
            let marker = String(dayN)
            if !returned.contains(marker) {
                returned.append(marker)
                prefs.set(returned, for: PreferenceKey.telemetryReturnedDays)
                log("retention.day", ["n": .int(min(max(dayN, 1), 60))])
            }
        }
    }

    /// `_slug`: lowercase `[a-z0-9_]`, at most 24 characters, so prose can
    /// never reach the funnel.
    public static func slug(_ value: String) -> String {
        var cleaned = ""
        var lastWasSeparator = false
        for character in value.lowercased() {
            if character.isASCII, character.isLetter || character.isNumber || character == "_" {
                cleaned.append(character)
                lastWasSeparator = false
            } else if !lastWasSeparator {
                cleaned.append("_")
                lastWasSeparator = true
            }
        }
        while cleaned.hasPrefix("_") { cleaned.removeFirst() }
        while cleaned.hasSuffix("_") { cleaned.removeLast() }
        if cleaned.isEmpty { return "unknown" }
        return String(cleaned.prefix(24))
    }

    // MARK: Internals

    /// Local midnight in epoch milliseconds, divided into whole days.
    static func dayNumber(_ date: Date) -> Int {
        let midnight = Calendar.current.startOfDay(for: date)
        return Int((midnight.timeIntervalSince1970 * 1000) / 86_400_000)
    }

    private func increment(_ name: String) {
        let key = Self.countPrefix + name
        prefs.set((prefs.int(key) ?? 0) + 1, for: key)
    }

    private static func isCategorical(_ value: Value) -> Bool {
        switch value {
        case .bool: true
        case let .string(text): text.count <= 24
        case let .int(number): (0...60).contains(number)
        }
    }

    private static func counterText(_ value: Value) -> String {
        switch value {
        case let .bool(flag): flag ? "true" : "false"
        case let .string(text): text
        case let .int(number): String(number)
        }
    }

    private static func json(_ value: Value) -> String {
        switch value {
        case let .bool(flag): flag ? "true" : "false"
        case let .string(text): jsonString(text)
        case let .int(number): String(number)
        }
    }

    private static func jsonString(_ text: String) -> String {
        let data = (try? JSONSerialization.data(withJSONObject: [text], options: [.fragmentsAllowed, .withoutEscapingSlashes])) ?? Data()
        let array = String(decoding: data, as: UTF8.self)
        return String(array.dropFirst().dropLast())
    }
}
