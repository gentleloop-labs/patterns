import Foundation
import GRDB

// Row types for every table in schema v10, mirroring `lib/models/models.dart`.
//
// Conventions that keep native and Flutter rows interchangeable:
// - Column names are spelled out in `CodingKeys`, never derived.
// - Timestamps are `DartTimestamp`, which keeps the stored text verbatim.
// - Flags Dart reads as `map[x] == 1` are kept as the stored `Int`, with a
//   Bool accessor that uses the same `== 1` rule.
// - Enum columns keep the stored index. The typed accessor returns nil for an
//   index this build does not know, instead of failing the whole fetch.

public protocol PatternsRecord: Codable, FetchableRecord, MutablePersistableRecord, Identifiable, Equatable, Sendable {
    var id: Int64? { get set }
}

extension PatternsRecord {
    public mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

// MARK: - Enums (stored as Dart `.index`)

public enum OcdType: Int, Sendable, CaseIterable { case obsession, compulsion }
public enum DelayOutcome: Int, Sendable, CaseIterable { case resisted, delayed, performed }
public enum ExposureStepStatus: Int, Sendable, CaseIterable { case notStarted, inProgress, completed }
public enum ResponseOutcome: Int, Sendable, CaseIterable { case resisted, delayed, partial, performed }
public enum ExperimentStatus: Int, Sendable, CaseIterable { case planned, completed }
public enum YbocsSeverity: Int, Sendable, CaseIterable {
    case subclinical, mild, moderate, severe, extreme

    /// Standard Goodman et al. bands for a 0 to 40 total.
    public static func forScore(_ total: Int) -> YbocsSeverity {
        switch total {
        case ...7: return .subclinical
        case ...15: return .mild
        case ...23: return .moderate
        case ...31: return .severe
        default: return .extreme
        }
    }
}
public enum MaterialType: Int, Sendable, CaseIterable { case script, loopTape, image, link }

// MARK: - journal

public struct JournalEntry: PatternsRecord {
    public static let databaseTableName = "journal"
    public var id: Int64?
    /// Day key, `yyyy-MM-dd` in local time. Unique.
    public var date: String
    /// Quill Delta JSON, or legacy plain text. See ``JournalContent``.
    public var content: String
    public var createdAt: DartTimestamp
    public var updatedAt: DartTimestamp

    public init(id: Int64? = nil, date: String, content: String, createdAt: DartTimestamp, updatedAt: DartTimestamp) {
        self.id = id; self.date = date; self.content = content; self.createdAt = createdAt; self.updatedAt = updatedAt
    }

    public var body: JournalContent { JournalContent(stored: content) }

    enum CodingKeys: String, CodingKey {
        case id, date, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - ocd

public struct OcdEntry: PatternsRecord {
    public static let databaseTableName = "ocd"
    public var id: Int64?
    public var typeIndex: Int
    public var datetime: DartTimestamp
    public var content: String
    public var distressLevel: Int
    public var response: String
    public var actionTaken: String?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, type: OcdType, datetime: DartTimestamp, content: String, distressLevel: Int,
                response: String, actionTaken: String? = nil, createdAt: DartTimestamp) {
        self.id = id; self.typeIndex = type.rawValue; self.datetime = datetime; self.content = content
        self.distressLevel = distressLevel; self.response = response; self.actionTaken = actionTaken
        self.createdAt = createdAt
    }

    public var type: OcdType? { OcdType(rawValue: typeIndex) }

    enum CodingKeys: String, CodingKey {
        case id, datetime, content, response
        case typeIndex = "type"
        case distressLevel = "distress_level"
        case actionTaken = "action_taken"
        case createdAt = "created_at"
    }
}

// MARK: - delay_sessions

public struct DelaySession: PatternsRecord {
    public static let databaseTableName = "delay_sessions"
    public var id: Int64?
    public var compulsion: String
    public var plannedSeconds: Int
    public var actualSeconds: Int
    public var completedFlag: Int
    public var urgeBefore: Int
    public var urgeAfter: Int
    public var outcomeIndex: Int
    public var note: String?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, compulsion: String, plannedSeconds: Int, actualSeconds: Int, completed: Bool,
                urgeBefore: Int, urgeAfter: Int, outcome: DelayOutcome, note: String? = nil, createdAt: DartTimestamp) {
        self.id = id; self.compulsion = compulsion; self.plannedSeconds = plannedSeconds
        self.actualSeconds = actualSeconds; self.completedFlag = completed ? 1 : 0; self.urgeBefore = urgeBefore
        self.urgeAfter = urgeAfter; self.outcomeIndex = outcome.rawValue; self.note = note; self.createdAt = createdAt
    }

