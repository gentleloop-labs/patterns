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

extension ErpExercisePlan {
    /// `getActiveErpExercisePlans`: unarchived plans, most recently changed
    /// first.
    public static func active() -> QueryInterfaceRequest<ErpExercisePlan> {
        ErpExercisePlan.filter(Column("archived") == 0).order(Column("updated_at").desc)
    }
}

extension ErpExerciseSession {
    /// `getErpExerciseSessions`: newest first.
    public static func all() -> QueryInterfaceRequest<ErpExerciseSession> {
        ErpExerciseSession.order(Column("created_at").desc)
    }
}

extension PatternsDatabase {
    @discardableResult
    public func insertErpPlan(_ plan: ErpExercisePlan) throws -> ErpExercisePlan {
        try queue.write { db in
            var plan = plan
            plan.id = nil
            try plan.insert(db)
            return plan
        }
    }

    /// `updateErpExercisePlan`: rewrites every column except `id`.
    public func updateErpPlan(_ plan: ErpExercisePlan) throws {
        guard plan.id != nil else {
            throw PersistenceError.recordNotFound(databaseTableName: ErpExercisePlan.databaseTableName, key: [:])
        }
        try queue.write { db in try plan.update(db) }
    }

    /// `archiveErpExercisePlan`: hides the plan but keeps it and its
    /// practice history.
    public func archiveErpPlan(id: Int64) throws {
        try queue.write { db in
            try db.execute(sql: "UPDATE erp_exercise_plans SET archived = 1, updated_at = ? WHERE id = ?",
                           arguments: [DartTimestamp.now().raw, id])
        }
    }

    @discardableResult
    public func insertErpSession(_ session: ErpExerciseSession) throws -> ErpExerciseSession {
        try queue.write { db in
            var session = session
            session.id = nil
            try session.insert(db)
            return session
        }
    }
}

extension YbocsAssessment {
    /// `getYbocsAssessments`: newest first.
    public static func all() -> QueryInterfaceRequest<YbocsAssessment> {
        YbocsAssessment.order(Column("datetime").desc)
    }
}

extension PatternsDatabase {
    @discardableResult
    public func insertYbocsAssessment(_ assessment: YbocsAssessment) throws -> YbocsAssessment {
        try queue.write { db in
            var assessment = assessment
            assessment.id = nil
            try assessment.insert(db)
            return assessment
        }
    }

    public func deleteYbocsAssessment(id: Int64) throws {
        _ = try queue.write { db in try YbocsAssessment.deleteOne(db, key: id) }
    }
}

extension UrgeSurfSession {
    /// `getUrgeSurfSessions`: newest first.
    public static func all() -> QueryInterfaceRequest<UrgeSurfSession> {
        UrgeSurfSession.order(Column("datetime").desc)
    }
}

extension PatternsDatabase {
    @discardableResult
    public func insertUrgeSurfSession(_ session: UrgeSurfSession) throws -> UrgeSurfSession {
        try queue.write { db in
            var session = session
            session.id = nil
            try session.insert(db)
            return session
        }
    }
}

extension ExposureHierarchy {
    /// `getActiveExposureHierarchies`: unarchived, most recently changed first.
    public static func active() -> QueryInterfaceRequest<ExposureHierarchy> {
        ExposureHierarchy.filter(Column("archived") == 0).order(Column("updated_at").desc)
    }
}

extension ExposureStep {
    /// `getExposureSteps`: grouped by ladder, in climbing order.
    public static func all() -> QueryInterfaceRequest<ExposureStep> {
        ExposureStep.order(Column("hierarchy_id").asc, Column("order_index").asc)
    }

    /// One ladder's steps in climbing order.
    public static func forHierarchy(_ id: Int64) -> QueryInterfaceRequest<ExposureStep> {
        ExposureStep.filter(Column("hierarchy_id") == id).order(Column("order_index").asc)
    }
}

extension PatternsDatabase {
    /// `insertExposureHierarchyWithSteps`: the ladder and its steps in one
    /// transaction, steps numbered in the order given.
    @discardableResult
    public func insertExposureHierarchy(_ hierarchy: ExposureHierarchy, steps: [ExposureStep]) throws -> Int64 {
        try queue.write { db in
            var hierarchy = hierarchy
            hierarchy.id = nil
            try hierarchy.insert(db)
            let id = db.lastInsertedRowID
            for (index, step) in steps.enumerated() {
                var step = step
                step.id = nil
                step.hierarchyId = id
                step.orderIndex = index
                try step.insert(db)
            }
            return id
        }
    }

    /// `archiveExposureHierarchy`.
    public func archiveExposureHierarchy(id: Int64) throws {
        try queue.write { db in
            try db.execute(sql: "UPDATE exposure_hierarchies SET archived = 1, updated_at = ? WHERE id = ?",
                           arguments: [DartTimestamp.now().raw, id])
        }
    }

    /// `updateExposureStep`: rewrites every column except `id`.
    public func updateExposureStep(_ step: ExposureStep) throws {
        guard step.id != nil else {
            throw PersistenceError.recordNotFound(databaseTableName: ExposureStep.databaseTableName, key: [:])
        }
        try queue.write { db in try step.update(db) }
    }
}

extension ExposureReflection {
    /// `getExposureReflections`: newest first.
    public static func all() -> QueryInterfaceRequest<ExposureReflection> {
        ExposureReflection.order(Column("datetime").desc)
    }
}

extension PatternsDatabase {
    @discardableResult
    public func insertExposureReflection(_ reflection: ExposureReflection) throws -> ExposureReflection {
        try queue.write { db in
            var reflection = reflection
            reflection.id = nil
            try reflection.insert(db)
            return reflection
        }
    }

    public func deleteExposureReflection(id: Int64) throws {
        _ = try queue.write { db in try ExposureReflection.deleteOne(db, key: id) }
    }
}

extension ResponsePreventionLog {
    /// `getResponsePreventionLogs`: newest first.
    public static func all() -> QueryInterfaceRequest<ResponsePreventionLog> {
        ResponsePreventionLog.order(Column("datetime").desc)
    }
}

extension PatternsDatabase {
    @discardableResult
    public func insertResponsePreventionLog(_ log: ResponsePreventionLog) throws -> ResponsePreventionLog {
        try queue.write { db in
            var log = log
            log.id = nil
            try log.insert(db)
            return log
        }
    }

    public func deleteResponsePreventionLog(id: Int64) throws {
        _ = try queue.write { db in try ResponsePreventionLog.deleteOne(db, key: id) }
    }
}

extension UncertaintyLog {
    /// `getUncertaintyLogs`: newest first.
    public static func all() -> QueryInterfaceRequest<UncertaintyLog> {
        UncertaintyLog.order(Column("datetime").desc)
    }
}

extension PatternsDatabase {
    @discardableResult
    public func insertUncertaintyLog(_ log: UncertaintyLog) throws -> UncertaintyLog {
        try queue.write { db in
            var log = log
            log.id = nil
            try log.insert(db)
            return log
        }
    }
}
