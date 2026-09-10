import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// User-facing Patterns interface copy for app title.
  ///
  /// In en, this message translates to:
  /// **'Patterns'**
  String get appTitle;

  /// User-facing Patterns interface copy for settings title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// User-facing Patterns interface copy for settings data section.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsDataSection;

  /// User-facing Patterns interface copy for settings export data title.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get settingsExportDataTitle;

  /// User-facing Patterns interface copy for settings export data subtitle.
  ///
  /// In en, this message translates to:
  /// **'Save your records to a local JSON backup'**
  String get settingsExportDataSubtitle;

  /// User-facing Patterns interface copy for settings import data title.
  ///
  /// In en, this message translates to:
  /// **'Import data'**
  String get settingsImportDataTitle;

  /// User-facing Patterns interface copy for settings import data subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore entries from a ZIP or JSON backup'**
  String get settingsImportDataSubtitle;

  /// User-facing Patterns interface copy for settings reminders section.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsRemindersSection;

  /// User-facing Patterns interface copy for settings daily reminder title.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get settingsDailyReminderTitle;

  /// User-facing Patterns interface copy for settings daily reminder at.
  ///
  /// In en, this message translates to:
  /// **'A gentle reminder at {time}'**
  String settingsDailyReminderAt(String time);

  /// User-facing Patterns interface copy for settings daily reminder off.
  ///
  /// In en, this message translates to:
  /// **'A gentle reminder to check in each day'**
  String get settingsDailyReminderOff;

  /// User-facing Patterns interface copy for settings reminder time title.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTimeTitle;

  /// User-facing Patterns interface copy for settings privacy section.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacySection;

  /// User-facing Patterns interface copy for settings privacy safety subtitle.
  ///
  /// In en, this message translates to:
  /// **'How your local data is handled'**
  String get settingsPrivacySafetySubtitle;

  /// User-facing Patterns interface copy for settings analytics title.
  ///
  /// In en, this message translates to:
  /// **'Share anonymous usage analytics'**
  String get settingsAnalyticsTitle;

  /// User-facing Patterns interface copy for settings analytics subtitle.
  ///
  /// In en, this message translates to:
  /// **'Share feature-use events only. Personal OCD data is never included.'**
  String get settingsAnalyticsSubtitle;

  /// User-facing Patterns interface copy for settings app lock title.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get settingsAppLockTitle;

  /// User-facing Patterns interface copy for settings app lock subtitle.
  ///
  /// In en, this message translates to:
  /// **'Require device unlock when Patterns reopens'**
  String get settingsAppLockSubtitle;

  /// User-facing Patterns interface copy for settings wipe title.
  ///
  /// In en, this message translates to:
  /// **'Wipe all data'**
  String get settingsWipeTitle;

  /// User-facing Patterns interface copy for settings wipe subtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete local entries and reset app preferences'**
  String get settingsWipeSubtitle;

  /// User-facing Patterns interface copy for settings pro section.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro'**
  String get settingsProSection;

  /// User-facing Patterns interface copy for settings pro active title.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro is active'**
  String get settingsProActiveTitle;

  /// User-facing Patterns interface copy for settings pro active subtitle.
  ///
  /// In en, this message translates to:
  /// **'Every recovery tool is unlocked. Thank you.'**
  String get settingsProActiveSubtitle;

  /// User-facing Patterns interface copy for settings unlock pro title.
  ///
  /// In en, this message translates to:
  /// **'Unlock Patterns Pro'**
  String get settingsUnlockProTitle;

  /// User-facing Patterns interface copy for settings unlock pro subtitle.
  ///
  /// In en, this message translates to:
  /// **'One-time unlock for all recovery tools'**
  String get settingsUnlockProSubtitle;

  /// User-facing Patterns interface copy for settings restore purchases title.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get settingsRestorePurchasesTitle;

  /// User-facing Patterns interface copy for settings restore purchases subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore a previous Patterns Pro unlock'**
  String get settingsRestorePurchasesSubtitle;

  /// User-facing Patterns interface copy for settings help section.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settingsHelpSection;

  /// User-facing Patterns interface copy for settings replay tour title.
  ///
  /// In en, this message translates to:
  /// **'Replay the app tour'**
  String get settingsReplayTourTitle;

  /// User-facing Patterns interface copy for settings replay tour subtitle.
  ///
  /// In en, this message translates to:
  /// **'Walk through what each tab does again'**
  String get settingsReplayTourSubtitle;

  /// User-facing Patterns interface copy for settings show welcome title.
  ///
  /// In en, this message translates to:
  /// **'Show the welcome screens'**
  String get settingsShowWelcomeTitle;

  /// User-facing Patterns interface copy for settings show welcome subtitle.
  ///
  /// In en, this message translates to:
  /// **'See the introduction next time Patterns opens'**
  String get settingsShowWelcomeSubtitle;

  /// User-facing Patterns interface copy for settings feedback section.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get settingsFeedbackSection;

  /// User-facing Patterns interface copy for settings rate title.
  ///
  /// In en, this message translates to:
  /// **'Rate Patterns'**
  String get settingsRateTitle;

  /// User-facing Patterns interface copy for settings rate subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell the store what you think'**
  String get settingsRateSubtitle;

  /// User-facing Patterns interface copy for settings send feedback title.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get settingsSendFeedbackTitle;

  /// User-facing Patterns interface copy for settings send feedback subtitle.
  ///
  /// In en, this message translates to:
  /// **'Share an idea or tell us what went wrong'**
  String get settingsSendFeedbackSubtitle;

  /// User-facing Patterns interface copy for settings support title.
  ///
  /// In en, this message translates to:
  /// **'Support Patterns'**
  String get settingsSupportTitle;

  /// User-facing Patterns interface copy for settings support subtitle.
  ///
  /// In en, this message translates to:
  /// **'Leave an optional tip to support development'**
  String get settingsSupportSubtitle;

  /// Appearance-setting interface copy for appearance title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// Appearance-setting interface copy for appearance system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// Appearance-setting interface copy for appearance light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// Appearance-setting interface copy for appearance dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// Language-selection interface copy for language title. Language names themselves are shown in their native form elsewhere.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// Language-selection interface copy for language subtitle. Language names themselves are shown in their native form elsewhere.
  ///
  /// In en, this message translates to:
  /// **'Choose the language Patterns uses'**
  String get languageSubtitle;

  /// Calm Insights copy for calm insights title. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'Calm Insights'**
  String get calmInsightsTitle;

  /// Calm Insights copy for calm insights subtitle. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'Hide streaks and calculated scores. Your recorded data stays available.'**
  String get calmInsightsSubtitle;

  /// Calm Insights copy for calm recent activity title. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'Your recent activity'**
  String get calmRecentActivityTitle;

  /// Calm Insights copy for calm no recent activity. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'Nothing recorded in the last 7 days. Your space is ready whenever you need it.'**
  String get calmNoRecentActivity;

  /// Calm Insights copy for calm journal activity. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 journal entry} other{{count} journal entries}}'**
  String calmJournalActivity(int count);

  /// Calm Insights copy for calm tracked activity. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tracked moment} other{{count} tracked moments}}'**
  String calmTrackedActivity(int count);

  /// Calm Insights copy for calm delay activity. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 compulsion delay} other{{count} compulsion delays}}'**
  String calmDelayActivity(int count);

  /// Calm Insights copy for calm erp activity. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ERP practice} other{{count} ERP practices}}'**
  String calmErpActivity(int count);

  /// Calm Insights copy for calm exposure activity. Keep it factual, neutral, and non-judgmental; do not imply a score, diagnosis, or treatment result.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 exposure completed} other{{count} exposures completed}}'**
  String calmExposureActivity(int count);

  /// Title for the recovery activity and metrics screen.
  ///
  /// In en, this message translates to:
  /// **'Recovery metrics'**
  String get recoveryMetricsTitle;

  /// Heading for the locked Recovery Metrics preview.
  ///
  /// In en, this message translates to:
  /// **'See your recovery activity together'**
  String get recoveryMetricsTeaserTitle;

  /// Calm Insights preview copy; must remain factual and must not mention scores, streaks, progress, or judgments.
  ///
  /// In en, this message translates to:
  /// **'Review exposures, practice sessions, and recorded urge changes across your ERP tools. Unlock with Patterns Pro.'**
  String get recoveryMetricsCalmTeaserBody;

  /// Recovery Metrics preview copy shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Review practice streaks, completed exposures, and recorded urge changes across your ERP tools. Unlock with Patterns Pro.'**
  String get recoveryMetricsDetailedTeaserBody;

  /// Button that opens the Patterns Pro purchase screen from Recovery Metrics.
  ///
  /// In en, this message translates to:
  /// **'Unlock Patterns Pro'**
  String get recoveryMetricsUnlockPro;

  /// Heading shown before any recovery-practice data has been recorded.
  ///
  /// In en, this message translates to:
  /// **'Your recovery activity will appear here'**
  String get recoveryMetricsEmptyTitle;

  /// Calm Insights empty state; must not imply scoring, progress, consistency, or streaks.
  ///
  /// In en, this message translates to:
  /// **'Practise a delay, an ERP session, or an exposure step to see factual activity counts here.'**
  String get recoveryMetricsCalmEmptyBody;

  /// Recovery Metrics empty state shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Practise a delay, an ERP session, or an exposure step to begin building your activity history and practice streak.'**
  String get recoveryMetricsDetailedEmptyBody;

  /// Label for the factual count of completed exposure steps.
  ///
  /// In en, this message translates to:
  /// **'Exposures done'**
  String get recoveryMetricsExposuresDone;

  /// Label for the factual count of completed recovery practice sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions practised'**
  String get recoveryMetricsSessionsPracticed;

  /// Label for the calculated average change between deliberately recorded pre- and post-practice urge values.
  ///
  /// In en, this message translates to:
  /// **'Average recorded urge change'**
  String get recoveryMetricsAverageUrgeDrop;

  /// Heading for a seven-day recovery activity strip shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get recoveryMetricsThisWeek;

  /// Practice-streak value shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day streak} other{{days} day streak}}'**
  String recoveryMetricsDayStreak(int days);

  /// Language-selection interface copy for system default. Language names themselves are shown in their native form elsewhere.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Accessible action label for cancel action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// Accessible action label for done action.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneAction;

  /// Quiet completion copy for done for now action. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Done for now'**
  String get doneForNowAction;

  /// Quiet completion copy for completion saved title. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get completionSavedTitle;

  /// Quiet completion copy for completion practice title. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Practice recorded'**
  String get completionPracticeTitle;

  /// Quiet completion copy for completion journal body. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Your journal entry is saved on this device.'**
  String get completionJournalBody;

  /// Quiet completion copy for completion tracked body. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Your tracked moment is saved on this device.'**
  String get completionTrackedBody;

  /// Quiet completion copy for completion tracked updated body. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Your tracked moment has been updated.'**
  String get completionTrackedUpdatedBody;

  /// Quiet completion copy for completion delay body. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Your compulsion-delay practice has been recorded.'**
  String get completionDelayBody;

  /// Quiet completion copy for completion erp body. Confirm only what was saved or recorded; do not praise, score, celebrate, or suggest another task.
  ///
  /// In en, this message translates to:
  /// **'Your ERP practice has been recorded.'**
  String get completionErpBody;

  /// Local notification or native notification-channel copy for notification open action. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Open notification'**
  String get notificationOpenAction;

  /// Local notification or native notification-channel copy for daily reminder channel name. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminderChannelName;

  /// Local notification or native notification-channel copy for daily reminder channel description. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'A gentle daily nudge to check in with Patterns.'**
  String get dailyReminderChannelDescription;

  /// Local notification or native notification-channel copy for daily reminder title. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'A quiet check-in'**
  String get dailyReminderTitle;

  /// Local notification or native notification-channel copy for daily reminder body. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Take a gentle moment with Patterns whenever you’re ready.'**
  String get dailyReminderBody;

  /// Local notification or native notification-channel copy for practice timer channel name. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Practice timer'**
  String get practiceTimerChannelName;

  /// Local notification or native notification-channel copy for practice timer channel description. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'A gentle alert when a timed practice window is complete.'**
  String get practiceTimerChannelDescription;

  /// Local notification or native notification-channel copy for app updates channel name. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'App updates'**
  String get appUpdatesChannelName;

  /// Local notification or native notification-channel copy for app updates channel description. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Occasional notes when Patterns gets meaningful new recovery tools.'**
  String get appUpdatesChannelDescription;

  /// Local notification or native notification-channel copy for update announcement title. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Patterns got better'**
  String get updateAnnouncementTitle;

  /// Local notification or native notification-channel copy for update announcement body. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'New recovery tools, progress insights, and a calmer Home are ready.'**
  String get updateAnnouncementBody;

  /// Local notification or native notification-channel copy for practice window complete title. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Practice window complete'**
  String get practiceWindowCompleteTitle;

  /// Local notification or native notification-channel copy for practice window complete body. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to notice what happened.'**
  String get practiceWindowCompleteBody;

  /// Local notification or native notification-channel copy for erp window complete title. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'ERP practice window complete'**
  String get erpWindowCompleteTitle;

  /// Local notification or native notification-channel copy for erp window complete body. Keep it concise, gentle, and suitable outside the app.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to reflect on what happened.'**
  String get erpWindowCompleteBody;

  /// Primary navigation label for the nav today destination.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// Primary navigation label for the nav home destination.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Primary navigation label for the nav journal destination.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navJournal;

  /// Primary navigation label for the nav track destination.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get navTrack;

  /// Primary navigation label for the nav tracker destination.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get navTracker;

  /// Primary navigation label for the nav recovery destination.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get navRecovery;

  /// Primary navigation label for the nav insights destination.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// Primary navigation label for the nav settings destination.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Manual export flow copy for export report title. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Export report'**
  String get exportReportTitle;

  /// Manual export flow copy for export report description. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Save a combined PDF of your journal, OCD log, and insights. You choose where to save it and whether to share it.'**
  String get exportReportDescription;

  /// Manual export flow copy for export time window. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Time window'**
  String get exportTimeWindow;

  /// Manual export flow copy for export start. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get exportStart;

  /// Manual export flow copy for export end. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get exportEnd;

  /// Manual export flow copy for export include sections. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Include sections'**
  String get exportIncludeSections;

  /// Manual export flow copy for export analytics summary. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Analytics summary'**
  String get exportAnalyticsSummary;

  /// Manual export flow copy for export journal entries. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Journal entries'**
  String get exportJournalEntries;

  /// Manual export flow copy for export ocd events. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'OCD events'**
  String get exportOcdEvents;

  /// Manual export flow copy for export ybocs self checks. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Y-BOCS self-checks'**
  String get exportYbocsSelfChecks;

  /// Manual export flow copy for export entry summary. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'{total, plural, =0{No entries} =1{1 entry} other{{total} entries}} in this range ({journal} journal, {ocd} OCD, {selfChecks} self-checks)'**
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks);

  /// Manual export flow copy for export large report. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'This report is large and may take a moment to generate.'**
  String get exportLargeReport;

  /// Manual export flow copy for export privacy warning. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'This creates an unencrypted PDF. Save it somewhere private.'**
  String get exportPrivacyWarning;

  /// Manual export flow copy for export save pdf. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Save PDF'**
  String get exportSavePdf;

  /// Manual export flow copy for export select section error. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Select at least one section to export.'**
  String get exportSelectSectionError;

  /// Manual export flow copy for export no entries error. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'No entries match this range and section selection.'**
  String get exportNoEntriesError;

  /// Manual export flow copy for export report saved. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Report saved'**
  String get exportReportSaved;

  /// Manual export flow copy for export report failed. Preserve the distinction between local data and an unencrypted file the user chooses to save or share.
  ///
  /// In en, this message translates to:
  /// **'Could not create report'**
  String get exportReportFailed;

  /// Localized date-range label for range seven days in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'7D'**
  String get rangeSevenDays;

  /// Localized date-range label for range thirty days in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'30D'**
  String get rangeThirtyDays;

  /// Localized date-range label for range ninety days in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'90D'**
  String get rangeNinetyDays;

  /// Localized date-range label for range year in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get rangeYear;

  /// Localized date-range label for range all in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get rangeAll;

  /// Localized date-range label for range custom in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get rangeCustom;

  /// Localized date-range label for range last seven days in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get rangeLastSevenDays;

  /// Localized date-range label for range last thirty days in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get rangeLastThirtyDays;

  /// Localized date-range label for range last ninety days in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'Last 90 days'**
  String get rangeLastNinetyDays;

  /// Localized date-range label for range last year in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get rangeLastYear;

  /// Localized date-range label for range all time in insights and exported reports.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get rangeAllTime;

  /// Generated personal PDF report copy for pdf personal report. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Personal Report'**
  String get pdfPersonalReport;

  /// Generated personal PDF report copy for pdf generated. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Generated {date}'**
  String pdfGenerated(String date);

  /// Generated personal PDF report copy for pdf disclaimer. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'This report contains personal notes created in Patterns for self-reflection. It is not medical advice and does not replace care from a qualified clinician.'**
  String get pdfDisclaimer;

  /// Generated personal PDF report copy for pdf journal count. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Journal entries'**
  String get pdfJournalCount;

  /// Generated personal PDF report copy for pdf ocd count. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'OCD events'**
  String get pdfOcdCount;

  /// Generated personal PDF report copy for pdf average distress. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Average distress'**
  String get pdfAverageDistress;

  /// Generated personal PDF report copy for pdf obsessions. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Obsessions'**
  String get pdfObsessions;

  /// Generated personal PDF report copy for pdf compulsions. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Compulsions'**
  String get pdfCompulsions;

  /// Generated personal PDF report copy for pdf no journal entries. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'No journal entries in this range.'**
  String get pdfNoJournalEntries;

  /// Generated personal PDF report copy for pdf no ocd events. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'No OCD events in this range.'**
  String get pdfNoOcdEvents;

  /// Generated personal PDF report copy for pdf obsession. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Obsession'**
  String get pdfObsession;

  /// Generated personal PDF report copy for pdf compulsion. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Compulsion'**
  String get pdfCompulsion;

  /// Generated personal PDF report copy for pdf distress score. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Distress {score}/10'**
  String pdfDistressScore(int score);

  /// Generated personal PDF report copy for pdf thought. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Thought'**
  String get pdfThought;

  /// Generated personal PDF report copy for pdf urge. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Urge'**
  String get pdfUrge;

  /// Generated personal PDF report copy for pdf response. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Response: {text}'**
  String pdfResponse(String text);

  /// Generated personal PDF report copy for pdf action taken. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Action taken: {text}'**
  String pdfActionTaken(String text);

  /// Generated personal PDF report copy for pdf ybocs description. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Yale-Brown Obsessive Compulsive Scale, self-rated in the app. Total is out of 40, with obsessions and compulsions each out of 20.'**
  String get pdfYbocsDescription;

  /// Generated personal PDF report copy for pdf most recent total. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Most recent total'**
  String get pdfMostRecentTotal;

  /// Generated personal PDF report copy for pdf taken on. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Taken on'**
  String get pdfTakenOn;

  /// Generated personal PDF report copy for pdf obsessions subtotal. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Obsessions subtotal'**
  String get pdfObsessionsSubtotal;

  /// Generated personal PDF report copy for pdf compulsions subtotal. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Compulsions subtotal'**
  String get pdfCompulsionsSubtotal;

  /// Generated personal PDF report copy for pdf change across range. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Change across range'**
  String get pdfChangeAcrossRange;

  /// Generated personal PDF report copy for pdf self checks in range. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Self-checks in range'**
  String get pdfSelfChecksInRange;

  /// Generated personal PDF report copy for pdf themes flagged. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Themes flagged'**
  String get pdfThemesFlagged;

  /// Generated personal PDF report copy for pdf single self check. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Single self-check in this range'**
  String get pdfSingleSelfCheck;

  /// Generated personal PDF report copy for pdf change since. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'{change} since {date}'**
  String pdfChangeSince(String change, String date);

  /// Generated personal PDF report copy for pdf date. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pdfDate;

  /// Generated personal PDF report copy for pdf total. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get pdfTotal;

  /// Generated personal PDF report copy for pdf band. Preserve OCD, ERP, and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.
  ///
  /// In en, this message translates to:
  /// **'Band'**
  String get pdfBand;

  /// Y-BOCS self-check severity-band label for severity subclinical. This is a standardized score description, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Subclinical'**
  String get severitySubclinical;

  /// Y-BOCS self-check severity-band label for severity mild. This is a standardized score description, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get severityMild;

  /// Y-BOCS self-check severity-band label for severity moderate. This is a standardized score description, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get severityModerate;

  /// Y-BOCS self-check severity-band label for severity severe. This is a standardized score description, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get severitySevere;

  /// Y-BOCS self-check severity-band label for severity extreme. This is a standardized score description, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get severityExtreme;

  /// Accessible action label for back action.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backAction;

  /// Onboarding copy for onboarding safety footnote. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Private by design. Not a diagnosis or a replacement for professional care.'**
  String get onboardingSafetyFootnote;

  /// Onboarding copy for onboarding headline. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'A quiet place to practise with OCD.'**
  String get onboardingHeadline;

  /// Onboarding copy for onboarding introduction. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Log the intrusive thought, delay the compulsion, and practise responding differently, one small step at a time.'**
  String get onboardingIntroduction;

  /// Onboarding copy for onboarding privacy. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Your OCD data stays on this device. No account. No cloud sync.'**
  String get onboardingPrivacy;

  /// Accessible action label for get started action.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStartedAction;

  /// Accessible action label for import existing data action.
  ///
  /// In en, this message translates to:
  /// **'Import existing data'**
  String get importExistingDataAction;

  /// Onboarding copy for onboarding question. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'What would help right now?'**
  String get onboardingQuestion;

  /// Onboarding copy for onboarding pick one. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Pick one. You can do the rest whenever you like.'**
  String get onboardingPickOne;

  /// Onboarding copy for onboarding urge title. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'I\'m fighting an urge right now'**
  String get onboardingUrgeTitle;

  /// Onboarding copy for onboarding urge subtitle. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Put some time between the urge and the ritual.'**
  String get onboardingUrgeSubtitle;

  /// Onboarding copy for onboarding journal title. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'I want to write something down'**
  String get onboardingJournalTitle;

  /// Onboarding copy for onboarding journal subtitle. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Get the thought out of your head and onto a page.'**
  String get onboardingJournalSubtitle;

  /// Onboarding copy for onboarding erp title. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'I want to practise leaving a compulsion undone'**
  String get onboardingErpTitle;

  /// Onboarding copy for onboarding erp subtitle. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'One short, guided exposure.'**
  String get onboardingErpSubtitle;

  /// Onboarding copy for onboarding self check title. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'I want to see where my OCD is right now'**
  String get onboardingSelfCheckTitle;

  /// Onboarding copy for onboarding self check subtitle. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'The Y-BOCS self-check. About 10 minutes.'**
  String get onboardingSelfCheckSubtitle;

  /// Onboarding copy for onboarding explore title. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'I\'m just exploring'**
  String get onboardingExploreTitle;

  /// Onboarding copy for onboarding explore subtitle. Use warm, direct self-help language without reassurance, diagnosis, treatment claims, or pressure.
  ///
  /// In en, this message translates to:
  /// **'Have a look around first.'**
  String get onboardingExploreSubtitle;

  /// Patterns 1.10 in-app announcement copy for whats new title. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Practice without pressure'**
  String get whatsNewTitle;

  /// Patterns 1.10 in-app announcement copy for whats new body. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Patterns 1.10 brings calmer insights, quieter session endings, accessibility improvements, and optional language selection.'**
  String get whatsNewBody;

  /// Patterns 1.10 in-app announcement copy for whats new languages title. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Calm Insights'**
  String get whatsNewLanguagesTitle;

  /// Patterns 1.10 in-app announcement copy for whats new languages body. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Choose factual activity summaries instead of calculated scores, streaks, and consistency percentages.'**
  String get whatsNewLanguagesBody;

  /// Patterns 1.10 in-app announcement copy for whats new private title. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'A clear stopping point'**
  String get whatsNewPrivateTitle;

  /// Patterns 1.10 in-app announcement copy for whats new private body. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Journal, tracking, compulsion-delay, and ERP sessions now end with a simple factual confirmation and Done for now.'**
  String get whatsNewPrivateBody;

  /// Patterns 1.10 in-app announcement copy for whats new reports title. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'More accessible, in your language'**
  String get whatsNewReportsTitle;

  /// Patterns 1.10 in-app announcement copy for whats new reports body. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Improved labels and reduced-motion behavior join English, Brazilian Portuguese, German, Japanese, Spanish, and French.'**
  String get whatsNewReportsBody;

  /// Patterns 1.10 in-app announcement copy for whats new explore action. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Explore Patterns 1.10'**
  String get whatsNewExploreAction;

  /// Patterns 1.10 in-app announcement copy for continue to patterns action. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Continue to Patterns'**
  String get continueToPatternsAction;

  /// Patterns 1.10 in-app announcement copy for whats new notification note. Mention only implemented behavior and preserve the local-data and review gates.
  ///
  /// In en, this message translates to:
  /// **'Your entries stay as written. Language and Calm Insights choices stay on this device and are not included in analytics or backups.'**
  String get whatsNewNotificationNote;

  /// Accessibility label for the journal editor bold formatting toggle.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get formatBold;

  /// Accessibility label for the journal editor italic formatting toggle.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get formatItalic;

  /// Accessibility label for the journal editor bulleted-list formatting toggle.
  ///
  /// In en, this message translates to:
  /// **'Bulleted list'**
  String get formatBulletedList;

  /// VoiceOver hint for a journal editor formatting toggle.
  ///
  /// In en, this message translates to:
  /// **'Double tap to turn this formatting on or off.'**
  String get formatToggleHint;

  /// Accessibility label for the editable rich-text journal field.
  ///
  /// In en, this message translates to:
  /// **'Journal editor'**
  String get journalEditorLabel;

  /// Accessibility hint for the editable rich-text journal field.
  ///
  /// In en, this message translates to:
  /// **'Enter your journal text. Formatting controls follow the editor.'**
  String get journalEditorHint;

  /// Accessibility value announced for an active practice timer.
  ///
  /// In en, this message translates to:
  /// **'Time remaining: {time}'**
  String timerRemaining(String time);

  /// Text alternative for the recovery score ring when Calm Insights is off.
  ///
  /// In en, this message translates to:
  /// **'Recovery score: {score} out of 100.'**
  String recoveryScoreSemantics(int score);

  /// Heading for the privacy and clinical-safety explanation.
  ///
  /// In en, this message translates to:
  /// **'Privacy & safety'**
  String get privacySafetyTitle;

  /// Explains which personal content and preferences remain local.
  ///
  /// In en, this message translates to:
  /// **'Journal entries, OCD events, distress ratings, reflections, and app preferences are stored locally on this device.'**
  String get privacyLocalContent;

  /// Explains the privacy boundary for StoreKit or platform-store purchases.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro and tips are processed by the app store. Patterns does not receive your payment-card details.'**
  String get privacyPurchases;

  /// Warns that user-initiated exports are unencrypted and leave local storage only by user action.
  ///
  /// In en, this message translates to:
  /// **'A manual export creates an unencrypted JSON backup or PDF report only where you choose to save or share it.'**
  String get privacyExports;

  /// Exact scope and exclusions for optional first-party anonymous analytics.
  ///
  /// In en, this message translates to:
  /// **'Anonymous usage analytics are off unless you enable them. If enabled, Patterns sends named feature-use events, a random installation ID, platform, app version, and event time to its first-party service. Journal entries, OCD data, generated summaries, locale, and language choices are never included. Turning analytics off clears pending events and the local analytics ID.'**
  String get privacyAnalytics;

  /// Clinical and emergency boundary; requires qualified native clinical review.
  ///
  /// In en, this message translates to:
  /// **'Patterns is a self-help tool for personal reflection and ERP practice. It does not diagnose or treat OCD, replace care from a qualified clinician, or provide emergency support.'**
  String get privacyClinicalBoundary;

  /// Button that opens the external privacy policy.
  ///
  /// In en, this message translates to:
  /// **'View full Privacy Policy'**
  String get viewPrivacyPolicyAction;

  /// Closes a dialog or sheet.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeAction;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro'**
  String get proPaywallTitle;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Also includes every Pro planning, practice, metrics, and reflection tool.'**
  String get proPaywallIncludedTools;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Already bought Pro? You will not be charged again.'**
  String get proPaywallAlreadyPurchased;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get proPaywallTryAgainAction;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get proPaywallRestorePurchasesAction;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get proPaywallRestoreShortAction;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro'**
  String get proPaywallUnlockAction;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro · {price}'**
  String proPaywallUnlockWithPrice(String price);

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are unavailable on this device.'**
  String get proPaywallPurchasesUnavailable;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro is not available right now. Please try again later.'**
  String get proPaywallProductUnavailable;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Could not load Patterns Pro. Please try again later.'**
  String get proPaywallProductLoadFailed;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Could not start the purchase.'**
  String get proPaywallPurchaseStartFailed;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'The purchase could not be completed. Please try again.'**
  String get proPaywallPurchaseFailed;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'No previous purchase was found on this account. If you bought Pro with a different account, sign in with that account and try again.'**
  String get proPaywallRestoreNotFound;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Purchases could not be restored. Please try again.'**
  String get proPaywallRestoreFailed;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get proPaywallWelcomeBack;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'You\'re all set'**
  String get proPaywallAllSet;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro has been restored on this device.'**
  String get proPaywallRestoredBody;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro is unlocked. Every recovery tool is now available.'**
  String get proPaywallUnlockedBody;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get proPaywallContinueAction;

  /// Patterns Pro purchase interface copy. Preserve purchase and restore meaning without pressure or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Loading Patterns Pro'**
  String get proPaywallLoadingLabel;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Move beyond tracking and practise recovery'**
  String get proHeadlineSettings;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Build on today’s practice'**
  String get proHeadlineTodayNextStep;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Review your recovery activity'**
  String get proHeadlineRecoveryMetrics;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Build a clear exposure ladder'**
  String get proHeadlineExposureHierarchy;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Keep practice materials together'**
  String get proHeadlineExposureMaterials;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Turn recovery into a routine'**
  String get proHeadlineStructuredPrograms;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Plan your response before OCD arrives'**
  String get proHeadlineActionPlanner;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Make your next choice easier'**
  String get proHeadlineImplementationIntentions;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Practise riding out the urge'**
  String get proHeadlineUrgeSurfing;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Record the response you chose'**
  String get proHeadlineResponsePrevention;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Practise making room for maybe'**
  String get proHeadlineUncertaintyTraining;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Test OCD’s predictions'**
  String get proHeadlineBehavioralExperiments;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Capture what each practice taught you'**
  String get proHeadlineReflectionJournal;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Build exposure ladders and practice plans'**
  String get proBenefitGeneralPlans;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Use focused response-prevention tools'**
  String get proBenefitGeneralResponsePrevention;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Review recovery activity and reflections'**
  String get proBenefitGeneralReview;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Review practice activity over time'**
  String get proBenefitMetricsActivity;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'See recorded activity without judging individual days'**
  String get proBenefitMetricsNonjudgmental;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Explore factual recovery patterns'**
  String get proBenefitMetricsPatterns;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Organize steps from gentler to harder'**
  String get proBenefitExposureLadder;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Keep scripts, loop tapes, images, and links nearby'**
  String get proBenefitExposureMaterials;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Turn a plan into repeatable practice'**
  String get proBenefitExposureRepeatable;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Follow a calm week-by-week structure'**
  String get proBenefitProgramsStructure;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Keep practice tasks in one place'**
  String get proBenefitProgramsTasks;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Review what helped as you continue'**
  String get proBenefitProgramsReview;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Choose a response before the hard moment'**
  String get proBenefitPlanningAhead;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Create practical if-then plans'**
  String get proBenefitPlanningIfThen;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Return to the plan when uncertainty rises'**
  String get proBenefitPlanningReturn;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Use focused practice tools in the moment'**
  String get proBenefitInMomentTools;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Record choices without writing sensitive details'**
  String get proBenefitInMomentPrivacy;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Build tolerance through repeatable practice'**
  String get proBenefitInMomentRepetition;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Compare predictions with what happened'**
  String get proBenefitReflectionCompare;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Capture learning after practice'**
  String get proBenefitReflectionCapture;

  /// Patterns Pro benefit copy. Keep it factual, gentle, and non-judgmental; do not promise treatment outcomes or use scores and streaks.
  ///
  /// In en, this message translates to:
  /// **'Notice useful patterns over time'**
  String get proBenefitReflectionPatterns;

  /// Patterns Pro restore status shown while the store checks the current account.
  ///
  /// In en, this message translates to:
  /// **'Checking your purchases…'**
  String get proRestoreChecking;

  /// Patterns Pro restore success confirmation. Do not imply a new charge or treatment outcome.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro restored. Every recovery tool is unlocked again.'**
  String get proRestoreSucceeded;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Support Patterns'**
  String get tipJarTitle;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Patterns is independent and ad-free. If it has helped you, a small tip means a lot. Tips are optional and do not unlock anything.'**
  String get tipJarBody;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Loading tip options'**
  String get tipJarLoadingLabel;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are unavailable on this device.'**
  String get tipJarPurchasesUnavailable;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'No tip options were found. Please try again later.'**
  String get tipJarOptionsUnavailable;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Tip options could not be loaded. Please try again later.'**
  String get tipJarLoadFailed;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'The tip could not be completed. Please try again.'**
  String get tipJarPurchaseFailed;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tipJarTryAgainAction;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Small tip'**
  String get tipSmallTitle;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'An optional small tip to support Patterns development. Unlocks no features.'**
  String get tipSmallDescription;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Medium tip'**
  String get tipMediumTitle;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'An optional medium tip to support Patterns development. Unlocks no features.'**
  String get tipMediumDescription;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Large tip'**
  String get tipLargeTitle;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'An optional large tip to support Patterns development. Unlocks no features.'**
  String get tipLargeDescription;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'{title}, {price}. {description}'**
  String tipChoiceSemantics(String title, String price, String description);

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Sends this optional tip'**
  String get tipChoiceHint;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Thank you'**
  String get tipThanksTitle;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Your support means a lot. Patterns stays ad-free and independent because of people like you.'**
  String get tipThanksBody;

  /// Optional tip purchase copy. State clearly that tips are optional and unlock no features; do not pressure the user.
  ///
  /// In en, this message translates to:
  /// **'Glad to help'**
  String get tipThanksAction;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Unlock Patterns Desktop Pro'**
  String get desktopProTitle;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'A one-time license for offline, desktop-optimized recovery tools.'**
  String get desktopProSubtitle;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Hierarchy Builder'**
  String get desktopFeatureHierarchyTitle;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Construct and track exposure steps and ladders.'**
  String get desktopFeatureHierarchyDescription;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'ERP Exercise Logs'**
  String get desktopFeatureErpTitle;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Record response prevention and timed exercises.'**
  String get desktopFeatureErpDescription;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Urge Surfing'**
  String get desktopFeatureUrgeTitle;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Follow urge changes with live timed logging.'**
  String get desktopFeatureUrgeDescription;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Recovery Activity'**
  String get desktopFeatureActivityTitle;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Review factual activity and weekly patterns.'**
  String get desktopFeatureActivityDescription;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'One-time license'**
  String get desktopOneTimeLicense;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'{price} one-time purchase'**
  String desktopOneTimePrice(String price);

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Buy license'**
  String get desktopPurchaseLicenseAction;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'The purchase page is unavailable in this build.'**
  String get desktopCheckoutUnavailable;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Already purchased? Enter your license key'**
  String get desktopAlreadyPurchased;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Enter your Lemon Squeezy license key:'**
  String get desktopLicensePrompt;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'License key'**
  String get desktopLicenseLabel;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Paste the license key from your receipt'**
  String get desktopLicenseHint;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Activating license…'**
  String get desktopLicenseActivating;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Activate license'**
  String get desktopActivateLicenseAction;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get desktopLicenseBackAction;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'Enter the complete license key from your receipt.'**
  String get desktopLicenseInvalid;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'This license could not be verified for Patterns Desktop Pro. Check the key and try again.'**
  String get desktopLicenseRejected;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'The license service could not be reached. Check your connection and try again.'**
  String get desktopLicenseUnavailable;

  /// Desktop Pro purchase and license activation copy. Keep claims factual and never expose raw service errors.
  ///
  /// In en, this message translates to:
  /// **'License activation is unavailable in this build.'**
  String get desktopLicenseNotConfigured;

  /// Title of the journal list screen.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journalTitle;

  /// Accessibility label for opening journal search.
  ///
  /// In en, this message translates to:
  /// **'Search journal'**
  String get journalSearchAction;

  /// Button label for choosing a journal-entry date.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get journalChooseDateAction;

  /// Placeholder for the journal search field.
  ///
  /// In en, this message translates to:
  /// **'Search entries'**
  String get journalSearchHint;

  /// Accessibility label for clearing the journal search field.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get journalClearSearchAction;

  /// Journal empty-state title when a search has no matches.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get journalNoMatchesTitle;

  /// Journal empty-state body when a search has no matches. Preserve the user's search query exactly.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches “{query}”.'**
  String journalNoMatchesBody(String query);

  /// Journal empty-state title before the user has written an entry.
  ///
  /// In en, this message translates to:
  /// **'No journal entries yet'**
  String get journalEmptyTitle;

  /// Journal empty-state guidance. Keep it optional, calm, and free of pressure.
  ///
  /// In en, this message translates to:
  /// **'A few quiet lines are enough to begin.'**
  String get journalEmptyBody;

  /// Safe journal loading error. Do not expose raw exception or database text.
  ///
  /// In en, this message translates to:
  /// **'Journal entries could not be loaded. Try again.'**
  String get journalLoadError;

  /// Accessibility label for journal loading progress.
  ///
  /// In en, this message translates to:
  /// **'Loading journal entries'**
  String get journalLoadingLabel;

  /// Live save-status text in the journal editor.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get journalSavingStatus;

  /// Saved-status text in the journal editor.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get journalSavedStatus;

  /// Unsaved-status text in the journal editor. Avoid alarmist wording.
  ///
  /// In en, this message translates to:
  /// **'Not saved'**
  String get journalUnsavedStatus;

  /// Action that opens confirmation before deleting one journal day.
  ///
  /// In en, this message translates to:
  /// **'Clear this day'**
  String get journalClearDayAction;

  /// Action that saves the current journal entry.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get journalSaveAction;

  /// Placeholder in the rich-text journal editor.
  ///
  /// In en, this message translates to:
  /// **'Start writing…'**
  String get journalStartWritingPlaceholder;

  /// Short guidance shown beside rich-text formatting controls.
  ///
  /// In en, this message translates to:
  /// **'Select text to format'**
  String get journalFormatSelectionHint;

  /// Factual confirmation after deleting one journal day.
  ///
  /// In en, this message translates to:
  /// **'The entry for that day was cleared.'**
  String get journalClearedMessage;

  /// Warm validation when the user tries to save an empty journal entry.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to save yet. Add a line whenever you feel ready.'**
  String get journalNothingToSaveMessage;

  /// Confirmation title before deleting one journal day.
  ///
  /// In en, this message translates to:
  /// **'Clear this day?'**
  String get journalClearDayTitle;

  /// Confirmation body before deleting one journal day. The date is already formatted for the active locale.
  ///
  /// In en, this message translates to:
  /// **'This clears everything saved for {date}. You can write here again anytime.'**
  String journalClearDayBody(String date);

  /// Non-destructive action that cancels deletion of a journal day.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get journalKeepEntryAction;

  /// Shortcut label for opening today's journal entry.
  ///
  /// In en, this message translates to:
  /// **'Today’s entry'**
  String get journalTodayEntry;

  /// Action that opens the journal editor for a selected date.
  ///
  /// In en, this message translates to:
  /// **'Open entry'**
  String get journalOpenEntryAction;

  /// Accessibility hint for a journal-entry card. The date is already formatted for the active locale.
  ///
  /// In en, this message translates to:
  /// **'Opens the journal entry for {date}.'**
  String journalOpenEntryHint(String date);

  /// Window title for the desktop journal workspace.
  ///
  /// In en, this message translates to:
  /// **'Journal workspace'**
  String get journalWorkspaceTitle;

  /// Desktop journal subtitle. Keep it calm and avoid implying treatment or a guaranteed emotional result.
  ///
  /// In en, this message translates to:
  /// **'Your space to reflect and let things out.'**
  String get journalSubtitle;

  /// Action that starts a new journal entry.
  ///
  /// In en, this message translates to:
  /// **'New entry'**
  String get journalNewEntryAction;

  /// Heading for journal entries before today.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get journalEarlierSection;

  /// Desktop journal empty state for the currently selected date.
  ///
  /// In en, this message translates to:
  /// **'No entry for this date.'**
  String get journalNoEntryForDate;

  /// Action that creates a journal entry for the selected date.
  ///
  /// In en, this message translates to:
  /// **'Create entry'**
  String get journalCreateEntryAction;

  /// Date and time shown above a desktop journal entry. Both placeholders are already formatted for the active locale.
  ///
  /// In en, this message translates to:
  /// **'{date} at {time}'**
  String journalEntryTimestamp(String date, String time);

  /// Destructive action that deletes one journal entry.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get journalDeleteEntryAction;

  /// Confirmation title before permanently deleting one journal entry.
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get journalDeleteEntryTitle;

  /// Confirmation body before permanently deleting one journal entry.
  ///
  /// In en, this message translates to:
  /// **'This journal entry will be permanently deleted.'**
  String get journalDeleteEntryBody;

  /// Factual confirmation after a journal entry is deleted.
  ///
  /// In en, this message translates to:
  /// **'The journal entry was deleted.'**
  String get journalDeletedMessage;

  /// Action that opens an existing journal entry for editing.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get journalEditAction;

  /// Desktop journal editor heading. The date is already formatted for the active locale.
  ///
  /// In en, this message translates to:
  /// **'Editing: {date}'**
  String journalEditingDate(String date);

  /// Desktop journal editor status when the document differs from the saved entry.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get journalUnsavedChangesStatus;

  /// Factual confirmation after saving a desktop journal entry.
  ///
  /// In en, this message translates to:
  /// **'Journal entry saved'**
  String get journalEntrySavedMessage;

  /// Accessibility label for a read-only journal entry. The date is already formatted for the active locale.
  ///
  /// In en, this message translates to:
  /// **'Read-only journal entry for {date}'**
  String journalReadOnlyLabel(String date);

  /// Locally detected journal theme label. This is descriptive only, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Contamination'**
  String get journalThemeContamination;

  /// Locally detected journal theme label. This is descriptive only, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Uncertainty'**
  String get journalThemeUncertainty;

  /// Locally detected journal theme label. This is descriptive only, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Checking'**
  String get journalThemeChecking;

  /// Locally detected journal theme label. This is descriptive only, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get journalThemeRelationship;

  /// Locally detected journal theme label. This is descriptive only, not a diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get journalThemeHealth;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
