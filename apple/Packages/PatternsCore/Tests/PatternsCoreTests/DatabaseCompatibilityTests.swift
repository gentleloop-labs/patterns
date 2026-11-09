import Foundation
import GRDB
import Testing
@testable import PatternsCore

@Suite("Opening Flutter's patterns.db in place")
struct DatabaseCompatibilityTests {
    @Test("an up-to-date v10 file opens without a single byte changing")
    func v10OpensReadOnly() throws {
        let dir = try TempDir()
        let url = try Fixtures.copyDatabase("v10.db", in: dir)
        let before = try sha256(url)

        let database = try PatternsDatabase.open(at: url)
        #expect(try database.schemaVersion() == 10)
        _ = try BackupCodec.exportJSON(database)
        try database.queue.close()

        #expect(try sha256(url) == before)
    }

    @Test("every row Flutter wrote reads back identically")
    func v10ExportMatchesFlutter() throws {
        let dir = try TempDir()
        let database = try PatternsDatabase.open(at: Fixtures.copyDatabase("v10.db", in: dir))
        let native = try JSONValue.parse(BackupCodec.exportJSON(database))
        #expect(native == (try Fixtures.json("v10.expected.json")))
        // Same bytes too, so backups stay diffable across platforms.
        #expect(try BackupCodec.exportJSON(database) == Fixtures.text("v10.expected.json"))
    }

    @Test("older installs upgrade exactly as Flutter's onUpgrade does", arguments: [1, 4, 9])
    func legacyUpgrade(version: Int) throws {
        let dir = try TempDir()
        let url = try Fixtures.copyDatabase("v\(version).db", in: dir)
        let raw = try DatabaseQueue(path: url.path)
        #expect(try raw.read { try Int.fetchOne($0, sql: "PRAGMA user_version") } == version)
        try raw.close()

        let database = try PatternsDatabase.open(at: url)
        #expect(try database.schemaVersion() == 10)
        let native = try JSONValue.parse(BackupCodec.exportJSON(database))
        #expect(native == (try Fixtures.json("v\(version).expected.json")))
    }

