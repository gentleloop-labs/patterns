import Foundation

/// A backup the app refuses to restore. Messages match the Dart
/// `FormatException`s in `lib/database/db_helper.dart`.
public struct BackupFormatError: Error, Equatable, CustomStringConvertible {
    public let message: String
    public init(_ message: String) { self.message = message }
    public var description: String { message }
}

/// Port of `DbHelper._validateBackup`. A backup that Flutter accepts is
/// accepted here and one that Flutter rejects is rejected here, so restores
/// behave the same on every platform.
enum BackupValidator {
    static func decodeRoot(_ text: String) throws -> JSONValue {
        let value: JSONValue
        do {
            value = try JSONValue.parse(text)
        } catch {
            throw BackupFormatError("Backup is not valid JSON")
        }
        guard case .object = value else { throw BackupFormatError("Backup root must be an object") }
        return value
    }

    static func list(_ data: JSONValue, _ key: String) throws -> [JSONValue] {
        guard let value = data[key], !value.isNull else { return [] }
        guard case let .array(items) = value else { throw BackupFormatError("Expected \(key) to be a list") }
        return items
    }

    static func validate(_ data: JSONValue) throws {
        if let schemaVersion = data["schema_version"], !schemaVersion.isNull {
            // Older backups restore; only newer ones are refused.
            guard case let .int(version) = schemaVersion, version <= Int64(PatternsSchema.backupSchemaVersion) else {
                throw BackupFormatError("Unsupported backup version")
            }
        }
        let rules: [(String, (Item) throws -> Void)] = [
            ("journal", journal),
            ("ocd", ocd),
            ("delay_sessions", delaySession),
            ("erp_exercise_plans", erpExercisePlan),
            ("erp_exercise_sessions", erpExerciseSession),
            ("exposure_hierarchies", exposureHierarchy),
            ("exposure_steps", exposureStep),
            ("response_prevention_logs", responsePrevention),
            ("urge_surf_sessions", urgeSurf),
            ("program_enrollments", programEnrollment),
            ("program_task_progress", programTaskProgress),
            ("behavioral_experiments", behavioralExperiment),
            ("exposure_reflections", exposureReflection),
            ("action_plans", actionPlan),
            ("implementation_intentions", implementationIntention),
            ("uncertainty_log", uncertaintyLog),
            ("exposure_materials", exposureMaterial),
            ("ybocs_assessments", ybocsAssessment),
        ]
        // Dart reads every list first, then validates items table by table.
        var lists: [(String, [JSONValue])] = []
        for (key, _) in rules { lists.append((key, try list(data, key))) }
        for (index, (key, rule)) in rules.enumerated() {
            for raw in lists[index].1 {
                try rule(Item(raw, table: key))
            }
        }
    }

    // MARK: - Item access

    struct Item {
        let value: JSONValue
        let table: String
        init(_ value: JSONValue, table: String) { self.value = value; self.table = table }

        func isObject() -> Bool {
            if case .object = value { return true }
            return false
        }

        subscript(key: String) -> JSONValue? {
            guard let v = value[key], !v.isNull else { return nil }
            return v
        }

        func string(_ key: String) throws -> String {
            guard case let .string(s)? = self[key] else { throw BackupFormatError("Expected \(key) to be a string") }
            return s
        }

        func int(_ key: String) throws -> Int64 {
            guard case let .int(i)? = self[key] else { throw BackupFormatError("Expected \(key) to be an integer") }
            return i
        }

        func optionalString(_ key: String, _ message: String) throws {
            if let v = self[key], v.stringValue == nil { throw BackupFormatError(message) }
        }

        func optionalInt(_ key: String, _ message: String) throws {
            if let v = self[key], v.intValue == nil { throw BackupFormatError(message) }
        }

        /// Dart's `DateTime.parse`, which throws on a bad value.
        func date(_ key: String) throws {
            guard DartDateTime.parse(try string(key)) != nil else {
                throw BackupFormatError("Invalid date format")
            }
        }
    }

    private static func requireObject(_ item: Item, _ message: String) throws {
        guard item.isObject() else { throw BackupFormatError(message) }
    }

    private static func range(_ value: Int64, _ bounds: ClosedRange<Int64>, _ message: String) throws {
        guard bounds.contains(value) else { throw BackupFormatError(message) }
    }

    private static func index(_ value: Int64, count: Int, _ message: String) throws {
        guard value >= 0, value < Int64(count) else { throw BackupFormatError(message) }
    }

    private static func flag(_ value: Int64, _ message: String) throws {
        guard value == 0 || value == 1 else { throw BackupFormatError(message) }
    }

    // MARK: - Per-table rules

    static func journal(_ item: Item) throws {
        try requireObject(item, "Invalid journal entry")
        _ = try item.string("date")
        _ = try item.string("content")
        _ = try item.string("created_at")
        _ = try item.string("updated_at")
        try item.date("created_at")
        try item.date("updated_at")
    }

