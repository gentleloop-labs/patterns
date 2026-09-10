// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDataSection => 'Data';

  @override
  String get settingsExportDataTitle => 'Export data';

  @override
  String get settingsExportDataSubtitle =>
      'Save your records to a local JSON backup';

  @override
  String get settingsImportDataTitle => 'Import data';

  @override
  String get settingsImportDataSubtitle =>
      'Restore entries from a ZIP or JSON backup';

  @override
  String get settingsRemindersSection => 'Reminders';

  @override
  String get settingsDailyReminderTitle => 'Daily reminder';

  @override
  String settingsDailyReminderAt(String time) {
    return 'A gentle reminder at $time';
  }

  @override
  String get settingsDailyReminderOff =>
      'A gentle reminder to check in each day';

  @override
  String get settingsReminderTimeTitle => 'Reminder time';

  @override
  String get settingsPrivacySection => 'Privacy';

  @override
  String get settingsPrivacySafetySubtitle => 'How your local data is handled';

  @override
  String get settingsAnalyticsTitle => 'Share anonymous usage analytics';

  @override
  String get settingsAnalyticsSubtitle =>
      'Share feature-use events only. Personal OCD data is never included.';

  @override
  String get settingsAppLockTitle => 'App lock';

  @override
  String get settingsAppLockSubtitle =>
      'Require device unlock when Patterns reopens';

  @override
  String get settingsWipeTitle => 'Wipe all data';

  @override
  String get settingsWipeSubtitle =>
      'Delete local entries and reset app preferences';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Pro is active';

  @override
  String get settingsProActiveSubtitle =>
      'Every recovery tool is unlocked. Thank you.';

  @override
  String get settingsUnlockProTitle => 'Unlock Patterns Pro';

  @override
  String get settingsUnlockProSubtitle =>
      'One-time unlock for all recovery tools';

  @override
  String get settingsRestorePurchasesTitle => 'Restore purchases';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Restore a previous Patterns Pro unlock';

  @override
  String get settingsHelpSection => 'Help';

  @override
  String get settingsReplayTourTitle => 'Replay the app tour';

  @override
  String get settingsReplayTourSubtitle =>
      'Walk through what each tab does again';

  @override
  String get settingsShowWelcomeTitle => 'Show the welcome screens';

  @override
  String get settingsShowWelcomeSubtitle =>
      'See the introduction next time Patterns opens';

  @override
  String get settingsFeedbackSection => 'Feedback';

  @override
  String get settingsRateTitle => 'Rate Patterns';

  @override
  String get settingsRateSubtitle => 'Tell the store what you think';

  @override
  String get settingsSendFeedbackTitle => 'Send feedback';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Share an idea or tell us what went wrong';

  @override
  String get settingsSupportTitle => 'Support Patterns';

  @override
  String get settingsSupportSubtitle =>
      'Leave an optional tip to support development';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageSubtitle => 'Choose the language Patterns uses';

  @override
  String get calmInsightsTitle => 'Calm Insights';

  @override
  String get calmInsightsSubtitle =>
      'Hide streaks and calculated scores. Your recorded data stays available.';

  @override
  String get calmRecentActivityTitle => 'Your recent activity';

  @override
  String get calmNoRecentActivity =>
      'Nothing recorded in the last 7 days. Your space is ready whenever you need it.';

  @override
  String calmJournalActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count journal entries',
      one: '1 journal entry',
    );
    return '$_temp0';
  }

  @override
  String calmTrackedActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracked moments',
      one: '1 tracked moment',
    );
    return '$_temp0';
  }

  @override
  String calmDelayActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compulsion delays',
      one: '1 compulsion delay',
    );
    return '$_temp0';
  }

  @override
  String calmErpActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ERP practices',
      one: '1 ERP practice',
    );
    return '$_temp0';
  }

  @override
  String calmExposureActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count exposures completed',
      one: '1 exposure completed',
    );
    return '$_temp0';
  }

  @override
  String get recoveryMetricsTitle => 'Recovery metrics';

  @override
  String get recoveryMetricsTeaserTitle =>
      'See your recovery activity together';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'Review exposures, practice sessions, and recorded urge changes across your ERP tools. Unlock with Patterns Pro.';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'Review practice streaks, completed exposures, and recorded urge changes across your ERP tools. Unlock with Patterns Pro.';

  @override
  String get recoveryMetricsUnlockPro => 'Unlock Patterns Pro';

  @override
  String get recoveryMetricsEmptyTitle =>
      'Your recovery activity will appear here';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      'Practise a delay, an ERP session, or an exposure step to see factual activity counts here.';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      'Practise a delay, an ERP session, or an exposure step to begin building your activity history and practice streak.';

  @override
  String get recoveryMetricsExposuresDone => 'Exposures done';

  @override
  String get recoveryMetricsSessionsPracticed => 'Sessions practised';

  @override
  String get recoveryMetricsAverageUrgeDrop => 'Average recorded urge change';

  @override
  String get recoveryMetricsThisWeek => 'This week';

  @override
  String recoveryMetricsDayStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days day streak',
      one: '1 day streak',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'System Default';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get doneAction => 'Done';

  @override
  String get doneForNowAction => 'Done for now';

  @override
  String get completionSavedTitle => 'Saved';

  @override
  String get completionPracticeTitle => 'Practice recorded';

  @override
  String get completionJournalBody =>
      'Your journal entry is saved on this device.';

  @override
  String get completionTrackedBody =>
      'Your tracked moment is saved on this device.';

  @override
  String get completionTrackedUpdatedBody =>
      'Your tracked moment has been updated.';

  @override
  String get completionDelayBody =>
      'Your compulsion-delay practice has been recorded.';

  @override
  String get completionErpBody => 'Your ERP practice has been recorded.';

  @override
  String get notificationOpenAction => 'Open notification';

  @override
  String get dailyReminderChannelName => 'Daily reminder';

  @override
  String get dailyReminderChannelDescription =>
      'A gentle daily nudge to check in with Patterns.';

  @override
  String get dailyReminderTitle => 'A quiet check-in';

  @override
  String get dailyReminderBody =>
      'Take a gentle moment with Patterns whenever you’re ready.';

  @override
  String get practiceTimerChannelName => 'Practice timer';

  @override
  String get practiceTimerChannelDescription =>
      'A gentle alert when a timed practice window is complete.';

  @override
  String get appUpdatesChannelName => 'App updates';

  @override
  String get appUpdatesChannelDescription =>
      'Occasional notes when Patterns gets meaningful new recovery tools.';

  @override
  String get updateAnnouncementTitle => 'Patterns got better';

  @override
  String get updateAnnouncementBody =>
      'New recovery tools, progress insights, and a calmer Home are ready.';

  @override
  String get practiceWindowCompleteTitle => 'Practice window complete';

  @override
  String get practiceWindowCompleteBody =>
      'Take a moment to notice what happened.';

  @override
  String get erpWindowCompleteTitle => 'ERP practice window complete';

  @override
  String get erpWindowCompleteBody =>
      'Take a moment to reflect on what happened.';

  @override
  String get navToday => 'Today';

  @override
  String get navHome => 'Home';

  @override
  String get navJournal => 'Journal';

  @override
  String get navTrack => 'Track';

  @override
  String get navTracker => 'Tracker';

  @override
  String get navRecovery => 'Recovery';

  @override
  String get navInsights => 'Insights';

  @override
  String get navSettings => 'Settings';

  @override
  String get exportReportTitle => 'Export report';

  @override
  String get exportReportDescription =>
      'Save a combined PDF of your journal, OCD log, and insights. You choose where to save it and whether to share it.';

  @override
  String get exportTimeWindow => 'Time window';

  @override
  String get exportStart => 'Start';

  @override
  String get exportEnd => 'End';

  @override
  String get exportIncludeSections => 'Include sections';

  @override
  String get exportAnalyticsSummary => 'Analytics summary';

  @override
  String get exportJournalEntries => 'Journal entries';

  @override
  String get exportOcdEvents => 'OCD events';

  @override
  String get exportYbocsSelfChecks => 'Y-BOCS self-checks';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total entries',
      one: '1 entry',
      zero: 'No entries',
    );
    return '$_temp0 in this range ($journal journal, $ocd OCD, $selfChecks self-checks)';
  }

  @override
  String get exportLargeReport =>
      'This report is large and may take a moment to generate.';

  @override
  String get exportPrivacyWarning =>
      'This creates an unencrypted PDF. Save it somewhere private.';

  @override
  String get exportSavePdf => 'Save PDF';

  @override
  String get exportSelectSectionError =>
      'Select at least one section to export.';

  @override
  String get exportNoEntriesError =>
      'No entries match this range and section selection.';

  @override
  String get exportReportSaved => 'Report saved';

  @override
  String get exportReportFailed => 'Could not create report';

  @override
  String get rangeSevenDays => '7D';

  @override
  String get rangeThirtyDays => '30D';

  @override
  String get rangeNinetyDays => '90D';

  @override
  String get rangeYear => 'Year';

  @override
  String get rangeAll => 'All';

  @override
  String get rangeCustom => 'Custom';

  @override
  String get rangeLastSevenDays => 'Last 7 days';

  @override
  String get rangeLastThirtyDays => 'Last 30 days';

  @override
  String get rangeLastNinetyDays => 'Last 90 days';

  @override
  String get rangeLastYear => 'Last year';

  @override
  String get rangeAllTime => 'All time';

  @override
  String get pdfPersonalReport => 'Personal Report';

  @override
  String pdfGenerated(String date) {
    return 'Generated $date';
  }

  @override
  String get pdfDisclaimer =>
      'This report contains personal notes created in Patterns for self-reflection. It is not medical advice and does not replace care from a qualified clinician.';

  @override
  String get pdfJournalCount => 'Journal entries';

  @override
  String get pdfOcdCount => 'OCD events';

  @override
  String get pdfAverageDistress => 'Average distress';

  @override
  String get pdfObsessions => 'Obsessions';

  @override
  String get pdfCompulsions => 'Compulsions';

  @override
  String get pdfNoJournalEntries => 'No journal entries in this range.';

  @override
  String get pdfNoOcdEvents => 'No OCD events in this range.';

  @override
  String get pdfObsession => 'Obsession';

  @override
  String get pdfCompulsion => 'Compulsion';

  @override
  String pdfDistressScore(int score) {
    return 'Distress $score/10';
  }

  @override
  String get pdfThought => 'Thought';

  @override
  String get pdfUrge => 'Urge';

  @override
  String pdfResponse(String text) {
    return 'Response: $text';
  }

  @override
  String pdfActionTaken(String text) {
    return 'Action taken: $text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scale, self-rated in the app. Total is out of 40, with obsessions and compulsions each out of 20.';

  @override
  String get pdfMostRecentTotal => 'Most recent total';

  @override
  String get pdfTakenOn => 'Taken on';

  @override
  String get pdfObsessionsSubtotal => 'Obsessions subtotal';

  @override
  String get pdfCompulsionsSubtotal => 'Compulsions subtotal';

  @override
  String get pdfChangeAcrossRange => 'Change across range';

  @override
  String get pdfSelfChecksInRange => 'Self-checks in range';

  @override
  String get pdfThemesFlagged => 'Themes flagged';

  @override
  String get pdfSingleSelfCheck => 'Single self-check in this range';

  @override
  String pdfChangeSince(String change, String date) {
    return '$change since $date';
  }

  @override
  String get pdfDate => 'Date';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfBand => 'Band';

  @override
  String get severitySubclinical => 'Subclinical';

  @override
  String get severityMild => 'Mild';

  @override
  String get severityModerate => 'Moderate';

  @override
  String get severitySevere => 'Severe';

  @override
  String get severityExtreme => 'Extreme';

  @override
  String get backAction => 'Back';

  @override
  String get onboardingSafetyFootnote =>
      'Private by design. Not a diagnosis or a replacement for professional care.';

  @override
  String get onboardingHeadline => 'A quiet place to practise with OCD.';

  @override
  String get onboardingIntroduction =>
      'Log the intrusive thought, delay the compulsion, and practise responding differently, one small step at a time.';

  @override
  String get onboardingPrivacy =>
      'Your OCD data stays on this device. No account. No cloud sync.';

  @override
  String get getStartedAction => 'Get started';

  @override
  String get importExistingDataAction => 'Import existing data';

  @override
  String get onboardingQuestion => 'What would help right now?';

  @override
  String get onboardingPickOne =>
      'Pick one. You can do the rest whenever you like.';

  @override
  String get onboardingUrgeTitle => 'I\'m fighting an urge right now';

  @override
  String get onboardingUrgeSubtitle =>
      'Put some time between the urge and the ritual.';

  @override
  String get onboardingJournalTitle => 'I want to write something down';

  @override
  String get onboardingJournalSubtitle =>
      'Get the thought out of your head and onto a page.';

  @override
  String get onboardingErpTitle =>
      'I want to practise leaving a compulsion undone';

  @override
  String get onboardingErpSubtitle => 'One short, guided exposure.';

  @override
  String get onboardingSelfCheckTitle =>
      'I want to see where my OCD is right now';

  @override
  String get onboardingSelfCheckSubtitle =>
      'The Y-BOCS self-check. About 10 minutes.';

  @override
  String get onboardingExploreTitle => 'I\'m just exploring';

  @override
  String get onboardingExploreSubtitle => 'Have a look around first.';

  @override
  String get whatsNewTitle => 'Practice without pressure';

  @override
  String get whatsNewBody =>
      'Patterns 1.10 brings calmer insights, quieter session endings, accessibility improvements, and optional language selection.';

  @override
  String get whatsNewLanguagesTitle => 'Calm Insights';

  @override
  String get whatsNewLanguagesBody =>
      'Choose factual activity summaries instead of calculated scores, streaks, and consistency percentages.';

  @override
  String get whatsNewPrivateTitle => 'A clear stopping point';

  @override
  String get whatsNewPrivateBody =>
      'Journal, tracking, compulsion-delay, and ERP sessions now end with a simple factual confirmation and Done for now.';

  @override
  String get whatsNewReportsTitle => 'More accessible, in your language';

  @override
  String get whatsNewReportsBody =>
      'Improved labels and reduced-motion behavior join English, Brazilian Portuguese, German, Japanese, Spanish, and French.';

  @override
  String get whatsNewExploreAction => 'Explore Patterns 1.10';

  @override
  String get continueToPatternsAction => 'Continue to Patterns';

  @override
  String get whatsNewNotificationNote =>
      'Your entries stay as written. Language and Calm Insights choices stay on this device and are not included in analytics or backups.';

  @override
  String get formatBold => 'Bold';

  @override
  String get formatItalic => 'Italic';

  @override
  String get formatBulletedList => 'Bulleted list';

  @override
  String get formatToggleHint =>
      'Double tap to turn this formatting on or off.';

  @override
  String get journalEditorLabel => 'Journal editor';

  @override
  String get journalEditorHint =>
      'Enter your journal text. Formatting controls follow the editor.';

  @override
  String timerRemaining(String time) {
    return 'Time remaining: $time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return 'Recovery score: $score out of 100.';
  }

  @override
  String get privacySafetyTitle => 'Privacy & safety';

  @override
  String get privacyLocalContent =>
      'Journal entries, OCD events, distress ratings, reflections, and app preferences are stored locally on this device.';

  @override
  String get privacyPurchases =>
      'Patterns Pro and tips are processed by the app store. Patterns does not receive your payment-card details.';

  @override
  String get privacyExports =>
      'A manual export creates an unencrypted JSON backup or PDF report only where you choose to save or share it.';

  @override
  String get privacyAnalytics =>
      'Anonymous usage analytics are off unless you enable them. If enabled, Patterns sends named feature-use events, a random installation ID, platform, app version, and event time to its first-party service. Journal entries, OCD data, generated summaries, locale, and language choices are never included. Turning analytics off clears pending events and the local analytics ID.';

  @override
  String get privacyClinicalBoundary =>
      'Patterns is a self-help tool for personal reflection and ERP practice. It does not diagnose or treat OCD, replace care from a qualified clinician, or provide emergency support.';

  @override
  String get viewPrivacyPolicyAction => 'View full Privacy Policy';

  @override
  String get closeAction => 'Close';

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools =>
      'Also includes every Pro planning, practice, metrics, and reflection tool.';

  @override
  String get proPaywallAlreadyPurchased =>
      'Already bought Pro? You will not be charged again.';

  @override
  String get proPaywallTryAgainAction => 'Try again';

  @override
  String get proPaywallRestorePurchasesAction => 'Restore purchases';

  @override
  String get proPaywallRestoreShortAction => 'Restore';

  @override
  String get proPaywallUnlockAction => 'Unlock Pro';

  @override
  String proPaywallUnlockWithPrice(String price) {
    return 'Unlock Pro · $price';
  }

  @override
  String get proPaywallPurchasesUnavailable =>
      'In-app purchases are unavailable on this device.';

  @override
  String get proPaywallProductUnavailable =>
      'Patterns Pro is not available right now. Please try again later.';

  @override
  String get proPaywallProductLoadFailed =>
      'Could not load Patterns Pro. Please try again later.';

  @override
  String get proPaywallPurchaseStartFailed => 'Could not start the purchase.';

  @override
  String get proPaywallPurchaseFailed =>
      'The purchase could not be completed. Please try again.';

  @override
  String get proPaywallRestoreNotFound =>
      'No previous purchase was found on this account. If you bought Pro with a different account, sign in with that account and try again.';

  @override
  String get proPaywallRestoreFailed =>
      'Purchases could not be restored. Please try again.';

  @override
  String get proPaywallWelcomeBack => 'Welcome back';

  @override
  String get proPaywallAllSet => 'You\'re all set';

  @override
  String get proPaywallRestoredBody =>
      'Patterns Pro has been restored on this device.';

  @override
  String get proPaywallUnlockedBody =>
      'Patterns Pro is unlocked. Every recovery tool is now available.';

  @override
  String get proPaywallContinueAction => 'Continue';

  @override
  String get proPaywallLoadingLabel => 'Loading Patterns Pro';

  @override
  String get proHeadlineSettings =>
      'Move beyond tracking and practise recovery';

  @override
  String get proHeadlineTodayNextStep => 'Build on today’s practice';

  @override
  String get proHeadlineRecoveryMetrics => 'Review your recovery activity';

  @override
  String get proHeadlineExposureHierarchy => 'Build a clear exposure ladder';

  @override
  String get proHeadlineExposureMaterials => 'Keep practice materials together';

  @override
  String get proHeadlineStructuredPrograms => 'Turn recovery into a routine';

  @override
  String get proHeadlineActionPlanner =>
      'Plan your response before OCD arrives';

  @override
  String get proHeadlineImplementationIntentions =>
      'Make your next choice easier';

  @override
  String get proHeadlineUrgeSurfing => 'Practise riding out the urge';

  @override
  String get proHeadlineResponsePrevention => 'Record the response you chose';

  @override
  String get proHeadlineUncertaintyTraining => 'Practise making room for maybe';

  @override
  String get proHeadlineBehavioralExperiments => 'Test OCD’s predictions';

  @override
  String get proHeadlineReflectionJournal =>
      'Capture what each practice taught you';

  @override
  String get proBenefitGeneralPlans =>
      'Build exposure ladders and practice plans';

  @override
  String get proBenefitGeneralResponsePrevention =>
      'Use focused response-prevention tools';

  @override
  String get proBenefitGeneralReview =>
      'Review recovery activity and reflections';

  @override
  String get proBenefitMetricsActivity => 'Review practice activity over time';

  @override
  String get proBenefitMetricsNonjudgmental =>
      'See recorded activity without judging individual days';

  @override
  String get proBenefitMetricsPatterns => 'Explore factual recovery patterns';

  @override
  String get proBenefitExposureLadder =>
      'Organize steps from gentler to harder';

  @override
  String get proBenefitExposureMaterials =>
      'Keep scripts, loop tapes, images, and links nearby';

  @override
  String get proBenefitExposureRepeatable =>
      'Turn a plan into repeatable practice';

  @override
  String get proBenefitProgramsStructure =>
      'Follow a calm week-by-week structure';

  @override
  String get proBenefitProgramsTasks => 'Keep practice tasks in one place';

  @override
  String get proBenefitProgramsReview => 'Review what helped as you continue';

  @override
  String get proBenefitPlanningAhead =>
      'Choose a response before the hard moment';

  @override
  String get proBenefitPlanningIfThen => 'Create practical if-then plans';

  @override
  String get proBenefitPlanningReturn =>
      'Return to the plan when uncertainty rises';

  @override
  String get proBenefitInMomentTools =>
      'Use focused practice tools in the moment';

  @override
  String get proBenefitInMomentPrivacy =>
      'Record choices without writing sensitive details';

  @override
  String get proBenefitInMomentRepetition =>
      'Build tolerance through repeatable practice';

  @override
  String get proBenefitReflectionCompare =>
      'Compare predictions with what happened';

  @override
  String get proBenefitReflectionCapture => 'Capture learning after practice';

  @override
  String get proBenefitReflectionPatterns => 'Notice useful patterns over time';

  @override
  String get proRestoreChecking => 'Checking your purchases…';

  @override
  String get proRestoreSucceeded =>
      'Patterns Pro restored. Every recovery tool is unlocked again.';

  @override
  String get tipJarTitle => 'Support Patterns';

  @override
  String get tipJarBody =>
      'Patterns is independent and ad-free. If it has helped you, a small tip means a lot. Tips are optional and do not unlock anything.';

  @override
  String get tipJarLoadingLabel => 'Loading tip options';

  @override
  String get tipJarPurchasesUnavailable =>
      'In-app purchases are unavailable on this device.';

  @override
  String get tipJarOptionsUnavailable =>
      'No tip options were found. Please try again later.';

  @override
  String get tipJarLoadFailed =>
      'Tip options could not be loaded. Please try again later.';

  @override
  String get tipJarPurchaseFailed =>
      'The tip could not be completed. Please try again.';

  @override
  String get tipJarTryAgainAction => 'Try again';

  @override
  String get tipSmallTitle => 'Small tip';

  @override
  String get tipSmallDescription =>
      'An optional small tip to support Patterns development. Unlocks no features.';

  @override
  String get tipMediumTitle => 'Medium tip';

  @override
  String get tipMediumDescription =>
      'An optional medium tip to support Patterns development. Unlocks no features.';

  @override
  String get tipLargeTitle => 'Large tip';

  @override
  String get tipLargeDescription =>
      'An optional large tip to support Patterns development. Unlocks no features.';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title, $price. $description';
  }

  @override
  String get tipChoiceHint => 'Sends this optional tip';

  @override
  String get tipThanksTitle => 'Thank you';

  @override
  String get tipThanksBody =>
      'Your support means a lot. Patterns stays ad-free and independent because of people like you.';

  @override
  String get tipThanksAction => 'Glad to help';

  @override
  String get desktopProTitle => 'Unlock Patterns Desktop Pro';

  @override
  String get desktopProSubtitle =>
      'A one-time license for offline, desktop-optimized recovery tools.';

  @override
  String get desktopFeatureHierarchyTitle => 'Hierarchy Builder';

  @override
  String get desktopFeatureHierarchyDescription =>
      'Construct and track exposure steps and ladders.';

  @override
  String get desktopFeatureErpTitle => 'ERP Exercise Logs';

  @override
  String get desktopFeatureErpDescription =>
      'Record response prevention and timed exercises.';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription =>
      'Follow urge changes with live timed logging.';

  @override
  String get desktopFeatureActivityTitle => 'Recovery Activity';

  @override
  String get desktopFeatureActivityDescription =>
      'Review factual activity and weekly patterns.';

  @override
  String get desktopOneTimeLicense => 'One-time license';

  @override
  String desktopOneTimePrice(String price) {
    return '$price one-time purchase';
  }

  @override
  String get desktopPurchaseLicenseAction => 'Buy license';

  @override
  String get desktopCheckoutUnavailable =>
      'The purchase page is unavailable in this build.';

  @override
  String get desktopAlreadyPurchased =>
      'Already purchased? Enter your license key';

  @override
  String get desktopLicensePrompt => 'Enter your Lemon Squeezy license key:';

  @override
  String get desktopLicenseLabel => 'License key';

  @override
  String get desktopLicenseHint => 'Paste the license key from your receipt';

  @override
  String get desktopLicenseActivating => 'Activating license…';

  @override
  String get desktopActivateLicenseAction => 'Activate license';

  @override
  String get desktopLicenseBackAction => 'Back';

  @override
  String get desktopLicenseInvalid =>
      'Enter the complete license key from your receipt.';

  @override
  String get desktopLicenseRejected =>
      'This license could not be verified for Patterns Desktop Pro. Check the key and try again.';

  @override
  String get desktopLicenseUnavailable =>
      'The license service could not be reached. Check your connection and try again.';

  @override
  String get desktopLicenseNotConfigured =>
      'License activation is unavailable in this build.';

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalSearchAction => 'Search journal';

  @override
  String get journalChooseDateAction => 'Choose date';

  @override
  String get journalSearchHint => 'Search entries';

  @override
  String get journalClearSearchAction => 'Clear search';

  @override
  String get journalNoMatchesTitle => 'No matches';

  @override
  String journalNoMatchesBody(String query) {
    return 'Nothing matches “$query”.';
  }

  @override
  String get journalEmptyTitle => 'No journal entries yet';

  @override
  String get journalEmptyBody => 'A few quiet lines are enough to begin.';

  @override
  String get journalLoadError =>
      'Journal entries could not be loaded. Try again.';

  @override
  String get journalLoadingLabel => 'Loading journal entries';

  @override
  String get journalSavingStatus => 'Saving…';

  @override
  String get journalSavedStatus => 'Saved';

  @override
  String get journalUnsavedStatus => 'Not saved';

  @override
  String get journalClearDayAction => 'Clear this day';

  @override
  String get journalSaveAction => 'Save';

  @override
  String get journalStartWritingPlaceholder => 'Start writing…';

  @override
  String get journalFormatSelectionHint => 'Select text to format';

  @override
  String get journalClearedMessage => 'The entry for that day was cleared.';

  @override
  String get journalNothingToSaveMessage =>
      'There is nothing to save yet. Add a line whenever you feel ready.';

  @override
  String get journalClearDayTitle => 'Clear this day?';

  @override
  String journalClearDayBody(String date) {
    return 'This clears everything saved for $date. You can write here again anytime.';
  }

  @override
  String get journalKeepEntryAction => 'Keep it';

  @override
  String get journalTodayEntry => 'Today’s entry';

  @override
  String get journalOpenEntryAction => 'Open entry';

  @override
  String journalOpenEntryHint(String date) {
    return 'Opens the journal entry for $date.';
  }

  @override
  String get journalWorkspaceTitle => 'Journal workspace';

  @override
  String get journalSubtitle => 'Your space to reflect and let things out.';

  @override
  String get journalNewEntryAction => 'New entry';

  @override
  String get journalEarlierSection => 'Earlier';

  @override
  String get journalNoEntryForDate => 'No entry for this date.';

  @override
  String get journalCreateEntryAction => 'Create entry';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date at $time';
  }

  @override
  String get journalDeleteEntryAction => 'Delete entry';

  @override
  String get journalDeleteEntryTitle => 'Delete entry?';

  @override
  String get journalDeleteEntryBody =>
      'This journal entry will be permanently deleted.';

  @override
  String get journalDeletedMessage => 'The journal entry was deleted.';

  @override
  String get journalEditAction => 'Edit';

  @override
  String journalEditingDate(String date) {
    return 'Editing: $date';
  }

  @override
  String get journalUnsavedChangesStatus => 'Unsaved changes';

  @override
  String get journalEntrySavedMessage => 'Journal entry saved';

  @override
  String journalReadOnlyLabel(String date) {
    return 'Read-only journal entry for $date';
  }

  @override
  String get journalThemeContamination => 'Contamination';

  @override
  String get journalThemeUncertainty => 'Uncertainty';

  @override
  String get journalThemeChecking => 'Checking';

  @override
  String get journalThemeRelationship => 'Relationship';

  @override
  String get journalThemeHealth => 'Health';

  @override
  String get todayGreetingMorning => 'Good morning';

  @override
  String get todayGreetingAfternoon => 'Good afternoon';

  @override
  String get todayGreetingEvening => 'Good evening';

  @override
  String get todayEncouragement => 'You’ve got this. One choice at a time.';

  @override
  String get todayContinuePractice => 'Continue your practice';

  @override
  String get todaySeeAllAction => 'See all';

  @override
  String get todayQuickActions => 'Quick actions';

  @override
  String get todayChooseActivity => 'What would you like to do?';

  @override
  String get todayWriteSomethingTitle => 'Write something down';

  @override
  String get todayWriteSomethingBody => 'Get a thought out of your head.';

  @override
  String get todayDelayUrgeTitle => 'Delay an urge';

  @override
  String get todayDelayUrgeBody => 'Create space before you respond.';

  @override
  String get todayPracticeErpTitle => 'Practise (ERP)';

  @override
  String get todayPracticeErpBody => 'A short, guided exercise.';

  @override
  String get todayFirstJournalTitle => 'Write down another moment';

  @override
  String get todayFirstJournalBody =>
      'Naming a thought can make it easier to observe.';

  @override
  String get todayFirstErpTitle => 'Practise again';

  @override
  String get todayFirstErpBody => 'Try another short, guided ERP practice.';

  @override
  String get todayFirstDelayTitle => 'Try a two-minute delay';

  @override
  String get todayFirstDelayBody =>
      'When an urge feels strong, put a little space before it.';

  @override
  String get todayStartPracticeAction => 'Start practice';

  @override
  String get todayStartDelayAction => 'Start a delay';

  @override
  String get todayProTitle => 'Continue with Patterns Pro';

  @override
  String get todayProBody =>
      'Build a plan, practise it, and review your activity over time.';

  @override
  String get todayHideSevenDays => 'Hide for 7 days';

  @override
  String get todayPracticeProgress => 'Practice progress';

  @override
  String get todaySteadyPractice => 'Steady practice';

  @override
  String get todayStartGently => 'Start gently';

  @override
  String get todayPracticeActiveBody =>
      'Your recorded activities are building a longer-term picture.';

  @override
  String get todayPracticeEmptyBody =>
      'This changes as you journal, track, and practise.';

  @override
  String get todayProgressDisclaimer =>
      'This reflects recorded practice frequency, not a diagnosis or clinical assessment. A lower number can occur during a difficult week.';

  @override
  String get todayProgressStartedTitle => 'Your activity is taking shape';

  @override
  String get todayProgressPendingBody =>
      'A progress number will appear after activities have been recorded across more than one day.';

  @override
  String get todayScoreNew => 'New';

  @override
  String get todayScoreStrong => 'Strong';

  @override
  String get todayScoreSteady => 'Steady';

  @override
  String get todayScoreBuilding => 'Building';

  @override
  String get todayScoreStarting => 'Starting';

  @override
  String get todayBeginCheckIn => 'Begin with one small check-in';

  @override
  String get todayNoChange => 'No change from the previous period';

  @override
  String todayPointsUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points points up',
      one: '1 point up',
    );
    return '$_temp0 from the previous period';
  }

  @override
  String todayPointsDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points points down',
      one: '1 point down',
    );
    return '$_temp0 from the previous period';
  }

  @override
  String get todayNextStep => 'Your next step';

  @override
  String get todayNextSelfCheckTitle => 'See where you are';

  @override
  String get todayNextSelfCheckBody =>
      'A self-check can record a baseline for later comparison.';

  @override
  String get todayNextSelfCheckAction => 'Take self-check';

  @override
  String get todayNextHierarchyTitle => 'Set up your practice';

  @override
  String get todayNextHierarchyBody =>
      'Build an exposure ladder from easier to harder steps.';

  @override
  String get todayNextHierarchyAction => 'Build ladder';

  @override
  String get todayNextPracticeTitle => 'Choose today’s practice';

  @override
  String get todayNextPracticeBody =>
      'Choose one manageable ERP exercise for today.';

  @override
  String get todayNextPracticeAction => 'Start practice';

  @override
  String get todayNextReflectTitle => 'Reflect on the practice';

  @override
  String get todayNextReflectBody =>
      'Record what you noticed during today’s practice.';

  @override
  String get todayNextReflectAction => 'Reflect';

  @override
  String get todayNextJournalTitle => 'Reflect on today';

  @override
  String get todayNextJournalBody =>
      'Write a line about what you noticed in your practice.';

  @override
  String get todayNextJournalAction => 'Open journal';

  @override
  String get todayCompulsionDelay => 'Compulsion delay';

  @override
  String get todayStartErp => 'Start ERP practice';

  @override
  String get todayResistUrgeBody =>
      'Sit with the urge before deciding what to do.';

  @override
  String get todayBuildToleranceBody =>
      'Practise a manageable step at your own pace.';

  @override
  String get todayResumeAction => 'Resume';

  @override
  String get todayStartAction => 'Start';

  @override
  String get todayJournalBody => 'Write and reflect in your private journal.';

  @override
  String get todayExposureTools => 'Exposure tools';

  @override
  String get todayExposureToolsBody =>
      'Hierarchy, materials, and uncertainty practice.';

  @override
  String get todayInsightsBody => 'Review your recorded activity.';

  @override
  String get todaySelfCheckTitle => 'Understand your patterns';

  @override
  String get todaySelfCheckDuration => 'Optional · about 10 min';

  @override
  String get todayInsightsPlaceholder =>
      'Your insights will appear here as you record activities.';

  @override
  String get todayDailyCheckInComplete => 'Daily check-in recorded';

  @override
  String get todayDailyCheckIn => 'Daily check-in';

  @override
  String get todayDailyCompleteBody => 'A journal entry is recorded for today.';

  @override
  String get todayDailyBody => 'Write a short journal entry when you’re ready.';

  @override
  String get todayOpenAction => 'Open';

  @override
  String get todayCheckInAction => 'Check in';

  @override
  String get todayRecoveryScore => 'Recovery score';

  @override
  String todayActivitiesLastSevenDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count activities in the last 7 days',
      one: '1 activity in the last 7 days',
    );
    return '$_temp0';
  }

  @override
  String get todayActivityRecorded => 'Calculated from recorded activity';

  @override
  String get todayPracticesRecorded => 'Practices recorded';

  @override
  String get todayPracticeStreak => 'Practice streak';

  @override
  String todaySessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
    );
    return '$_temp0';
  }

  @override
  String todayDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get todayPickUpBody => 'Continue from the previously recorded time.';

  @override
  String get todayPracticeUrgesBody =>
      'Practise waiting before responding to an urge.';

  @override
  String get todayReadCheckIn => 'Read today’s check-in';

  @override
  String get todayOpenJournalMore => 'Open Journal to read or add more';

  @override
  String get todayShortJournal => 'Write a short journal entry';

  @override
  String get todayExplore => 'Explore';

  @override
  String get todayReflectProcess => 'Reflect and process';

  @override
  String get todayRecoveryTools => 'Recovery tools';

  @override
  String get todaySupportPractice => 'Support your practice';

  @override
  String get todayTrackBody => 'Log thoughts and urges';

  @override
  String get todaySeePatterns => 'Review your recorded patterns';

  @override
  String todayScoreA11y(int score, String label) {
    return 'Practice progress: $score out of 100, $label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return 'Practice timer: $elapsed elapsed of $planned';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day: activity recorded';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day: no activity recorded';
  }

  @override
  String get trackerTitle => 'Track';

  @override
  String get trackerPauseUrgeAction => 'Pause an urge';

  @override
  String get trackerFilterGroupLabel => 'Filter tracked moments';

  @override
  String get trackerFilterAll => 'All';

  @override
  String get trackerFilterObsessions => 'Obsessions';

  @override
  String get trackerFilterCompulsions => 'Compulsions';

  @override
  String get trackerLoadingLabel => 'Loading tracked moments';

  @override
  String get trackerLoadError =>
      'Your tracked moments could not be loaded. Please try again.';

  @override
  String get trackerEditTitle => 'Edit event';

  @override
  String get trackerAddTitle => 'Track event';

  @override
  String get trackerTypeGroupLabel => 'Event type';

  @override
  String get trackerTypeObsession => 'Obsession';

  @override
  String get trackerTypeCompulsion => 'Compulsion';

  @override
  String get trackerThoughtLabel => 'What did the thought say?';

  @override
  String get trackerUrgeLabel => 'What was the urge?';

  @override
  String get trackerThoughtHint => 'Name the thought or image.';

  @override
  String get trackerUrgeHint => 'Name the urge or compulsion.';

  @override
  String get trackerActionLabel => 'What did OCD get you to do?';

  @override
  String get trackerActionHint => 'A short note is enough.';

  @override
  String get trackerResponseLabel => 'What you did instead';

  @override
  String get trackerResponseHint =>
      'Record any response you chose, including a partial delay.';

  @override
  String get trackerSavingAction => 'Saving…';

  @override
  String get trackerUpdateAction => 'Update event';

  @override
  String get trackerSaveAction => 'Save event';

  @override
  String get trackerContentRequired =>
      'Whenever you’re ready, add a few words about what happened.';

  @override
  String get trackerSaveError =>
      'Your event could not be saved. Please try again.';

  @override
  String get trackerUpdateError =>
      'Your event could not be updated. Please try again.';

  @override
  String get trackerEditTooltip => 'Edit event';

  @override
  String get trackerDeleteTooltip => 'Delete event';

  @override
  String trackerDistressValue(int value) {
    return 'Distress $value out of 10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => 'No response noted';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type. $date. Distress $distress out of 10. $content. Response: $response';
  }

  @override
  String get trackerDeleteTitle => 'Delete event?';

  @override
  String get trackerDeleteBody =>
      'This removes the event from your local history on this device.';

  @override
  String get trackerDeleteAction => 'Delete';

  @override
  String get trackerDeletedMessage => 'Event deleted';

  @override
  String get trackerDeleteError =>
      'Your event could not be deleted. Please try again.';

  @override
  String get trackerDistressLabel => 'Distress, 0 to 10';

  @override
  String get trackerEmptyTitle => 'No events yet';

  @override
  String get trackerEmptyBody =>
      'Log only what feels useful. A short note is enough.';

  @override
  String get trackerEmptyAction => 'Track OCD event';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsExportReport => 'Export report';

  @override
  String get insightsObsessionsLogged => 'Obsessions logged';

  @override
  String get insightsThemesFound => 'Themes found';

  @override
  String get insightsCompulsions => 'Compulsions';

  @override
  String get insightsAverageIntensityShort => 'Average intensity';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => 'Practice progress';

  @override
  String get insightsScoreNeedsMoreActivity =>
      'A score appears once you’ve practised a few times across a couple of days, so it shows a trend rather than a single moment. Your sessions below are already counted.';

  @override
  String get insightsScoreEmpty =>
      'A score will appear here once you’ve practised a few times. Nothing to measure just yet.';

  @override
  String insightsComparedPreviousDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: 'day',
    );
    return 'compared with the previous $_temp0';
  }

  @override
  String get insightsComparedPreviousRange =>
      'compared with the previous range';

  @override
  String get insightsPracticeProgressBoundary =>
      'Reflects how often you practise, not a diagnosis or how you’re doing clinically. A lower number during a hard week can happen.';

  @override
  String get insightsMoodOverTime => 'Mood over time';

  @override
  String get insightsMoodGood => 'Good';

  @override
  String get insightsMoodOkay => 'Okay';

  @override
  String get insightsMoodLow => 'Low';

  @override
  String get insightsYbocsOverTime => 'Y-BOCS over time';

  @override
  String get insightsYbocsEmpty =>
      'Take the self-check and your recorded total will start a line here.';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return '$severity range. Take the self-check again in a few weeks to add another recorded point.';
  }

  @override
  String insightsYbocsSeverityRange(String severity, String range) {
    return '$severity ($range)';
  }

  @override
  String insightsAcrossSelfChecks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count self-checks',
      one: '1 self-check',
    );
    return 'across $_temp0';
  }

  @override
  String get insightsYbocsBoundary =>
      'A snapshot, not a diagnosis. Recorded totals can move around, and one higher total does not define your progress.';

  @override
  String get insightsAverageUrgeIntensity => 'Average urge intensity';

  @override
  String get insightsErpPractice => 'ERP practice';

  @override
  String insightsSessions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sessions',
      one: 'session',
    );
    return '$_temp0';
  }

  @override
  String get insightsConsistency => 'Consistency';

  @override
  String insightsActiveDays(int active, int total) {
    return '$active of $total days';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return 'Activity recorded on $active of $total days';
  }

  @override
  String get insightsTopThemes => 'Top themes';

  @override
  String get insightsThemesEmpty =>
      'Themes will appear as you record what OCD focuses on.';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme, $percent percent of recorded themes';
  }

  @override
  String get insightsChangeRange => 'Change date range';

  @override
  String get insightsOverviewTab => 'Overview';

  @override
  String get insightsObsessionsTab => 'Obsessions';

  @override
  String get insightsCompulsionsTab => 'Compulsions';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ $value increase, $comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ $value decrease, $comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ No change, $comparison';
  }

  @override
  String get insightsNoData => 'No data yet';

  @override
  String get insightsLoading => 'Loading insights';

  @override
  String get insightsLoadError =>
      'Your insights could not be loaded. Please try again.';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date: $value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title. Recorded points: $values';
  }

  @override
  String get ybocsSeveritySubclinical => 'Subclinical';

  @override
  String get ybocsSeverityMild => 'Mild';

  @override
  String get ybocsSeverityModerate => 'Moderate';

  @override
  String get ybocsSeveritySevere => 'Severe';

  @override
  String get ybocsSeverityExtreme => 'Extreme';

  @override
  String get insightsThemeContamination => 'Contamination';

  @override
  String get insightsThemeHarm => 'Harm';

  @override
  String get insightsThemeChecking => 'Checking';

  @override
  String get insightsThemeReassurance => 'Reassurance';

  @override
  String get insightsThemeHealth => 'Health';

  @override
  String get insightsThemeRelationship => 'Relationship';

  @override
  String get insightsThemeSymmetry => 'Symmetry';

  @override
  String get insightsThemeMoral => 'Moral';

  @override
  String get insightsThemeRumination => 'Rumination';

  @override
  String get insightsThemeUncertainty => 'Uncertainty';

  @override
  String get insightsThemeOther => 'Other';

  @override
  String get recoveryTitle => 'Recovery';

  @override
  String get recoverySubtitle =>
      'Tools and practices, grouped by where you are in your work.';

  @override
  String get recoveryImmediateHelpTitle => 'Support for a hard moment';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Emergency Toolkit',
      'copingLibrary': 'Coping Library',
      'compulsionDelay': 'Compulsion Delay',
      'ybocsSelfCheck': 'OCD Self-Check',
      'recoveryMetrics': 'Recovery Metrics',
      'exposureHierarchy': 'Exposure Hierarchy',
      'exposureMaterials': 'Exposure Materials',
      'structuredPrograms': 'Structured Programs',
      'actionPlanner': 'Action Planner',
      'implementationIntentions': 'Implementation Intentions',
      'guidedErp': 'Guided ERP',
      'urgeSurfing': 'Urge Surfing',
      'responsePrevention': 'Response Prevention',
      'uncertaintyTraining': 'Uncertainty Training',
      'behavioralExperiments': 'Behavioral Experiments',
      'reflectionJournal': 'Reflection Journal',
      'other': 'Recovery tool',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Fast grounding support.',
      'copingLibrary': 'Ground and reset.',
      'compulsionDelay': 'Create space before responding.',
      'ybocsSelfCheck': 'A Y-BOCS check-in.',
      'recoveryMetrics': 'Review recorded activity.',
      'exposureHierarchy': 'Build your ladder.',
      'exposureMaterials': 'Keep scripts and links.',
      'structuredPrograms': 'Follow guided weeks.',
      'actionPlanner': 'Plan responses.',
      'implementationIntentions': 'Make if-then plans.',
      'guidedErp': 'Practise a plan.',
      'urgeSurfing': 'Ride the wave.',
      'responsePrevention': 'Record what you did instead.',
      'uncertaintyTraining': 'Practise making room for maybe.',
      'behavioralExperiments': 'Test OCD’s prediction.',
      'reflectionJournal': 'Capture what you noticed.',
      'other': 'Open a recovery tool.',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Assess',
      'plan': 'Plan',
      'practice': 'Practise',
      'review': 'Review',
      'other': 'Tools',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'See where you are.',
      'plan': 'Set up your practice.',
      'practice': 'Do one practice.',
      'review': 'Reflect and learn.',
      'other': 'Choose what is useful.',
    });
    return '$_temp0';
  }

  @override
  String get recoveryProBadge => 'Patterns Pro';

  @override
  String recoveryOpenToolHint(String title) {
    return 'Open $title';
  }

  @override
  String recoveryLockedToolHint(String title) {
    return '$title requires Patterns Pro';
  }

  @override
  String get delayNameUrgeValidation =>
      'Whenever you’re ready, name the urge you want to sit with.';

  @override
  String get delayOutcomeValidation =>
      'When you’re ready, choose what you ended up doing.';

  @override
  String get delaySaveError =>
      'Your practice could not be saved. Please try again.';

  @override
  String get delayStopEarlyTitle => 'Stop early?';

  @override
  String get delayStopEarlyBody =>
      'It’s okay to stop. The time you waited can still be recorded.';

  @override
  String get delayKeepGoingAction => 'Keep going';

  @override
  String get delayStopAction => 'I need to stop';

  @override
  String get delaySetupTitle => 'Pause the urge';

  @override
  String get delayUrgeQuestion => 'Which urge are you sitting with?';

  @override
  String get delayUrgeHint =>
      'For example: checking the lock, washing, or searching online';

  @override
  String get delayUrgeBeforeLabel => 'How strong is the urge right now?';

  @override
  String get delayDurationQuestion => 'How long will you wait?';

  @override
  String get delayDurationGroupLabel => 'Delay duration';

  @override
  String get delayBeginAction => 'Begin';

  @override
  String get delayCountdownTitle => 'You’re sitting with it';

  @override
  String get delayCountdownBody =>
      'Notice the urge without acting. You can choose what happens next.';

  @override
  String get delayReflectionTitle => 'What happened?';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'The planned time ended. The details below are optional.',
      'early': 'You ended the timer early. The details below are optional.',
      'other': 'The timer ended. The details below are optional.',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel => 'How strong is the urge now?';

  @override
  String get delayOutcomeQuestion => 'What did you do with the urge?';

  @override
  String get delayOutcomeGroupLabel => 'Recorded outcome';

  @override
  String get delayNoteLabel => 'Anything you noticed? (optional)';

  @override
  String get delayNoteHint => 'A short note is enough.';

  @override
  String get delaySavingAction => 'Saving…';

  @override
  String get delaySaveAction => 'Save practice';

  @override
  String delayMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count min',
      one: '1 min',
    );
    return '$_temp0';
  }

  @override
  String get delayCustomAction => 'Custom';

  @override
  String get delayCustomTitle => 'Custom delay';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Did not do it',
      'delayed': 'Delayed it',
      'performed': 'Did it',
      'other': 'Not selected',
    });
    return '$_temp0';
  }

  @override
  String delayUrgeValue(int value) {
    return 'Urge $value out of 10';
  }

  @override
  String delayCustomMinutesValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return 'Custom delay: $_temp0';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation':
          'When you’re ready, choose what happened during practice.',
      'saveError': 'Your ERP practice could not be saved. Please try again.',
      'stopTitle': 'Stop early?',
      'stopBody':
          'It’s okay to stop. The time you practised can still be recorded.',
      'keepGoing': 'Keep going',
      'stop': 'Stop',
      'anxietyBefore': 'How strong is the urge or anxiety right now?',
      'duration': 'Duration',
      'start': 'Start practice',
      'countdownCue': 'Practise without',
      'resisting': 'Response you are not doing',
      'countdownBody':
          'You do not need to prove the prediction wrong before the timer ends.',
      'stopEarly': 'Stop early',
      'reflectionTitle': 'Reflect',
      'reflectionBody':
          'The details below are optional. Record only what feels useful.',
      'anxietyAfter': 'How strong is it now?',
      'outcomeQuestion': 'What did you do?',
      'whatHappened': 'What actually happened?',
      'whatHappenedHint': 'What did you notice during or after the practice?',
      'learning': 'Learning for next time',
      'learningHint': 'What do you want to remember the next time OCD asks?',
      'exposure': 'Exposure',
      'prediction': 'Prediction',
      'commitment': 'Commitment',
      'saving': 'Saving…',
      'save': 'Save practice',
      'other': 'ERP practice',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'The planned time ended.',
      'early': 'You ended the timer early.',
      'other': 'The timer ended.',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Did not do the response',
      'delayed': 'Delayed the response',
      'performed': 'Did the response',
      'other': 'Not selected',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return 'Intensity $value out of 10';
  }
}