    @Test("a file from a newer build is refused and left untouched")
    func newerSchemaRefused() throws {
        let dir = try TempDir()
        let url = try Fixtures.copyDatabase("v10.db", in: dir)
        let raw = try DatabaseQueue(path: url.path)
        try raw.writeWithoutTransaction { try $0.execute(sql: "PRAGMA user_version = 11") }
        try raw.close()
        let before = try sha256(url)

        #expect(throws: PatternsDatabase.OpenError.newerSchema(found: 11, supported: 10)) {
            _ = try PatternsDatabase.open(at: url)
        }
        #expect(try sha256(url) == before)
    }

    @Test("a fresh install creates the same tables and columns as Flutter")
    func freshSchemaMatchesFlutter() throws {
        let dir = try TempDir()
        let fresh = try PatternsDatabase.open(at: dir.url.appendingPathComponent("fresh.db"))
        let flutter = try DatabaseQueue(path: Fixtures.copyDatabase("v10.db", in: dir).path)

        func describe(_ reader: some DatabaseReader) throws -> [String: [String]] {
            try reader.read { db in
                var result: [String: [String]] = [:]
                for table in PatternsSchema.dataTables {
                    result[table] = try Row.fetchAll(db, sql: "PRAGMA table_info(\(table.quotedDatabaseIdentifier))")
                        .map { row in
                            let name: String = row["name"]
                            let type: String = row["type"]
                            let pk: Int = row["pk"]
                            let notNull: Int = row["notnull"]
                            return "\(name) \(type) pk=\(pk) notnull=\(notNull)"
                        }
                }
                return result
            }
        }

        #expect(try fresh.schemaVersion() == 10)
        #expect(try describe(fresh.queue) == describe(flutter))
        let unique = try fresh.queue.read { db in
            try db.indexes(on: "journal").filter(\.isUnique).map(\.columns)
        }
        #expect(unique == [["date"]])
    }

    @Test("typed records decode every Flutter row")
    func typedRecords() throws {
        let dir = try TempDir()
        let database = try PatternsDatabase.open(at: Fixtures.copyDatabase("v10.db", in: dir))
        try database.queue.read { db in
            let journal = try JournalEntry.order(Column("id")).fetchAll(db)
            #expect(journal.count == 4)
            #expect(journal[0].body.richRuns.contains(RichRun("paused", bold: true)))
            #expect(journal[1].body == .plain("Legacy plain text from before rich text.\nSecond line."))
            #expect(journal[2].body.plainText.hasPrefix("今日は"))
            #expect(journal[2].updatedAt.raw.hasSuffix("Z"))
            #expect(journal[0].createdAt.raw == "2026-03-01T08:15:04.120045")
            #expect(journal[0].createdAt.date != nil)

            let ocd = try OcdEntry.order(Column("id")).fetchAll(db)
            #expect(ocd.map(\.type) == [.obsession, .compulsion, .obsession])
            #expect(ocd[0].actionTaken == nil)
            #expect(ocd[1].actionTaken == "Read it once")

            #expect(try DelaySession.fetchAll(db).map(\.completed).sorted { !$0 && $1 } == [false, true])
            #expect(try ErpExercisePlan.fetchAll(db).filter(\.archived).count == 1)
            #expect(try ErpExerciseSession.fetchAll(db).contains { $0.planId == nil })
            #expect(try ExposureHierarchy.fetchCount(db) == 1)
            let steps = try ExposureStep.order(Column("order_index")).fetchAll(db)
            #expect(steps.map(\.status) == [.completed, .notStarted])
            #expect(steps[1].completedAt == nil)
            #expect(try ResponsePreventionLog.fetchOne(db)?.outcome == .performed)
            #expect(try UrgeSurfSession.fetchOne(db)?.peakUrge == 9)
            #expect(try ProgramEnrollment.fetchOne(db)?.programId == "erp_foundations")
            #expect(try ProgramTaskProgress.fetchOne(db)?.taskId == "w1_learn")
            #expect(try BehavioralExperiment.fetchAll(db).map(\.status).contains(.planned))
            #expect(try ExposureReflection.fetchOne(db)?.whatILearned == "I can tolerate it")
            #expect(try ActionPlan.fetchAll(db).contains { $0.date == nil && $0.completed })
            #expect(try ImplementationIntention.fetchCount(db) == 1)
            #expect(try UncertaintyLog.fetchOne(db)?.willingness == 6)
            let materials = try ExposureMaterial.order(Column("id")).fetchAll(db)
            #expect(materials.map(\.type) == [.script, .loopTape, .image, .link])
            let ybocs = try YbocsAssessment.order(Column("id")).fetchAll(db)
            #expect(ybocs[0].itemScores == [3, 3, 3, 3, 2, 3, 2, 3, 2, 2])
            #expect(ybocs[0].themes == ["contamination", "checking"])
            #expect(ybocs[1].themes == [])
            #expect(ybocs[1].symptoms == [])
            #expect(ybocs[0].severity == YbocsSeverity.forScore(ybocs[0].totalScore))
        }
    }

    @Test("saving records without edits changes nothing on disk")
    func unchangedSaveIsLossless() throws {
        let dir = try TempDir()
        let database = try PatternsDatabase.open(at: Fixtures.copyDatabase("v10.db", in: dir))
        try database.queue.write { db in
            func resave<R: PatternsRecord>(_: R.Type) throws {
                for var record in try R.fetchAll(db) { try record.update(db) }
            }
            try resave(JournalEntry.self)
            try resave(OcdEntry.self)
            try resave(DelaySession.self)
            try resave(ErpExercisePlan.self)
            try resave(ErpExerciseSession.self)
            try resave(ExposureHierarchy.self)
            try resave(ExposureStep.self)
            try resave(ResponsePreventionLog.self)
            try resave(UrgeSurfSession.self)
            try resave(ProgramEnrollment.self)
            try resave(ProgramTaskProgress.self)
            try resave(BehavioralExperiment.self)
            try resave(ExposureReflection.self)
            try resave(ActionPlan.self)
            try resave(ImplementationIntention.self)
            try resave(UncertaintyLog.self)
            try resave(ExposureMaterial.self)
            try resave(YbocsAssessment.self)
        }
        #expect(try BackupCodec.exportJSON(database) == Fixtures.text("v10.expected.json"))
    }

    @Test("an unknown enum index does not break reading the table")
    func unknownEnumTolerated() throws {
        let database = try PatternsDatabase.inMemory()
        try database.queue.write { db in
            try db.execute(sql: """
                INSERT INTO ocd (type, datetime, content, distress_level, response, created_at)
                VALUES (7, '2026-01-01T00:00:00.000', 'x', 1, '', '2026-01-01T00:00:00.000')
                """)
        }
        let rows = try database.queue.read { try OcdEntry.fetchAll($0) }
        #expect(rows.count == 1)
        #expect(rows[0].type == nil)
        #expect(rows[0].typeIndex == 7)
    }
}
