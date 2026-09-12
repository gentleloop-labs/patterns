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
  /// **'Save your records to a local ZIP backup'**
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

  /// Today greeting shown before noon.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get todayGreetingMorning;

  /// Today greeting shown during the afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get todayGreetingAfternoon;

  /// Today greeting shown during the evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get todayGreetingEvening;

  /// Gentle Today heading copy. Avoid reassurance, pressure, or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'You’ve got this. One choice at a time.'**
  String get todayEncouragement;

  /// Today section heading for resuming a recovery activity.
  ///
  /// In en, this message translates to:
  /// **'Continue your practice'**
  String get todayContinuePractice;

  /// Action that opens the full list of recovery activities.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get todaySeeAllAction;

  /// Today section heading for frequently used actions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get todayQuickActions;

  /// Optional first-run Today activity heading. Keep it non-directive.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do?'**
  String get todayChooseActivity;

  /// First-run action for recording a thought or moment.
  ///
  /// In en, this message translates to:
  /// **'Write something down'**
  String get todayWriteSomethingTitle;

  /// First-run journal action explanation. Do not promise a clinical outcome.
  ///
  /// In en, this message translates to:
  /// **'Get a thought out of your head.'**
  String get todayWriteSomethingBody;

  /// First-run action for starting a compulsion delay.
  ///
  /// In en, this message translates to:
  /// **'Delay an urge'**
  String get todayDelayUrgeTitle;

  /// First-run compulsion-delay explanation.
  ///
  /// In en, this message translates to:
  /// **'Create space before you respond.'**
  String get todayDelayUrgeBody;

  /// First-run action for starting an ERP exercise. Preserve ERP terminology.
  ///
  /// In en, this message translates to:
  /// **'Practise (ERP)'**
  String get todayPracticeErpTitle;

  /// First-run ERP action explanation.
  ///
  /// In en, this message translates to:
  /// **'A short, guided exercise.'**
  String get todayPracticeErpBody;

  /// Recommended Today action after a first journal path.
  ///
  /// In en, this message translates to:
  /// **'Write down another moment'**
  String get todayFirstJournalTitle;

  /// Recommended journal explanation. Avoid guaranteed emotional or treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'Naming a thought can make it easier to observe.'**
  String get todayFirstJournalBody;

  /// Recommended Today action after a first ERP path.
  ///
  /// In en, this message translates to:
  /// **'Practise again'**
  String get todayFirstErpTitle;

  /// Recommended ERP explanation. Avoid streak or momentum pressure.
  ///
  /// In en, this message translates to:
  /// **'Try another short, guided ERP practice.'**
  String get todayFirstErpBody;

  /// Recommended Today action for a brief compulsion delay.
  ///
  /// In en, this message translates to:
  /// **'Try a two-minute delay'**
  String get todayFirstDelayTitle;

  /// Recommended compulsion-delay explanation.
  ///
  /// In en, this message translates to:
  /// **'When an urge feels strong, put a little space before it.'**
  String get todayFirstDelayBody;

  /// Action that starts an ERP practice.
  ///
  /// In en, this message translates to:
  /// **'Start practice'**
  String get todayStartPracticeAction;

  /// Action that starts a compulsion delay.
  ///
  /// In en, this message translates to:
  /// **'Start a delay'**
  String get todayStartDelayAction;

  /// Today card title that opens the Patterns Pro purchase screen.
  ///
  /// In en, this message translates to:
  /// **'Continue with Patterns Pro'**
  String get todayProTitle;

  /// Patterns Pro Today card copy. Do not promise recovery or clinical outcomes.
  ///
  /// In en, this message translates to:
  /// **'Build a plan, practise it, and review your activity over time.'**
  String get todayProBody;

  /// Action that temporarily hides the Today Patterns Pro card.
  ///
  /// In en, this message translates to:
  /// **'Hide for 7 days'**
  String get todayHideSevenDays;

  /// Heading for calculated practice information shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Practice progress'**
  String get todayPracticeProgress;

  /// Practice summary shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Steady practice'**
  String get todaySteadyPractice;

  /// Empty calculated-progress heading shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Start gently'**
  String get todayStartGently;

  /// Calculated-progress explanation shown only when Calm Insights is disabled. Avoid judgment or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Your recorded activities are building a longer-term picture.'**
  String get todayPracticeActiveBody;

  /// Calculated-progress empty explanation shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'This changes as you journal, track, and practise.'**
  String get todayPracticeEmptyBody;

  /// Safety boundary for a calculated practice score. Preserve the non-diagnostic qualification.
  ///
  /// In en, this message translates to:
  /// **'This reflects recorded practice frequency, not a diagnosis or clinical assessment. A lower number can occur during a difficult week.'**
  String get todayProgressDisclaimer;

  /// Heading before enough data exists to calculate practice progress. Avoid praise or judgment.
  ///
  /// In en, this message translates to:
  /// **'Your activity is taking shape'**
  String get todayProgressStartedTitle;

  /// Factual explanation of when calculated practice progress becomes available.
  ///
  /// In en, this message translates to:
  /// **'A progress number will appear after activities have been recorded across more than one day.'**
  String get todayProgressPendingBody;

  /// Calculated practice-score band shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get todayScoreNew;

  /// Calculated practice-score band shown only when Calm Insights is disabled; it is not a clinical assessment.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get todayScoreStrong;

  /// Calculated practice-score band shown only when Calm Insights is disabled; it is not a clinical assessment.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get todayScoreSteady;

  /// Calculated practice-score band shown only when Calm Insights is disabled; it is not a clinical assessment.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get todayScoreBuilding;

  /// Calculated practice-score band shown only when Calm Insights is disabled; it is not a clinical assessment.
  ///
  /// In en, this message translates to:
  /// **'Starting'**
  String get todayScoreStarting;

  /// Calculated-progress starting copy shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Begin with one small check-in'**
  String get todayBeginCheckIn;

  /// Calculated-progress delta shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'No change from the previous period'**
  String get todayNoChange;

  /// Positive calculated-progress delta shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{points, plural, =1{1 point up} other{{points} points up}} from the previous period'**
  String todayPointsUp(int points);

  /// Negative calculated-progress delta shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{points, plural, =1{1 point down} other{{points} points down}} from the previous period'**
  String todayPointsDown(int points);

  /// Heading for one optional recommended recovery activity.
  ///
  /// In en, this message translates to:
  /// **'Your next step'**
  String get todayNextStep;

  /// Recommended action title for the optional Y-BOCS self-check.
  ///
  /// In en, this message translates to:
  /// **'See where you are'**
  String get todayNextSelfCheckTitle;

  /// Y-BOCS recommendation copy. Keep it optional and non-diagnostic.
  ///
  /// In en, this message translates to:
  /// **'A self-check can record a baseline for later comparison.'**
  String get todayNextSelfCheckBody;

  /// Action that opens the optional Y-BOCS self-check.
  ///
  /// In en, this message translates to:
  /// **'Take self-check'**
  String get todayNextSelfCheckAction;

  /// Recommended action title for building an exposure hierarchy.
  ///
  /// In en, this message translates to:
  /// **'Set up your practice'**
  String get todayNextHierarchyTitle;

  /// Exposure-hierarchy recommendation. Preserve the gradual ordering.
  ///
  /// In en, this message translates to:
  /// **'Build an exposure ladder from easier to harder steps.'**
  String get todayNextHierarchyBody;

  /// Action that opens the exposure hierarchy builder.
  ///
  /// In en, this message translates to:
  /// **'Build ladder'**
  String get todayNextHierarchyAction;

  /// Recommended action title for an ERP practice. Avoid momentum or streak pressure.
  ///
  /// In en, this message translates to:
  /// **'Choose today’s practice'**
  String get todayNextPracticeTitle;

  /// ERP recommendation copy. Preserve ERP terminology and avoid treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Choose one manageable ERP exercise for today.'**
  String get todayNextPracticeBody;

  /// Action that starts the recommended ERP practice.
  ///
  /// In en, this message translates to:
  /// **'Start practice'**
  String get todayNextPracticeAction;

  /// Recommended action title for an optional post-practice reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflect on the practice'**
  String get todayNextReflectTitle;

  /// Optional reflection copy; do not judge the result of the practice.
  ///
  /// In en, this message translates to:
  /// **'Record what you noticed during today’s practice.'**
  String get todayNextReflectBody;

  /// Action that opens a post-practice reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflect'**
  String get todayNextReflectAction;

  /// Recommended action title for an optional journal reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflect on today'**
  String get todayNextJournalTitle;

  /// Optional journal recommendation; do not judge the result of the practice.
  ///
  /// In en, this message translates to:
  /// **'Write a line about what you noticed in your practice.'**
  String get todayNextJournalBody;

  /// Action that opens the journal from Today.
  ///
  /// In en, this message translates to:
  /// **'Open journal'**
  String get todayNextJournalAction;

  /// Today title for a current or available compulsion-delay activity.
  ///
  /// In en, this message translates to:
  /// **'Compulsion delay'**
  String get todayCompulsionDelay;

  /// Today title for starting an ERP practice. Preserve ERP terminology.
  ///
  /// In en, this message translates to:
  /// **'Start ERP practice'**
  String get todayStartErp;

  /// Compulsion-delay explanation. Avoid promising that an urge will disappear.
  ///
  /// In en, this message translates to:
  /// **'Sit with the urge before deciding what to do.'**
  String get todayResistUrgeBody;

  /// ERP practice explanation. Avoid guaranteed treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'Practise a manageable step at your own pace.'**
  String get todayBuildToleranceBody;

  /// Action that resumes a saved practice session.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get todayResumeAction;

  /// Action that starts an available practice session.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get todayStartAction;

  /// Today quick-action explanation for the local journal.
  ///
  /// In en, this message translates to:
  /// **'Write and reflect in your private journal.'**
  String get todayJournalBody;

  /// Today quick-action title for exposure hierarchy and related ERP tools.
  ///
  /// In en, this message translates to:
  /// **'Exposure tools'**
  String get todayExposureTools;

  /// Today quick-action explanation for exposure tools.
  ///
  /// In en, this message translates to:
  /// **'Hierarchy, materials, and uncertainty practice.'**
  String get todayExposureToolsBody;

  /// Today quick-action explanation for Insights. Do not imply judgment or treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'Review your recorded activity.'**
  String get todayInsightsBody;

  /// Optional first-run Y-BOCS self-check entry. Keep it non-diagnostic.
  ///
  /// In en, this message translates to:
  /// **'Understand your patterns'**
  String get todaySelfCheckTitle;

  /// Duration and optional status of the first-run self-check.
  ///
  /// In en, this message translates to:
  /// **'Optional · about 10 min'**
  String get todaySelfCheckDuration;

  /// Factual first-run Insights empty state.
  ///
  /// In en, this message translates to:
  /// **'Your insights will appear here as you record activities.'**
  String get todayInsightsPlaceholder;

  /// Factual Today status after a journal check-in exists for the current day.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in recorded'**
  String get todayDailyCheckInComplete;

  /// Today title for creating a journal check-in.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get todayDailyCheckIn;

  /// Factual Today status for a completed daily journal check-in.
  ///
  /// In en, this message translates to:
  /// **'A journal entry is recorded for today.'**
  String get todayDailyCompleteBody;

  /// Optional daily journal check-in explanation.
  ///
  /// In en, this message translates to:
  /// **'Write a short journal entry when you’re ready.'**
  String get todayDailyBody;

  /// Action that opens today’s existing journal entry.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get todayOpenAction;

  /// Action that opens a new daily journal entry.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get todayCheckInAction;

  /// Calculated score heading shown only when Calm Insights is disabled; it is not a clinical assessment.
  ///
  /// In en, this message translates to:
  /// **'Recovery score'**
  String get todayRecoveryScore;

  /// Factual desktop Calm Insights summary for recorded activity.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 activity in the last 7 days} other{{count} activities in the last 7 days}}'**
  String todayActivitiesLastSevenDays(int count);

  /// Neutral desktop caption for the calculated score shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Calculated from recorded activity'**
  String get todayActivityRecorded;

  /// Factual desktop heading used when Calm Insights is enabled.
  ///
  /// In en, this message translates to:
  /// **'Practices recorded'**
  String get todayPracticesRecorded;

  /// Desktop streak heading shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Practice streak'**
  String get todayPracticeStreak;

  /// Factual count of recovery practice sessions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 session} other{{count} sessions}}'**
  String todaySessionsCount(int count);

  /// Count used in the practice streak shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String todayDaysCount(int count);

  /// Today explanation for resuming a compulsion delay.
  ///
  /// In en, this message translates to:
  /// **'Continue from the previously recorded time.'**
  String get todayPickUpBody;

  /// Today explanation for starting a compulsion delay.
  ///
  /// In en, this message translates to:
  /// **'Practise waiting before responding to an urge.'**
  String get todayPracticeUrgesBody;

  /// Desktop action title when today already has a journal entry.
  ///
  /// In en, this message translates to:
  /// **'Read today’s check-in'**
  String get todayReadCheckIn;

  /// Desktop explanation when today already has a journal entry.
  ///
  /// In en, this message translates to:
  /// **'Open Journal to read or add more'**
  String get todayOpenJournalMore;

  /// Desktop daily journal check-in explanation.
  ///
  /// In en, this message translates to:
  /// **'Write a short journal entry'**
  String get todayShortJournal;

  /// Desktop Today section heading for app destinations.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get todayExplore;

  /// Desktop Journal destination explanation.
  ///
  /// In en, this message translates to:
  /// **'Reflect and process'**
  String get todayReflectProcess;

  /// Desktop Recovery destination title.
  ///
  /// In en, this message translates to:
  /// **'Recovery tools'**
  String get todayRecoveryTools;

  /// Desktop Recovery destination explanation. Avoid treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Support your practice'**
  String get todaySupportPractice;

  /// Desktop Track destination explanation.
  ///
  /// In en, this message translates to:
  /// **'Log thoughts and urges'**
  String get todayTrackBody;

  /// Desktop Insights destination explanation. Avoid judgment or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'Review your recorded patterns'**
  String get todaySeePatterns;

  /// Text alternative for the calculated practice-progress ring shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Practice progress: {score} out of 100, {label}'**
  String todayScoreA11y(int score, String label);

  /// Text alternative for the circular and linear practice timer graphics.
  ///
  /// In en, this message translates to:
  /// **'Practice timer: {elapsed} elapsed of {planned}'**
  String todayTimerA11y(String elapsed, String planned);

  /// Accessible status for a day with recorded activity in the seven-day strip.
  ///
  /// In en, this message translates to:
  /// **'{day}: activity recorded'**
  String todayDayActiveA11y(String day);

  /// Accessible status for a day without recorded activity in the seven-day strip.
  ///
  /// In en, this message translates to:
  /// **'{day}: no activity recorded'**
  String todayDayInactiveA11y(String day);

  /// Heading for the OCD tracking history screen.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get trackerTitle;

  /// Action that opens the compulsion-delay tool from the tracker.
  ///
  /// In en, this message translates to:
  /// **'Pause an urge'**
  String get trackerPauseUrgeAction;

  /// Accessibility label for the tracker filter control group.
  ///
  /// In en, this message translates to:
  /// **'Filter tracked moments'**
  String get trackerFilterGroupLabel;

  /// Tracker filter that includes obsessions and compulsions.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get trackerFilterAll;

  /// Tracker filter that includes only recorded obsessions.
  ///
  /// In en, this message translates to:
  /// **'Obsessions'**
  String get trackerFilterObsessions;

  /// Tracker filter that includes only recorded compulsions.
  ///
  /// In en, this message translates to:
  /// **'Compulsions'**
  String get trackerFilterCompulsions;

  /// Accessible live-region label while tracker history loads.
  ///
  /// In en, this message translates to:
  /// **'Loading tracked moments'**
  String get trackerLoadingLabel;

  /// Privacy-safe error shown when tracker history cannot load. Do not expose technical details.
  ///
  /// In en, this message translates to:
  /// **'Your tracked moments could not be loaded. Please try again.'**
  String get trackerLoadError;

  /// Heading for editing a recorded OCD event.
  ///
  /// In en, this message translates to:
  /// **'Edit event'**
  String get trackerEditTitle;

  /// Heading for recording an OCD event.
  ///
  /// In en, this message translates to:
  /// **'Track event'**
  String get trackerAddTitle;

  /// Accessibility label for the obsession or compulsion selector.
  ///
  /// In en, this message translates to:
  /// **'Event type'**
  String get trackerTypeGroupLabel;

  /// Clinical label for an obsession event. Keep terminology consistent with the glossary.
  ///
  /// In en, this message translates to:
  /// **'Obsession'**
  String get trackerTypeObsession;

  /// Clinical label for a compulsion event. Keep terminology consistent with the glossary.
  ///
  /// In en, this message translates to:
  /// **'Compulsion'**
  String get trackerTypeCompulsion;

  /// Label asking the user to record the content of an obsession.
  ///
  /// In en, this message translates to:
  /// **'What did the thought say?'**
  String get trackerThoughtLabel;

  /// Label asking the user to record a compulsive urge.
  ///
  /// In en, this message translates to:
  /// **'What was the urge?'**
  String get trackerUrgeLabel;

  /// Short, non-judgmental hint for recording an obsession.
  ///
  /// In en, this message translates to:
  /// **'Name the thought or image.'**
  String get trackerThoughtHint;

  /// Short, non-judgmental hint for recording a compulsive urge.
  ///
  /// In en, this message translates to:
  /// **'Name the urge or compulsion.'**
  String get trackerUrgeHint;

  /// Optional field asking what action followed the recorded OCD event.
  ///
  /// In en, this message translates to:
  /// **'What did OCD get you to do?'**
  String get trackerActionLabel;

  /// Gentle hint that a brief tracker response is acceptable.
  ///
  /// In en, this message translates to:
  /// **'A short note is enough.'**
  String get trackerActionHint;

  /// Optional field for the response the user chose instead of a compulsion.
  ///
  /// In en, this message translates to:
  /// **'What you did instead'**
  String get trackerResponseLabel;

  /// Non-scoring hint for recording any chosen response without implying success or treatment outcome.
  ///
  /// In en, this message translates to:
  /// **'Record any response you chose, including a partial delay.'**
  String get trackerResponseHint;

  /// Disabled tracker save-button label while the event is being stored.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get trackerSavingAction;

  /// Action that saves edits to a tracked event.
  ///
  /// In en, this message translates to:
  /// **'Update event'**
  String get trackerUpdateAction;

  /// Action that stores a new tracked event.
  ///
  /// In en, this message translates to:
  /// **'Save event'**
  String get trackerSaveAction;

  /// Warm validation shown when the main tracker field is empty.
  ///
  /// In en, this message translates to:
  /// **'Whenever you’re ready, add a few words about what happened.'**
  String get trackerContentRequired;

  /// Privacy-safe error shown when a new tracker event cannot be stored.
  ///
  /// In en, this message translates to:
  /// **'Your event could not be saved. Please try again.'**
  String get trackerSaveError;

  /// Privacy-safe error shown when tracker edits cannot be stored.
  ///
  /// In en, this message translates to:
  /// **'Your event could not be updated. Please try again.'**
  String get trackerUpdateError;

  /// Tooltip and accessibility label for editing a tracker event.
  ///
  /// In en, this message translates to:
  /// **'Edit event'**
  String get trackerEditTooltip;

  /// Tooltip and accessibility label for deleting a tracker event.
  ///
  /// In en, this message translates to:
  /// **'Delete event'**
  String get trackerDeleteTooltip;

  /// Accessible and visible description of a deliberately recorded distress value.
  ///
  /// In en, this message translates to:
  /// **'Distress {value} out of 10'**
  String trackerDistressValue(int value);

  /// Compact visible form of a deliberately recorded distress value.
  ///
  /// In en, this message translates to:
  /// **'{value}/10'**
  String trackerDistressShortValue(int value);

  /// Factual placeholder when no optional response was recorded for an OCD event.
  ///
  /// In en, this message translates to:
  /// **'No response noted'**
  String get trackerNoStrategy;

  /// Screen-reader summary of a tracker history card. User-entered content and response must remain unchanged.
  ///
  /// In en, this message translates to:
  /// **'{type}. {date}. Distress {distress} out of 10. {content}. Response: {response}'**
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  );

  /// Confirmation title before permanently deleting a local tracker event.
  ///
  /// In en, this message translates to:
  /// **'Delete event?'**
  String get trackerDeleteTitle;

  /// Local-first privacy explanation for deleting a tracker event.
  ///
  /// In en, this message translates to:
  /// **'This removes the event from your local history on this device.'**
  String get trackerDeleteBody;

  /// Destructive action that confirms tracker event deletion.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get trackerDeleteAction;

  /// Accessible factual confirmation after a tracker event is deleted.
  ///
  /// In en, this message translates to:
  /// **'Event deleted'**
  String get trackerDeletedMessage;

  /// Privacy-safe error shown when tracker deletion fails.
  ///
  /// In en, this message translates to:
  /// **'Your event could not be deleted. Please try again.'**
  String get trackerDeleteError;

  /// Visible label for the deliberately recorded distress slider.
  ///
  /// In en, this message translates to:
  /// **'Distress, 0 to 10'**
  String get trackerDistressLabel;

  /// Factual heading when tracker history is empty.
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get trackerEmptyTitle;

  /// Gentle empty-state explanation without pressure or engagement language.
  ///
  /// In en, this message translates to:
  /// **'Log only what feels useful. A short note is enough.'**
  String get trackerEmptyBody;

  /// Action that opens the form to record an OCD event.
  ///
  /// In en, this message translates to:
  /// **'Track OCD event'**
  String get trackerEmptyAction;

  /// Heading for the mobile Insights screen.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// Accessible action for opening the manual PDF report export flow.
  ///
  /// In en, this message translates to:
  /// **'Export report'**
  String get insightsExportReport;

  /// Factual count label for recorded obsessions.
  ///
  /// In en, this message translates to:
  /// **'Obsessions logged'**
  String get insightsObsessionsLogged;

  /// Factual count label for locally derived OCD themes.
  ///
  /// In en, this message translates to:
  /// **'Themes found'**
  String get insightsThemesFound;

  /// Factual count label for recorded compulsions.
  ///
  /// In en, this message translates to:
  /// **'Compulsions'**
  String get insightsCompulsions;

  /// Compact label for average user-recorded urge intensity.
  ///
  /// In en, this message translates to:
  /// **'Average intensity'**
  String get insightsAverageIntensityShort;

  /// Compact denominator for a user-recorded value on a zero-to-ten scale.
  ///
  /// In en, this message translates to:
  /// **'/10'**
  String get insightsOutOfTenShort;

  /// Calculated practice-progress heading shown only when Calm Insights is disabled. Not a clinical outcome.
  ///
  /// In en, this message translates to:
  /// **'Practice progress'**
  String get insightsPracticeProgress;

  /// Explanation shown before enough data exists for the optional calculated practice score.
  ///
  /// In en, this message translates to:
  /// **'A score appears once you’ve practised a few times across a couple of days, so it shows a trend rather than a single moment. Your sessions below are already counted.'**
  String get insightsScoreNeedsMoreActivity;

  /// Neutral empty explanation for the optional calculated practice score.
  ///
  /// In en, this message translates to:
  /// **'A score will appear here once you’ve practised a few times. Nothing to measure just yet.'**
  String get insightsScoreEmpty;

  /// Comparison period appended to a calculated Insights delta.
  ///
  /// In en, this message translates to:
  /// **'compared with the previous {count, plural, =1{day} other{{count} days}}'**
  String insightsComparedPreviousDays(int count);

  /// Generic comparison period appended to a calculated Insights delta.
  ///
  /// In en, this message translates to:
  /// **'compared with the previous range'**
  String get insightsComparedPreviousRange;

  /// Non-diagnostic boundary for the optional calculated practice score.
  ///
  /// In en, this message translates to:
  /// **'Reflects how often you practise, not a diagnosis or how you’re doing clinically. A lower number during a hard week can happen.'**
  String get insightsPracticeProgressBoundary;

  /// Heading and chart alternative for user-recorded mood values.
  ///
  /// In en, this message translates to:
  /// **'Mood over time'**
  String get insightsMoodOverTime;

  /// Legend label for the high end of the user-recorded mood chart.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get insightsMoodGood;

  /// Legend label for the middle of the user-recorded mood chart.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get insightsMoodOkay;

  /// Legend label for the low end of the user-recorded mood chart.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get insightsMoodLow;

  /// Heading and chart alternative for deliberately recorded Y-BOCS self-check totals.
  ///
  /// In en, this message translates to:
  /// **'Y-BOCS over time'**
  String get insightsYbocsOverTime;

  /// Neutral empty state for the Y-BOCS history chart. Do not imply diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Take the self-check and your recorded total will start a line here.'**
  String get insightsYbocsEmpty;

  /// Compact denominator for a recorded Y-BOCS total.
  ///
  /// In en, this message translates to:
  /// **'/40'**
  String get insightsOutOfFortyShort;

  /// Factual explanation when only one Y-BOCS self-check exists. Severity is localized.
  ///
  /// In en, this message translates to:
  /// **'{severity} range. Take the self-check again in a few weeks to add another recorded point.'**
  String insightsYbocsSingleResult(String severity);

  /// Visible Y-BOCS severity band and stable numeric range.
  ///
  /// In en, this message translates to:
  /// **'{severity} ({range})'**
  String insightsYbocsSeverityRange(String severity, String range);

  /// Comparison scope for a calculated Y-BOCS delta, hidden in Calm Insights.
  ///
  /// In en, this message translates to:
  /// **'across {count, plural, =1{1 self-check} other{{count} self-checks}}'**
  String insightsAcrossSelfChecks(int count);

  /// Clinical boundary beneath Y-BOCS history. Must not reassure, diagnose, or claim treatment outcome.
  ///
  /// In en, this message translates to:
  /// **'A snapshot, not a diagnosis. Recorded totals can move around, and one higher total does not define your progress.'**
  String get insightsYbocsBoundary;

  /// Heading and chart alternative for average user-recorded urge intensity.
  ///
  /// In en, this message translates to:
  /// **'Average urge intensity'**
  String get insightsAverageUrgeIntensity;

  /// Heading and chart alternative for factual ERP practice counts.
  ///
  /// In en, this message translates to:
  /// **'ERP practice'**
  String get insightsErpPractice;

  /// Unit displayed after the factual ERP practice count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{session} other{sessions}}'**
  String insightsSessions(int count);

  /// Calculated activity consistency heading shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get insightsConsistency;

  /// Factual active-day count beneath the optional consistency percentage.
  ///
  /// In en, this message translates to:
  /// **'{active} of {total} days'**
  String insightsActiveDays(int active, int total);

  /// Text alternative for the Insights activity heatmap.
  ///
  /// In en, this message translates to:
  /// **'Activity recorded on {active} of {total} days'**
  String insightsActivityMapSummary(int active, int total);

  /// Heading for locally derived themes in recorded OCD events.
  ///
  /// In en, this message translates to:
  /// **'Top themes'**
  String get insightsTopThemes;

  /// Neutral empty state for locally derived OCD themes.
  ///
  /// In en, this message translates to:
  /// **'Themes will appear as you record what OCD focuses on.'**
  String get insightsThemesEmpty;

  /// Text alternative for one theme progress bar.
  ///
  /// In en, this message translates to:
  /// **'{theme}, {percent} percent of recorded themes'**
  String insightsThemeShare(String theme, int percent);

  /// Tooltip and accessibility label for the Insights date-range menu.
  ///
  /// In en, this message translates to:
  /// **'Change date range'**
  String get insightsChangeRange;

  /// Insights tab showing a general overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get insightsOverviewTab;

  /// Insights tab focused on recorded obsessions.
  ///
  /// In en, this message translates to:
  /// **'Obsessions'**
  String get insightsObsessionsTab;

  /// Insights tab focused on recorded compulsions.
  ///
  /// In en, this message translates to:
  /// **'Compulsions'**
  String get insightsCompulsionsTab;

  /// Insights tab focused on ERP practice.
  ///
  /// In en, this message translates to:
  /// **'ERP'**
  String get insightsErpTab;

  /// Visible, non-colour cue for a calculated metric increase. No judgment is implied.
  ///
  /// In en, this message translates to:
  /// **'↑ {value} increase, {comparison}'**
  String insightsDeltaIncrease(String value, String comparison);

  /// Visible, non-colour cue for a calculated metric decrease. No judgment is implied.
  ///
  /// In en, this message translates to:
  /// **'↓ {value} decrease, {comparison}'**
  String insightsDeltaDecrease(String value, String comparison);

  /// Visible, non-colour cue for an unchanged calculated metric.
  ///
  /// In en, this message translates to:
  /// **'→ No change, {comparison}'**
  String insightsDeltaUnchanged(String comparison);

  /// Neutral chart empty state.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get insightsNoData;

  /// Accessible live-region label while Insights data loads.
  ///
  /// In en, this message translates to:
  /// **'Loading insights'**
  String get insightsLoading;

  /// Privacy-safe Insights load error. Do not expose technical details.
  ///
  /// In en, this message translates to:
  /// **'Your insights could not be loaded. Please try again.'**
  String get insightsLoadError;

  /// One locale-formatted date and value in an accessible chart alternative.
  ///
  /// In en, this message translates to:
  /// **'{date}: {value}'**
  String insightsChartPoint(String date, String value);

  /// Text alternative for a chart. Values contains localized point descriptions.
  ///
  /// In en, this message translates to:
  /// **'{title}. Recorded points: {values}'**
  String insightsChartSummary(String title, String values);

  /// Y-BOCS severity-band label for totals 0 to 7. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'Subclinical'**
  String get ybocsSeveritySubclinical;

  /// Y-BOCS severity-band label for totals 8 to 15. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get ybocsSeverityMild;

  /// Y-BOCS severity-band label for totals 16 to 23. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get ybocsSeverityModerate;

  /// Y-BOCS severity-band label for totals 24 to 31. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get ybocsSeveritySevere;

  /// Y-BOCS severity-band label for totals 32 to 40. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get ybocsSeverityExtreme;

  /// Localized display label for the stable contamination theme ID.
  ///
  /// In en, this message translates to:
  /// **'Contamination'**
  String get insightsThemeContamination;

  /// Localized display label for the stable harm theme ID.
  ///
  /// In en, this message translates to:
  /// **'Harm'**
  String get insightsThemeHarm;

  /// Localized display label for the stable checking theme ID.
  ///
  /// In en, this message translates to:
  /// **'Checking'**
  String get insightsThemeChecking;

  /// Localized display label for the stable reassurance theme ID.
  ///
  /// In en, this message translates to:
  /// **'Reassurance'**
  String get insightsThemeReassurance;

  /// Localized display label for the stable health theme ID.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get insightsThemeHealth;

  /// Localized display label for the stable relationship theme ID.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get insightsThemeRelationship;

  /// Localized display label for the stable symmetry theme ID.
  ///
  /// In en, this message translates to:
  /// **'Symmetry'**
  String get insightsThemeSymmetry;

  /// Localized display label for the stable moral theme ID.
  ///
  /// In en, this message translates to:
  /// **'Moral'**
  String get insightsThemeMoral;

  /// Localized display label for the stable rumination theme ID.
  ///
  /// In en, this message translates to:
  /// **'Rumination'**
  String get insightsThemeRumination;

  /// Localized display label for the stable uncertainty theme ID.
  ///
  /// In en, this message translates to:
  /// **'Uncertainty'**
  String get insightsThemeUncertainty;

  /// Fallback localized display label for an unknown stable theme ID.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get insightsThemeOther;

  /// Heading for the mobile Recovery Hub.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get recoveryTitle;

  /// Non-clinical explanation beneath the Recovery Hub heading.
  ///
  /// In en, this message translates to:
  /// **'Tools and practices, grouped by where you are in your work.'**
  String get recoverySubtitle;

  /// Heading above quick-access grounding and delay tools. Do not imply emergency medical care.
  ///
  /// In en, this message translates to:
  /// **'Support for a hard moment'**
  String get recoveryImmediateHelpTitle;

  /// Localized display title selected from a stable recovery-tool ID. OCD, ERP, and Y-BOCS terminology follows the release glossary.
  ///
  /// In en, this message translates to:
  /// **'{tool, select, emergencyToolkit{Emergency Toolkit} copingLibrary{Coping Library} compulsionDelay{Compulsion Delay} ybocsSelfCheck{OCD Self-Check} recoveryMetrics{Recovery Metrics} exposureHierarchy{Exposure Hierarchy} exposureMaterials{Exposure Materials} structuredPrograms{Structured Programs} actionPlanner{Action Planner} implementationIntentions{Implementation Intentions} guidedErp{Guided ERP} urgeSurfing{Urge Surfing} responsePrevention{Response Prevention} uncertaintyTraining{Uncertainty Training} behavioralExperiments{Behavioral Experiments} reflectionJournal{Reflection Journal} other{Recovery tool}}'**
  String recoveryToolTitle(String tool);

  /// Short, non-judgmental explanation selected from a stable recovery-tool ID. Avoid outcome or treatment claims.
  ///
  /// In en, this message translates to:
  /// **'{tool, select, emergencyToolkit{Fast grounding support.} copingLibrary{Ground and reset.} compulsionDelay{Create space before responding.} ybocsSelfCheck{A Y-BOCS check-in.} recoveryMetrics{Review recorded activity.} exposureHierarchy{Build your ladder.} exposureMaterials{Keep scripts and links.} structuredPrograms{Follow guided weeks.} actionPlanner{Plan responses.} implementationIntentions{Make if-then plans.} guidedErp{Practise a plan.} urgeSurfing{Ride the wave.} responsePrevention{Record what you did instead.} uncertaintyTraining{Practise making room for maybe.} behavioralExperiments{Test OCD’s prediction.} reflectionJournal{Capture what you noticed.} other{Open a recovery tool.}}'**
  String recoveryToolSubtitle(String tool);

  /// Recovery Hub section title selected from a stable journey-stage ID.
  ///
  /// In en, this message translates to:
  /// **'{stage, select, assess{Assess} plan{Plan} practice{Practise} review{Review} other{Tools}}'**
  String recoveryStageTitle(String stage);

  /// Calm Recovery Hub section explanation selected from a stable journey-stage ID.
  ///
  /// In en, this message translates to:
  /// **'{stage, select, assess{See where you are.} plan{Set up your practice.} practice{Do one practice.} review{Reflect and learn.} other{Choose what is useful.}}'**
  String recoveryStageSubtitle(String stage);

  /// Visible non-colour badge on a locked Recovery Hub tool.
  ///
  /// In en, this message translates to:
  /// **'Patterns Pro'**
  String get recoveryProBadge;

  /// Screen-reader hint for an available Recovery Hub tool. Title is localized.
  ///
  /// In en, this message translates to:
  /// **'Open {title}'**
  String recoveryOpenToolHint(String title);

  /// Screen-reader hint for a locked Recovery Hub tool. Title is localized.
  ///
  /// In en, this message translates to:
  /// **'{title} requires Patterns Pro'**
  String recoveryLockedToolHint(String title);

  /// Warm validation when the compulsion-delay urge field is empty.
  ///
  /// In en, this message translates to:
  /// **'Whenever you’re ready, name the urge you want to sit with.'**
  String get delayNameUrgeValidation;

  /// Warm validation when no factual compulsion-delay outcome is selected.
  ///
  /// In en, this message translates to:
  /// **'When you’re ready, choose what you ended up doing.'**
  String get delayOutcomeValidation;

  /// Privacy-safe error when a compulsion-delay record cannot be stored.
  ///
  /// In en, this message translates to:
  /// **'Your practice could not be saved. Please try again.'**
  String get delaySaveError;

  /// Title of the confirmation shown before ending a compulsion-delay timer early.
  ///
  /// In en, this message translates to:
  /// **'Stop early?'**
  String get delayStopEarlyTitle;

  /// Non-judgmental explanation for ending a compulsion-delay timer early. Do not score or praise.
  ///
  /// In en, this message translates to:
  /// **'It’s okay to stop. The time you waited can still be recorded.'**
  String get delayStopEarlyBody;

  /// Action that closes the stop confirmation and continues the timer.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get delayKeepGoingAction;

  /// Action that ends a compulsion-delay timer early without judgment.
  ///
  /// In en, this message translates to:
  /// **'I need to stop'**
  String get delayStopAction;

  /// Heading for setting up a compulsion-delay practice.
  ///
  /// In en, this message translates to:
  /// **'Pause the urge'**
  String get delaySetupTitle;

  /// Prompt for naming the urge or compulsion being delayed.
  ///
  /// In en, this message translates to:
  /// **'Which urge are you sitting with?'**
  String get delayUrgeQuestion;

  /// Examples for the compulsion-delay urge field. Do not include an ellipsis-only instruction.
  ///
  /// In en, this message translates to:
  /// **'For example: checking the lock, washing, or searching online'**
  String get delayUrgeHint;

  /// Label for a deliberately recorded pre-practice urge value.
  ///
  /// In en, this message translates to:
  /// **'How strong is the urge right now?'**
  String get delayUrgeBeforeLabel;

  /// Prompt for selecting a compulsion-delay timer length.
  ///
  /// In en, this message translates to:
  /// **'How long will you wait?'**
  String get delayDurationQuestion;

  /// Accessibility label for the compulsion-delay duration selector.
  ///
  /// In en, this message translates to:
  /// **'Delay duration'**
  String get delayDurationGroupLabel;

  /// Action that starts the compulsion-delay timer.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get delayBeginAction;

  /// Neutral heading while a compulsion-delay timer is running.
  ///
  /// In en, this message translates to:
  /// **'You’re sitting with it'**
  String get delayCountdownTitle;

  /// Non-reassuring instruction while a compulsion-delay timer runs. Do not promise that an urge will pass.
  ///
  /// In en, this message translates to:
  /// **'Notice the urge without acting. You can choose what happens next.'**
  String get delayCountdownBody;

  /// Neutral heading for the optional compulsion-delay reflection.
  ///
  /// In en, this message translates to:
  /// **'What happened?'**
  String get delayReflectionTitle;

  /// Factual timer status selected from a stable completion state. Do not praise, score, or imply success.
  ///
  /// In en, this message translates to:
  /// **'{status, select, completed{The planned time ended. The details below are optional.} early{You ended the timer early. The details below are optional.} other{The timer ended. The details below are optional.}}'**
  String delayReflectionStatus(String status);

  /// Label for a deliberately recorded post-practice urge value.
  ///
  /// In en, this message translates to:
  /// **'How strong is the urge now?'**
  String get delayUrgeAfterLabel;

  /// Prompt for the user’s factual compulsion-delay outcome.
  ///
  /// In en, this message translates to:
  /// **'What did you do with the urge?'**
  String get delayOutcomeQuestion;

  /// Accessibility label for the compulsion-delay outcome selector.
  ///
  /// In en, this message translates to:
  /// **'Recorded outcome'**
  String get delayOutcomeGroupLabel;

  /// Label for an optional user-written compulsion-delay reflection.
  ///
  /// In en, this message translates to:
  /// **'Anything you noticed? (optional)'**
  String get delayNoteLabel;

  /// Gentle hint for an optional compulsion-delay note.
  ///
  /// In en, this message translates to:
  /// **'A short note is enough.'**
  String get delayNoteHint;

  /// Disabled action label while a compulsion-delay record is being saved.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get delaySavingAction;

  /// Action that stores the compulsion-delay record before quiet completion.
  ///
  /// In en, this message translates to:
  /// **'Save practice'**
  String get delaySaveAction;

  /// Compact locale-aware minute count for a compulsion-delay duration.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 min} other{{count} min}}'**
  String delayMinutes(int count);

  /// Option for choosing a custom compulsion-delay duration.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get delayCustomAction;

  /// Heading for the custom compulsion-delay duration slider.
  ///
  /// In en, this message translates to:
  /// **'Custom delay'**
  String get delayCustomTitle;

  /// Factual display label selected from the stable compulsion-delay outcome wire value. Avoid praise or judgment.
  ///
  /// In en, this message translates to:
  /// **'{outcome, select, resisted{Did not do it} delayed{Delayed it} performed{Did it} other{Not selected}}'**
  String delayOutcome(String outcome);

  /// Accessible value for a deliberately recorded urge slider.
  ///
  /// In en, this message translates to:
  /// **'Urge {value} out of 10'**
  String delayUrgeValue(int value);

  /// Accessible value for the custom compulsion-delay duration slider.
  ///
  /// In en, this message translates to:
  /// **'Custom delay: {count, plural, =1{1 minute} other{{count} minutes}}'**
  String delayCustomMinutesValue(int count);

  /// Localized Guided ERP interface text selected from a stable UI key. Preserve OCD and ERP terminology; avoid reassurance, praise, scores, and treatment claims.
  ///
  /// In en, this message translates to:
  /// **'{key, select, outcomeValidation{When you’re ready, choose what happened during practice.} saveError{Your ERP practice could not be saved. Please try again.} stopTitle{Stop early?} stopBody{It’s okay to stop. The time you practised can still be recorded.} keepGoing{Keep going} stop{Stop} anxietyBefore{How strong is the urge or anxiety right now?} duration{Duration} start{Start practice} countdownCue{Practise without} resisting{Response you are not doing} countdownBody{You do not need to prove the prediction wrong before the timer ends.} stopEarly{Stop early} reflectionTitle{Reflect} reflectionBody{The details below are optional. Record only what feels useful.} anxietyAfter{How strong is it now?} outcomeQuestion{What did you do?} whatHappened{What actually happened?} whatHappenedHint{What did you notice during or after the practice?} learning{Learning for next time} learningHint{What do you want to remember the next time OCD asks?} exposure{Exposure} prediction{Prediction} commitment{Commitment} saving{Saving…} save{Save practice} other{ERP practice}}'**
  String erpFlowText(String key);

  /// Factual Guided ERP timer status selected from a stable completion state. Do not praise or score.
  ///
  /// In en, this message translates to:
  /// **'{status, select, completed{The planned time ended.} early{You ended the timer early.} other{The timer ended.}}'**
  String erpReflectionStatus(String status);

  /// Factual label selected from the stable ERP outcome wire value. Avoid judgment.
  ///
  /// In en, this message translates to:
  /// **'{outcome, select, resisted{Did not do the response} delayed{Delayed the response} performed{Did the response} other{Not selected}}'**
  String erpOutcome(String outcome);

  /// Accessible value for a deliberately recorded urge or anxiety slider in Guided ERP.
  ///
  /// In en, this message translates to:
  /// **'Intensity {value} out of 10'**
  String erpIntensityValue(int value);

  /// Localized Guided ERP plan and editor interface text selected from a stable UI key. Preserve OCD and ERP terminology; avoid reassurance, praise, scores, and treatment claims.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Guided ERP} subtitle{Reuse a plan, practise, and learn from the result.} myPlans{My ERP plans} newAction{New} plansError{ERP plans are unavailable right now.} recentPractice{Recent practice} historyError{Practice history is unavailable right now.} archiveTitle{Archive this plan?} archiveBody{It will leave your active plans, but past practice stays in your history.} keepAction{Keep it} archiveAction{Archive} exposureValidation{Name the situation you want to practise with, whenever you are ready.} commitmentValidation{Choose the response you want to practise resisting, and this will save.} saveError{Your ERP plan could not be saved. Please try again.} updated{ERP plan updated.} created{ERP plan created.} editTitle{Edit ERP plan} createTitle{Create ERP plan} exerciseType{Exercise type} exposureTarget{Exposure target} ocdPrediction{OCD prediction} preventionCommitment{Response-prevention commitment} defaultDuration{Default duration} saving{Saving…} saveAction{Save plan} createAction{Create plan} emptyTitle{Create your first ERP plan} emptyBody{Write the exposure, prediction, and response you want to practise once. Then reuse it whenever you need.} moreActions{More plan actions} editAction{Edit plan} archivePlanAction{Archive plan} practiceGuide{Practice guide} historyEmpty{Completed practices will appear here.} customDuration{Custom duration} other{ERP plan}}'**
  String erpPlanText(String key);

  /// Factual summary of the user-written response-prevention commitment on an ERP plan card. Preserve the user text exactly.
  ///
  /// In en, this message translates to:
  /// **'Resist: {response}'**
  String erpPlanResist(String response);

  /// Visible, non-colour representation of the user's deliberately recorded before and after ERP intensity values.
  ///
  /// In en, this message translates to:
  /// **'{before} → {after}'**
  String erpPlanRatingChange(int before, int after);

  /// Built-in prediction for the zero-configuration first-run ERP practice. Do not reassure or claim that discomfort will pass.
  ///
  /// In en, this message translates to:
  /// **'OCD says the discomfort will not change unless you respond.'**
  String get erpFirstRunPrediction;

  /// Localized ERP template title selected from a stable template ID. Requires OCD/ERP terminology review.
  ///
  /// In en, this message translates to:
  /// **'{template, select, delayChecking{Delay Checking} delayReassurance{Delay Reassurance Seeking} delayGoogling{Delay Googling} delayRumination{Delay Rumination} delayWashing{Delay Washing} other{Guided ERP}}'**
  String erpTemplateTitle(String template);

  /// Short explanation selected from a stable ERP template ID.
  ///
  /// In en, this message translates to:
  /// **'{template, select, delayChecking{Practise leaving something unchecked for a short window.} delayReassurance{Wait before asking someone to make the fear feel certain.} delayGoogling{Postpone searching for certainty or proof.} delayRumination{Notice mental problem-solving without following it.} delayWashing{Wait before washing, cleaning, or sanitising again.} other{Practise delaying a response.}}'**
  String erpTemplateSubtitle(String template);

  /// Long introduction selected from a stable ERP template ID. Avoid reassurance or outcome claims.
  ///
  /// In en, this message translates to:
  /// **'{template, select, delayChecking{Create a repeatable plan for moments when OCD pushes you to check locks, switches, messages, symptoms, or mistakes again.} delayReassurance{Create a plan for urges to ask, confess, explain, or get someone to confirm that things are okay.} delayGoogling{Create a plan for moments when OCD wants you to search symptoms, meanings, risks, rules, or stories until you feel sure.} delayRumination{Create a plan for mental compulsions like replaying, proving, reviewing, or solving.} delayWashing{Create a plan for urges to wash, clean, sanitise, or reset because something feels contaminated.} other{Create a repeatable ERP practice plan.}}'**
  String erpTemplateIntro(String template);

  /// Non-promissory rationale selected from a stable ERP template ID. Do not claim treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'{template, select, delayChecking{ERP lets you practise having uncertainty present without doing a ritual right away.} delayReassurance{Reassurance can feel helpful in the moment, but delaying it lets you practise not knowing.} delayGoogling{Postponing research interrupts the certainty loop and lets you practise leaving a question unanswered.} delayRumination{Rumination can look like thinking, but ERP practice lets you step out of the loop without finishing the argument.} delayWashing{Waiting lets you practise having a contamination feeling present without an immediate ritual.} other{ERP practice makes room for uncertainty without an immediate ritual.}}'**
  String erpTemplateWhy(String template);

  /// Plan-editor prompt selected from a stable ERP template and field key. Keep normal safety and hygiene boundaries explicit.
  ///
  /// In en, this message translates to:
  /// **'{key, select, delayCheckingExposure{What will you leave unchecked or check only once?} delayCheckingPrediction{What does OCD predict if you do not recheck?} delayCheckingCommitment{What checking ritual will you practise resisting?} delayReassuranceExposure{What reassurance do you want to ask for?} delayReassurancePrediction{What does OCD say will happen if you do not ask?} delayReassuranceCommitment{What message, confession, or question will you resist?} delayGooglingExposure{What search or question will you leave unanswered?} delayGooglingPrediction{What does OCD say you need to know right now?} delayGooglingCommitment{What search, article, or forum will you avoid?} delayRuminationExposure{What thought loop will you leave unfinished?} delayRuminationPrediction{What does OCD say you must solve or prove?} delayRuminationCommitment{What mental review or argument will you resist?} delayWashingExposure{What normal hygiene boundary will you follow?} delayWashingPrediction{What does OCD predict if you do not wash again?} delayWashingCommitment{What extra washing, cleaning, or sanitising will you resist?} other{What response will you practise resisting?}}'**
  String erpTemplatePrompt(String key);

  /// One instruction selected from a stable ERP template and step key. Do not override normal safety or hygiene.
  ///
  /// In en, this message translates to:
  /// **'{key, select, delayChecking1{Define one checking rule before you begin.} delayChecking2{Do the planned check once if it is part of normal safety.} delayChecking3{Resist rechecking while the timer runs.} delayChecking4{Notice the urge without negotiating with it.} delayReassurance1{Define the reassurance request before you begin.} delayReassurance2{Do not send the message or ask the question during the timer.} delayReassurance3{Let the discomfort be present without seeking certainty.} delayReassurance4{Return to what you were doing as gently as you can.} delayGoogling1{Define the search before opening anything else.} delayGoogling2{Close the search box or browser tab.} delayGoogling3{Start the timer before reading anything else.} delayGoogling4{Leave the question unanswered for now.} delayRumination1{Name the loop: reviewing, solving, proving, or checking.} delayRumination2{Let the thought be unfinished.} delayRumination3{Bring attention back to one ordinary task or sensation.} delayRumination4{Restart gently each time the loop pulls you back.} delayWashing1{Define the normal hygiene boundary before starting.} delayWashing2{Start with a delay that feels challenging but possible.} delayWashing3{Keep your hands away from the sink or sanitiser during the timer.} delayWashing4{Let the discomfort be present without trying to make it perfect.} other{Follow the plan you chose.}}'**
  String erpTemplateInstruction(String key);

  /// Compact cue selected from a stable ERP template and cue key.
  ///
  /// In en, this message translates to:
  /// **'{key, select, delayChecking1{Check once} delayChecking2{No rechecking} delayChecking3{Notice the urge} delayReassurance1{Hold the ask} delayReassurance2{Let uncertainty stay} delayReassurance3{Return gently} delayGoogling1{Close search} delayGoogling2{Start timer} delayGoogling3{Leave it unanswered} delayRumination1{Name the loop} delayRumination2{Leave unfinished} delayRumination3{Return to task} delayWashing1{Set a boundary} delayWashing2{Delay washing} delayWashing3{Allow discomfort} other{Follow the plan}}'**
  String erpTemplateCue(String key);

  /// Structured Programs interface copy selected from a stable UI key. Avoid praise, streak language, treatment claims, or recommendations.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Structured Programs} subtitle{Follow a guided, week-by-week plan at your own pace.} themeGroup{By OCD theme} themeGroupEmpty{Choose a theme if it fits what you want to practise.} themeGroupMatched{Themes recorded in your last self-check are labelled below.} generalGroup{General practice} generalCaption{Skills that can be used across themes.} enrollError{This program could not be opened. Please try again.} started{Started} notStarted{Not started} openHint{Open program details} selfCheckMatch{Matches your self-check} tapToStart{Tap to start} progressLoadError{Program activity could not be loaded. Please try again.} activityRecorded{Your task choices are recorded locally.} taskSaveError{This task change could not be saved. Please try again.} weekComplete{All tasks marked complete} weekNotComplete{Tasks remain} weekToggleHint{Expand or collapse this week} taskToggleHint{Mark or unmark this task} other{Program}}'**
  String structuredProgramText(String key);

  /// Accessible calculated program progress shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} tasks, {percent} percent'**
  String structuredProgramProgress(int done, int total, int percent);

  /// Factual number of weeks followed by a localized program subtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 week · {subtitle}} other{{count} weeks · {subtitle}}}'**
  String structuredProgramSummary(int count, String subtitle);

  /// Factual program completion state. Do not praise, celebrate, score, or imply treatment progress.
  ///
  /// In en, this message translates to:
  /// **'All {count, plural, =1{1 task is} other{{count} tasks are}} marked complete.'**
  String structuredProgramComplete(int count);

  /// Calculated task progress shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} tasks marked complete'**
  String structuredProgramTaskProgress(int done, int total);

  /// Compact calculated week progress shown only when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total}'**
  String structuredProgramCompactProgress(int done, int total);

  /// Exposure hierarchy mobile UI copy. Keep it factual and self-directed; do not imply prescribed treatment order, completion pressure, or outcomes.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Exposure Hierarchy} newAction{New} subtitle{Build a ladder of exposures and practise one step at a time.} loadError{Your hierarchies are unavailable right now. Please try again.} archiveTitle{Archive this hierarchy?} archiveBody{This removes the hierarchy from your active list. Its saved steps remain on this device.} keepAction{Keep it} archiveAction{Archive} archiveSuccess{Hierarchy archived.} archiveError{This hierarchy could not be archived. Please try again.} emptyTitle{Start your first ladder} emptyBody{List possible exposures from easier to harder and choose your own pace.} buildAction{Build a hierarchy} newTitle{New hierarchy} nameLabel{Name} nameHint{For example, touching door handles} themeLabel{Theme (optional)} themeHint{For example, contamination} generalTheme{General} stepsTitle{Steps, easier first} addAction{Add} createAction{Create hierarchy} saving{Saving…} titleValidation{Add a name for this ladder.} stepValidation{Add at least one exposure step.} createSuccess{Hierarchy saved.} createError{This hierarchy could not be saved. Please try again.} stepHint{What exposure could you practise?} difficulty{Difficulty} anxiety{Anticipated anxiety} materialAction{Material} statusNotStarted{Not started} statusInProgress{In progress} statusDone{Done} statusError{This step status could not be saved. Please try again.} moveUp{Move step up} moveDown{Move step down} removeStep{Remove step} openHierarchy{Open hierarchy} archiveHierarchy{Archive hierarchy} other{Exposure hierarchy}}'**
  String exposureHierarchyText(String key);

  /// Factual saved-step summary for one hierarchy. Theme is user-entered and must remain unchanged.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{{theme}} =1{{done} of 1 step · {theme}} other{{done} of {count} steps · {theme}}}'**
  String exposureHierarchySummary(int done, int count, String theme);

  /// Visible and accessible one-based exposure step number.
  ///
  /// In en, this message translates to:
  /// **'Step {number}'**
  String exposureStepLabel(int number);

  /// Accessible exposure difficulty or anticipated-anxiety rating.
  ///
  /// In en, this message translates to:
  /// **'{value} of 10'**
  String exposureRating(int value);

  /// Accessible and visible factual ratings saved for an exposure step.
  ///
  /// In en, this message translates to:
  /// **'Difficulty {difficulty} of 10 · Anticipated anxiety {anxiety} of 10'**
  String exposureStepMetrics(int difficulty, int anxiety);

  /// Text alternative for an exposure hierarchy progress ring. Calculated progress is factual and carries no praise.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of steps marked done'**
  String exposureProgress(int percent);

  /// Exposure-material library/editor copy. Local files and user-entered titles, scripts, and links must remain private and unchanged.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Exposure Materials} newAction{New} subtitle{Keep your scripts, loop recordings, images, and links together for use during an exposure.} loadError{Your materials are unavailable right now. Please try again.} typeScript{Script} typeLoopTape{Loop recording} typeImage{Image} typeLink{Link} deleteTitle{Delete this material?} deleteBody{This removes the material from this device, including its stored file if present.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete material} deleteSuccess{Material deleted.} deleteError{This material could not be deleted. Please try again.} emptyTitle{Gather your materials} emptyBody{Save a script, loop recording, image, or link for an exposure you choose.} addAction{Add a material} readScript{Read script} openLink{Open link} viewImage{View image} linkError{That link could not be opened.} imageMissing{This image is no longer available on this device.} recordingMissing{This recording is no longer available on this device.} stop{Stop} playLoop{Play loop} microphoneNeeded{Microphone access is needed to record a loop. You can change this in device settings.} nameValidation{Add a name for this material.} scriptValidation{Add the script text.} linkValidation{Paste a link.} imageValidation{Choose an image.} recordingValidation{Record a loop before saving.} saveSuccess{Material saved.} saveError{This material could not be saved. Please try again.} titleLabel{Title} titleHint{A short name you will recognise} saveAction{Save material} scriptLabel{Script} scriptHint{The text you want to read during the exposure} linkLabel{Link} pickImage{Choose image} changeImage{Change image} rerecord{Record again} recorderHint{Record a short clip to replay in a loop.} record{Record} recording{Recording} other{Exposure material}}'**
  String exposureMaterialsText(String key);

  /// Title for creating a material. Type is already localized.
  ///
  /// In en, this message translates to:
  /// **'New {type}'**
  String exposureMaterialEditorTitle(String type);

  /// Accessible elapsed time while recording a local loop clip.
  ///
  /// In en, this message translates to:
  /// **'Recording · {seconds} s'**
  String exposureRecordingSeconds(int seconds);

  /// Response-prevention log interface copy. Keep outcomes factual and non-judgmental; do not praise resistance, shame a performed response, or promise progress.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Response Prevention} logAction{Log} subtitle{Record the trigger, the response you chose, and your distress at that time.} loadError{Your response logs are unavailable right now. Please try again.} deleteTitle{Delete this response log?} deleteBody{This permanently removes the log from this device.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete response log} deleteSuccess{Response log deleted.} deleteError{This response log could not be deleted. Please try again.} outcomeResisted{Not performed} outcomeDelayed{Delayed} outcomePartial{Partly performed} outcomePerformed{Performed} emptyTitle{Record a response} emptyBody{After a trigger, record what you chose and the distress you noticed.} emptyAction{Log a response} editorTitle{Log a response} situationLabel{What set it off?} situationHint{The trigger and the response OCD prompted} outcomeQuestion{What did you do?} distressLabel{Distress at the time} noteLabel{Note (optional)} noteHint{Anything you want to remember} saveAction{Save log} situationValidation{Add a brief description of the trigger.} saveSuccess{Response log saved.} saveError{This response log could not be saved. Please try again.} other{Response prevention}}'**
  String responsePreventionText(String key);

  /// Visible and accessible deliberately recorded distress rating in a response-prevention log.
  ///
  /// In en, this message translates to:
  /// **'Distress {value} of 10'**
  String responsePreventionDistress(int value);

  /// Accessible summary of a saved response-prevention log. Outcome and date are already localized; situation is unchanged user text.
  ///
  /// In en, this message translates to:
  /// **'{outcome} · {date} · distress {distress} of 10 · {situation}'**
  String responsePreventionLogSummary(
    String outcome,
    String date,
    int distress,
    String situation,
  );

  /// Urge-surfing interface copy. Keep it optional, factual, and non-reassuring; never promise that an urge will fall, pass, or become easier.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Urge Surfing} subtitle{Observe an urge for a chosen amount of time without needing to change it or act on it.} startAction{Start a surf} historyTitle{Past surfs} emptyHistory{No saved surfs yet. A recorded surf will appear here.} loadError{Your saved surfs are unavailable right now. Please try again.} triggerFallback{An urge} setupTitle{Before you surf} triggerLabel{What is the urge? (optional)} triggerHint{For example, the urge to wash my hands again} initialUrgeLabel{Urge at the start} durationQuestion{How long would you like to observe it?} begin{Begin} surfingTitle{Observe the urge} surfingBody{Notice thoughts and sensations, and choose what you do next. You can stop at any time.} currentUrgeLabel{Urge right now} doneAction{Done for now} reflectionTitle{Record what you noticed} waveTitle{Recorded urge levels} finalUrgeLabel{Urge at the end} noteLabel{Note (optional)} noteHint{What did you notice?} saveAction{Save surf} finishAction{Finish} saveSuccess{Surf record saved.} finishSuccess{Practice finished.} saveError{This surf could not be saved. Please try again.} timerComplete{Observation timer complete.} other{Urge surfing}}'**
  String urgeSurfText(String key);

  /// Visible and accessible deliberately recorded urge rating.
  ///
  /// In en, this message translates to:
  /// **'Urge {value} of 10'**
  String urgeSurfRating(int value);

  /// Localized urge-surf duration choice or history duration.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{1 minute} other{{minutes} minutes}}'**
  String urgeSurfDuration(int minutes);

  /// Factual elapsed duration for a saved urge-surf session.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min {seconds} sec'**
  String urgeSurfRecordedDuration(int minutes, int seconds);

  /// Factual accessible summary of deliberately recorded urge levels and duration. Duration is already localized.
  ///
  /// In en, this message translates to:
  /// **'Started at {initial} of 10 · highest recorded {peak} of 10 · ended at {finalLevel} of 10 · {duration}'**
  String urgeSurfHistorySummary(
    int initial,
    int peak,
    int finalLevel,
    String duration,
  );

  /// Accessible saved-session card combining unchanged user trigger text with already-localized date and factual rating summary.
  ///
  /// In en, this message translates to:
  /// **'{trigger} · {date} · {summary}'**
  String urgeSurfSessionSemantics(String trigger, String date, String summary);

  /// Factual summary shown after an urge-surf timer; do not infer improvement.
  ///
  /// In en, this message translates to:
  /// **'Started at {initial} of 10 · highest recorded {peak} of 10'**
  String urgeSurfWaveSummary(int initial, int peak);

  /// Compact countdown display. Seconds is pre-padded to two ASCII digits for timer readability.
  ///
  /// In en, this message translates to:
  /// **'{minutes}:{seconds}'**
  String urgeSurfTimerDisplay(int minutes, String seconds);

  /// Accessible countdown value. It is not a live region and should not be announced every second.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min {seconds} sec remaining'**
  String urgeSurfTimeRemaining(int minutes, int seconds);

  /// Immediate self-help and paced-breathing copy. Never promise safety, symptom relief, urge disappearance, or replace emergency or clinical care.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Support right now} pauseTitle{Pause before responding} pauseBody{You do not have to respond to the urge immediately. Choose one self-help exercise below and take it slowly.} boundary{These tools do not provide emergency or clinical care. If you may be in immediate danger, contact local emergency services.} breathe{Breathe} breatheSubtitle{Follow a paced breathing cycle} delay{Delay the urge} delaySubtitle{Make space with a timer} surf{Surf the urge} surfSubtitle{Notice the urge without acting on it} coping{Coping techniques} copingSubtitle{Grounding, acceptance, and more} remindersTitle{A few reminders} reminderThought{A thought does not require a response. I can notice it without acting.} reminderUrge{An urge may change over time. I can choose what I do next.} reminderUncertainty{I can make room for uncertainty in this moment.} breatheIn{Breathe in} hold{Hold} breatheOut{Breathe out} breathingHint{Follow the circle: breathe in for 4 seconds, hold, breathe out for 4 seconds, then hold.} other{Support tool}}'**
  String emergencyToolkitText(String key);

  /// Y-BOCS mobile flow copy selected from a stable UI key. Keep the flow factual, non-diagnostic, non-reassuring, and explicit about local storage and emergency boundaries.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{OCD Self-Check} introBody{A guided self-check based on the Yale-Brown Obsessive Compulsive Scale (Y-BOCS), covering the patterns you notice and how much they affect you.} spotTitle{Notice the patterns} spotBody{Select obsessions and compulsions you have experienced.} impactTitle{Record the impact} impactBody{Answer 10 questions about how much they affect your day.} resultIntroTitle{Review the result} resultIntroBody{See the recorded themes, subtotals, and severity range.} begin{Begin} retakeAction{Take it again} privacyDuration{Takes about 10 minutes. Your answers stay on this device unless you choose to export them.} disclaimer{This self-check can help you describe your experience. It does not diagnose OCD and is not emergency support. Only a qualified professional can diagnose OCD.} historyTitle{Your history} historyBody{Your previous recorded totals appear here.} deleteTitle{Delete assessment?} deleteBody{This permanently removes this assessment from this device.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete assessment} deleteSuccess{Assessment deleted.} deleteError{This assessment could not be deleted. Please try again.} checklistTitle{What feels familiar?} checklistBody{Select anything you have experienced, now or in the past. Skip what does not fit.} obsessions{Obsessions} obsessionsDescription{Unwanted thoughts, images, or urges} compulsions{Compulsions} compulsionsDescription{Behaviours or mental acts performed in response to distress} continueAction{Continue} seeResults{See results} next{Next} resultsTitle{Your result} retake{Retake} saved{Saved} saveHistory{Save to my history} saving{Saving…} saveSuccess{Saved to your history.} saveError{This assessment could not be saved. Please try again.} breakdownTitle{Recorded subtotals} typesTitle{Types recorded} typesNone{No obsession or compulsion type was recorded in this self-check.} typesBoth{Both obsessions and compulsions were recorded in this self-check.} typesObsessions{Obsessions were recorded in this self-check.} typesCompulsions{Compulsions were recorded in this self-check.} themesTitle{Themes recorded} themesBody{The checklist categories containing the items you selected.} nextStepsTitle{About this result} nextStepsBody{This result is a self-reported snapshot, not a diagnosis or emergency support. If these patterns affect your life, you can discuss them with a qualified professional. If you may be in immediate danger, contact local emergency services.} other{Y-BOCS self-check}}'**
  String ybocsText(String key);

  /// Checklist continue action with the number of selected symptom items.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Continue} =1{Continue · 1 selected} other{Continue · {count} selected}}'**
  String ybocsSelectedCount(int count);

  /// Visible and accessible progress through the ten Y-BOCS severity questions.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String ybocsQuestionProgress(int current, int total);

  /// Accessible Y-BOCS total or subtotal with its maximum value.
  ///
  /// In en, this message translates to:
  /// **'{score} of {maximum}'**
  String ybocsScoreOutOf(int score, int maximum);

  /// Accessible summary of one saved Y-BOCS assessment. Severity and date are already localized.
  ///
  /// In en, this message translates to:
  /// **'{severity} · {score} of 40 · {date}'**
  String ybocsHistorySummary(String severity, int score, String date);

  /// Accessible result-card summary containing a localized severity, score, and non-diagnostic explanation.
  ///
  /// In en, this message translates to:
  /// **'{severity} · {score} · {description}'**
  String ybocsSeveritySummary(
    String severity,
    String score,
    String description,
  );

  /// Accessible alternative for a visual Y-BOCS subtotal bar.
  ///
  /// In en, this message translates to:
  /// **'{label} · {score}'**
  String ybocsSubtotalSummary(String label, String score);

  /// Accessible selected-item count for one Y-BOCS checklist category.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item selected} other{{count} items selected}}'**
  String ybocsCategorySelectedCount(int count);

  /// Factual accessibility announcement after a program task change is saved.
  ///
  /// In en, this message translates to:
  /// **'{status, select, completed{Task marked complete.} notCompleted{Task marked incomplete.} other{Task updated.}}'**
  String structuredProgramTaskChanged(String status);

  /// Localized program title selected from a stable program ID.
  ///
  /// In en, this message translates to:
  /// **'{program, select, delay4wk{4-Week Compulsion Delay} uncertainty3wk{Uncertainty Tolerance} other{Structured Program}}'**
  String structuredProgramTitle(String program);

  /// Non-promissory program subtitle selected from a stable program ID.
  ///
  /// In en, this message translates to:
  /// **'{program, select, delay4wk{Practise delaying compulsions, one week at a time} uncertainty3wk{Practise living with not knowing} other{A guided practice plan}}'**
  String structuredProgramSubtitle(String program);

  /// Localized week title selected from a stable general-program week ID.
  ///
  /// In en, this message translates to:
  /// **'{week, select, delayW1{Week 1 · Notice and name} delayW2{Week 2 · Stretch the gap} delayW3{Week 3 · Sit longer} delayW4{Week 4 · Daily practice} uncertaintyW1{Week 1 · Leave it open} uncertaintyW2{Week 2 · Maybe, maybe not} uncertaintyW3{Week 3 · Let it be} other{Program week}}'**
  String structuredProgramWeek(String week);

  /// Localized task selected from a stable general-program task ID. Do not promise symptom change or treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'{task, select, w1a{Record 3 urges without acting immediately} w1b{Delay one compulsion by 1 minute, 3 times} w2a{Delay compulsions by 5 minutes} w2b{Try urge surfing once} w3a{Delay by 15 minutes} w3b{Resist one reassurance-seeking urge} w4a{Complete one exposure each day} w4b{Reflect on what you noticed} u1a{Leave one question unanswered} u1b{Resist checking once} u2a{Use a “maybe, maybe not” response 3 times} u2b{Delay searching online about a worry} u3a{Go a day without seeking certainty} u3b{Reflect on what you noticed} other{Program task}}'**
  String structuredProgramTask(String task);

  /// Localized OCD track title selected from a stable track ID. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'{track, select, contamination{Contamination and washing} checking{Checking and doubt} harm{Harm and taboo thoughts} relationship{Relationship doubt} justRight{Just right and symmetry} other{OCD theme}}'**
  String ocdTrackTitle(String track);

  /// Neutral OCD track explanation selected from a stable track ID. Do not reassure, diagnose, or imply intent from intrusive thoughts.
  ///
  /// In en, this message translates to:
  /// **'{track, select, contamination{For fears that something is dirty, contagious, or unsafe to touch, and the washing or cleaning that follows.} checking{For locks, hobs, switches, messages, and other things you return to because doing them does not feel certain enough.} harm{For intrusive thoughts about harm or themes that feel violent, sexual, or blasphemous, and the compulsions or avoidance that follow.} relationship{For recurring doubts about whether a relationship is right, whether you feel enough, or what the doubt means.} justRight{For things that feel as though they must be even, ordered, or repeated until they feel right.} other{A practice track organised around an OCD theme.}}'**
  String ocdTrackBlurb(String track);

  /// Localized theme label selected from a stable track ID and used to prefill a new user-editable hierarchy.
  ///
  /// In en, this message translates to:
  /// **'{track, select, contamination{Contamination} checking{Checking} harm{Harm and taboo thoughts} relationship{Relationship doubt} justRight{Just right} other{OCD theme}}'**
  String ocdTrackTheme(String track);

  /// Factual explanation for a track without a corresponding Y-BOCS checklist category. Do not claim clinical validation.
  ///
  /// In en, this message translates to:
  /// **'{track, select, relationship{The Y-BOCS checklist predates research on relationship OCD, so this theme is not one of its categories. You can still use this practice track.} other{This theme is not represented as a Y-BOCS checklist category.}}'**
  String ocdTrackChecklistNote(String track);

  /// Localized week title selected from a stable OCD-track week ID.
  ///
  /// In en, this message translates to:
  /// **'{week, select, ct1{Week 1 · Touch, then wait} ct2{Week 2 · One wash, not three} ct3{Week 3 · Carry it home} ck1{Week 1 · Look once} ck2{Week 2 · No mental replay} ck3{Week 3 · Leave it unresolved} hm1{Week 1 · Let it be there} hm2{Week 2 · Stop asking} hm3{Week 3 · No inner court case} rl1{Week 1 · Stop testing} rl2{Week 2 · No reassurance} rl3{Week 3 · Live with maybe} jr1{Week 1 · Leave it crooked} jr2{Week 2 · No repeating} jr3{Week 3 · Good enough} other{Track week}}'**
  String ocdTrackWeek(String week);

  /// Localized ERP task selected from a stable OCD-track task ID. Do not promise discomfort reduction, override normal safety/hygiene, reassure, or imply treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'{task, select, ct1a{Touch something that feels slightly unclean and leave your hands unwashed for five minutes} ct1b{Record the urge before and after without washing} ct2a{Wash once, normally, and do not return for a second round} ct2b{Leave one surface at home uncleaned for the week} ct3a{Go somewhere that usually prompts washing afterwards and do not wash when you get in} ct3b{Write down what OCD predicted next to what happened} ck1a{Check one thing once, then walk away without a second look} ck1b{Leave the house once without a final sweep of the rooms} ck2a{When the urge to replay the memory arrives, leave the doubt unresolved} ck2b{Send one message without rereading it before or after} ck3a{Go a day without returning to check anything twice} ck3b{Note what happened and what OCD predicted} hm1a{Let one intrusive thought stay for a minute without arguing with it or pushing it away} hm1b{Notice the mental review before it starts and leave it alone} hm2a{Resist asking whether you are a good person and do not search for an answer either} hm2b{Stay in a situation you have been avoiding because of the thought} hm3a{Go a day without checking your feelings for evidence about yourself} hm3b{Write down what the week was like without grading yourself} rl1a{Notice one compatibility test you use and skip it once} rl1b{Leave a relationship doubt unanswered for ten minutes} rl2a{Go a day without asking your partner, a friend, or the internet whether the relationship is right} rl2b{Do something together without monitoring how you feel during it} rl3a{Use a “maybe, maybe not” response when the question arrives} rl3b{Reflect on the week without making a decision about the future} jr1a{Leave one object slightly out of place and let the feeling be present} jr1b{Do one thing once even though it did not feel finished} jr2a{Resist repeating an action to make it feel right} jr2b{Write something without returning to make the wording feel even} jr3a{Go through a day leaving several things deliberately unfinished} jr3b{Record what happened to the not-right feeling without changing it} other{Track task}}'**
  String ocdTrackTask(String task);

  /// First-person Y-BOCS severity prompt selected from its stable question ID. Requires clinical review and must remain non-diagnostic.
  ///
  /// In en, this message translates to:
  /// **'{question, select, o_time{How much of my time is taken up by obsessive thoughts?} o_interfere{How much do the obsessions get in the way of my life?} o_distress{How much distress do the obsessive thoughts cause me?} o_resist{How hard do I try to resist the obsessive thoughts?} o_control{How much control do I have over the obsessive thoughts?} c_time{How much time do I spend on compulsions, such as rituals or checking?} c_interfere{How much do the compulsions get in the way of my life?} c_distress{How anxious or upset would I feel if I could not do the compulsion?} c_resist{How hard do I try to resist the compulsions?} c_control{How much control do I have over the compulsions?} other{Self-check question}}'**
  String ybocsQuestionPrompt(String question);

  /// Y-BOCS response anchor selected from a stable question ID plus its unchanged zero-to-four score. Requires clinical review.
  ///
  /// In en, this message translates to:
  /// **'{option, select, o_time_0{None at all} o_time_1{A little: less than an hour a day, or a few now and then} o_time_2{A moderate amount: 1 to 3 hours a day, or frequent intrusions} o_time_3{A lot: 3 to 8 hours a day, or very frequent intrusions} o_time_4{Almost constant: more than 8 hours a day} o_interfere_0{Not at all} o_interfere_1{A little: they do not really affect what I do} o_interfere_2{Some: they interfere but I can still manage} o_interfere_3{A lot: they clearly get in the way of my day} o_interfere_4{So much that I can barely function} o_distress_0{None} o_distress_1{A little: not too disturbing} o_distress_2{A moderate amount: disturbing but manageable} o_distress_3{A lot: very disturbing} o_distress_4{Nearly constant, disabling distress} o_resist_0{I always try to resist, or they barely happen} o_resist_1{I try to resist most of the time} o_resist_2{I make some effort to resist} o_resist_3{I give in to almost all of them without much of a fight} o_resist_4{I completely give in to them, willingly} o_control_0{Full control: I can dismiss them easily} o_control_1{A lot of control: usually I can stop or divert them} o_control_2{Some control: sometimes I can, sometimes I cannot} o_control_3{Little control: I rarely manage to stop them} o_control_4{No control: they feel completely involuntary} c_time_0{None at all} c_time_1{A little: less than an hour a day, or a few now and then} c_time_2{A moderate amount: 1 to 3 hours a day, or frequent rituals} c_time_3{A lot: 3 to 8 hours a day, or very frequent rituals} c_time_4{Almost constant: more than 8 hours a day} c_interfere_0{Not at all} c_interfere_1{A little: they do not really affect what I do} c_interfere_2{Some: they interfere but I can still manage} c_interfere_3{A lot: they clearly get in the way of my day} c_interfere_4{So much that I can barely function} c_distress_0{Not at all} c_distress_1{A little uneasy} c_distress_2{Moderately anxious} c_distress_3{Very anxious} c_distress_4{Overwhelmed, disabling anxiety} c_resist_0{I always try to resist, or they barely happen} c_resist_1{I try to resist most of the time} c_resist_2{I make some effort to resist} c_resist_3{I give in to almost all of them without much of a fight} c_resist_4{I completely give in to them, willingly} c_control_0{Full control: I can stop myself easily} c_control_1{A lot of control: usually I can stop or delay} c_control_2{Some control: sometimes I can, sometimes I cannot} c_control_3{Little control: I can rarely stop or delay} c_control_4{No control: I have to complete them} other{Response option}}'**
  String ybocsQuestionOption(String option);

  /// Y-BOCS symptom category selected from the stable stored category ID. Requires clinical terminology review.
  ///
  /// In en, this message translates to:
  /// **'{category, select, aggressive{Aggressive or harm-related} contamination{Contamination} sexual{Sexual} hoarding_obs{Hoarding or saving} religious{Religious or moral scrupulosity} symmetry_obs{Symmetry or exactness} somatic{Body or illness} misc_obs{Other obsessions} washing{Washing or cleaning} checking{Checking} repeating{Repeating rituals} counting{Counting} ordering{Ordering or arranging} misc_comp{Other compulsions} other{Other theme}}'**
  String ybocsCategoryTitle(String category);

  /// First-person Y-BOCS symptom checklist item selected from its stable stored ID. Requires clinical and safety review; never imply desire or intent from an intrusive thought.
  ///
  /// In en, this message translates to:
  /// **'{symptom, select, agg_harm_self{Fear I might harm myself} agg_harm_others{Fear I might harm someone else} agg_violent{Violent or horrific images in my mind} agg_blurt{Fear I will blurt out insults or obscenities} agg_impulse{Fear I will act on an unwanted impulse} agg_responsible{Fear I will be responsible for something terrible happening} con_dirt{Concern with dirt or germs} con_bodily{Disgust with bodily waste or secretions} con_chemicals{Concern about household chemicals or cleaners} con_ill{Fear I will get ill from contamination} con_spread{Fear I will spread contamination to others} con_sticky{Bothered by sticky substances or residues} sex_forbidden{Forbidden or unwanted sexual thoughts or images} sex_others{Sexual thoughts involving others that disturb me} sex_orientation{Unwanted doubts about my sexual orientation} sex_aggressive{Aggressive sexual thoughts toward others} hoard_discard{Fear of throwing away something I might need} hoard_value{Feeling objects have value I cannot let go of} rel_sacrilege{Concern with sacrilege or blasphemy} rel_rightwrong{Excessive concern with right and wrong, or morality} rel_punish{Fear of punishment by God or fate} sym_even{Need things even, balanced, or “just right”} sym_exact{Need for exactness, order, or precision} sym_incomplete{A feeling of incompleteness until things feel right} som_illness{Excessive concern with illness or disease} som_body{Excessive concern with a body part or appearance} misc_know{Need to know or remember things} misc_saywrong{Fear of saying the wrong thing} misc_lucky{Lucky or unlucky numbers, words, or colours} misc_sounds{Intrusive sounds, words, or music I cannot stop} misc_lose{Fear of losing things} wash_hands{Excessive or ritualised hand-washing} wash_shower{Excessive showering, bathing, or grooming} wash_clean{Excessive cleaning of household items} wash_avoid{Avoiding things I see as contaminated} chk_locks{Checking locks, appliances, taps, or the stove} chk_harm{Checking I did not or will not harm someone} chk_mistake{Checking I did not make a mistake} chk_body{Checking my body for signs of illness} rep_reread{Re-reading or re-writing} rep_routine{Repeating routine actions, such as going through doors or going up and down} rep_untilright{Repeating until it feels “just right”} cnt_count{Counting objects, steps, or actions} cnt_numbers{Doing things a certain number of times} ord_arrange{Arranging things until they are symmetrical or exact} ord_align{Aligning or straightening objects repeatedly} mc_mental{Mental rituals, such as silent prayers, phrases, or reviewing} mc_reassure{Repeatedly asking for reassurance or confessing} mc_touch{Needing to touch, tap, or rub things} mc_lists{Excessive list-making} mc_avoid{Avoiding situations to prevent an urge} other{Other symptom}}'**
  String ybocsSymptomLabel(String symptom);

  /// Non-diagnostic explanation selected from the saved Y-BOCS severity enum. Do not reassure, diagnose, claim outcomes, or invent regional emergency numbers.
  ///
  /// In en, this message translates to:
  /// **'{severity, select, subclinical{This total falls in the subclinical Y-BOCS range. The result is a snapshot, not a diagnosis.} mild{This total falls in the mild Y-BOCS range. The result is a snapshot, not a diagnosis.} moderate{This total falls in the moderate Y-BOCS range. The result is a snapshot, not a diagnosis.} severe{This total falls in the severe Y-BOCS range. Consider discussing the impact with a qualified professional.} extreme{This total falls in the extreme Y-BOCS range. Consider contacting a qualified professional for support. If you may be in immediate danger, contact local emergency services.} other{This recorded total is a snapshot, not a diagnosis.}}'**
  String ybocsSeverityBlurb(String severity);

  /// Behavioral Experiments interface copy selected from a stable UI key. Preserve OCD terminology and user text; avoid reassurance, praise, scores, and claims that a prediction was disproved.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Behavioral Experiments} newAction{New} subtitle{Compare an OCD prediction with what you observe after a planned action.} loadError{Your experiments are unavailable right now. Please try again.} deleteTitle{Delete this experiment?} deleteBody{This permanently removes the experiment from this device.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete experiment} deleteSuccess{Experiment deleted.} deleteError{This experiment could not be deleted. Please try again.} statusPlanned{Planned} statusCompleted{Completed} outcomeLabel{What happened} learningLabel{What I noted} recordAction{Record what happened} emptyTitle{Plan a behavioral experiment} emptyBody{Write down OCD’s prediction, choose a small action, and later record what you observed.} emptyAction{New experiment} outcomeEditorTitle{Record what happened} newEditorTitle{New experiment} predictedLabel{OCD predicted} testActionLabel{Planned action} outcomeInputLabel{What actually happened?} outcomeInputHint{Record what you observed, without grading the result} learningInputLabel{Anything you want to note? (optional)} learningInputHint{A detail you may want to remember} predictionInputLabel{What does OCD predict?} predictionInputHint{For example: If I do not check again, the house will flood} confidenceQuestion{How certain does the prediction feel?} experimentInputLabel{What action will test the prediction?} experimentInputHint{For example: Leave after one normal check and observe what happens} saveOutcome{Save observation} saveExperiment{Save experiment} outcomeValidation{Add a short note about what you observed.} planValidation{Add both OCD’s prediction and the action you plan to take.} outcomeSaveSuccess{Observation saved.} planSaveSuccess{Experiment saved. Record what happened after you try it.} saveError{This experiment could not be saved. Your text is still here. Please try again.} other{Behavioral experiment}}'**
  String behavioralExperimentText(String key);

  /// Locale-formatted, deliberately recorded confidence value. Percent already includes the locale-appropriate percent sign.
  ///
  /// In en, this message translates to:
  /// **'{percent} certain'**
  String behavioralExperimentConfidence(String percent);

  /// Accessible factual summary of a behavioral experiment. Prediction and experiment are user-authored and must remain unchanged.
  ///
  /// In en, this message translates to:
  /// **'{status} · {date} · {confidence}. Prediction: {prediction}. Planned action: {experiment}.'**
  String behavioralExperimentCardSummary(
    String status,
    String date,
    String confidence,
    String prediction,
    String experiment,
  );

  /// Exposure Reflection interface copy selected from a stable UI key. Preserve all user-authored text; avoid reassurance, judgment, treatment claims, or claiming that an OCD prediction was wrong.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Exposure Reflections} newAction{New} subtitle{Record what you noticed after an exposure. Add only the details that feel useful.} loadError{Your reflections are unavailable right now. Please try again.} deleteTitle{Delete this reflection?} deleteBody{This permanently removes the reflection from this device.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete reflection} deleteSuccess{Reflection deleted.} deleteError{This reflection could not be deleted. Please try again.} emptyTitle{Reflect on an exposure} emptyBody{Record what happened, what OCD predicted, and anything you want to remember. Only the first prompt is required.} emptyAction{New reflection} editorTitle{New reflection} whatHappenedLabel{What happened?} whatHappenedHint{The exposure or practice you did} predictionLabel{What did OCD predict?} predictionHint{The outcome OCD said might happen} actualLabel{What did you observe?} actualHint{What happened during or after the exposure} learningLabel{Anything you want to remember? (optional)} learningHint{A detail that may be useful later} nextTimeLabel{Anything you might change? (optional)} nextTimeHint{Leave this blank if nothing comes to mind} saveAction{Save reflection} validation{Start with a short note about what happened. The remaining prompts are optional.} saveSuccess{Reflection saved.} saveError{This reflection could not be saved. Your text is still here. Please try again.} other{Exposure reflection}}'**
  String exposureReflectionText(String key);

  /// Accessible factual summary of an exposure reflection. The event text is user-authored and must remain unchanged.
  ///
  /// In en, this message translates to:
  /// **'{date}. What happened: {whatHappened}.'**
  String exposureReflectionCardSummary(String date, String whatHappened);

  /// Implementation Intentions interface copy selected from a stable UI key. Keep the feature factual and optional; preserve user-authored text and avoid promises that a response will become automatic or easier.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{If–Then Plans} newAction{New} subtitle{Pair a situation with a response you want to try when it happens.} loadError{Your if–then plans are unavailable right now. Please try again.} deleteTitle{Delete this if–then plan?} deleteBody{This permanently removes the plan from this device.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete if–then plan} deleteSuccess{If–then plan deleted.} deleteError{This if–then plan could not be deleted. Please try again.} emptyTitle{Create an if–then plan} emptyBody{Write a situation and the response you want to try when it happens.} emptyAction{New if–then plan} editorTitle{New if–then plan} triggerLabel{If…} triggerHint{The situation, for example: I notice the urge to seek reassurance} responseLabel{then I will…} responseHint{The response you want to try, for example: write down what I am noticing} saveAction{Save if–then plan} validation{Add both the situation and the response you want to try.} saveSuccess{If–then plan saved.} saveError{This if–then plan could not be saved. Your text is still here. Please try again.} other{If–then plan}}'**
  String implementationIntentionText(String key);

  /// Visible and accessible if–then statement. Both placeholders contain unchanged user-authored text; translators may reorder them for natural grammar.
  ///
  /// In en, this message translates to:
  /// **'If {trigger}, then I will {response}.'**
  String implementationIntentionStatement(String trigger, String response);

  /// Uncertainty Practice interface copy selected from a stable UI key. Keep wording optional and factual; never promise safety, reduced discomfort, learning, progress, or a clinical outcome.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Uncertainty Practice} subtitle{Practise making room for not knowing.} loadError{Practice counts are unavailable right now. You can still open an exercise.} whyLabel{ABOUT THIS PRACTICE} willingnessLabel{How willing were you to sit with not knowing?} noteLabel{Note (optional)} noteHint{What did you notice?} saveAction{Record this practice} saveSuccess{Practice recorded.} saveError{This practice could not be recorded. Your note is still here. Please try again.} other{Uncertainty practice}}'**
  String uncertaintyTrainingText(String key);

  /// Exercise title resolved from an unchanged stable exercise ID.
  ///
  /// In en, this message translates to:
  /// **'{exercise, select, maybe{Maybe, maybe not} unanswered{Leave it unanswered} resist{Pause certainty-seeking} other{Uncertainty exercise}}'**
  String uncertaintyExerciseTitle(String exercise);

  /// Brief uncertainty-exercise instruction resolved from a stable ID. Do not reassure or promise that discomfort or urges will change.
  ///
  /// In en, this message translates to:
  /// **'{exercise, select, maybe{When OCD asks for certainty, try responding “maybe, maybe not” and return attention to what you were doing.} unanswered{Let one recurring question remain open instead of resolving it.} resist{Notice an urge to check, search, or ask for reassurance, and choose not to follow it for this practice.} other{A practice for allowing uncertainty to remain present.}}'**
  String uncertaintyExerciseIntro(String exercise);

  /// Factual explanation of an uncertainty exercise. Never claim safety, brain retraining, symptom reduction, or treatment outcomes.
  ///
  /// In en, this message translates to:
  /// **'{exercise, select, maybe{This exercise practises leaving a question unresolved without adding reassurance.} unanswered{This exercise practises allowing a question to remain open.} resist{This exercise records a deliberate attempt to avoid seeking certainty.} other{This exercise is a self-help practice for making room for uncertainty.}}'**
  String uncertaintyExerciseWhy(String exercise);

  /// Optional practice prompt resolved from an unchanged stable exercise ID.
  ///
  /// In en, this message translates to:
  /// **'{exercise, select, maybe{Choose one worry and respond with “maybe, maybe not.” Notice what is present without trying to settle it.} unanswered{Choose one question you would usually settle and leave it unanswered for this practice.} resist{Notice one certainty-seeking urge and leave it unanswered for this practice.} other{Choose one small way to leave uncertainty unresolved for this practice.}}'**
  String uncertaintyExercisePrompt(String exercise);

  /// Factual historical practice count, hidden when Calm Insights is enabled.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 practice} other{{count} practices}}'**
  String uncertaintyPracticeCount(int count);

  /// Accessible exercise-card summary when Calm Insights hides the historical count.
  ///
  /// In en, this message translates to:
  /// **'{title}. {intro}'**
  String uncertaintyExerciseSummary(String title, String intro);

  /// Accessible exercise-card summary with a factual count when Calm Insights is disabled.
  ///
  /// In en, this message translates to:
  /// **'{title}. {intro} {count, plural, =1{Recorded 1 practice.} other{Recorded {count} practices.}}'**
  String uncertaintyExerciseSummaryWithCount(
    String title,
    String intro,
    int count,
  );

  /// Visible and accessible deliberately recorded willingness rating; remains available in Calm Insights mode.
  ///
  /// In en, this message translates to:
  /// **'Willingness {value} of 10'**
  String uncertaintyWillingness(int value);

  /// Action Planner interface copy selected from a stable UI key. Preserve user text and the optional ISO storage date; avoid promising that a situation will become easier or that a response is clinically recommended.
  ///
  /// In en, this message translates to:
  /// **'{key, select, title{Action Planner} newAction{New} subtitle{Record a situation and the response you want to try.} loadError{Your action plans are unavailable right now. Please try again.} deleteTitle{Delete this action plan?} deleteBody{This permanently removes the plan from this device.} cancel{Cancel} deleteAction{Delete} deleteTooltip{Delete action plan} deleteSuccess{Action plan deleted.} deleteError{This action plan could not be deleted. Please try again.} statePlanned{Planned} stateCompleted{Marked complete} toggleMarkComplete{Mark action plan complete} toggleMarkIncomplete{Mark action plan incomplete} toggleSuccessComplete{Action plan marked complete.} toggleSuccessIncomplete{Action plan marked incomplete.} toggleError{This action plan could not be updated. Its previous state is still shown. Please try again.} emptyTitle{Create an action plan} emptyBody{Write down a situation and the response you want to try when it occurs.} emptyAction{New action plan} editorTitle{New action plan} situationLabel{When OCD shows up} situationHint{For example: I notice the urge to search for a symptom} actionLabel{Response I want to try} actionHint{For example: wait 15 minutes before deciding whether to search} dateLabel{Date (optional)} pickDate{Choose a date} clearDate{Remove date} notesLabel{Notes (optional)} notesHint{Anything you want to remember} saveAction{Save action plan} validation{Add both the situation and the response you want to try.} saveSuccess{Action plan saved.} saveError{This action plan could not be saved. Your text is still here. Please try again.} other{Action plan}}'**
  String actionPlanText(String key);

  /// Accessible factual action-plan summary. Situation and action contain unchanged user-authored text.
  ///
  /// In en, this message translates to:
  /// **'{status}. Situation: {situation}. Planned response: {action}.'**
  String actionPlanCardSummary(String status, String situation, String action);

  /// Accessible action-plan date. Date is already locale formatted, while storage remains ASCII ISO.
  ///
  /// In en, this message translates to:
  /// **'Planned date: {date}.'**
  String actionPlanDateSummary(String date);

  /// Settings, privacy, backup, reminder, analytics, and App Lock interface copy selected from a stable UI key. Backup and wipe wording must distinguish local records, local preferences, app-store purchases, and unencrypted manual exports.
  ///
  /// In en, this message translates to:
  /// **'{key, select, proActiveMessage{Patterns Pro is active on this device.} welcomeScheduled{The welcome screens will appear next time you open Patterns.} exportPromptTitle{Export data?} exportPromptBody{Patterns creates an unencrypted ZIP backup of your local records. Save it somewhere private.} exportBackupAction{Export ZIP backup} exportDialogTitle{Export Patterns data} exportSucceeded{Data exported.} exportFailed{Export failed. Your data is unchanged. Please try again.} importPromptTitle{Import data?} importPromptBody{Choose a ZIP or JSON Patterns backup. You can review its contents before replacing your current records.} chooseBackupAction{Choose backup} importDialogTitle{Select Patterns backup} backupUnreadable{Patterns could not read this backup file. Choose another file.} backupInvalid{This is not a valid Patterns backup. Your current data is unchanged.} importFailed{Import failed. Your current data is unchanged. Please try again.} importPreviewTitle{Replace current data?} importPreviewIntro{This backup contains the following local records. Importing it replaces your current records.} replaceAction{Replace data} importSucceeded{Data imported.} wipePromptTitle{Wipe all local data?} wipePromptBody{This permanently deletes local journal entries, OCD records, recovery practice history, locally stored materials, and app preferences from this device. This cannot be undone. Your Patterns Pro purchase remains with your app-store account, but this device will forget the local unlock. You can restore it afterwards.} wipeAction{Wipe data} wipeSucceeded{Local data wiped.} wipeFailed{Patterns could not finish wiping local data. Please try again.} appLockDisabled{App lock disabled.} deviceLockUnavailable{Device lock is unavailable. Set up a device passcode or biometrics, then try again.} appLockReason{Unlock Patterns to enable app lock.} appLockEnabled{App lock enabled.} appLockTemporaryLockout{Too many attempts. Try again in a moment.} appLockBiometricLockout{Biometric authentication is locked. Unlock your device with its passcode first.} appLockEnableFailed{Patterns could not change app lock. Please try again.} reminderOff{Daily reminder turned off.} notificationsUnavailable{Notifications are off for Patterns. Enable them in your device settings to receive reminders.} reminderOn{Daily reminder turned on.} reminderChangeFailed{Patterns could not change the reminder. Your previous setting is still in place.} analyticsChangeFailed{Patterns could not change anonymous usage sharing. Your previous setting is still in place.} privacyPolicyFailed{Patterns could not open the privacy policy. Please try again.} other{Settings}}'**
  String settingsText(String key);

  /// Exact journal-entry count in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No journal entries} =1{1 journal entry} other{{count} journal entries}}'**
  String settingsBackupJournalCount(int count);

  /// Exact OCD-event count in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No OCD events} =1{1 OCD event} other{{count} OCD events}}'**
  String settingsBackupOcdCount(int count);

  /// Exact compulsion-delay session count in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No delay sessions} =1{1 delay session} other{{count} delay sessions}}'**
  String settingsBackupDelayCount(int count);

  /// Exact Guided ERP plan count in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No ERP plans} =1{1 ERP plan} other{{count} ERP plans}}'**
  String settingsBackupErpPlanCount(int count);

  /// Exact Guided ERP practice count in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No ERP practices} =1{1 ERP practice} other{{count} ERP practices}}'**
  String settingsBackupErpPracticeCount(int count);

  /// Combined exact count for the remaining recovery-tool tables in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No other recovery-tool records} =1{1 other recovery-tool record} other{{count} other recovery-tool records}}'**
  String settingsBackupRecoveryCount(int count);

  /// Exact Y-BOCS self-check count in a backup preview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No Y-BOCS self-checks} =1{1 Y-BOCS self-check} other{{count} Y-BOCS self-checks}}'**
  String settingsBackupSelfCheckCount(int count);

  /// Confirmation after the user changes the daily reminder time. Time is already locale-formatted.
  ///
  /// In en, this message translates to:
  /// **'Reminder set for {time}.'**
  String settingsReminderSetFor(String time);

  /// Native biometric prompt reason shown when App Lock protects Patterns.
  ///
  /// In en, this message translates to:
  /// **'Unlock Patterns to continue.'**
  String get appUnlockReason;

  /// Factual App Lock recovery message when device authentication is no longer configured.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is unavailable. App lock has been turned off.'**
  String get appLockUnavailableDisabled;

  /// Retryable App Lock error. Do not imply data loss.
  ///
  /// In en, this message translates to:
  /// **'Patterns could not be unlocked. Please try again.'**
  String get appUnlockFailed;

  /// Accessibility label for the full-screen privacy cover that hides personal content.
  ///
  /// In en, this message translates to:
  /// **'Patterns privacy screen'**
  String get privacyScreenLabel;

  /// Disabled App Lock action while native authentication is in progress.
  ///
  /// In en, this message translates to:
  /// **'Unlocking…'**
  String get unlockingAction;

  /// Action to retry native App Lock authentication.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockAction;

  /// Optional, non-coercive anonymous usage analytics consent title.
  ///
  /// In en, this message translates to:
  /// **'Help improve Patterns?'**
  String get analyticsPromptTitle;

  /// Privacy-sensitive analytics consent explanation. Must accurately state the default-off behavior and excluded personal or locale data.
  ///
  /// In en, this message translates to:
  /// **'Share anonymous feature-use events to help improve Patterns. Journal entries, OCD content, ratings, notes, generated summaries, locale, and language choices are never included. Sharing stays off unless you choose it.'**
  String get analyticsPromptBody;

  /// Neutral action that declines or defers an optional prompt.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNowAction;

  /// Explicit action granting anonymous usage analytics consent.
  ///
  /// In en, this message translates to:
  /// **'Share anonymous usage'**
  String get shareAnonymousUsageAction;
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
