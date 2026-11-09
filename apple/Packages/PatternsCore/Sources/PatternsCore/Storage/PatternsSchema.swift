import GRDB

/// The on-disk schema, copied verbatim from `lib/database/db_helper.dart`.
///
/// The Flutter Android app and older iOS builds read the same files and
/// backups, so this must stay identical to the Dart DDL. Native 2.0 ships
/// schema v10 unchanged so a Flutter build can still be installed on top.
/// Any v11+ change has to land in both codebases together.
public enum PatternsSchema {
    /// `PRAGMA user_version` written by the Flutter app (sqflite `version:`).
    public static let currentVersion = 10

    /// `schema_version` written into backup `data.json` files.
    public static let backupSchemaVersion = 10

    public static let databaseFileName = "patterns.db"

    /// Every data table, in the order Flutter exports, imports and wipes them.
    public static let dataTables: [String] = [
        "journal",
        "ocd",
        "delay_sessions",
        "erp_exercise_plans",
        "erp_exercise_sessions",
        "exposure_hierarchies",
        "exposure_steps",
        "response_prevention_logs",
        "urge_surf_sessions",
        "program_enrollments",
        "program_task_progress",
        "behavioral_experiments",
        "exposure_reflections",
        "action_plans",
        "implementation_intentions",
        "uncertainty_log",
        "exposure_materials",
        "ybocs_assessments",
    ]

    static let journalDDL = """
        CREATE TABLE journal (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT UNIQUE,
          content TEXT,
          created_at TEXT,
          updated_at TEXT
        )
        """

    static let ocdDDL = """
        CREATE TABLE ocd (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type INTEGER,
          datetime TEXT,
          content TEXT,
          distress_level INTEGER,
          response TEXT,
          action_taken TEXT,
          created_at TEXT
        )
        """

    /// Tables added by each Flutter `onUpgrade` step, keyed by the version
    /// that introduced them. All use `CREATE TABLE IF NOT EXISTS`.
    static let additions: [(version: Int, ddl: [String])] = [
        (2, [delaySessions]),
        (3, [erpExercisePlans, erpExerciseSessions]),
        (4, [exposureHierarchies, exposureSteps]),
        (5, [responsePreventionLogs, urgeSurfSessions]),
        (6, [programEnrollments, programTaskProgress]),
        (7, [behavioralExperiments, exposureReflections]),
        (8, [actionPlans, implementationIntentions, uncertaintyLog]),
        (9, [exposureMaterials]),
        (10, [ybocsAssessments]),
    ]

    /// Mirrors Flutter's `_createDB`: a brand-new install.
    static func create(_ db: Database) throws {
        try db.execute(sql: journalDDL)
        try db.execute(sql: ocdDDL)
        for step in additions {
            for ddl in step.ddl { try db.execute(sql: ddl) }
        }
    }

    /// Mirrors Flutter's `_onUpgrade(oldVersion)`. Purely additive.
    static func upgrade(_ db: Database, from oldVersion: Int) throws {
        for step in additions where oldVersion < step.version {
            for ddl in step.ddl { try db.execute(sql: ddl) }
        }
    }

    static let delaySessions = """
        CREATE TABLE IF NOT EXISTS delay_sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          compulsion TEXT,
          planned_seconds INTEGER,
          actual_seconds INTEGER,
          completed INTEGER,
          urge_before INTEGER,
          urge_after INTEGER,
          outcome INTEGER,
          note TEXT,
          created_at TEXT
        )
        """

    static let erpExercisePlans = """
        CREATE TABLE IF NOT EXISTS erp_exercise_plans (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          exercise_id TEXT,
          exercise_title TEXT,
          trigger_or_exposure TEXT,
          fear_prediction TEXT,
          prevention_commitment TEXT,
          default_seconds INTEGER,
          archived INTEGER,
          created_at TEXT,
          updated_at TEXT
        )
        """

