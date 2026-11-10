import Foundation
import GRDB

// Reads and writes ported from `lib/database/db_helper.dart`, with the same
// ordering and the same column rules, so rows look the same whichever app
// wrote them.

// MARK: - Journal

extension JournalEntry {
    /// `getJournalEntries`: every entry, oldest day first.
    public static func all() -> QueryInterfaceRequest<JournalEntry> {
        JournalEntry.order(Column("date").asc)
    }

    /// The `yyyy-MM-dd` day key Flutter writes, in local time.
    public static func dayKey(for date: Date, calendar: Calendar = .current) -> String {
        let parts = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
    }

    /// Parses a stored day key (as Dart's `DateTime.parse`) to local midnight.
    public static func date(forDayKey key: String) -> Date? {
        DartDateTime.parse(key)
    }
}

extension PatternsDatabase {
    /// `upsertJournalEntry`: one entry per day. Updating keeps the row's id
    /// and `created_at` and rewrites `date`, `content` and `updated_at`.
    /// Returns true when a new day was written.
    @discardableResult
    public func saveJournalEntry(date: String, content: String, now: Date = Date()) throws -> Bool {
        try queue.write { db in
            let stamp = DartTimestamp(now)
            if var existing = try JournalEntry.filter(Column("date") == date).fetchOne(db) {
                existing.date = date
                existing.content = content
                existing.updatedAt = stamp
                try existing.update(db, columns: ["date", "content", "updated_at"])
                return false
            }
            var entry = JournalEntry(date: date, content: content, createdAt: stamp, updatedAt: stamp)
            try entry.insert(db)
            return true
        }
    }

    /// `deleteJournalEntry`: frees the day so it can be written again.
    public func deleteJournalEntry(date: String) throws {
        _ = try queue.write { db in
            try JournalEntry.filter(Column("date") == date).deleteAll(db)
        }
    }
}

// MARK: - OCD tracker

extension OcdEntry {
    /// `getOcdEntries`: newest moment first.
    public static func all() -> QueryInterfaceRequest<OcdEntry> {
        OcdEntry.order(Column("datetime").desc)
    }

    /// The "high distress" filter on the tracker list.
    public static let highDistressThreshold = 7
}

extension PatternsDatabase {
    @discardableResult
    public func insertOcdEntry(_ entry: OcdEntry) throws -> OcdEntry {
        try queue.write { db in
            var entry = entry
            entry.id = nil
            try entry.insert(db)
            return entry
        }
    }

    /// Rewrites every column except `id`, as Flutter's `updateOcdEntry` does.
    public func updateOcdEntry(_ entry: OcdEntry) throws {
        guard entry.id != nil else { throw PersistenceError.recordNotFound(databaseTableName: OcdEntry.databaseTableName, key: [:]) }
        try queue.write { db in try entry.update(db) }
    }

    public func deleteOcdEntry(id: Int64) throws {
        _ = try queue.write { db in try OcdEntry.deleteOne(db, key: id) }
    }
}

// MARK: - Wipe

extension PatternsDatabase {
    /// `DbHelper.clearAll`: empties every data table in one transaction. The
    /// schema and `user_version` stay as they are.
    public func clearAll() throws {
        try queue.write { db in
            for table in PatternsSchema.dataTables {
                try db.execute(sql: "DELETE FROM \(table.quotedDatabaseIdentifier)")
            }
        }
    }
}

extension DelaySession {
    /// `getDelaySessions`: newest first.
    public static func all() -> QueryInterfaceRequest<DelaySession> {
        DelaySession.order(Column("created_at").desc)
    }
}

extension PatternsDatabase {
    /// `insertDelaySession`.
    @discardableResult
    public func insertDelaySession(_ session: DelaySession) throws -> DelaySession {
        try queue.write { db in
            var session = session
            session.id = nil
            try session.insert(db)
            return session
        }
    }
}
