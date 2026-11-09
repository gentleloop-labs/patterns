import Foundation
import GRDB
import Testing
@testable import PatternsCore

/// Writes files created by native code for `test/native_fixtures_test.dart`
/// to read back with the real Flutter code, proving the rollback and
/// cross-platform paths: a Flutter build installed over native 2.0, and a
/// native backup restored on Android or macOS.
///
/// Runs only with `PATTERNS_WRITE_SWIFT_OUT=1` (set by compat-check.sh).
@Suite("Native output for Flutter")
struct SwiftOutputForFlutterTests {
    static let enabled = ProcessInfo.processInfo.environment["PATTERNS_WRITE_SWIFT_OUT"] == "1"

    @Test("write swift.db, swift.expected.json and swift-backup.zip", .enabled(if: enabled))
    func writeOutputs() throws {
        let out = Fixtures.swiftOutDir
        try? FileManager.default.removeItem(at: out)
        try FileManager.default.createDirectory(at: out, withIntermediateDirectories: true)

        let dbURL = out.appendingPathComponent("swift.db")
        let database = try PatternsDatabase.open(at: dbURL)
        let store = MaterialFileStore(supportDirectory: out.appendingPathComponent("support"))
        try Self.insertNativeRows(database, store: store)

        try BackupCodec.exportJSON(database)
            .write(to: out.appendingPathComponent("swift.expected.json"), atomically: true, encoding: .utf8)
        try BackupCodec.exportBundle(database, materials: store)
            .write(to: out.appendingPathComponent("swift-backup.zip"))
        try database.queue.close()
    }

    /// One row per table, written through the native record types with
    /// freshly formatted timestamps, the way the native UI will write them.
    static func insertNativeRows(_ database: PatternsDatabase, store: MaterialFileStore) throws {
        let now = DartTimestamp(Date(timeIntervalSince1970: 1_772_352_904.120_045))
        let later = DartTimestamp(Date(timeIntervalSince1970: 1_772_400_000))
        let tapeName = MaterialFileStore.generatedName(extension: "m4a", now: Date(timeIntervalSince1970: 1_772_352_905))
        try store.write(Data((0..<512).map { UInt8($0 % 251) }), named: tapeName)

        let rich = JournalContent.delta([
            DeltaOp(text: "Written "),
            DeltaOp(text: "natively", attributes: [("bold", .bool(true))]),
            DeltaOp(text: " ✓ 日本語\n"),
        ])

        try database.queue.write { db in
            var journal = JournalEntry(date: "2026-03-01", content: rich.stored, createdAt: now, updatedAt: later)
            try journal.insert(db)
            var legacy = JournalEntry(date: "2026-03-02", content: JournalContent.plain("plain").stored,
                                      createdAt: now, updatedAt: now)
            try legacy.insert(db)
            var obsession = OcdEntry(type: .obsession, datetime: now, content: "Thought", distressLevel: 6,
                                     response: "Let it be", createdAt: now)
            try obsession.insert(db)
            var compulsion = OcdEntry(type: .compulsion, datetime: later, content: "Urge", distressLevel: 9,
                                      response: "Delayed", actionTaken: "Checked once", createdAt: later)
            try compulsion.insert(db)
            var delay = DelaySession(compulsion: "Checking", plannedSeconds: 600, actualSeconds: 600, completed: true,
                                     urgeBefore: 8, urgeAfter: 3, outcome: .resisted, createdAt: now)
            try delay.insert(db)
            var plan = ErpExercisePlan(exerciseId: "custom", exerciseTitle: "Plan", triggerOrExposure: "t",
                                       fearPrediction: "f", preventionCommitment: "p", defaultSeconds: 300,
                                       createdAt: now, updatedAt: now)
            try plan.insert(db)
            var session = ErpExerciseSession(planId: plan.id, exerciseId: "custom", exerciseTitle: "Plan",
                                             triggerOrExposure: "t", fearPrediction: "f", preventionCommitment: "p",
                                             plannedSeconds: 300, actualSeconds: 200, completed: false,
                                             anxietyBefore: 7, anxietyAfter: 4, outcome: .delayed,
                                             whatHappened: "w", learning: "l", createdAt: now)
            try session.insert(db)
            var hierarchy = ExposureHierarchy(title: "Ladder", theme: "checking", createdAt: now, updatedAt: now)
            try hierarchy.insert(db)
            var step = ExposureStep(hierarchyId: hierarchy.id, orderIndex: 0, description: "Step", difficulty: 4,
                                    anxietyRating: 5, status: .completed, completedAt: later)
            try step.insert(db)
            var prevention = ResponsePreventionLog(datetime: now, situation: "s", outcome: .partial, anxietyLevel: 5,
                                                   linkedStepId: step.id, createdAt: now)
            try prevention.insert(db)
            var surf = UrgeSurfSession(datetime: now, trigger: "t", initialUrge: 6, peakUrge: 8, finalUrge: 2,
                                       durationSeconds: 300, createdAt: now)
            try surf.insert(db)
            var enrollment = ProgramEnrollment(programId: "erp_foundations", createdAt: now)
            try enrollment.insert(db)
            var progress = ProgramTaskProgress(enrollmentId: enrollment.id!, weekIndex: 0, taskId: "w1",
                                               completedAt: later)
            try progress.insert(db)
            var experiment = BehavioralExperiment(datetime: now, fearPrediction: "f", confidence: 70,
                                                  experiment: "e", status: .planned, createdAt: now)
            try experiment.insert(db)
            var reflection = ExposureReflection(datetime: now, whatHappened: "a", ocdPredicted: "b",
                                                actuallyHappened: "c", whatILearned: "d", doDifferently: "e",
                                                createdAt: now)
            try reflection.insert(db)
            var action = ActionPlan(situation: "s", plannedAction: "a", date: "2026-03-03", createdAt: now)
            try action.insert(db)
            var intention = ImplementationIntention(trigger: "If", response: "Then", createdAt: now)
            try intention.insert(db)
            var uncertainty = UncertaintyLog(datetime: now, exerciseId: "maybe", willingness: 5, createdAt: now)
            try uncertainty.insert(db)
            var material = ExposureMaterial(type: .loopTape, title: "Tape", fileName: tapeName,
                                            linkedHierarchyId: hierarchy.id, createdAt: now)
            try material.insert(db)
            var ybocs = YbocsAssessment(datetime: now, obsessionScore: 10, compulsionScore: 9, totalScore: 19,
                                        severity: .forScore(19), itemScores: [2, 2, 2, 2, 2, 2, 2, 2, 2, 1],
                                        themes: ["checking"], symptoms: ["check_locks"], createdAt: now)
            try ybocs.insert(db)
        }
    }

    @Test("native-written rows pass Flutter's backup validation")
    func nativeRowsValidate() throws {
        let dir = try TempDir()
        let database = try PatternsDatabase.inMemory()
        try Self.insertNativeRows(database, store: MaterialFileStore(supportDirectory: dir.url))
        let summary = try BackupCodec.preview(json: BackupCodec.exportJSON(database))
        #expect(summary.journalCount == 2)
        #expect(PatternsSchema.dataTables.allSatisfy { summary.count($0) > 0 })
    }
}