    static let erpExerciseSessions = """
        CREATE TABLE IF NOT EXISTS erp_exercise_sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          plan_id INTEGER,
          exercise_id TEXT,
          exercise_title TEXT,
          trigger_or_exposure TEXT,
          fear_prediction TEXT,
          prevention_commitment TEXT,
          planned_seconds INTEGER,
          actual_seconds INTEGER,
          completed INTEGER,
          anxiety_before INTEGER,
          anxiety_after INTEGER,
          outcome INTEGER,
          what_happened TEXT,
          learning TEXT,
          note TEXT,
          created_at TEXT
        )
        """

    static let exposureHierarchies = """
        CREATE TABLE IF NOT EXISTS exposure_hierarchies (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          theme TEXT,
          archived INTEGER,
          created_at TEXT,
          updated_at TEXT
        )
        """

    static let exposureSteps = """
        CREATE TABLE IF NOT EXISTS exposure_steps (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          hierarchy_id INTEGER,
          order_index INTEGER,
          description TEXT,
          difficulty INTEGER,
          anxiety_rating INTEGER,
          status INTEGER,
          completed_at TEXT
        )
        """

    static let responsePreventionLogs = """
        CREATE TABLE IF NOT EXISTS response_prevention_logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datetime TEXT,
          situation TEXT,
          outcome INTEGER,
          anxiety_level INTEGER,
          note TEXT,
          linked_step_id INTEGER,
          created_at TEXT
        )
        """

    static let urgeSurfSessions = """
        CREATE TABLE IF NOT EXISTS urge_surf_sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datetime TEXT,
          trigger TEXT,
          initial_urge INTEGER,
          peak_urge INTEGER,
          final_urge INTEGER,
          duration_seconds INTEGER,
          note TEXT,
          created_at TEXT
        )
        """

    static let programEnrollments = """
        CREATE TABLE IF NOT EXISTS program_enrollments (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          program_id TEXT,
          created_at TEXT
        )
        """

    static let programTaskProgress = """
        CREATE TABLE IF NOT EXISTS program_task_progress (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          enrollment_id INTEGER,
          week_index INTEGER,
          task_id TEXT,
          completed_at TEXT
        )
        """

    static let behavioralExperiments = """
        CREATE TABLE IF NOT EXISTS behavioral_experiments (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datetime TEXT,
          fear_prediction TEXT,
          confidence INTEGER,
          experiment TEXT,
          outcome TEXT,
          learning TEXT,
          status INTEGER,
          created_at TEXT
        )
        """

    static let exposureReflections = """
        CREATE TABLE IF NOT EXISTS exposure_reflections (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datetime TEXT,
          what_happened TEXT,
          ocd_predicted TEXT,
          actually_happened TEXT,
          what_i_learned TEXT,
          do_differently TEXT,
          created_at TEXT
        )
        """

    static let actionPlans = """
        CREATE TABLE IF NOT EXISTS action_plans (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          situation TEXT,
          planned_action TEXT,
          date TEXT,
          notes TEXT,
          completed INTEGER,
          created_at TEXT
        )
        """

    static let implementationIntentions = """
        CREATE TABLE IF NOT EXISTS implementation_intentions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          trigger TEXT,
          response TEXT,
          created_at TEXT
        )
        """

    static let uncertaintyLog = """
        CREATE TABLE IF NOT EXISTS uncertainty_log (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datetime TEXT,
          exercise_id TEXT,
          willingness INTEGER,
          note TEXT,
          created_at TEXT
        )
        """

    static let exposureMaterials = """
        CREATE TABLE IF NOT EXISTS exposure_materials (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type INTEGER,
          title TEXT,
          text TEXT,
          url TEXT,
          file_name TEXT,
          linked_hierarchy_id INTEGER,
          linked_step_id INTEGER,
          created_at TEXT
        )
        """

    static let ybocsAssessments = """
        CREATE TABLE IF NOT EXISTS ybocs_assessments (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datetime TEXT,
          obsession_score INTEGER,
          compulsion_score INTEGER,
          total_score INTEGER,
          severity INTEGER,
          item_scores TEXT,
          themes TEXT,
          symptoms TEXT,
          created_at TEXT
        )
        """
}
