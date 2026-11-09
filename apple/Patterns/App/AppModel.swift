import Foundation
import Observation
import PatternsCore
import SwiftUI

/// App-wide state: the opened data stores and the user's settings.
///
/// Settings are always read from and written to the Flutter preference keys,
/// so the values survive a rollback to a Flutter build.
@MainActor
@Observable
final class AppModel {
    let prefs: FlutterPreferences
    let database: PatternsDatabase
    let materials: MaterialFileStore
    let supportDirectory: URL
    let navigation: AppNavigation

    private(set) var strings: Strings
    private(set) var language: AppLanguage
    private(set) var appearance: AppAppearance
    private(set) var appLockEnabled: Bool
    private(set) var hasStarted: Bool
    private(set) var calmInsightsEnabled: Bool
    private(set) var usageAnalyticsEnabled: Bool
    private(set) var reminder: ReminderSettings
    let store: PurchaseStore
    /// The cached unlock (`proUnlocked`), honoured offline as Flutter does.
    var proUnlocked: Bool { store.proUnlocked }

    /// Bumped after a restore or wipe so every screen reloads its data.
    private(set) var dataRevision = 0

    init(prefs: FlutterPreferences, database: PatternsDatabase, materials: MaterialFileStore, supportDirectory: URL) {
        self.prefs = prefs
        self.database = database
        self.materials = materials
        self.supportDirectory = supportDirectory
        navigation = AppNavigation(prefs: prefs)
        let language = prefs.string(PreferenceKey.appLanguage).flatMap(AppLanguage.init(rawValue:)) ?? .english
        self.language = language
        strings = Strings.load(locale: LocaleResolver.effectiveLocale(language: language))
        appearance = prefs.string(PreferenceKey.appearance).flatMap(AppAppearance.init(rawValue:)) ?? .system
        appLockEnabled = prefs.bool(PreferenceKey.appLockEnabled) ?? false
        hasStarted = prefs.bool(PreferenceKey.hasStarted) ?? false
        calmInsightsEnabled = prefs.bool(PreferenceKey.calmInsightsEnabled) ?? false
        usageAnalyticsEnabled = prefs.bool(PreferenceKey.usageAnalyticsEnabled) ?? false
        reminder = ReminderSettings(prefs: prefs)
        store = PurchaseStore(prefs: prefs)
    }

    /// Re-reads every setting after the preferences were cleared, as the
    /// Flutter wipe invalidates its preference providers. `hasStarted` is
    /// left alone so the screen does not jump to the welcome flow mid-use;
    /// like Flutter, the welcome shows on the next launch.
    func reloadPreferences() {
        let language = prefs.string(PreferenceKey.appLanguage).flatMap(AppLanguage.init(rawValue:)) ?? .english
        if language != self.language {
            self.language = language
            strings = Strings.load(locale: LocaleResolver.effectiveLocale(language: language))
        }
        appearance = prefs.string(PreferenceKey.appearance).flatMap(AppAppearance.init(rawValue:)) ?? .system
        appLockEnabled = prefs.bool(PreferenceKey.appLockEnabled) ?? false
        calmInsightsEnabled = prefs.bool(PreferenceKey.calmInsightsEnabled) ?? false
        usageAnalyticsEnabled = prefs.bool(PreferenceKey.usageAnalyticsEnabled) ?? false
        reminder = ReminderSettings(prefs: prefs)
        store.reloadCachedUnlock()
    }

    func setCalmInsights(_ enabled: Bool) {
        prefs.set(enabled, for: PreferenceKey.calmInsightsEnabled)
        calmInsightsEnabled = enabled
    }

    /// Records the consent decision and the collection flag together, as
    /// Flutter's `_setUsageAnalytics` does. Sending events arrives with the
    /// analytics port.
    func setUsageAnalytics(_ enabled: Bool) {
        prefs.set(enabled ? "granted" : "declined", for: PreferenceKey.analyticsConsentDecision)
        prefs.set(enabled, for: PreferenceKey.usageAnalyticsEnabled)
        usageAnalyticsEnabled = enabled
    }

    func setReminderEnabled(_ enabled: Bool) {
        prefs.set(enabled, for: PreferenceKey.reminderEnabled)
        reminder.enabled = enabled
    }

    func setReminderTime(hour: Int, minute: Int) {
        prefs.set(hour, for: PreferenceKey.reminderHour)
        prefs.set(minute, for: PreferenceKey.reminderMinute)
        reminder.hour = hour
        reminder.minute = minute
    }

    var colorScheme: ColorScheme? {
        switch appearance {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }

    func setLanguage(_ language: AppLanguage) {
        prefs.set(language.rawValue, for: PreferenceKey.appLanguage)
        self.language = language
        strings = Strings.load(locale: LocaleResolver.effectiveLocale(language: language))
    }

    /// Re-resolves "System default" after the device language changes.
    func refreshSystemLanguage() {
        guard language == .system else { return }
        let resolved = LocaleResolver.effectiveLocale(language: .system)
        if resolved != strings.localeIdentifier { strings = Strings.load(locale: resolved) }
    }

    func setAppearance(_ appearance: AppAppearance) {
        prefs.set(appearance.rawValue, for: PreferenceKey.appearance)
        self.appearance = appearance
    }

    func setAppLockEnabled(_ enabled: Bool) {
        prefs.set(enabled, for: PreferenceKey.appLockEnabled)
        appLockEnabled = enabled
    }

    func markStarted() {
        prefs.set(true, for: PreferenceKey.hasStarted)
        hasStarted = true
    }

    /// Settings ▸ Wipe: every data table, every exposure material file and
    /// every setting, as Flutter's wipe does. That includes the cached Pro
    /// unlock: the confirmation says the device forgets it, and a restore
    /// (or the launch-time entitlement check) brings it back. The pending
    /// reminder is cancelled too, since its setting is gone; Flutter left it
    /// scheduled.
    func wipeAllData() async throws {
        let database = database
        let materials = materials
        try await Task.detached(priority: .userInitiated) {
            try database.clearAll()
            try materials.deleteAll()
        }.value
        prefs.clear()
        Reminders.cancelDaily()
        reloadPreferences()
        dataDidChange()
    }

    func dataDidChange() {
        dataRevision += 1
    }
}

/// `ReminderSettings` from `lib/app_preferences.dart`. Defaults to 8:00 PM.
struct ReminderSettings: Equatable {
    var enabled: Bool
    var hour: Int
    var minute: Int

    init(prefs: FlutterPreferences) {
        enabled = prefs.bool(PreferenceKey.reminderEnabled) ?? false
        hour = prefs.int(PreferenceKey.reminderHour) ?? Reminders.defaultHour
        minute = prefs.int(PreferenceKey.reminderMinute) ?? Reminders.defaultMinute
    }

    /// The time as a `Date` today, for formatting and the time picker.
    var date: Date {
        Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
    }
}