    static func ocd(_ item: Item) throws {
        try requireObject(item, "Invalid OCD entry")
        let type = try item.int("type")
        _ = try item.string("datetime")
        _ = try item.string("content")
        let distress = try item.int("distress_level")
        _ = try item.string("response")
        _ = try item.string("created_at")
        try item.optionalString("action_taken", "Invalid action taken")
        try index(type, count: OcdType.allCases.count, "Invalid OCD entry type")
        try range(distress, 0...10, "Invalid distress level")
        try item.date("datetime")
        try item.date("created_at")
    }

    static func erpExercisePlan(_ item: Item) throws {
        try requireObject(item, "Invalid ERP exercise plan")
        for key in ["exercise_id", "exercise_title", "trigger_or_exposure", "fear_prediction", "prevention_commitment"] {
            _ = try item.string(key)
        }
        _ = try item.int("default_seconds")
        let archived = try item.int("archived")
        _ = try item.string("created_at")
        _ = try item.string("updated_at")
        try flag(archived, "Invalid ERP exercise plan archive state")
        try item.date("created_at")
        try item.date("updated_at")
    }

    static func erpExerciseSession(_ item: Item) throws {
        try requireObject(item, "Invalid ERP exercise session")
        try item.optionalInt("plan_id", "Invalid ERP exercise plan id")
        for key in ["exercise_id", "exercise_title", "trigger_or_exposure", "fear_prediction", "prevention_commitment"] {
            _ = try item.string(key)
        }
        _ = try item.int("planned_seconds")
        _ = try item.int("actual_seconds")
        _ = try item.int("completed")
        let before = try item.int("anxiety_before")
        let after = try item.int("anxiety_after")
        let outcome = try item.int("outcome")
        _ = try item.string("what_happened")
        _ = try item.string("learning")
        _ = try item.string("created_at")
        try item.optionalString("note", "Invalid ERP exercise session note")
        guard (0...10).contains(before), (0...10).contains(after) else {
            throw BackupFormatError("Invalid anxiety level")
        }
        try index(outcome, count: DelayOutcome.allCases.count, "Invalid ERP exercise outcome")
        try item.date("created_at")
    }

    static func delaySession(_ item: Item) throws {
        try requireObject(item, "Invalid delay session")
        _ = try item.string("compulsion")
        _ = try item.int("planned_seconds")
        _ = try item.int("actual_seconds")
        _ = try item.int("completed")
        let before = try item.int("urge_before")
        let after = try item.int("urge_after")
        let outcome = try item.int("outcome")
        _ = try item.string("created_at")
        try item.optionalString("note", "Invalid delay session note")
        guard (0...10).contains(before), (0...10).contains(after) else {
            throw BackupFormatError("Invalid urge level")
        }
        try index(outcome, count: DelayOutcome.allCases.count, "Invalid delay outcome")
        try item.date("created_at")
    }

    static func exposureHierarchy(_ item: Item) throws {
        try requireObject(item, "Invalid exposure hierarchy")
        _ = try item.string("title")
        _ = try item.string("theme")
        let archived = try item.int("archived")
        _ = try item.string("created_at")
        _ = try item.string("updated_at")
        try flag(archived, "Invalid exposure hierarchy archive state")
        try item.date("created_at")
        try item.date("updated_at")
    }

    static func exposureStep(_ item: Item) throws {
        try requireObject(item, "Invalid exposure step")
        try item.optionalInt("hierarchy_id", "Invalid exposure step hierarchy id")
        _ = try item.int("order_index")
        _ = try item.string("description")
        let difficulty = try item.int("difficulty")
        let anxiety = try item.int("anxiety_rating")
        let status = try item.int("status")
        try item.optionalString("completed_at", "Invalid exposure step completed_at")
        guard (0...10).contains(difficulty), (0...10).contains(anxiety) else {
            throw BackupFormatError("Invalid exposure step rating")
        }
        try index(status, count: ExposureStepStatus.allCases.count, "Invalid exposure step status")
        if item["completed_at"] != nil { try item.date("completed_at") }
    }

    static func responsePrevention(_ item: Item) throws {
        try requireObject(item, "Invalid response prevention log")
        _ = try item.string("datetime")
        _ = try item.string("situation")
        let outcome = try item.int("outcome")
        let anxiety = try item.int("anxiety_level")
        _ = try item.string("created_at")
        try item.optionalString("note", "Invalid response prevention note")
        try item.optionalInt("linked_step_id", "Invalid response prevention step id")
        try index(outcome, count: ResponseOutcome.allCases.count, "Invalid response prevention outcome")
        try range(anxiety, 0...10, "Invalid response prevention anxiety")
        try item.date("datetime")
        try item.date("created_at")
    }

