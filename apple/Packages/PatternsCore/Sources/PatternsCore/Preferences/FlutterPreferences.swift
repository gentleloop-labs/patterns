import Foundation

/// Settings stored by Flutter's `shared_preferences` (legacy API, plugin
/// `shared_preferences_foundation` 2.5): `UserDefaults.standard`, every key
/// prefixed with `flutter.`.
///
/// The native app keeps the same names and value types, so an upgraded user
/// keeps Pro, app lock, reminders, language, appearance and consent choices,
/// and a Flutter build installed on top would still read them.
///
/// Types matter. Dart casts strictly (`getBool` on a stored int throws), so
/// bools are written as bools, ints as integers and doubles as doubles.
public final class FlutterPreferences: @unchecked Sendable {
    public static let prefix = "flutter."

    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    private func storageKey(_ key: String) -> String { Self.prefix + key }

    // MARK: Reading (strictly typed, like Dart)

    public func object(_ key: String) -> Any? {
        defaults.object(forKey: storageKey(key))
    }

    public func bool(_ key: String) -> Bool? {
        guard let number = object(key) as? NSNumber, Self.isBoolean(number) else { return nil }
        return number.boolValue
    }

    public func int(_ key: String) -> Int? {
        guard let number = object(key) as? NSNumber,
              !Self.isBoolean(number), !Self.isFloatingPoint(number) else { return nil }
        return number.intValue
    }

    public func double(_ key: String) -> Double? {
        guard let number = object(key) as? NSNumber,
              !Self.isBoolean(number), Self.isFloatingPoint(number) else { return nil }
        return number.doubleValue
    }

    public func string(_ key: String) -> String? {
        object(key) as? String
    }

    public func stringList(_ key: String) -> [String]? {
        guard let array = object(key) as? [Any] else { return nil }
        let strings = array.compactMap { $0 as? String }
        return strings.count == array.count ? strings : nil
    }

    public func contains(_ key: String) -> Bool { object(key) != nil }

    /// All Flutter-visible keys, without the prefix (Dart's `getKeys()`).
    public var keys: Set<String> {
        Set(defaults.dictionaryRepresentation().keys
            .filter { $0.hasPrefix(Self.prefix) }
            .map { String($0.dropFirst(Self.prefix.count)) })
    }

    // MARK: Writing

    public func set(_ value: Bool, for key: String) { defaults.set(value, forKey: storageKey(key)) }
    public func set(_ value: Int, for key: String) { defaults.set(NSNumber(value: Int64(value)), forKey: storageKey(key)) }
    public func set(_ value: Double, for key: String) { defaults.set(NSNumber(value: value), forKey: storageKey(key)) }
    public func set(_ value: String, for key: String) { defaults.set(value, forKey: storageKey(key)) }
    public func set(_ value: [String], for key: String) { defaults.set(value, forKey: storageKey(key)) }

    public func remove(_ key: String) { defaults.removeObject(forKey: storageKey(key)) }

    /// Dart's `clear()`: removes only `flutter.`-prefixed keys.
    public func clear() {
        for key in keys { remove(key) }
    }

    // MARK: NSNumber classification (mirrors Flutter's standard codec)

    static func isBoolean(_ number: NSNumber) -> Bool {
        CFGetTypeID(number) == CFBooleanGetTypeID()
    }

    static func isFloatingPoint(_ number: NSNumber) -> Bool {
        let type = String(cString: number.objCType)
        return type == "d" || type == "f"
    }
}

/// Every key the Flutter app stores, by its exact stored name.
/// Sources: `lib/app_preferences.dart`, `lib/services/review_prompt.dart`,
/// `lib/services/telemetry.dart`, `lib/services/usage_analytics.dart`,
/// `lib/widgets/section_intro.dart`.
public enum PreferenceKey {
    // app_preferences.dart
    public static let appLockEnabled = "appLockEnabled"
    public static let mobileSelectedTab = "mobileSelectedTab"
    public static let desktopSelectedTab = "desktopSelectedTab"
    public static let reminderEnabled = "reminderEnabled"
    public static let reminderHour = "reminderHour"
    public static let reminderMinute = "reminderMinute"
    public static let proUnlocked = "proUnlocked"
    public static let lastSeenReleaseId = "lastSeenReleaseId"
    public static let releaseAnnouncementScheduledId = "releaseAnnouncementScheduledId"
    public static let hasStarted = "hasStarted"
    public static let appearance = "appearance"
    public static let appearanceMigrationV1 = "appearanceMigrationV1"
    public static let appLanguage = "appLanguage"
    public static let calmInsightsEnabled = "calmInsightsEnabled"
    public static let analyticsConsentDecision = "analyticsConsentDecision"
    public static let meaningfulActionCount = "meaningfulActionCount"
    public static let lastMeaningfulAction = "lastMeaningfulAction"
    public static let proCardDismissedUntil = "proCardDismissedUntil"
    public static let tabTourSeen = "sectionSeen_tabTour"
    public static let firstRunPath = "firstRunPath"
    public static let firstActivityDone = "firstActivityDone"
    public static let debugSeedEnabled = "debugSeedEnabled"
    public static let usageAnalyticsEnabled = "usageAnalyticsEnabled"

