import Foundation
import OSLog
import PatternsCore

/// The launch sequence. Order matters for data safety:
///
/// 1. Snapshot the Flutter data (once) before anything touches it.
/// 2. Apply Flutter's settings migrations (a no-op for upgraded users).
/// 3. Open `patterns.db` in place.
///
/// Nothing here deletes or rewrites user data. If the database cannot be
/// opened, the app shows a recovery screen instead of creating a new one.
enum AppBootstrap {
    static let log = Logger(subsystem: "com.maskedsyntax.patterns", category: "bootstrap")

    enum Failure: Error, Equatable {
        /// Written by a newer build. Left untouched.
        case newerData(found: Int, supported: Int)
        /// Could not open the database. The message is for support.
        case unreadable(String)
    }

    @MainActor
    static func start(
        fileManager: FileManager = .default,
        defaults: UserDefaults = .standard
    ) -> Result<AppModel, Failure> {
        let support: URL
        do {
            support = try AppDirectories.applicationSupport(fileManager: fileManager)
        } catch {
            return .failure(.unreadable("Application Support: \(error)"))
        }

        do {
            let outcome = try LegacyDataSnapshot.takeIfNeeded(supportDirectory: support, fileManager: fileManager)
            log.info("Pre-native snapshot: \(String(describing: outcome), privacy: .public)")
        } catch {
            // The snapshot is a safety net, not a requirement. The original
            // files are untouched either way.
            log.error("Pre-native snapshot failed: \(String(describing: error), privacy: .public)")
        }

        let prefs = FlutterPreferences(defaults: defaults)
        prefs.applyLaunchMigrations()

        do {
            let url = support.appendingPathComponent(PatternsSchema.databaseFileName)
            let database = try PatternsDatabase.open(at: url)
            let model = AppModel(
                prefs: prefs,
                database: database,
                materials: MaterialFileStore(supportDirectory: support),
                supportDirectory: support
            )
            Task {
                await Reminders.rescheduleOnLaunch(prefs: prefs, strings: model.strings)
                await Reminders.scheduleReleaseAnnouncementIfNeeded(prefs: prefs, strings: model.strings)
            }
            model.store.start()
            model.events.appLaunched()
            model.reviews.recordSessionStart()
            model.startAnalyticsFlushing()
            return .success(model)
        } catch let PatternsDatabase.OpenError.newerSchema(found, supported) {
            return .failure(.newerData(found: found, supported: supported))
        } catch {
            log.fault("Database open failed: \(String(describing: error), privacy: .public)")
            return .failure(.unreadable(String(describing: error)))
        }
    }
}
