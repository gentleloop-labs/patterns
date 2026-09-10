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
}