    public var completed: Bool { completedFlag == 1 }
    public var outcome: DelayOutcome? { DelayOutcome(rawValue: outcomeIndex) }

    enum CodingKeys: String, CodingKey {
        case id, compulsion, note
        case plannedSeconds = "planned_seconds"
        case actualSeconds = "actual_seconds"
        case completedFlag = "completed"
        case urgeBefore = "urge_before"
        case urgeAfter = "urge_after"
        case outcomeIndex = "outcome"
        case createdAt = "created_at"
    }
}

// MARK: - erp_exercise_plans

public struct ErpExercisePlan: PatternsRecord {
    public static let databaseTableName = "erp_exercise_plans"
    public var id: Int64?
    public var exerciseId: String
    public var exerciseTitle: String
    public var triggerOrExposure: String
    public var fearPrediction: String
    public var preventionCommitment: String
    public var defaultSeconds: Int
    public var archivedFlag: Int
    public var createdAt: DartTimestamp
    public var updatedAt: DartTimestamp

    public init(id: Int64? = nil, exerciseId: String, exerciseTitle: String, triggerOrExposure: String,
                fearPrediction: String, preventionCommitment: String, defaultSeconds: Int, archived: Bool = false,
                createdAt: DartTimestamp, updatedAt: DartTimestamp) {
        self.id = id; self.exerciseId = exerciseId; self.exerciseTitle = exerciseTitle
        self.triggerOrExposure = triggerOrExposure; self.fearPrediction = fearPrediction
        self.preventionCommitment = preventionCommitment; self.defaultSeconds = defaultSeconds
        self.archivedFlag = archived ? 1 : 0; self.createdAt = createdAt; self.updatedAt = updatedAt
    }

    public var archived: Bool { archivedFlag == 1 }

    enum CodingKeys: String, CodingKey {
        case id
        case exerciseId = "exercise_id"
        case exerciseTitle = "exercise_title"
        case triggerOrExposure = "trigger_or_exposure"
        case fearPrediction = "fear_prediction"
        case preventionCommitment = "prevention_commitment"
        case defaultSeconds = "default_seconds"
        case archivedFlag = "archived"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - erp_exercise_sessions

public struct ErpExerciseSession: PatternsRecord {
    public static let databaseTableName = "erp_exercise_sessions"
    public var id: Int64?
    public var planId: Int64?
    public var exerciseId: String
    public var exerciseTitle: String
    public var triggerOrExposure: String
    public var fearPrediction: String
    public var preventionCommitment: String
    public var plannedSeconds: Int
    public var actualSeconds: Int
    public var completedFlag: Int
    public var anxietyBefore: Int
    public var anxietyAfter: Int
    public var outcomeIndex: Int
    public var whatHappened: String
    public var learning: String
    public var note: String?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, planId: Int64? = nil, exerciseId: String, exerciseTitle: String,
                triggerOrExposure: String, fearPrediction: String, preventionCommitment: String,
                plannedSeconds: Int, actualSeconds: Int, completed: Bool, anxietyBefore: Int, anxietyAfter: Int,
                outcome: DelayOutcome, whatHappened: String, learning: String, note: String? = nil,
                createdAt: DartTimestamp) {
        self.id = id; self.planId = planId; self.exerciseId = exerciseId; self.exerciseTitle = exerciseTitle
        self.triggerOrExposure = triggerOrExposure; self.fearPrediction = fearPrediction
        self.preventionCommitment = preventionCommitment; self.plannedSeconds = plannedSeconds
        self.actualSeconds = actualSeconds; self.completedFlag = completed ? 1 : 0
        self.anxietyBefore = anxietyBefore; self.anxietyAfter = anxietyAfter; self.outcomeIndex = outcome.rawValue
        self.whatHappened = whatHappened; self.learning = learning; self.note = note; self.createdAt = createdAt
    }

    public var completed: Bool { completedFlag == 1 }
    public var outcome: DelayOutcome? { DelayOutcome(rawValue: outcomeIndex) }

    enum CodingKeys: String, CodingKey {
        case id, learning, note
        case planId = "plan_id"
        case exerciseId = "exercise_id"
        case exerciseTitle = "exercise_title"
        case triggerOrExposure = "trigger_or_exposure"
        case fearPrediction = "fear_prediction"
        case preventionCommitment = "prevention_commitment"
        case plannedSeconds = "planned_seconds"
        case actualSeconds = "actual_seconds"
        case completedFlag = "completed"
        case anxietyBefore = "anxiety_before"
        case anxietyAfter = "anxiety_after"
        case outcomeIndex = "outcome"
        case whatHappened = "what_happened"
        case createdAt = "created_at"
    }
}

// MARK: - exposure_hierarchies

public struct ExposureHierarchy: PatternsRecord {
    public static let databaseTableName = "exposure_hierarchies"
    public var id: Int64?
    public var title: String
    public var theme: String
    public var archivedFlag: Int
    public var createdAt: DartTimestamp
    public var updatedAt: DartTimestamp

