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

    func dataDidChange() {
        dataRevision += 1
    }
}
