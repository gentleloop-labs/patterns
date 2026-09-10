import '../l10n/app_localizations.dart';

enum ProEntryPoint {
  settings,
  todayNextStep,
  recoveryMetrics,
  exposureHierarchy,
  exposureMaterials,
  structuredPrograms,
  actionPlanner,
  implementationIntentions,
  urgeSurfing,
  responsePrevention,
  uncertaintyTraining,
  behavioralExperiments,
  reflectionJournal,
}

extension ProEntryPointCopy on ProEntryPoint {
  String get wireName => switch (this) {
    ProEntryPoint.settings => 'settings',
    ProEntryPoint.todayNextStep => 'today_next_step',
    ProEntryPoint.recoveryMetrics => 'recovery_metrics',
    ProEntryPoint.exposureHierarchy => 'exposure_hierarchy',
    ProEntryPoint.exposureMaterials => 'exposure_materials',
    ProEntryPoint.structuredPrograms => 'structured_programs',
    ProEntryPoint.actionPlanner => 'action_planner',
    ProEntryPoint.implementationIntentions => 'implementation_intentions',
    ProEntryPoint.urgeSurfing => 'urge_surfing',
    ProEntryPoint.responsePrevention => 'response_prevention',
    ProEntryPoint.uncertaintyTraining => 'uncertainty_training',
    ProEntryPoint.behavioralExperiments => 'behavioral_experiments',
    ProEntryPoint.reflectionJournal => 'reflection_journal',
  };

  String headline(AppLocalizations strings) => switch (this) {
    ProEntryPoint.todayNextStep => strings.proHeadlineTodayNextStep,
    ProEntryPoint.recoveryMetrics => strings.proHeadlineRecoveryMetrics,
    ProEntryPoint.exposureHierarchy => strings.proHeadlineExposureHierarchy,
    ProEntryPoint.exposureMaterials => strings.proHeadlineExposureMaterials,
    ProEntryPoint.structuredPrograms => strings.proHeadlineStructuredPrograms,
    ProEntryPoint.actionPlanner => strings.proHeadlineActionPlanner,
    ProEntryPoint.implementationIntentions =>
      strings.proHeadlineImplementationIntentions,
    ProEntryPoint.urgeSurfing => strings.proHeadlineUrgeSurfing,
    ProEntryPoint.responsePrevention => strings.proHeadlineResponsePrevention,
    ProEntryPoint.uncertaintyTraining => strings.proHeadlineUncertaintyTraining,
    ProEntryPoint.behavioralExperiments =>
      strings.proHeadlineBehavioralExperiments,
    ProEntryPoint.reflectionJournal => strings.proHeadlineReflectionJournal,
    ProEntryPoint.settings => strings.proHeadlineSettings,
  };

  List<String> benefits(AppLocalizations strings) => switch (this) {
    ProEntryPoint.recoveryMetrics => [
      strings.proBenefitMetricsActivity,
      strings.proBenefitMetricsNonjudgmental,
      strings.proBenefitMetricsPatterns,
    ],
    ProEntryPoint.exposureHierarchy || ProEntryPoint.exposureMaterials => [
      strings.proBenefitExposureLadder,
      strings.proBenefitExposureMaterials,
      strings.proBenefitExposureRepeatable,
    ],
    ProEntryPoint.structuredPrograms => [
      strings.proBenefitProgramsStructure,
      strings.proBenefitProgramsTasks,
      strings.proBenefitProgramsReview,
    ],
    ProEntryPoint.actionPlanner || ProEntryPoint.implementationIntentions => [
      strings.proBenefitPlanningAhead,
      strings.proBenefitPlanningIfThen,
      strings.proBenefitPlanningReturn,
    ],
    ProEntryPoint.urgeSurfing ||
    ProEntryPoint.responsePrevention ||
    ProEntryPoint.uncertaintyTraining => [
      strings.proBenefitInMomentTools,
      strings.proBenefitInMomentPrivacy,
      strings.proBenefitInMomentRepetition,
    ],
    ProEntryPoint.behavioralExperiments || ProEntryPoint.reflectionJournal => [
      strings.proBenefitReflectionCompare,
      strings.proBenefitReflectionCapture,
      strings.proBenefitReflectionPatterns,
    ],
    ProEntryPoint.settings || ProEntryPoint.todayNextStep => [
      strings.proBenefitGeneralPlans,
      strings.proBenefitGeneralResponsePrevention,
      strings.proBenefitGeneralReview,
    ],
  };
}
