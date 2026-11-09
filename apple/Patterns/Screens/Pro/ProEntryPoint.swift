/// `ProEntryPoint` from `lib/services/pro_entry_point.dart`: where the
/// paywall was opened from, which picks its headline and benefits. Wire
/// names match the Flutter analytics events.
enum ProEntryPoint: String {
    case settings
    case todayNextStep = "today_next_step"
    case recoveryMetrics = "recovery_metrics"
    case exposureHierarchy = "exposure_hierarchy"
    case exposureMaterials = "exposure_materials"
    case structuredPrograms = "structured_programs"
    case actionPlanner = "action_planner"
    case implementationIntentions = "implementation_intentions"
    case urgeSurfing = "urge_surfing"
    case responsePrevention = "response_prevention"
    case uncertaintyTraining = "uncertainty_training"
    case behavioralExperiments = "behavioral_experiments"
    case reflectionJournal = "reflection_journal"

    var wireName: String { rawValue }

    func headline(_ strings: Strings) -> String {
        switch self {
        case .todayNextStep: strings.proHeadlineTodayNextStep
        case .recoveryMetrics: strings.proHeadlineRecoveryMetrics
        case .exposureHierarchy: strings.proHeadlineExposureHierarchy
        case .exposureMaterials: strings.proHeadlineExposureMaterials
        case .structuredPrograms: strings.proHeadlineStructuredPrograms
        case .actionPlanner: strings.proHeadlineActionPlanner
        case .implementationIntentions: strings.proHeadlineImplementationIntentions
        case .urgeSurfing: strings.proHeadlineUrgeSurfing
        case .responsePrevention: strings.proHeadlineResponsePrevention
        case .uncertaintyTraining: strings.proHeadlineUncertaintyTraining
        case .behavioralExperiments: strings.proHeadlineBehavioralExperiments
        case .reflectionJournal: strings.proHeadlineReflectionJournal
        case .settings: strings.proHeadlineSettings
        }
    }

    func benefits(_ strings: Strings) -> [String] {
        switch self {
        case .recoveryMetrics:
            [strings.proBenefitMetricsActivity, strings.proBenefitMetricsNonjudgmental, strings.proBenefitMetricsPatterns]
        case .exposureHierarchy, .exposureMaterials:
            [strings.proBenefitExposureLadder, strings.proBenefitExposureMaterials, strings.proBenefitExposureRepeatable]
        case .structuredPrograms:
            [strings.proBenefitProgramsStructure, strings.proBenefitProgramsTasks, strings.proBenefitProgramsReview]
        case .actionPlanner, .implementationIntentions:
            [strings.proBenefitPlanningAhead, strings.proBenefitPlanningIfThen, strings.proBenefitPlanningReturn]
        case .urgeSurfing, .responsePrevention, .uncertaintyTraining:
            [strings.proBenefitInMomentTools, strings.proBenefitInMomentPrivacy, strings.proBenefitInMomentRepetition]
        case .behavioralExperiments, .reflectionJournal:
            [strings.proBenefitReflectionCompare, strings.proBenefitReflectionCapture, strings.proBenefitReflectionPatterns]
        case .settings, .todayNextStep:
            [strings.proBenefitGeneralPlans, strings.proBenefitGeneralResponsePrevention, strings.proBenefitGeneralReview]
        }
    }
}
