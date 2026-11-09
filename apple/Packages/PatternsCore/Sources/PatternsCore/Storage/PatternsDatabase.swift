import Foundation
import GRDB

/// The app's SQLite database: the same `patterns.db` file the Flutter app
/// created, opened in place.
///
/// Opening follows sqflite's `openDatabase(version: 10)` contract:
/// - `user_version == 0` with no tables: brand-new install, create the schema.
/// - `user_version < 10`: run Flutter's additive `onUpgrade` steps.
/// - `user_version == 10`: open as-is. Nothing is written.
/// - `user_version > 10`: refuse. A newer build wrote this file, and touching
///   it could lose data, so the caller shows a support screen instead.
public final class PatternsDatabase: Sendable {
    public let queue: DatabaseQueue

    public enum OpenError: Error, Equatable, CustomStringConvertible {
        case newerSchema(found: Int, supported: Int)

        public var description: String {
            switch self {
            case let .newerSchema(found, supported):
                return "Database schema v\(found) is newer than this build supports (v\(supported))."
            }
        }
    }

    private init(queue: DatabaseQueue) {
        self.queue = queue
    }

    /// The location Flutter uses on Apple platforms:
    /// `getApplicationSupportDirectory()/patterns.db`.
    public static func defaultURL(fileManager: FileManager = .default) throws -> URL {
        try AppDirectories.applicationSupport(fileManager: fileManager)
            .appendingPathComponent(PatternsSchema.databaseFileName)
    }

    public static func open(at url: URL) throws -> PatternsDatabase {
        let queue = try DatabaseQueue(path: url.path, configuration: configuration())
        try prepare(queue)
        return PatternsDatabase(queue: queue)
    }

    /// An isolated in-memory database with the current schema, for tests and
    /// previews.
    public static func inMemory() throws -> PatternsDatabase {
        let queue = try DatabaseQueue(configuration: configuration())
        try prepare(queue)
        return PatternsDatabase(queue: queue)
    }

    /// The stored `PRAGMA user_version`.
    public func schemaVersion() throws -> Int {
        try queue.read { try Int.fetchOne($0, sql: "PRAGMA user_version") ?? 0 }
    }

    private static func configuration() -> Configuration {
        var config = Configuration()
        // sqflite does not enable foreign keys, and the schema declares none.
        // Keep SQLite's behaviour identical to the Flutter app.
        config.foreignKeysEnabled = false
        config.label = "patterns.db"
        return config
    }

    private static func prepare(_ queue: DatabaseQueue) throws {
        try queue.writeWithoutTransaction { db in
            let version = try Int.fetchOne(db, sql: "PRAGMA user_version") ?? 0
            if version > PatternsSchema.currentVersion {
                throw OpenError.newerSchema(found: version, supported: PatternsSchema.currentVersion)
            }
            if version == PatternsSchema.currentVersion { return }

            try db.inTransaction {
                if version == 0, try !db.tableExists("journal") {
                    try PatternsSchema.create(db)
                } else {
                    // Version 0 with tables present should not happen. Treat it
                    // as a v1 file, so the additive steps can never fail and
                    // existing rows are never touched.
                    try PatternsSchema.upgrade(db, from: max(version, 1))
                }
                try db.execute(sql: "PRAGMA user_version = \(PatternsSchema.currentVersion)")
                return .commit
            }
        }
    }
}

/// App sandbox folders, resolved the way Flutter's `path_provider` does.
public enum AppDirectories {
    /// The folder Flutter's `getApplicationSupportDirectory()` returns
    /// (path_provider_foundation 2.6): `Library/Application Support` on iOS,
    /// and on macOS the same folder plus a bundle-ID subfolder. Created if
    /// missing.
    public static func applicationSupport(
        fileManager: FileManager = .default,
        bundleIdentifier: String? = Bundle.main.bundleIdentifier
    ) throws -> URL {
        var url = try fileManager.url(
            for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true
        )
        #if os(macOS)
        if let bundleIdentifier {
            url.appendPathComponent(bundleIdentifier, isDirectory: true)
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        }
        #endif
        return url
    }
}