    public init(id: Int64? = nil, title: String, theme: String, archived: Bool = false,
                createdAt: DartTimestamp, updatedAt: DartTimestamp) {
        self.id = id; self.title = title; self.theme = theme; self.archivedFlag = archived ? 1 : 0
        self.createdAt = createdAt; self.updatedAt = updatedAt
    }

    public var archived: Bool { archivedFlag == 1 }

    enum CodingKeys: String, CodingKey {
        case id, title, theme
        case archivedFlag = "archived"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - exposure_steps

public struct ExposureStep: PatternsRecord {
    public static let databaseTableName = "exposure_steps"
    public var id: Int64?
    public var hierarchyId: Int64?
    public var orderIndex: Int
    public var description: String
    public var difficulty: Int
    public var anxietyRating: Int
    public var statusIndex: Int
    public var completedAt: DartTimestamp?

    public init(id: Int64? = nil, hierarchyId: Int64?, orderIndex: Int, description: String, difficulty: Int,
                anxietyRating: Int, status: ExposureStepStatus, completedAt: DartTimestamp? = nil) {
        self.id = id; self.hierarchyId = hierarchyId; self.orderIndex = orderIndex; self.description = description
        self.difficulty = difficulty; self.anxietyRating = anxietyRating; self.statusIndex = status.rawValue
        self.completedAt = completedAt
    }

    public var status: ExposureStepStatus? { ExposureStepStatus(rawValue: statusIndex) }

    enum CodingKeys: String, CodingKey {
        case id, description, difficulty
        case hierarchyId = "hierarchy_id"
        case orderIndex = "order_index"
        case anxietyRating = "anxiety_rating"
        case statusIndex = "status"
        case completedAt = "completed_at"
    }
}

// MARK: - response_prevention_logs

public struct ResponsePreventionLog: PatternsRecord {
    public static let databaseTableName = "response_prevention_logs"
    public var id: Int64?
    public var datetime: DartTimestamp
    public var situation: String
    public var outcomeIndex: Int
    public var anxietyLevel: Int
    public var note: String?
    public var linkedStepId: Int64?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, datetime: DartTimestamp, situation: String, outcome: ResponseOutcome,
                anxietyLevel: Int, note: String? = nil, linkedStepId: Int64? = nil, createdAt: DartTimestamp) {
        self.id = id; self.datetime = datetime; self.situation = situation; self.outcomeIndex = outcome.rawValue
        self.anxietyLevel = anxietyLevel; self.note = note; self.linkedStepId = linkedStepId; self.createdAt = createdAt
    }

    public var outcome: ResponseOutcome? { ResponseOutcome(rawValue: outcomeIndex) }

    enum CodingKeys: String, CodingKey {
        case id, datetime, situation, note
        case outcomeIndex = "outcome"
        case anxietyLevel = "anxiety_level"
        case linkedStepId = "linked_step_id"
        case createdAt = "created_at"
    }
}

// MARK: - urge_surf_sessions

public struct UrgeSurfSession: PatternsRecord {
    public static let databaseTableName = "urge_surf_sessions"
    public var id: Int64?
    public var datetime: DartTimestamp
    public var trigger: String
    public var initialUrge: Int
    public var peakUrge: Int
    public var finalUrge: Int
    public var durationSeconds: Int
    public var note: String?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, datetime: DartTimestamp, trigger: String, initialUrge: Int, peakUrge: Int,
                finalUrge: Int, durationSeconds: Int, note: String? = nil, createdAt: DartTimestamp) {
        self.id = id; self.datetime = datetime; self.trigger = trigger; self.initialUrge = initialUrge
        self.peakUrge = peakUrge; self.finalUrge = finalUrge; self.durationSeconds = durationSeconds
        self.note = note; self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case id, datetime, trigger, note
        case initialUrge = "initial_urge"
        case peakUrge = "peak_urge"
        case finalUrge = "final_urge"
        case durationSeconds = "duration_seconds"
        case createdAt = "created_at"
    }
}

// MARK: - program_enrollments

public struct ProgramEnrollment: PatternsRecord {
    public static let databaseTableName = "program_enrollments"
    public var id: Int64?
    public var programId: String
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, programId: String, createdAt: DartTimestamp) {
        self.id = id; self.programId = programId; self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case id
        case programId = "program_id"
        case createdAt = "created_at"
    }
}

// MARK: - program_task_progress

public struct ProgramTaskProgress: PatternsRecord {
    public static let databaseTableName = "program_task_progress"
    public var id: Int64?
    public var enrollmentId: Int64
    public var weekIndex: Int
    public var taskId: String
    public var completedAt: DartTimestamp