    static func urgeSurf(_ item: Item) throws {
        try requireObject(item, "Invalid urge surf session")
        _ = try item.string("datetime")
        _ = try item.string("trigger")
        _ = try item.int("initial_urge")
        _ = try item.int("peak_urge")
        _ = try item.int("final_urge")
        _ = try item.int("duration_seconds")
        _ = try item.string("created_at")
        try item.optionalString("note", "Invalid urge surf note")
        for key in ["initial_urge", "peak_urge", "final_urge"] {
            try range(try item.int(key), 0...10, "Invalid urge level")
        }
        try item.date("datetime")
        try item.date("created_at")
    }

    static func programEnrollment(_ item: Item) throws {
        try requireObject(item, "Invalid program enrollment")
        _ = try item.string("program_id")
        _ = try item.string("created_at")
        try item.date("created_at")
    }

    static func programTaskProgress(_ item: Item) throws {
        try requireObject(item, "Invalid program task progress")
        _ = try item.int("enrollment_id")
        _ = try item.int("week_index")
        _ = try item.string("task_id")
        _ = try item.string("completed_at")
        try item.date("completed_at")
    }

    static func behavioralExperiment(_ item: Item) throws {
        try requireObject(item, "Invalid behavioral experiment")
        _ = try item.string("datetime")
        _ = try item.string("fear_prediction")
        let confidence = try item.int("confidence")
        _ = try item.string("experiment")
        _ = try item.string("outcome")
        _ = try item.string("learning")
        let status = try item.int("status")
        _ = try item.string("created_at")
        try range(confidence, 0...100, "Invalid experiment confidence")
        try index(status, count: ExperimentStatus.allCases.count, "Invalid experiment status")
        try item.date("datetime")
        try item.date("created_at")
    }

    static func exposureReflection(_ item: Item) throws {
        try requireObject(item, "Invalid exposure reflection")
        for key in ["datetime", "what_happened", "ocd_predicted", "actually_happened", "what_i_learned",
                    "do_differently", "created_at"] {
            _ = try item.string(key)
        }
        try item.date("datetime")
        try item.date("created_at")
    }

    static func actionPlan(_ item: Item) throws {
        try requireObject(item, "Invalid action plan")
        _ = try item.string("situation")
        _ = try item.string("planned_action")
        let completed = try item.int("completed")
        _ = try item.string("created_at")
        try item.optionalString("date", "Invalid action plan date")
        try item.optionalString("notes", "Invalid action plan notes")
        try flag(completed, "Invalid action plan completed state")
        try item.date("created_at")
    }

    static func implementationIntention(_ item: Item) throws {
        try requireObject(item, "Invalid implementation intention")
        _ = try item.string("trigger")
        _ = try item.string("response")
        _ = try item.string("created_at")
        try item.date("created_at")
    }

    static func uncertaintyLog(_ item: Item) throws {
        try requireObject(item, "Invalid uncertainty log")
        _ = try item.string("datetime")
        _ = try item.string("exercise_id")
        let willingness = try item.int("willingness")
        _ = try item.string("created_at")
        try item.optionalString("note", "Invalid uncertainty log note")
        try range(willingness, 0...10, "Invalid uncertainty willingness")
        try item.date("datetime")
        try item.date("created_at")
    }

    static func exposureMaterial(_ item: Item) throws {
        try requireObject(item, "Invalid exposure material")
        let type = try item.int("type")
        _ = try item.string("title")
        _ = try item.string("created_at")
        for key in ["text", "url", "file_name"] {
            try item.optionalString(key, "Invalid exposure material \(key)")
        }
        try item.optionalInt("linked_hierarchy_id", "Invalid exposure material hierarchy id")
        try item.optionalInt("linked_step_id", "Invalid exposure material step id")
        try index(type, count: MaterialType.allCases.count, "Invalid exposure material type")
        try item.date("created_at")
    }

    static func ybocsAssessment(_ item: Item) throws {
        try requireObject(item, "Invalid Y-BOCS assessment")
        _ = try item.string("datetime")
        let obsession = try item.int("obsession_score")
        let compulsion = try item.int("compulsion_score")
        let total = try item.int("total_score")
        let severity = try item.int("severity")
        let itemScores = try item.string("item_scores")
        _ = try item.string("created_at")
        for key in ["themes", "symptoms"] {
            try item.optionalString(key, "Invalid Y-BOCS assessment \(key)")
        }
        guard (0...20).contains(obsession), (0...20).contains(compulsion) else {
            throw BackupFormatError("Invalid Y-BOCS subscore")
        }
        try range(total, 0...40, "Invalid Y-BOCS total score")
        try index(severity, count: YbocsSeverity.allCases.count, "Invalid Y-BOCS severity")
        if !itemScores.trimmingCharacters(in: .whitespaces).isEmpty {
            for part in itemScores.split(separator: ",", omittingEmptySubsequences: false) {
                guard let score = Int(part.trimmingCharacters(in: .whitespaces)), (0...4).contains(score) else {
                    throw BackupFormatError("Invalid Y-BOCS item score")
                }
            }
        }
        try item.date("datetime")
        try item.date("created_at")
    }
}
