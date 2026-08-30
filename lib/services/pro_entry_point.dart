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

  String get headline => switch (this) {
    ProEntryPoint.todayNextStep => 'Keep building on today’s progress',
    ProEntryPoint.recoveryMetrics => 'See how your practice is changing',
    ProEntryPoint.exposureHierarchy => 'Build a clear exposure ladder',
    ProEntryPoint.exposureMaterials => 'Keep practice materials together',
    ProEntryPoint.structuredPrograms => 'Turn recovery into a routine',
    ProEntryPoint.actionPlanner => 'Plan your response before OCD arrives',
    ProEntryPoint.implementationIntentions => 'Make your next choice easier',
    ProEntryPoint.urgeSurfing => 'Practice riding out the urge',
    ProEntryPoint.responsePrevention => 'Track the response you chose',
    ProEntryPoint.uncertaintyTraining => 'Practice making room for maybe',
    ProEntryPoint.behavioralExperiments => 'Test OCD’s predictions',
    ProEntryPoint.reflectionJournal => 'Capture what each practice taught you',
    ProEntryPoint.settings => 'Move beyond tracking and practise recovery',
  };

  List<String> get benefits => switch (this) {
    ProEntryPoint.recoveryMetrics => const [
      'Follow practice consistency over time',
      'Notice change without judging individual days',
      'Review deeper recovery patterns',
    ],
    ProEntryPoint.exposureHierarchy ||
    ProEntryPoint.exposureMaterials => const [
      'Organize steps from gentler to harder',
      'Keep scripts, loop tapes, images, and links nearby',
      'Turn a plan into repeatable practice',
    ],
    ProEntryPoint.structuredPrograms => const [
      'Follow a calm week-by-week structure',
      'Keep practice tasks in one place',
      'Review what helped as you progress',
    ],
    ProEntryPoint.actionPlanner ||
    ProEntryPoint.implementationIntentions => const [
      'Choose a response before the hard moment',
      'Create practical if-then plans',
      'Return to the plan when uncertainty rises',
    ],
    ProEntryPoint.urgeSurfing ||
    ProEntryPoint.responsePrevention ||
    ProEntryPoint.uncertaintyTraining => const [
      'Use focused practice tools in the moment',
      'Record choices without writing sensitive details',
      'Build tolerance through repeatable reps',
    ],
    ProEntryPoint.behavioralExperiments ||
    ProEntryPoint.reflectionJournal => const [
      'Compare predictions with what happened',
      'Capture learning after practice',
      'Spot useful patterns over time',
    ],
    ProEntryPoint.settings || ProEntryPoint.todayNextStep => const [
      'Build exposure ladders and practice plans',
      'Use focused response-prevention tools',
      'Review recovery metrics and reflections',
    ],
  };
}
