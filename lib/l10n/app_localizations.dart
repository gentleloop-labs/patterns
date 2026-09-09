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

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Patterns'**
  String get appTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language Patterns uses'**
  String get languageSubtitle;

  /// No description provided for @calmInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Calm Insights'**
  String get calmInsightsTitle;

  /// No description provided for @calmInsightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hide streaks and calculated scores. Your recorded data stays available.'**
  String get calmInsightsSubtitle;

  /// No description provided for @calmRecentActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Your recent activity'**
  String get calmRecentActivityTitle;

  /// No description provided for @calmNoRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Nothing recorded in the last 7 days. Your space is ready whenever you need it.'**
  String get calmNoRecentActivity;

  /// No description provided for @calmJournalActivity.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 journal entry} other{{count} journal entries}}'**
  String calmJournalActivity(int count);

  /// No description provided for @calmTrackedActivity.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tracked moment} other{{count} tracked moments}}'**
  String calmTrackedActivity(int count);

  /// No description provided for @calmDelayActivity.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 compulsion delay} other{{count} compulsion delays}}'**
  String calmDelayActivity(int count);

  /// No description provided for @calmErpActivity.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ERP practice} other{{count} ERP practices}}'**
  String calmErpActivity(int count);

  /// No description provided for @calmExposureActivity.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 exposure completed} other{{count} exposures completed}}'**
  String calmExposureActivity(int count);

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @doneAction.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneAction;

  /// No description provided for @doneForNowAction.
  ///
  /// In en, this message translates to:
  /// **'Done for now'**
  String get doneForNowAction;

  /// No description provided for @completionSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get completionSavedTitle;

  /// No description provided for @completionPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice recorded'**
  String get completionPracticeTitle;

  /// No description provided for @completionJournalBody.
  ///
  /// In en, this message translates to:
  /// **'Your journal entry is saved on this device.'**
  String get completionJournalBody;

  /// No description provided for @completionTrackedBody.
  ///
  /// In en, this message translates to:
  /// **'Your tracked moment is saved on this device.'**
  String get completionTrackedBody;

  /// No description provided for @completionTrackedUpdatedBody.
  ///
  /// In en, this message translates to:
  /// **'Your tracked moment has been updated.'**
  String get completionTrackedUpdatedBody;

  /// No description provided for @completionDelayBody.
  ///
  /// In en, this message translates to:
  /// **'Your compulsion-delay practice has been recorded.'**
  String get completionDelayBody;

  /// No description provided for @completionErpBody.
  ///
  /// In en, this message translates to:
  /// **'Your ERP practice has been recorded.'**
  String get completionErpBody;

  /// No description provided for @notificationOpenAction.
  ///
  /// In en, this message translates to:
  /// **'Open notification'**
  String get notificationOpenAction;

  /// No description provided for @dailyReminderChannelName.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminderChannelName;

  /// No description provided for @dailyReminderChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'A gentle daily nudge to check in with Patterns.'**
  String get dailyReminderChannelDescription;

  /// No description provided for @dailyReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'A quiet check-in'**
  String get dailyReminderTitle;

  /// No description provided for @dailyReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Take a gentle moment with Patterns whenever you’re ready.'**
  String get dailyReminderBody;

  /// No description provided for @practiceTimerChannelName.
  ///
  /// In en, this message translates to:
  /// **'Practice timer'**
  String get practiceTimerChannelName;

  /// No description provided for @practiceTimerChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'A gentle alert when a timed practice window is complete.'**
  String get practiceTimerChannelDescription;

  /// No description provided for @appUpdatesChannelName.
  ///
  /// In en, this message translates to:
  /// **'App updates'**
  String get appUpdatesChannelName;

  /// No description provided for @appUpdatesChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Occasional notes when Patterns gets meaningful new recovery tools.'**
  String get appUpdatesChannelDescription;

  /// No description provided for @updateAnnouncementTitle.
  ///
  /// In en, this message translates to:
  /// **'Patterns got better'**
  String get updateAnnouncementTitle;

  /// No description provided for @updateAnnouncementBody.
  ///
  /// In en, this message translates to:
  /// **'New recovery tools, progress insights, and a calmer Home are ready.'**
  String get updateAnnouncementBody;

  /// No description provided for @practiceWindowCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice window complete'**
  String get practiceWindowCompleteTitle;

  /// No description provided for @practiceWindowCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to notice what happened.'**
  String get practiceWindowCompleteBody;

  /// No description provided for @erpWindowCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'ERP practice window complete'**
  String get erpWindowCompleteTitle;

  /// No description provided for @erpWindowCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to reflect on what happened.'**
  String get erpWindowCompleteBody;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navJournal;

  /// No description provided for @navTrack.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get navTrack;

  /// No description provided for @navTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get navTracker;

  /// No description provided for @navRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get navRecovery;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @exportReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export report'**
  String get exportReportTitle;

  /// No description provided for @exportReportDescription.
  ///
  /// In en, this message translates to:
  /// **'Save a combined PDF of your journal, OCD log, and insights. You choose where to save it and whether to share it.'**
  String get exportReportDescription;

  /// No description provided for @exportTimeWindow.
  ///
  /// In en, this message translates to:
  /// **'Time window'**
  String get exportTimeWindow;

  /// No description provided for @exportStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get exportStart;

  /// No description provided for @exportEnd.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get exportEnd;

  /// No description provided for @exportIncludeSections.
  ///
  /// In en, this message translates to:
  /// **'Include sections'**
  String get exportIncludeSections;

  /// No description provided for @exportAnalyticsSummary.
  ///
  /// In en, this message translates to:
  /// **'Analytics summary'**
  String get exportAnalyticsSummary;

  /// No description provided for @exportJournalEntries.
  ///
  /// In en, this message translates to:
  /// **'Journal entries'**
  String get exportJournalEntries;

  /// No description provided for @exportOcdEvents.
  ///
  /// In en, this message translates to:
  /// **'OCD events'**
  String get exportOcdEvents;

  /// No description provided for @exportYbocsSelfChecks.
  ///
  /// In en, this message translates to:
  /// **'Y-BOCS self-checks'**
  String get exportYbocsSelfChecks;

  /// No description provided for @exportEntrySummary.
  ///
  /// In en, this message translates to:
  /// **'{total, plural, =0{No entries} =1{1 entry} other{{total} entries}} in this range ({journal} journal, {ocd} OCD, {selfChecks} self-checks)'**
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks);

  /// No description provided for @exportLargeReport.
  ///
  /// In en, this message translates to:
  /// **'This report is large and may take a moment to generate.'**
  String get exportLargeReport;

  /// No description provided for @exportPrivacyWarning.
  ///
  /// In en, this message translates to:
  /// **'This creates an unencrypted PDF. Save it somewhere private.'**
  String get exportPrivacyWarning;

  /// No description provided for @exportSavePdf.
  ///
  /// In en, this message translates to:
  /// **'Save PDF'**
  String get exportSavePdf;

  /// No description provided for @exportSelectSectionError.
  ///
  /// In en, this message translates to:
  /// **'Select at least one section to export.'**
  String get exportSelectSectionError;

  /// No description provided for @exportNoEntriesError.
  ///
  /// In en, this message translates to:
  /// **'No entries match this range and section selection.'**
  String get exportNoEntriesError;

  /// No description provided for @exportReportSaved.
  ///
  /// In en, this message translates to:
  /// **'Report saved'**
  String get exportReportSaved;

  /// No description provided for @exportReportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create report'**
  String get exportReportFailed;

  /// No description provided for @rangeSevenDays.
  ///
  /// In en, this message translates to:
  /// **'7D'**
  String get rangeSevenDays;

  /// No description provided for @rangeThirtyDays.
  ///
  /// In en, this message translates to:
  /// **'30D'**
  String get rangeThirtyDays;

  /// No description provided for @rangeNinetyDays.
  ///
  /// In en, this message translates to:
  /// **'90D'**
  String get rangeNinetyDays;

  /// No description provided for @rangeYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get rangeYear;

  /// No description provided for @rangeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get rangeAll;

  /// No description provided for @rangeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get rangeCustom;

  /// No description provided for @rangeLastSevenDays.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get rangeLastSevenDays;

  /// No description provided for @rangeLastThirtyDays.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get rangeLastThirtyDays;

  /// No description provided for @rangeLastNinetyDays.
  ///
  /// In en, this message translates to:
  /// **'Last 90 days'**
  String get rangeLastNinetyDays;

  /// No description provided for @rangeLastYear.
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get rangeLastYear;

  /// No description provided for @rangeAllTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get rangeAllTime;

  /// No description provided for @pdfPersonalReport.
  ///
  /// In en, this message translates to:
  /// **'Personal Report'**
  String get pdfPersonalReport;

  /// No description provided for @pdfGenerated.
  ///
  /// In en, this message translates to:
  /// **'Generated {date}'**
  String pdfGenerated(String date);

  /// No description provided for @pdfDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This report contains personal notes created in Patterns for self-reflection. It is not medical advice and does not replace care from a qualified clinician.'**
  String get pdfDisclaimer;

  /// No description provided for @pdfJournalCount.
  ///
  /// In en, this message translates to:
  /// **'Journal entries'**
  String get pdfJournalCount;

  /// No description provided for @pdfOcdCount.
  ///
  /// In en, this message translates to:
  /// **'OCD events'**
  String get pdfOcdCount;

  /// No description provided for @pdfAverageDistress.
  ///
  /// In en, this message translates to:
  /// **'Average distress'**
  String get pdfAverageDistress;

  /// No description provided for @pdfObsessions.
  ///
  /// In en, this message translates to:
  /// **'Obsessions'**
  String get pdfObsessions;

  /// No description provided for @pdfCompulsions.
  ///
  /// In en, this message translates to:
  /// **'Compulsions'**
  String get pdfCompulsions;

  /// No description provided for @pdfNoJournalEntries.
  ///
  /// In en, this message translates to:
  /// **'No journal entries in this range.'**
  String get pdfNoJournalEntries;

  /// No description provided for @pdfNoOcdEvents.
  ///
  /// In en, this message translates to:
  /// **'No OCD events in this range.'**
  String get pdfNoOcdEvents;

  /// No description provided for @pdfObsession.
  ///
  /// In en, this message translates to:
  /// **'Obsession'**
  String get pdfObsession;

  /// No description provided for @pdfCompulsion.
  ///
  /// In en, this message translates to:
  /// **'Compulsion'**
  String get pdfCompulsion;

  /// No description provided for @pdfDistressScore.
  ///
  /// In en, this message translates to:
  /// **'Distress {score}/10'**
  String pdfDistressScore(int score);

  /// No description provided for @pdfThought.
  ///
  /// In en, this message translates to:
  /// **'Thought'**
  String get pdfThought;

  /// No description provided for @pdfUrge.
  ///
  /// In en, this message translates to:
  /// **'Urge'**
  String get pdfUrge;

  /// No description provided for @pdfResponse.
  ///
  /// In en, this message translates to:
  /// **'Response: {text}'**
  String pdfResponse(String text);

  /// No description provided for @pdfActionTaken.
  ///
  /// In en, this message translates to:
  /// **'Action taken: {text}'**
  String pdfActionTaken(String text);

  /// No description provided for @pdfYbocsDescription.
  ///
  /// In en, this message translates to:
  /// **'Yale-Brown Obsessive Compulsive Scale, self-rated in the app. Total is out of 40, with obsessions and compulsions each out of 20.'**
  String get pdfYbocsDescription;

  /// No description provided for @pdfMostRecentTotal.
  ///
  /// In en, this message translates to:
  /// **'Most recent total'**
  String get pdfMostRecentTotal;

  /// No description provided for @pdfTakenOn.
  ///
  /// In en, this message translates to:
  /// **'Taken on'**
  String get pdfTakenOn;

  /// No description provided for @pdfObsessionsSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Obsessions subtotal'**
  String get pdfObsessionsSubtotal;

  /// No description provided for @pdfCompulsionsSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Compulsions subtotal'**
  String get pdfCompulsionsSubtotal;

  /// No description provided for @pdfChangeAcrossRange.
  ///
  /// In en, this message translates to:
  /// **'Change across range'**
  String get pdfChangeAcrossRange;

  /// No description provided for @pdfSelfChecksInRange.
  ///
  /// In en, this message translates to:
  /// **'Self-checks in range'**
  String get pdfSelfChecksInRange;

  /// No description provided for @pdfThemesFlagged.
  ///
  /// In en, this message translates to:
  /// **'Themes flagged'**
  String get pdfThemesFlagged;

  /// No description provided for @pdfSingleSelfCheck.
  ///
  /// In en, this message translates to:
  /// **'Single self-check in this range'**
  String get pdfSingleSelfCheck;

  /// No description provided for @pdfChangeSince.
  ///
  /// In en, this message translates to:
  /// **'{change} since {date}'**
  String pdfChangeSince(String change, String date);

  /// No description provided for @pdfDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pdfDate;

  /// No description provided for @pdfTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get pdfTotal;

  /// No description provided for @pdfBand.
  ///
  /// In en, this message translates to:
  /// **'Band'**
  String get pdfBand;

  /// No description provided for @severitySubclinical.
  ///
  /// In en, this message translates to:
  /// **'Subclinical'**
  String get severitySubclinical;

  /// No description provided for @severityMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get severityMild;

  /// No description provided for @severityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get severityModerate;

  /// No description provided for @severitySevere.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get severitySevere;

  /// No description provided for @severityExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get severityExtreme;

  /// No description provided for @backAction.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backAction;

  /// No description provided for @onboardingSafetyFootnote.
  ///
  /// In en, this message translates to:
  /// **'Private by design. Not a diagnosis or a replacement for professional care.'**
  String get onboardingSafetyFootnote;

  /// No description provided for @onboardingHeadline.
  ///
  /// In en, this message translates to:
  /// **'A quiet place to practise with OCD.'**
  String get onboardingHeadline;

  /// No description provided for @onboardingIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Log the intrusive thought, delay the compulsion, and practise responding differently, one small step at a time.'**
  String get onboardingIntroduction;

  /// No description provided for @onboardingPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Your OCD data stays on this device. No account. No cloud sync.'**
  String get onboardingPrivacy;

  /// No description provided for @getStartedAction.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStartedAction;

  /// No description provided for @importExistingDataAction.
  ///
  /// In en, this message translates to:
  /// **'Import existing data'**
  String get importExistingDataAction;

  /// No description provided for @onboardingQuestion.
  ///
  /// In en, this message translates to:
  /// **'What would help right now?'**
  String get onboardingQuestion;

  /// No description provided for @onboardingPickOne.
  ///
  /// In en, this message translates to:
  /// **'Pick one. You can do the rest whenever you like.'**
  String get onboardingPickOne;

  /// No description provided for @onboardingUrgeTitle.
  ///
  /// In en, this message translates to:
  /// **'I\'m fighting an urge right now'**
  String get onboardingUrgeTitle;

  /// No description provided for @onboardingUrgeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Put some time between the urge and the ritual.'**
  String get onboardingUrgeSubtitle;

  /// No description provided for @onboardingJournalTitle.
  ///
  /// In en, this message translates to:
  /// **'I want to write something down'**
  String get onboardingJournalTitle;

  /// No description provided for @onboardingJournalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get the thought out of your head and onto a page.'**
  String get onboardingJournalSubtitle;

  /// No description provided for @onboardingErpTitle.
  ///
  /// In en, this message translates to:
  /// **'I want to practise leaving a compulsion undone'**
  String get onboardingErpTitle;

  /// No description provided for @onboardingErpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One short, guided exposure.'**
  String get onboardingErpSubtitle;

  /// No description provided for @onboardingSelfCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'I want to see where my OCD is right now'**
  String get onboardingSelfCheckTitle;

  /// No description provided for @onboardingSelfCheckSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The Y-BOCS self-check. About 10 minutes.'**
  String get onboardingSelfCheckSubtitle;

  /// No description provided for @onboardingExploreTitle.
  ///
  /// In en, this message translates to:
  /// **'I\'m just exploring'**
  String get onboardingExploreTitle;

  /// No description provided for @onboardingExploreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Have a look around first.'**
  String get onboardingExploreSubtitle;

  /// No description provided for @whatsNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice without pressure'**
  String get whatsNewTitle;

  /// No description provided for @whatsNewBody.
  ///
  /// In en, this message translates to:
  /// **'Patterns 1.10 brings calmer insights, quieter session endings, accessibility improvements, and optional language selection.'**
  String get whatsNewBody;

  /// No description provided for @whatsNewLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Calm Insights'**
  String get whatsNewLanguagesTitle;

  /// No description provided for @whatsNewLanguagesBody.
  ///
  /// In en, this message translates to:
  /// **'Choose factual activity summaries instead of calculated scores, streaks, and consistency percentages.'**
  String get whatsNewLanguagesBody;

  /// No description provided for @whatsNewPrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'A clear stopping point'**
  String get whatsNewPrivateTitle;

  /// No description provided for @whatsNewPrivateBody.
  ///
  /// In en, this message translates to:
  /// **'Journal, tracking, compulsion-delay, and ERP sessions now end with a simple factual confirmation and Done for now.'**
  String get whatsNewPrivateBody;

  /// No description provided for @whatsNewReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'More accessible, in your language'**
  String get whatsNewReportsTitle;

  /// No description provided for @whatsNewReportsBody.
  ///
  /// In en, this message translates to:
  /// **'Improved labels and reduced-motion behavior join English, Brazilian Portuguese, German, Japanese, Spanish, and French.'**
  String get whatsNewReportsBody;

  /// No description provided for @whatsNewExploreAction.
  ///
  /// In en, this message translates to:
  /// **'Explore Patterns 1.10'**
  String get whatsNewExploreAction;

  /// No description provided for @continueToPatternsAction.
  ///
  /// In en, this message translates to:
  /// **'Continue to Patterns'**
  String get continueToPatternsAction;

  /// No description provided for @whatsNewNotificationNote.
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
