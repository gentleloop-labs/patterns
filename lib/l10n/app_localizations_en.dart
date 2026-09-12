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

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Guided ERP',
      'subtitle': 'Reuse a plan, practise, and learn from the result.',
      'myPlans': 'My ERP plans',
      'newAction': 'New',
      'plansError': 'ERP plans are unavailable right now.',
      'recentPractice': 'Recent practice',
      'historyError': 'Practice history is unavailable right now.',
      'archiveTitle': 'Archive this plan?',
      'archiveBody':
          'It will leave your active plans, but past practice stays in your history.',
      'keepAction': 'Keep it',
      'archiveAction': 'Archive',
      'exposureValidation':
          'Name the situation you want to practise with, whenever you are ready.',
      'commitmentValidation':
          'Choose the response you want to practise resisting, and this will save.',
      'saveError': 'Your ERP plan could not be saved. Please try again.',
      'updated': 'ERP plan updated.',
      'created': 'ERP plan created.',
      'editTitle': 'Edit ERP plan',
      'createTitle': 'Create ERP plan',
      'exerciseType': 'Exercise type',
      'exposureTarget': 'Exposure target',
      'ocdPrediction': 'OCD prediction',
      'preventionCommitment': 'Response-prevention commitment',
      'defaultDuration': 'Default duration',
      'saving': 'Saving…',
      'saveAction': 'Save plan',
      'createAction': 'Create plan',
      'emptyTitle': 'Create your first ERP plan',
      'emptyBody':
          'Write the exposure, prediction, and response you want to practise once. Then reuse it whenever you need.',
      'moreActions': 'More plan actions',
      'editAction': 'Edit plan',
      'archivePlanAction': 'Archive plan',
      'practiceGuide': 'Practice guide',
      'historyEmpty': 'Completed practices will appear here.',
      'customDuration': 'Custom duration',
      'other': 'ERP plan',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return 'Resist: $response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction =>
      'OCD says the discomfort will not change unless you respond.';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Delay Checking',
      'delayReassurance': 'Delay Reassurance Seeking',
      'delayGoogling': 'Delay Googling',
      'delayRumination': 'Delay Rumination',
      'delayWashing': 'Delay Washing',
      'other': 'Guided ERP',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Practise leaving something unchecked for a short window.',
      'delayReassurance':
          'Wait before asking someone to make the fear feel certain.',
      'delayGoogling': 'Postpone searching for certainty or proof.',
      'delayRumination': 'Notice mental problem-solving without following it.',
      'delayWashing': 'Wait before washing, cleaning, or sanitising again.',
      'other': 'Practise delaying a response.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Create a repeatable plan for moments when OCD pushes you to check locks, switches, messages, symptoms, or mistakes again.',
      'delayReassurance':
          'Create a plan for urges to ask, confess, explain, or get someone to confirm that things are okay.',
      'delayGoogling':
          'Create a plan for moments when OCD wants you to search symptoms, meanings, risks, rules, or stories until you feel sure.',
      'delayRumination':
          'Create a plan for mental compulsions like replaying, proving, reviewing, or solving.',
      'delayWashing':
          'Create a plan for urges to wash, clean, sanitise, or reset because something feels contaminated.',
      'other': 'Create a repeatable ERP practice plan.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'ERP lets you practise having uncertainty present without doing a ritual right away.',
      'delayReassurance':
          'Reassurance can feel helpful in the moment, but delaying it lets you practise not knowing.',
      'delayGoogling':
          'Postponing research interrupts the certainty loop and lets you practise leaving a question unanswered.',
      'delayRumination':
          'Rumination can look like thinking, but ERP practice lets you step out of the loop without finishing the argument.',
      'delayWashing':
          'Waiting lets you practise having a contamination feeling present without an immediate ritual.',
      'other':
          'ERP practice makes room for uncertainty without an immediate ritual.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure':
          'What will you leave unchecked or check only once?',
      'delayCheckingPrediction': 'What does OCD predict if you do not recheck?',
      'delayCheckingCommitment':
          'What checking ritual will you practise resisting?',
      'delayReassuranceExposure': 'What reassurance do you want to ask for?',
      'delayReassurancePrediction':
          'What does OCD say will happen if you do not ask?',
      'delayReassuranceCommitment':
          'What message, confession, or question will you resist?',
      'delayGooglingExposure':
          'What search or question will you leave unanswered?',
      'delayGooglingPrediction':
          'What does OCD say you need to know right now?',
      'delayGooglingCommitment':
          'What search, article, or forum will you avoid?',
      'delayRuminationExposure': 'What thought loop will you leave unfinished?',
      'delayRuminationPrediction': 'What does OCD say you must solve or prove?',
      'delayRuminationCommitment':
          'What mental review or argument will you resist?',
      'delayWashingExposure': 'What normal hygiene boundary will you follow?',
      'delayWashingPrediction':
          'What does OCD predict if you do not wash again?',
      'delayWashingCommitment':
          'What extra washing, cleaning, or sanitising will you resist?',
      'other': 'What response will you practise resisting?',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Define one checking rule before you begin.',
      'delayChecking2':
          'Do the planned check once if it is part of normal safety.',
      'delayChecking3': 'Resist rechecking while the timer runs.',
      'delayChecking4': 'Notice the urge without negotiating with it.',
      'delayReassurance1': 'Define the reassurance request before you begin.',
      'delayReassurance2':
          'Do not send the message or ask the question during the timer.',
      'delayReassurance3':
          'Let the discomfort be present without seeking certainty.',
      'delayReassurance4':
          'Return to what you were doing as gently as you can.',
      'delayGoogling1': 'Define the search before opening anything else.',
      'delayGoogling2': 'Close the search box or browser tab.',
      'delayGoogling3': 'Start the timer before reading anything else.',
      'delayGoogling4': 'Leave the question unanswered for now.',
      'delayRumination1':
          'Name the loop: reviewing, solving, proving, or checking.',
      'delayRumination2': 'Let the thought be unfinished.',
      'delayRumination3':
          'Bring attention back to one ordinary task or sensation.',
      'delayRumination4': 'Restart gently each time the loop pulls you back.',
      'delayWashing1': 'Define the normal hygiene boundary before starting.',
      'delayWashing2':
          'Start with a delay that feels challenging but possible.',
      'delayWashing3':
          'Keep your hands away from the sink or sanitiser during the timer.',
      'delayWashing4':
          'Let the discomfort be present without trying to make it perfect.',
      'other': 'Follow the plan you chose.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Check once',
      'delayChecking2': 'No rechecking',
      'delayChecking3': 'Notice the urge',
      'delayReassurance1': 'Hold the ask',
      'delayReassurance2': 'Let uncertainty stay',
      'delayReassurance3': 'Return gently',
      'delayGoogling1': 'Close search',
      'delayGoogling2': 'Start timer',
      'delayGoogling3': 'Leave it unanswered',
      'delayRumination1': 'Name the loop',
      'delayRumination2': 'Leave unfinished',
      'delayRumination3': 'Return to task',
      'delayWashing1': 'Set a boundary',
      'delayWashing2': 'Delay washing',
      'delayWashing3': 'Allow discomfort',
      'other': 'Follow the plan',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Structured Programs',
      'subtitle': 'Follow a guided, week-by-week plan at your own pace.',
      'themeGroup': 'By OCD theme',
      'themeGroupEmpty': 'Choose a theme if it fits what you want to practise.',
      'themeGroupMatched':
          'Themes recorded in your last self-check are labelled below.',
      'generalGroup': 'General practice',
      'generalCaption': 'Skills that can be used across themes.',
      'enrollError': 'This program could not be opened. Please try again.',
      'started': 'Started',
      'notStarted': 'Not started',
      'openHint': 'Open program details',
      'selfCheckMatch': 'Matches your self-check',
      'tapToStart': 'Tap to start',
      'progressLoadError':
          'Program activity could not be loaded. Please try again.',
      'activityRecorded': 'Your task choices are recorded locally.',
      'taskSaveError': 'This task change could not be saved. Please try again.',
      'weekComplete': 'All tasks marked complete',
      'weekNotComplete': 'Tasks remain',
      'weekToggleHint': 'Expand or collapse this week',
      'taskToggleHint': 'Mark or unmark this task',
      'other': 'Program',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$done of $total tasks, $percent percent';
  }

  @override
  String structuredProgramSummary(int count, String subtitle) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks · $subtitle',
      one: '1 week · $subtitle',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramComplete(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks are',
      one: '1 task is',
    );
    return 'All $_temp0 marked complete.';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$done of $total tasks marked complete';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'OCD Self-Check',
      'introBody':
          'A guided self-check based on the Yale-Brown Obsessive Compulsive Scale (Y-BOCS), covering the patterns you notice and how much they affect you.',
      'spotTitle': 'Notice the patterns',
      'spotBody': 'Select obsessions and compulsions you have experienced.',
      'impactTitle': 'Record the impact',
      'impactBody': 'Answer 10 questions about how much they affect your day.',
      'resultIntroTitle': 'Review the result',
      'resultIntroBody':
          'See the recorded themes, subtotals, and severity range.',
      'begin': 'Begin',
      'retakeAction': 'Take it again',
      'privacyDuration':
          'Takes about 10 minutes. Your answers stay on this device unless you choose to export them.',
      'disclaimer':
          'This self-check can help you describe your experience. It does not diagnose OCD and is not emergency support. Only a qualified professional can diagnose OCD.',
      'historyTitle': 'Your history',
      'historyBody': 'Your previous recorded totals appear here.',
      'deleteTitle': 'Delete assessment?',
      'deleteBody':
          'This permanently removes this assessment from this device.',
      'cancel': 'Cancel',
      'deleteAction': 'Delete',
      'deleteTooltip': 'Delete assessment',
      'deleteSuccess': 'Assessment deleted.',
      'deleteError': 'This assessment could not be deleted. Please try again.',
      'checklistTitle': 'What feels familiar?',
      'checklistBody':
          'Select anything you have experienced, now or in the past. Skip what does not fit.',
      'obsessions': 'Obsessions',
      'obsessionsDescription': 'Unwanted thoughts, images, or urges',
      'compulsions': 'Compulsions',
      'compulsionsDescription':
          'Behaviours or mental acts performed in response to distress',
      'continueAction': 'Continue',
      'seeResults': 'See results',
      'next': 'Next',
      'resultsTitle': 'Your result',
      'retake': 'Retake',
      'saved': 'Saved',
      'saveHistory': 'Save to my history',
      'saving': 'Saving…',
      'saveSuccess': 'Saved to your history.',
      'saveError': 'This assessment could not be saved. Please try again.',
      'breakdownTitle': 'Recorded subtotals',
      'typesTitle': 'Types recorded',
      'typesNone':
          'No obsession or compulsion type was recorded in this self-check.',
      'typesBoth':
          'Both obsessions and compulsions were recorded in this self-check.',
      'typesObsessions': 'Obsessions were recorded in this self-check.',
      'typesCompulsions': 'Compulsions were recorded in this self-check.',
      'themesTitle': 'Themes recorded',
      'themesBody':
          'The checklist categories containing the items you selected.',
      'nextStepsTitle': 'About this result',
      'nextStepsBody':
          'This result is a self-reported snapshot, not a diagnosis or emergency support. If these patterns affect your life, you can discuss them with a qualified professional. If you may be in immediate danger, contact local emergency services.',
      'other': 'Y-BOCS self-check',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continue · $count selected',
      one: 'Continue · 1 selected',
      zero: 'Continue',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String ybocsScoreOutOf(int score, int maximum) {
    return '$score of $maximum';
  }

  @override
  String ybocsHistorySummary(String severity, int score, String date) {
    return '$severity · $score of 40 · $date';
  }

  @override
  String ybocsSeveritySummary(
    String severity,
    String score,
    String description,
  ) {
    return '$severity · $score · $description';
  }

  @override
  String ybocsSubtotalSummary(String label, String score) {
    return '$label · $score';
  }

  @override
  String ybocsCategorySelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items selected',
      one: '1 item selected',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Task marked complete.',
      'notCompleted': 'Task marked incomplete.',
      'other': 'Task updated.',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': '4-Week Compulsion Delay',
      'uncertainty3wk': 'Uncertainty Tolerance',
      'other': 'Structured Program',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Practise delaying compulsions, one week at a time',
      'uncertainty3wk': 'Practise living with not knowing',
      'other': 'A guided practice plan',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': 'Week 1 · Notice and name',
      'delayW2': 'Week 2 · Stretch the gap',
      'delayW3': 'Week 3 · Sit longer',
      'delayW4': 'Week 4 · Daily practice',
      'uncertaintyW1': 'Week 1 · Leave it open',
      'uncertaintyW2': 'Week 2 · Maybe, maybe not',
      'uncertaintyW3': 'Week 3 · Let it be',
      'other': 'Program week',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': 'Record 3 urges without acting immediately',
      'w1b': 'Delay one compulsion by 1 minute, 3 times',
      'w2a': 'Delay compulsions by 5 minutes',
      'w2b': 'Try urge surfing once',
      'w3a': 'Delay by 15 minutes',
      'w3b': 'Resist one reassurance-seeking urge',
      'w4a': 'Complete one exposure each day',
      'w4b': 'Reflect on what you noticed',
      'u1a': 'Leave one question unanswered',
      'u1b': 'Resist checking once',
      'u2a': 'Use a “maybe, maybe not” response 3 times',
      'u2b': 'Delay searching online about a worry',
      'u3a': 'Go a day without seeking certainty',
      'u3b': 'Reflect on what you noticed',
      'other': 'Program task',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contamination and washing',
      'checking': 'Checking and doubt',
      'harm': 'Harm and taboo thoughts',
      'relationship': 'Relationship doubt',
      'justRight': 'Just right and symmetry',
      'other': 'OCD theme',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination':
          'For fears that something is dirty, contagious, or unsafe to touch, and the washing or cleaning that follows.',
      'checking':
          'For locks, hobs, switches, messages, and other things you return to because doing them does not feel certain enough.',
      'harm':
          'For intrusive thoughts about harm or themes that feel violent, sexual, or blasphemous, and the compulsions or avoidance that follow.',
      'relationship':
          'For recurring doubts about whether a relationship is right, whether you feel enough, or what the doubt means.',
      'justRight':
          'For things that feel as though they must be even, ordered, or repeated until they feel right.',
      'other': 'A practice track organised around an OCD theme.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contamination',
      'checking': 'Checking',
      'harm': 'Harm and taboo thoughts',
      'relationship': 'Relationship doubt',
      'justRight': 'Just right',
      'other': 'OCD theme',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'The Y-BOCS checklist predates research on relationship OCD, so this theme is not one of its categories. You can still use this practice track.',
      'other': 'This theme is not represented as a Y-BOCS checklist category.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': 'Week 1 · Touch, then wait',
      'ct2': 'Week 2 · One wash, not three',
      'ct3': 'Week 3 · Carry it home',
      'ck1': 'Week 1 · Look once',
      'ck2': 'Week 2 · No mental replay',
      'ck3': 'Week 3 · Leave it unresolved',
      'hm1': 'Week 1 · Let it be there',
      'hm2': 'Week 2 · Stop asking',
      'hm3': 'Week 3 · No inner court case',
      'rl1': 'Week 1 · Stop testing',
      'rl2': 'Week 2 · No reassurance',
      'rl3': 'Week 3 · Live with maybe',
      'jr1': 'Week 1 · Leave it crooked',
      'jr2': 'Week 2 · No repeating',
      'jr3': 'Week 3 · Good enough',
      'other': 'Track week',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a':
          'Touch something that feels slightly unclean and leave your hands unwashed for five minutes',
      'ct1b': 'Record the urge before and after without washing',
      'ct2a': 'Wash once, normally, and do not return for a second round',
      'ct2b': 'Leave one surface at home uncleaned for the week',
      'ct3a':
          'Go somewhere that usually prompts washing afterwards and do not wash when you get in',
      'ct3b': 'Write down what OCD predicted next to what happened',
      'ck1a': 'Check one thing once, then walk away without a second look',
      'ck1b': 'Leave the house once without a final sweep of the rooms',
      'ck2a':
          'When the urge to replay the memory arrives, leave the doubt unresolved',
      'ck2b': 'Send one message without rereading it before or after',
      'ck3a': 'Go a day without returning to check anything twice',
      'ck3b': 'Note what happened and what OCD predicted',
      'hm1a':
          'Let one intrusive thought stay for a minute without arguing with it or pushing it away',
      'hm1b': 'Notice the mental review before it starts and leave it alone',
      'hm2a':
          'Resist asking whether you are a good person and do not search for an answer either',
      'hm2b':
          'Stay in a situation you have been avoiding because of the thought',
      'hm3a':
          'Go a day without checking your feelings for evidence about yourself',
      'hm3b': 'Write down what the week was like without grading yourself',
      'rl1a': 'Notice one compatibility test you use and skip it once',
      'rl1b': 'Leave a relationship doubt unanswered for ten minutes',
      'rl2a':
          'Go a day without asking your partner, a friend, or the internet whether the relationship is right',
      'rl2b': 'Do something together without monitoring how you feel during it',
      'rl3a': 'Use a “maybe, maybe not” response when the question arrives',
      'rl3b': 'Reflect on the week without making a decision about the future',
      'jr1a':
          'Leave one object slightly out of place and let the feeling be present',
      'jr1b': 'Do one thing once even though it did not feel finished',
      'jr2a': 'Resist repeating an action to make it feel right',
      'jr2b': 'Write something without returning to make the wording feel even',
      'jr3a': 'Go through a day leaving several things deliberately unfinished',
      'jr3b':
          'Record what happened to the not-right feeling without changing it',
      'other': 'Track task',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time': 'How much of my time is taken up by obsessive thoughts?',
      'o_interfere': 'How much do the obsessions get in the way of my life?',
      'o_distress': 'How much distress do the obsessive thoughts cause me?',
      'o_resist': 'How hard do I try to resist the obsessive thoughts?',
      'o_control': 'How much control do I have over the obsessive thoughts?',
      'c_time':
          'How much time do I spend on compulsions, such as rituals or checking?',
      'c_interfere': 'How much do the compulsions get in the way of my life?',
      'c_distress':
          'How anxious or upset would I feel if I could not do the compulsion?',
      'c_resist': 'How hard do I try to resist the compulsions?',
      'c_control': 'How much control do I have over the compulsions?',
      'other': 'Self-check question',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'None at all',
      'o_time_1': 'A little: less than an hour a day, or a few now and then',
      'o_time_2':
          'A moderate amount: 1 to 3 hours a day, or frequent intrusions',
      'o_time_3': 'A lot: 3 to 8 hours a day, or very frequent intrusions',
      'o_time_4': 'Almost constant: more than 8 hours a day',
      'o_interfere_0': 'Not at all',
      'o_interfere_1': 'A little: they do not really affect what I do',
      'o_interfere_2': 'Some: they interfere but I can still manage',
      'o_interfere_3': 'A lot: they clearly get in the way of my day',
      'o_interfere_4': 'So much that I can barely function',
      'o_distress_0': 'None',
      'o_distress_1': 'A little: not too disturbing',
      'o_distress_2': 'A moderate amount: disturbing but manageable',
      'o_distress_3': 'A lot: very disturbing',
      'o_distress_4': 'Nearly constant, disabling distress',
      'o_resist_0': 'I always try to resist, or they barely happen',
      'o_resist_1': 'I try to resist most of the time',
      'o_resist_2': 'I make some effort to resist',
      'o_resist_3': 'I give in to almost all of them without much of a fight',
      'o_resist_4': 'I completely give in to them, willingly',
      'o_control_0': 'Full control: I can dismiss them easily',
      'o_control_1': 'A lot of control: usually I can stop or divert them',
      'o_control_2': 'Some control: sometimes I can, sometimes I cannot',
      'o_control_3': 'Little control: I rarely manage to stop them',
      'o_control_4': 'No control: they feel completely involuntary',
      'c_time_0': 'None at all',
      'c_time_1': 'A little: less than an hour a day, or a few now and then',
      'c_time_2': 'A moderate amount: 1 to 3 hours a day, or frequent rituals',
      'c_time_3': 'A lot: 3 to 8 hours a day, or very frequent rituals',
      'c_time_4': 'Almost constant: more than 8 hours a day',
      'c_interfere_0': 'Not at all',
      'c_interfere_1': 'A little: they do not really affect what I do',
      'c_interfere_2': 'Some: they interfere but I can still manage',
      'c_interfere_3': 'A lot: they clearly get in the way of my day',
      'c_interfere_4': 'So much that I can barely function',
      'c_distress_0': 'Not at all',
      'c_distress_1': 'A little uneasy',
      'c_distress_2': 'Moderately anxious',
      'c_distress_3': 'Very anxious',
      'c_distress_4': 'Overwhelmed, disabling anxiety',
      'c_resist_0': 'I always try to resist, or they barely happen',
      'c_resist_1': 'I try to resist most of the time',
      'c_resist_2': 'I make some effort to resist',
      'c_resist_3': 'I give in to almost all of them without much of a fight',
      'c_resist_4': 'I completely give in to them, willingly',
      'c_control_0': 'Full control: I can stop myself easily',
      'c_control_1': 'A lot of control: usually I can stop or delay',
      'c_control_2': 'Some control: sometimes I can, sometimes I cannot',
      'c_control_3': 'Little control: I can rarely stop or delay',
      'c_control_4': 'No control: I have to complete them',
      'other': 'Response option',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': 'Aggressive or harm-related',
      'contamination': 'Contamination',
      'sexual': 'Sexual',
      'hoarding_obs': 'Hoarding or saving',
      'religious': 'Religious or moral scrupulosity',
      'symmetry_obs': 'Symmetry or exactness',
      'somatic': 'Body or illness',
      'misc_obs': 'Other obsessions',
      'washing': 'Washing or cleaning',
      'checking': 'Checking',
      'repeating': 'Repeating rituals',
      'counting': 'Counting',
      'ordering': 'Ordering or arranging',
      'misc_comp': 'Other compulsions',
      'other': 'Other theme',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': 'Fear I might harm myself',
      'agg_harm_others': 'Fear I might harm someone else',
      'agg_violent': 'Violent or horrific images in my mind',
      'agg_blurt': 'Fear I will blurt out insults or obscenities',
      'agg_impulse': 'Fear I will act on an unwanted impulse',
      'agg_responsible':
          'Fear I will be responsible for something terrible happening',
      'con_dirt': 'Concern with dirt or germs',
      'con_bodily': 'Disgust with bodily waste or secretions',
      'con_chemicals': 'Concern about household chemicals or cleaners',
      'con_ill': 'Fear I will get ill from contamination',
      'con_spread': 'Fear I will spread contamination to others',
      'con_sticky': 'Bothered by sticky substances or residues',
      'sex_forbidden': 'Forbidden or unwanted sexual thoughts or images',
      'sex_others': 'Sexual thoughts involving others that disturb me',
      'sex_orientation': 'Unwanted doubts about my sexual orientation',
      'sex_aggressive': 'Aggressive sexual thoughts toward others',
      'hoard_discard': 'Fear of throwing away something I might need',
      'hoard_value': 'Feeling objects have value I cannot let go of',
      'rel_sacrilege': 'Concern with sacrilege or blasphemy',
      'rel_rightwrong': 'Excessive concern with right and wrong, or morality',
      'rel_punish': 'Fear of punishment by God or fate',
      'sym_even': 'Need things even, balanced, or “just right”',
      'sym_exact': 'Need for exactness, order, or precision',
      'sym_incomplete': 'A feeling of incompleteness until things feel right',
      'som_illness': 'Excessive concern with illness or disease',
      'som_body': 'Excessive concern with a body part or appearance',
      'misc_know': 'Need to know or remember things',
      'misc_saywrong': 'Fear of saying the wrong thing',
      'misc_lucky': 'Lucky or unlucky numbers, words, or colours',
      'misc_sounds': 'Intrusive sounds, words, or music I cannot stop',
      'misc_lose': 'Fear of losing things',
      'wash_hands': 'Excessive or ritualised hand-washing',
      'wash_shower': 'Excessive showering, bathing, or grooming',
      'wash_clean': 'Excessive cleaning of household items',
      'wash_avoid': 'Avoiding things I see as contaminated',
      'chk_locks': 'Checking locks, appliances, taps, or the stove',
      'chk_harm': 'Checking I did not or will not harm someone',
      'chk_mistake': 'Checking I did not make a mistake',
      'chk_body': 'Checking my body for signs of illness',
      'rep_reread': 'Re-reading or re-writing',
      'rep_routine':
          'Repeating routine actions, such as going through doors or going up and down',
      'rep_untilright': 'Repeating until it feels “just right”',
      'cnt_count': 'Counting objects, steps, or actions',
      'cnt_numbers': 'Doing things a certain number of times',
      'ord_arrange': 'Arranging things until they are symmetrical or exact',
      'ord_align': 'Aligning or straightening objects repeatedly',
      'mc_mental':
          'Mental rituals, such as silent prayers, phrases, or reviewing',
      'mc_reassure': 'Repeatedly asking for reassurance or confessing',
      'mc_touch': 'Needing to touch, tap, or rub things',
      'mc_lists': 'Excessive list-making',
      'mc_avoid': 'Avoiding situations to prevent an urge',
      'other': 'Other symptom',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical':
          'This total falls in the subclinical Y-BOCS range. The result is a snapshot, not a diagnosis.',
      'mild':
          'This total falls in the mild Y-BOCS range. The result is a snapshot, not a diagnosis.',
      'moderate':
          'This total falls in the moderate Y-BOCS range. The result is a snapshot, not a diagnosis.',
      'severe':
          'This total falls in the severe Y-BOCS range. Consider discussing the impact with a qualified professional.',
      'extreme':
          'This total falls in the extreme Y-BOCS range. Consider contacting a qualified professional for support. If you may be in immediate danger, contact local emergency services.',
      'other': 'This recorded total is a snapshot, not a diagnosis.',
    });
    return '$_temp0';
  }
}