    /// `SectionIntro` one-time intro flags.
    public static func sectionSeen(_ id: String) -> String { "sectionSeen_\(id)" }

    // review_prompt.dart
    public static let ratingAttemptHistory = "rating_request_attempt_timestamps"
    public static let ratingCompleted = "rating_completed"
    public static let ratingDistinctDays = "rating_distinct_days"
    public static let ratingFirstSeen = "rating_first_seen_ts"
    public static let ratingJournalCount = "rating_journal_count"
    public static let ratingLastDayKey = "rating_last_day_key"
    public static let ratingLastDeclineTs = "rating_last_decline_ts"
    public static let ratingLastFailureTs = "rating_last_failure_ts"
    public static let ratingLastPromptTs = "rating_last_prompt_ts"
    public static let ratingMeaningfulActionCount = "rating_meaningful_action_count"
    public static let ratingOcdCount = "rating_ocd_count"
    public static let ratingOptedOut = "rating_opted_out"

    // telemetry.dart
    public static let telemetryLog = "tel_log"
    public static let telemetryInstallDay = "tel_install_day"
    public static let telemetryReturnedDays = "tel_returned_days"

    // usage_analytics.dart
    public static let usageAnalyticsQueue = "usageAnalyticsQueueV1"
    public static let usageAnalyticsInstallId = "usageAnalyticsInstallIdV1"
}

/// Stored values of the enum-like string preferences.
public enum AppAppearance: String, Sendable, CaseIterable { case system, light, dark }

public enum AnalyticsConsentDecision: String, Sendable, CaseIterable { case undecided, granted, declined }

/// `AppLanguage.preferenceValue` values from `lib/l10n/app_language.dart`.
public enum AppLanguage: String, Sendable, CaseIterable {
    case system
    case english = "en"
    case german = "de"
    case japanese = "ja"
    case spanish = "es"
    case french = "fr"
    case portugueseBrazil = "pt-BR"
}

extension FlutterPreferences {
    /// The launch-time defaults and migrations from Flutter's
    /// `initAppPreferences()`, applied in the same order with the same
    /// "established install" rule. Running this on an upgraded Flutter
    /// install is a no-op, because Flutter already wrote every key.
    public func applyLaunchMigrations() {
        // Captured before any write: new installs follow the system, upgrades
        // keep the choices they already had.
        let establishedInstall = !keys.isEmpty

        if string(PreferenceKey.appLanguage).flatMap(AppLanguage.init(rawValue:)) == nil {
            set(establishedInstall ? AppLanguage.english.rawValue : AppLanguage.system.rawValue,
                for: PreferenceKey.appLanguage)
        }

        if bool(PreferenceKey.calmInsightsEnabled) == nil {
            set(!establishedInstall, for: PreferenceKey.calmInsightsEnabled)
        }

        if !(bool(PreferenceKey.appearanceMigrationV1) ?? false) {
            set(establishedInstall ? AppAppearance.dark.rawValue : AppAppearance.system.rawValue,
                for: PreferenceKey.appearance)
            set(true, for: PreferenceKey.appearanceMigrationV1)
        }

        if !contains(PreferenceKey.analyticsConsentDecision) {
            let analyticsWasEnabled = bool(PreferenceKey.usageAnalyticsEnabled) ?? false
            let decision: AnalyticsConsentDecision =
                analyticsWasEnabled ? .granted : establishedInstall ? .declined : .undecided
            set(decision.rawValue, for: PreferenceKey.analyticsConsentDecision)
        }

        if !contains(PreferenceKey.meaningfulActionCount) {
            set((bool(PreferenceKey.firstActivityDone) ?? false) ? 2 : 0, for: PreferenceKey.meaningfulActionCount)
        }
    }
}
