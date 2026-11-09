import Foundation
import Testing
@testable import PatternsCore

@Suite("Flutter settings")
struct FlutterPreferencesTests {
    final class Suite {
        let name = "patterns-tests-\(UUID().uuidString)"
        let defaults: UserDefaults
        init() { defaults = UserDefaults(suiteName: name)! }
        deinit { defaults.removePersistentDomain(forName: name) }
    }

    @Test("reads values exactly as shared_preferences stored them")
    func readsFlutterLayout() {
        let suite = Suite()
        // What shared_preferences_foundation writes for an upgraded Pro user.
        suite.defaults.set(true, forKey: "flutter.proUnlocked")
        suite.defaults.set(true, forKey: "flutter.appLockEnabled")
        suite.defaults.set(NSNumber(value: Int64(21)), forKey: "flutter.reminderHour")
        suite.defaults.set("ja", forKey: "flutter.appLanguage")
        suite.defaults.set(["1", "2"], forKey: "flutter.tel_returned_days")
        suite.defaults.set(true, forKey: "unprefixed") // not Flutter's

        let prefs = FlutterPreferences(defaults: suite.defaults)
        #expect(prefs.bool(PreferenceKey.proUnlocked) == true)
        #expect(prefs.bool(PreferenceKey.appLockEnabled) == true)
        #expect(prefs.int(PreferenceKey.reminderHour) == 21)
        #expect(prefs.string(PreferenceKey.appLanguage) == "ja")
        #expect(prefs.stringList(PreferenceKey.telemetryReturnedDays) == ["1", "2"])
        #expect(!prefs.keys.contains("unprefixed"))
    }

    @Test("types stay strict, as Dart's casts are")
    func strictTypes() {
        let suite = Suite()
        let prefs = FlutterPreferences(defaults: suite.defaults)
        prefs.set(true, for: "b")
        prefs.set(1, for: "i")
        prefs.set(1.0, for: "d")
        #expect(prefs.int("b") == nil)
        #expect(prefs.bool("i") == nil)
        #expect(prefs.int("d") == nil)
        #expect(prefs.double("i") == nil)
        #expect(prefs.bool("b") == true && prefs.int("i") == 1 && prefs.double("d") == 1.0)
        #expect(suite.defaults.object(forKey: "flutter.b") != nil)
    }

    @Test("launch migrations do nothing to an upgraded Flutter install")
    func migrationsAreNoOpAfterFlutter() {
        let suite = Suite()
        let prefs = FlutterPreferences(defaults: suite.defaults)
        // State Flutter's initAppPreferences leaves behind.
        prefs.set("de", for: PreferenceKey.appLanguage)
        prefs.set(false, for: PreferenceKey.calmInsightsEnabled)
        prefs.set("light", for: PreferenceKey.appearance)
        prefs.set(true, for: PreferenceKey.appearanceMigrationV1)
        prefs.set("granted", for: PreferenceKey.analyticsConsentDecision)
        prefs.set(5, for: PreferenceKey.meaningfulActionCount)
        let before = suite.defaults.dictionaryRepresentation().filter { $0.key.hasPrefix("flutter.") }

        prefs.applyLaunchMigrations()

        let after = suite.defaults.dictionaryRepresentation().filter { $0.key.hasPrefix("flutter.") }
        #expect(NSDictionary(dictionary: before).isEqual(to: after))
    }

    @Test("a fresh install gets Flutter's new-install defaults")
    func freshInstallDefaults() {
        let suite = Suite()
        let prefs = FlutterPreferences(defaults: suite.defaults)
        prefs.applyLaunchMigrations()
        #expect(prefs.string(PreferenceKey.appLanguage) == "system")
        #expect(prefs.bool(PreferenceKey.calmInsightsEnabled) == true)
        #expect(prefs.string(PreferenceKey.appearance) == "system")
        #expect(prefs.string(PreferenceKey.analyticsConsentDecision) == "undecided")
        #expect(prefs.int(PreferenceKey.meaningfulActionCount) == 0)
    }

    @Test("an old install that predates the migrations gets the established-install values")
    func establishedInstallDefaults() {
        let suite = Suite()
        let prefs = FlutterPreferences(defaults: suite.defaults)
        prefs.set(true, for: PreferenceKey.hasStarted)
        prefs.set(true, for: PreferenceKey.firstActivityDone)
        prefs.applyLaunchMigrations()
        #expect(prefs.string(PreferenceKey.appLanguage) == "en")
        #expect(prefs.bool(PreferenceKey.calmInsightsEnabled) == false)
        #expect(prefs.string(PreferenceKey.appearance) == "dark")
        #expect(prefs.string(PreferenceKey.analyticsConsentDecision) == "declined")
        #expect(prefs.int(PreferenceKey.meaningfulActionCount) == 2)
    }
}

@Suite("Pre-native safety snapshot")
struct LegacyDataSnapshotTests {
    @Test("copies the database and materials once, before first open")
    func takesSnapshotOnce() throws {
        let dir = try TempDir()
        let support = dir.url
        _ = try Fixtures.copyDatabase("v10.db", in: dir)
        let store = MaterialFileStore(supportDirectory: support)
        try store.write(Data("tape".utf8), named: "m_1.m4a")

        let outcome = try LegacyDataSnapshot.takeIfNeeded(supportDirectory: support)
        guard case let .taken(manifest) = outcome else {
            Issue.record("Expected a snapshot, got \(outcome)")
            return
        }
        #expect(manifest.materials.map(\.name) == ["m_1.m4a"])
        let copied = support.appendingPathComponent("pre-native-backup/patterns.db")
        #expect(try sha256(copied) == sha256(Fixtures.url("v10.db")))
        #expect(try LegacyDataSnapshot.takeIfNeeded(supportDirectory: support) == .alreadyTaken)
        #expect(LegacyDataSnapshot.manifest(supportDirectory: support) == manifest)

        // The snapshot is not a material and never ends up in a backup.
        #expect(store.allFiles().map(\.lastPathComponent) == ["m_1.m4a"])
    }

    @Test("a fresh install has nothing to copy")
    func freshInstall() throws {
        let dir = try TempDir()
        #expect(try LegacyDataSnapshot.takeIfNeeded(supportDirectory: dir.url) == .nothingToSnapshot)
    }

    @Test("a hot rollback journal is copied with the database")
    func copiesJournal() throws {
        let dir = try TempDir()
        _ = try Fixtures.copyDatabase("v10.db", in: dir)
        try Data("journal".utf8).write(to: dir.url.appendingPathComponent("patterns.db-journal"))
        guard case let .taken(manifest) = try LegacyDataSnapshot.takeIfNeeded(supportDirectory: dir.url) else {
            Issue.record("Expected a snapshot")
            return
        }
        #expect(manifest.databaseCompanions == ["patterns.db-journal"])
    }
}