    public init(id: Int64? = nil, enrollmentId: Int64, weekIndex: Int, taskId: String, completedAt: DartTimestamp) {
        self.id = id; self.enrollmentId = enrollmentId; self.weekIndex = weekIndex; self.taskId = taskId
        self.completedAt = completedAt
    }

    enum CodingKeys: String, CodingKey {
        case id
        case enrollmentId = "enrollment_id"
        case weekIndex = "week_index"
        case taskId = "task_id"
        case completedAt = "completed_at"
    }
}

// MARK: - behavioral_experiments

public struct BehavioralExperiment: PatternsRecord {
    public static let databaseTableName = "behavioral_experiments"
    public var id: Int64?
    public var datetime: DartTimestamp
    public var fearPrediction: String
    /// 0 to 100.
    public var confidence: Int
    public var experiment: String
    public var outcome: String?
    public var learning: String?
    public var statusIndex: Int
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, datetime: DartTimestamp, fearPrediction: String, confidence: Int, experiment: String,
                outcome: String = "", learning: String = "", status: ExperimentStatus, createdAt: DartTimestamp) {
        self.id = id; self.datetime = datetime; self.fearPrediction = fearPrediction; self.confidence = confidence
        self.experiment = experiment; self.outcome = outcome; self.learning = learning
        self.statusIndex = status.rawValue; self.createdAt = createdAt
    }

    /// Dart reads `map['outcome'] ?? ''`.
    public var outcomeText: String { outcome ?? "" }
    /// Dart reads `map['learning'] ?? ''`.
    public var learningText: String { learning ?? "" }
    public var status: ExperimentStatus? { ExperimentStatus(rawValue: statusIndex) }

    enum CodingKeys: String, CodingKey {
        case id, datetime, confidence, experiment, outcome, learning
        case fearPrediction = "fear_prediction"
        case statusIndex = "status"
        case createdAt = "created_at"
    }
}

// MARK: - exposure_reflections

public struct ExposureReflection: PatternsRecord {
    public static let databaseTableName = "exposure_reflections"
    public var id: Int64?
    public var datetime: DartTimestamp
    public var whatHappened: String
    public var ocdPredicted: String
    public var actuallyHappened: String
    public var whatILearned: String
    public var doDifferently: String
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, datetime: DartTimestamp, whatHappened: String, ocdPredicted: String,
                actuallyHappened: String, whatILearned: String, doDifferently: String, createdAt: DartTimestamp) {
        self.id = id; self.datetime = datetime; self.whatHappened = whatHappened; self.ocdPredicted = ocdPredicted
        self.actuallyHappened = actuallyHappened; self.whatILearned = whatILearned
        self.doDifferently = doDifferently; self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case id, datetime
        case whatHappened = "what_happened"
        case ocdPredicted = "ocd_predicted"
        case actuallyHappened = "actually_happened"
        case whatILearned = "what_i_learned"
        case doDifferently = "do_differently"
        case createdAt = "created_at"
    }
}

// MARK: - action_plans

public struct ActionPlan: PatternsRecord {
    public static let databaseTableName = "action_plans"
    public var id: Int64?
    public var situation: String
    public var plannedAction: String
    /// Stored verbatim, as Dart treats it as an opaque string.
    public var date: String?
    public var notes: String?
    public var completedFlag: Int
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, situation: String, plannedAction: String, date: String? = nil, notes: String? = nil,
                completed: Bool = false, createdAt: DartTimestamp) {
        self.id = id; self.situation = situation; self.plannedAction = plannedAction; self.date = date
        self.notes = notes; self.completedFlag = completed ? 1 : 0; self.createdAt = createdAt
    }

    public var completed: Bool { completedFlag == 1 }

    enum CodingKeys: String, CodingKey {
        case id, situation, date, notes
        case plannedAction = "planned_action"
        case completedFlag = "completed"
        case createdAt = "created_at"
    }
}

// MARK: - implementation_intentions

public struct ImplementationIntention: PatternsRecord {
    public static let databaseTableName = "implementation_intentions"
    public var id: Int64?
    public var trigger: String
    public var response: String
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, trigger: String, response: String, createdAt: DartTimestamp) {
        self.id = id; self.trigger = trigger; self.response = response; self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case id, trigger, response
        case createdAt = "created_at"
    }
}

// MARK: - uncertainty_log

public struct UncertaintyLog: PatternsRecord {
    public static let databaseTableName = "uncertainty_log"
    public var id: Int64?
    public var datetime: DartTimestamp
    public var exerciseId: String
    /// 0 to 10.
    public var willingness: Int
    public var note: String?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, datetime: DartTimestamp, exerciseId: String, willingness: Int, note: String? = nil,
                createdAt: DartTimestamp) {
        self.id = id; self.datetime = datetime; self.exerciseId = exerciseId; self.willingness = willingness
        self.note = note; self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case id, datetime, willingness, note
        case exerciseId = "exercise_id"
        case createdAt = "created_at"
    }
}

// MARK: - exposure_materials

public struct ExposureMaterial: PatternsRecord {
    public static let databaseTableName = "exposure_materials"
    public var id: Int64?
    public var typeIndex: Int
    public var title: String
    public var text: String?
    public var url: String?
    /// Relative name inside the materials folder. See ``MaterialFileStore``.
    public var fileName: String?
    public var linkedHierarchyId: Int64?
    public var linkedStepId: Int64?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, type: MaterialType, title: String, text: String? = nil, url: String? = nil,
                fileName: String? = nil, linkedHierarchyId: Int64? = nil, linkedStepId: Int64? = nil,
                createdAt: DartTimestamp) {
        self.id = id; self.typeIndex = type.rawValue; self.title = title; self.text = text; self.url = url
        self.fileName = fileName; self.linkedHierarchyId = linkedHierarchyId; self.linkedStepId = linkedStepId
        self.createdAt = createdAt
    }

    public var type: MaterialType? { MaterialType(rawValue: typeIndex) }

    enum CodingKeys: String, CodingKey {
        case id, title, text, url
        case typeIndex = "type"
        case fileName = "file_name"
        case linkedHierarchyId = "linked_hierarchy_id"
        case linkedStepId = "linked_step_id"
        case createdAt = "created_at"
    }
}

// MARK: - ybocs_assessments

public struct YbocsAssessment: PatternsRecord {
    public static let databaseTableName = "ybocs_assessments"
    public var id: Int64?
    public var datetime: DartTimestamp
    public var obsessionScore: Int
    public var compulsionScore: Int
    public var totalScore: Int
    public var severityIndex: Int
    /// Comma-separated 0 to 4 scores for the ten items.
    public var itemScoresRaw: String
    /// Comma-separated symptom category ids.
    public var themesRaw: String?
    /// Comma-separated symptom item ids.
    public var symptomsRaw: String?
    public var createdAt: DartTimestamp

    public init(id: Int64? = nil, datetime: DartTimestamp, obsessionScore: Int, compulsionScore: Int, totalScore: Int,
                severity: YbocsSeverity, itemScores: [Int], themes: [String], symptoms: [String],
                createdAt: DartTimestamp) {
        self.id = id; self.datetime = datetime; self.obsessionScore = obsessionScore
        self.compulsionScore = compulsionScore; self.totalScore = totalScore; self.severityIndex = severity.rawValue
        self.itemScoresRaw = itemScores.map(String.init).joined(separator: ",")
        self.themesRaw = themes.joined(separator: ","); self.symptomsRaw = symptoms.joined(separator: ",")
        self.createdAt = createdAt
    }

    public var severity: YbocsSeverity? { YbocsSeverity(rawValue: severityIndex) }

    public var itemScores: [Int] {
        let s = itemScoresRaw.trimmingCharacters(in: .whitespaces)
        guard !s.isEmpty else { return [] }
        return s.split(separator: ",", omittingEmptySubsequences: false)
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
    }

    public var themes: [String] { Self.splitIds(themesRaw) }
    public var symptoms: [String] { Self.splitIds(symptomsRaw) }

    private static func splitIds(_ raw: String?) -> [String] {
        let s = raw?.trimmingCharacters(in: .whitespaces) ?? ""
        guard !s.isEmpty else { return [] }
        return s.split(separator: ",", omittingEmptySubsequences: false).map(String.init)
    }

    enum CodingKeys: String, CodingKey {
        case id, datetime
        case obsessionScore = "obsession_score"
        case compulsionScore = "compulsion_score"
        case totalScore = "total_score"
        case severityIndex = "severity"
        case itemScoresRaw = "item_scores"
        case themesRaw = "themes"
        case symptomsRaw = "symptoms"
        case createdAt = "created_at"
    }
}
