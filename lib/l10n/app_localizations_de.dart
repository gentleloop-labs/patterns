// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsDataSection => 'Daten';

  @override
  String get settingsExportDataTitle => 'Daten exportieren';

  @override
  String get settingsExportDataSubtitle =>
      'Ihre Einträge in einer lokalen JSON-Sicherung speichern';

  @override
  String get settingsImportDataTitle => 'Daten importieren';

  @override
  String get settingsImportDataSubtitle =>
      'Einträge aus einer ZIP- oder JSON-Sicherung wiederherstellen';

  @override
  String get settingsRemindersSection => 'Erinnerungen';

  @override
  String get settingsDailyReminderTitle => 'Tägliche Erinnerung';

  @override
  String settingsDailyReminderAt(String time) {
    return 'Eine sanfte Erinnerung um $time';
  }

  @override
  String get settingsDailyReminderOff =>
      'Eine sanfte tägliche Erinnerung zum Einchecken';

  @override
  String get settingsReminderTimeTitle => 'Erinnerungszeit';

  @override
  String get settingsPrivacySection => 'Datenschutz';

  @override
  String get settingsPrivacySafetySubtitle =>
      'Wie Ihre lokalen Daten behandelt werden';

  @override
  String get settingsAnalyticsTitle => 'Anonyme Nutzungsanalyse teilen';

  @override
  String get settingsAnalyticsSubtitle =>
      'Nur Ereignisse zur Funktionsnutzung teilen. Persönliche OCD-Daten werden nie einbezogen.';

  @override
  String get settingsAppLockTitle => 'App-Sperre';

  @override
  String get settingsAppLockSubtitle =>
      'Beim erneuten Öffnen von Patterns die Gerätesperre verlangen';

  @override
  String get settingsWipeTitle => 'Alle Daten löschen';

  @override
  String get settingsWipeSubtitle =>
      'Lokale Einträge löschen und App-Einstellungen zurücksetzen';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Pro ist aktiv';

  @override
  String get settingsProActiveSubtitle =>
      'Alle Genesungswerkzeuge sind freigeschaltet. Vielen Dank.';

  @override
  String get settingsUnlockProTitle => 'Patterns Pro freischalten';

  @override
  String get settingsUnlockProSubtitle =>
      'Einmalige Freischaltung aller Genesungswerkzeuge';

  @override
  String get settingsRestorePurchasesTitle => 'Käufe wiederherstellen';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Eine frühere Patterns-Pro-Freischaltung wiederherstellen';

  @override
  String get settingsHelpSection => 'Hilfe';

  @override
  String get settingsReplayTourTitle => 'App-Tour wiederholen';

  @override
  String get settingsReplayTourSubtitle =>
      'Noch einmal ansehen, was die einzelnen Tabs tun';

  @override
  String get settingsShowWelcomeTitle => 'Willkommensseiten anzeigen';

  @override
  String get settingsShowWelcomeSubtitle =>
      'Die Einführung beim nächsten Öffnen von Patterns anzeigen';

  @override
  String get settingsFeedbackSection => 'Feedback';

  @override
  String get settingsRateTitle => 'Patterns bewerten';

  @override
  String get settingsRateSubtitle => 'Teilen Sie Ihre Meinung im Store';

  @override
  String get settingsSendFeedbackTitle => 'Feedback senden';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Teilen Sie eine Idee oder melden Sie ein Problem';

  @override
  String get settingsSupportTitle => 'Patterns unterstützen';

  @override
  String get settingsSupportSubtitle =>
      'Mit einem optionalen Trinkgeld die Entwicklung unterstützen';

  @override
  String get appearanceTitle => 'Darstellung';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceLight => 'Hell';

  @override
  String get appearanceDark => 'Dunkel';

  @override
  String get languageTitle => 'Sprache';

  @override
  String get languageSubtitle => 'Wählen Sie die Sprache für Patterns';

  @override
  String get calmInsightsTitle => 'Ruhige Einblicke';

  @override
  String get calmInsightsSubtitle =>
      'Blendet Serien und berechnete Werte aus. Ihre erfassten Daten bleiben verfügbar.';

  @override
  String get calmRecentActivityTitle => 'Ihre letzten Aktivitäten';

  @override
  String get calmNoRecentActivity =>
      'In den letzten 7 Tagen wurde nichts erfasst. Dieser Bereich ist bereit, wenn Sie ihn brauchen.';

  @override
  String calmJournalActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tagebucheinträge',
      one: '1 Tagebucheintrag',
    );
    return '$_temp0';
  }

  @override
  String calmTrackedActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count erfasste Momente',
      one: '1 erfasster Moment',
    );
    return '$_temp0';
  }

  @override
  String calmDelayActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aufgeschobene Zwangshandlungen',
      one: '1 aufgeschobene Zwangshandlung',
    );
    return '$_temp0';
  }

  @override
  String calmErpActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ERP-Übungen',
      one: '1 ERP-Übung',
    );
    return '$_temp0';
  }

  @override
  String calmExposureActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count abgeschlossene Expositionen',
      one: '1 abgeschlossene Exposition',
    );
    return '$_temp0';
  }

  @override
  String get recoveryMetricsTitle => 'Genesungsaktivität';

  @override
  String get recoveryMetricsTeaserTitle =>
      'Ihre Genesungsaktivität im Überblick';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'Sehen Sie Expositionen, Übungseinheiten und erfasste Veränderungen des Drangs aus Ihren ERP-Werkzeugen. Mit Patterns Pro freischalten.';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'Sehen Sie Übungsserien, abgeschlossene Expositionen und erfasste Veränderungen des Drangs aus Ihren ERP-Werkzeugen. Mit Patterns Pro freischalten.';

  @override
  String get recoveryMetricsUnlockPro => 'Patterns Pro freischalten';

  @override
  String get recoveryMetricsEmptyTitle =>
      'Ihre Genesungsaktivität erscheint hier';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      'Üben Sie einen Aufschub, eine ERP-Einheit oder einen Expositionsschritt, um hier sachliche Aktivitätszahlen zu sehen.';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      'Üben Sie einen Aufschub, eine ERP-Einheit oder einen Expositionsschritt, um Ihren Aktivitätsverlauf und Ihre Übungsserie aufzubauen.';

  @override
  String get recoveryMetricsExposuresDone => 'Expositionen abgeschlossen';

  @override
  String get recoveryMetricsSessionsPracticed => 'Einheiten geübt';

  @override
  String get recoveryMetricsAverageUrgeDrop =>
      'Durchschnittliche erfasste Drangänderung';

  @override
  String get recoveryMetricsThisWeek => 'Diese Woche';

  @override
  String recoveryMetricsDayStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage Serie',
      one: '1 Tag Serie',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get cancelAction => 'Abbrechen';

  @override
  String get doneAction => 'Fertig';

  @override
  String get doneForNowAction => 'Für jetzt fertig';

  @override
  String get completionSavedTitle => 'Gespeichert';

  @override
  String get completionPracticeTitle => 'Übung erfasst';

  @override
  String get completionJournalBody =>
      'Ihr Tagebucheintrag wurde auf diesem Gerät gespeichert.';

  @override
  String get completionTrackedBody =>
      'Der erfasste Moment wurde auf diesem Gerät gespeichert.';

  @override
  String get completionTrackedUpdatedBody =>
      'Der erfasste Moment wurde aktualisiert.';

  @override
  String get completionDelayBody =>
      'Ihre Übung zum Aufschieben einer Zwangshandlung wurde erfasst.';

  @override
  String get completionErpBody => 'Ihre ERP-Übung wurde erfasst.';

  @override
  String get notificationOpenAction => 'Mitteilung öffnen';

  @override
  String get dailyReminderChannelName => 'Tägliche Erinnerung';

  @override
  String get dailyReminderChannelDescription =>
      'Eine sanfte tägliche Erinnerung für einen Moment mit Patterns.';

  @override
  String get dailyReminderTitle => 'Ein ruhiger Moment';

  @override
  String get dailyReminderBody =>
      'Nehmen Sie sich einen behutsamen Moment mit Patterns, wenn Sie bereit sind.';

  @override
  String get practiceTimerChannelName => 'Übungs-Timer';

  @override
  String get practiceTimerChannelDescription =>
      'Ein sanfter Hinweis, wenn ein zeitlich begrenztes Übungsfenster endet.';

  @override
  String get appUpdatesChannelName => 'App-Aktualisierungen';

  @override
  String get appUpdatesChannelDescription =>
      'Gelegentliche Hinweise auf wichtige neue Genesungswerkzeuge in Patterns.';

  @override
  String get updateAnnouncementTitle => 'Patterns wurde verbessert';

  @override
  String get updateAnnouncementBody =>
      'Neue Genesungswerkzeuge, Fortschrittseinblicke und eine ruhigere Startseite sind verfügbar.';

  @override
  String get practiceWindowCompleteTitle => 'Übungszeit beendet';

  @override
  String get practiceWindowCompleteBody =>
      'Nehmen Sie sich einen Moment, um wahrzunehmen, was geschehen ist.';

  @override
  String get erpWindowCompleteTitle => 'ERP-Übungszeit beendet';

  @override
  String get erpWindowCompleteBody =>
      'Nehmen Sie sich einen Moment, um über das Geschehene nachzudenken.';

  @override
  String get navToday => 'Heute';

  @override
  String get navHome => 'Start';

  @override
  String get navJournal => 'Tagebuch';

  @override
  String get navTrack => 'Erfassen';

  @override
  String get navTracker => 'Tracker';

  @override
  String get navRecovery => 'Genesung';

  @override
  String get navInsights => 'Einblicke';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get exportReportTitle => 'Bericht exportieren';

  @override
  String get exportReportDescription =>
      'Speichern Sie ein gemeinsames PDF aus Tagebuch, OCD-Protokoll und Einblicken. Sie entscheiden, wo Sie es speichern und ob Sie es teilen.';

  @override
  String get exportTimeWindow => 'Zeitraum';

  @override
  String get exportStart => 'Start';

  @override
  String get exportEnd => 'Ende';

  @override
  String get exportIncludeSections => 'Abschnitte einschließen';

  @override
  String get exportAnalyticsSummary => 'Analyseübersicht';

  @override
  String get exportJournalEntries => 'Tagebucheinträge';

  @override
  String get exportOcdEvents => 'OCD-Ereignisse';

  @override
  String get exportYbocsSelfChecks => 'Y-BOCS-Selbstchecks';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total Einträge',
      one: '1 Eintrag',
      zero: 'Keine Einträge',
    );
    return '$_temp0 in diesem Zeitraum ($journal Tagebuch, $ocd OCD, $selfChecks Selbstchecks)';
  }

  @override
  String get exportLargeReport =>
      'Dieser Bericht ist groß und die Erstellung kann einen Moment dauern.';

  @override
  String get exportPrivacyWarning =>
      'Dadurch entsteht ein unverschlüsseltes PDF. Speichern Sie es an einem privaten Ort.';

  @override
  String get exportSavePdf => 'PDF speichern';

  @override
  String get exportSelectSectionError =>
      'Wählen Sie mindestens einen Abschnitt für den Export.';

  @override
  String get exportNoEntriesError =>
      'Keine Einträge entsprechen diesem Zeitraum und dieser Auswahl.';

  @override
  String get exportReportSaved => 'Bericht gespeichert';

  @override
  String get exportReportFailed => 'Bericht konnte nicht erstellt werden';

  @override
  String get rangeSevenDays => '7 T';

  @override
  String get rangeThirtyDays => '30 T';

  @override
  String get rangeNinetyDays => '90 T';

  @override
  String get rangeYear => 'Jahr';

  @override
  String get rangeAll => 'Alle';

  @override
  String get rangeCustom => 'Benutzerdefiniert';

  @override
  String get rangeLastSevenDays => 'Letzte 7 Tage';

  @override
  String get rangeLastThirtyDays => 'Letzte 30 Tage';

  @override
  String get rangeLastNinetyDays => 'Letzte 90 Tage';

  @override
  String get rangeLastYear => 'Letztes Jahr';

  @override
  String get rangeAllTime => 'Gesamter Zeitraum';

  @override
  String get pdfPersonalReport => 'Persönlicher Bericht';

  @override
  String pdfGenerated(String date) {
    return 'Erstellt am $date';
  }

  @override
  String get pdfDisclaimer =>
      'Dieser Bericht enthält persönliche Notizen, die in Patterns zur Selbstreflexion erstellt wurden. Er ist keine medizinische Beratung und ersetzt keine Behandlung durch qualifiziertes Fachpersonal.';

  @override
  String get pdfJournalCount => 'Tagebucheinträge';

  @override
  String get pdfOcdCount => 'OCD-Ereignisse';

  @override
  String get pdfAverageDistress => 'Durchschnittliche Belastung';

  @override
  String get pdfObsessions => 'Obsessionen';

  @override
  String get pdfCompulsions => 'Zwänge';

  @override
  String get pdfNoJournalEntries =>
      'Keine Tagebucheinträge in diesem Zeitraum.';

  @override
  String get pdfNoOcdEvents => 'Keine OCD-Ereignisse in diesem Zeitraum.';

  @override
  String get pdfObsession => 'Obsession';

  @override
  String get pdfCompulsion => 'Zwang';

  @override
  String pdfDistressScore(int score) {
    return 'Belastung $score/10';
  }

  @override
  String get pdfThought => 'Gedanke';

  @override
  String get pdfUrge => 'Drang';

  @override
  String pdfResponse(String text) {
    return 'Reaktion: $text';
  }

  @override
  String pdfActionTaken(String text) {
    return 'Ergriffene Handlung: $text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scale, in der App selbst eingeschätzt. Die Gesamtpunktzahl beträgt 40; Obsessionen und Zwänge jeweils 20.';

  @override
  String get pdfMostRecentTotal => 'Neueste Gesamtpunktzahl';

  @override
  String get pdfTakenOn => 'Erfasst am';

  @override
  String get pdfObsessionsSubtotal => 'Zwischensumme Obsessionen';

  @override
  String get pdfCompulsionsSubtotal => 'Zwischensumme Zwänge';

  @override
  String get pdfChangeAcrossRange => 'Veränderung im Zeitraum';

  @override
  String get pdfSelfChecksInRange => 'Selbstchecks im Zeitraum';

  @override
  String get pdfThemesFlagged => 'Markierte Themen';

  @override
  String get pdfSingleSelfCheck => 'Ein Selbstcheck in diesem Zeitraum';

  @override
  String pdfChangeSince(String change, String date) {
    return '$change seit $date';
  }

  @override
  String get pdfDate => 'Datum';

  @override
  String get pdfTotal => 'Gesamt';

  @override
  String get pdfBand => 'Bereich';

  @override
  String get severitySubclinical => 'Subklinisch';

  @override
  String get severityMild => 'Leicht';

  @override
  String get severityModerate => 'Mittelgradig';

  @override
  String get severitySevere => 'Schwer';

  @override
  String get severityExtreme => 'Extrem';

  @override
  String get backAction => 'Zurück';

  @override
  String get onboardingSafetyFootnote =>
      'Datenschutz ist eingebaut. Keine Diagnose und kein Ersatz für professionelle Hilfe.';

  @override
  String get onboardingHeadline => 'Ein ruhiger Ort zum Üben mit OCD.';

  @override
  String get onboardingIntroduction =>
      'Halten Sie den aufdringlichen Gedanken fest, verzögern Sie den Zwang und üben Sie Schritt für Schritt eine andere Reaktion.';

  @override
  String get onboardingPrivacy =>
      'Ihre OCD-Daten bleiben auf diesem Gerät. Kein Konto. Keine Cloud-Synchronisierung.';

  @override
  String get getStartedAction => 'Loslegen';

  @override
  String get importExistingDataAction => 'Vorhandene Daten importieren';

  @override
  String get onboardingQuestion => 'Was würde Ihnen gerade helfen?';

  @override
  String get onboardingPickOne =>
      'Wählen Sie eine Option. Alles andere können Sie später ausprobieren.';

  @override
  String get onboardingUrgeTitle => 'Ich kämpfe gerade mit einem Drang';

  @override
  String get onboardingUrgeSubtitle =>
      'Schaffen Sie etwas Abstand zwischen Drang und Ritual.';

  @override
  String get onboardingJournalTitle => 'Ich möchte etwas aufschreiben';

  @override
  String get onboardingJournalSubtitle =>
      'Bringen Sie den Gedanken aus dem Kopf aufs Papier.';

  @override
  String get onboardingErpTitle =>
      'Ich möchte üben, einen Zwang nicht auszuführen';

  @override
  String get onboardingErpSubtitle => 'Eine kurze, geführte Exposition.';

  @override
  String get onboardingSelfCheckTitle =>
      'Ich möchte sehen, wo mein OCD gerade steht';

  @override
  String get onboardingSelfCheckSubtitle =>
      'Der Y-BOCS-Selbstcheck. Etwa 10 Minuten.';

  @override
  String get onboardingExploreTitle => 'Ich sehe mich nur um';

  @override
  String get onboardingExploreSubtitle =>
      'Schauen Sie sich zunächst in Ruhe um.';

  @override
  String get whatsNewTitle => 'Üben ohne Druck';

  @override
  String get whatsNewBody =>
      'Patterns 1.10 bietet ruhigere Einblicke, sanftere Abschlüsse, bessere Barrierefreiheit und eine optionale Sprachauswahl.';

  @override
  String get whatsNewLanguagesTitle => 'Ruhige Einblicke';

  @override
  String get whatsNewLanguagesBody =>
      'Wählen Sie sachliche Aktivitätsübersichten statt berechneter Punktzahlen, Serien und Konsistenzwerte.';

  @override
  String get whatsNewPrivateTitle => 'Ein klarer Abschluss';

  @override
  String get whatsNewPrivateBody =>
      'Tagebuch-, Tracking-, Aufschub- und ERP-Sitzungen enden jetzt mit einer sachlichen Bestätigung und „Für jetzt fertig“.';

  @override
  String get whatsNewReportsTitle => 'Barriereärmer, in Ihrer Sprache';

  @override
  String get whatsNewReportsBody =>
      'Verbesserte Beschriftungen und weniger Bewegung ergänzen Englisch, brasilianisches Portugiesisch, Deutsch, Japanisch, Spanisch und Französisch.';

  @override
  String get whatsNewExploreAction => 'Patterns 1.10 entdecken';

  @override
  String get continueToPatternsAction => 'Weiter zu Patterns';

  @override
  String get whatsNewNotificationNote =>
      'Ihre Einträge bleiben unverändert. Sprache und Ruhige Einblicke bleiben auf diesem Gerät und werden weder in Analysen noch in Backups aufgenommen.';

  @override
  String get formatBold => 'Fett';

  @override
  String get formatItalic => 'Kursiv';

  @override
  String get formatBulletedList => 'Aufzählung';

  @override
  String get formatToggleHint =>
      'Doppeltippen, um diese Formatierung ein- oder auszuschalten.';

  @override
  String get journalEditorLabel => 'Tagebuch-Editor';

  @override
  String get journalEditorHint =>
      'Geben Sie Ihren Tagebuchtext ein. Die Formatierungssteuerung folgt auf den Editor.';

  @override
  String timerRemaining(String time) {
    return 'Verbleibende Zeit: $time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return 'Recovery-Punktzahl: $score von 100.';
  }

  @override
  String get privacySafetyTitle => 'Datenschutz & Sicherheit';

  @override
  String get privacyLocalContent =>
      'Tagebucheinträge, OCD-Ereignisse, Belastungswerte, Reflexionen und App-Einstellungen werden lokal auf diesem Gerät gespeichert.';

  @override
  String get privacyPurchases =>
      'Patterns Pro und Trinkgelder werden vom App Store verarbeitet. Patterns erhält keine Daten Ihrer Zahlungskarte.';

  @override
  String get privacyExports =>
      'Ein manueller Export erstellt nur dort eine unverschlüsselte JSON-Sicherung oder einen PDF-Bericht, wo Sie ihn speichern oder teilen.';

  @override
  String get privacyAnalytics =>
      'Anonyme Nutzungsanalysen sind aus, bis Sie sie aktivieren. Wenn aktiviert, sendet Patterns benannte Funktionsereignisse, eine zufällige Installations-ID, Plattform, App-Version und Ereigniszeit an den eigenen Dienst. Tagebucheinträge, OCD-Daten, erstellte Zusammenfassungen, Region und Sprachauswahl werden nie einbezogen. Beim Ausschalten werden ausstehende Ereignisse und die lokale Analyse-ID gelöscht.';

  @override
  String get privacyClinicalBoundary =>
      'Patterns ist ein Selbsthilfetool für persönliche Reflexion und ERP-Übungen. Es diagnostiziert oder behandelt OCD nicht, ersetzt keine qualifizierte fachliche Betreuung und bietet keine Notfallhilfe.';

  @override
  String get viewPrivacyPolicyAction => 'Vollständige Datenschutzerklärung';

  @override
  String get closeAction => 'Schließen';

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools =>
      'Enthält außerdem alle Pro-Werkzeuge für Planung, Übungen, Auswertungen und Reflexion.';

  @override
  String get proPaywallAlreadyPurchased =>
      'Pro bereits gekauft? Sie werden nicht erneut belastet.';

  @override
  String get proPaywallTryAgainAction => 'Erneut versuchen';

  @override
  String get proPaywallRestorePurchasesAction => 'Käufe wiederherstellen';

  @override
  String get proPaywallRestoreShortAction => 'Wiederherstellen';

  @override
  String get proPaywallUnlockAction => 'Pro freischalten';

  @override
  String proPaywallUnlockWithPrice(String price) {
    return 'Pro freischalten · $price';
  }

  @override
  String get proPaywallPurchasesUnavailable =>
      'In-App-Käufe sind auf diesem Gerät nicht verfügbar.';

  @override
  String get proPaywallProductUnavailable =>
      'Patterns Pro ist momentan nicht verfügbar. Bitte versuchen Sie es später erneut.';

  @override
  String get proPaywallProductLoadFailed =>
      'Patterns Pro konnte nicht geladen werden. Bitte versuchen Sie es später erneut.';

  @override
  String get proPaywallPurchaseStartFailed =>
      'Der Kauf konnte nicht gestartet werden.';

  @override
  String get proPaywallPurchaseFailed =>
      'Der Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es erneut.';

  @override
  String get proPaywallRestoreNotFound =>
      'Für dieses Konto wurde kein früherer Kauf gefunden. Wenn Sie Pro mit einem anderen Konto gekauft haben, melden Sie sich damit an und versuchen Sie es erneut.';

  @override
  String get proPaywallRestoreFailed =>
      'Käufe konnten nicht wiederhergestellt werden. Bitte versuchen Sie es erneut.';

  @override
  String get proPaywallWelcomeBack => 'Willkommen zurück';

  @override
  String get proPaywallAllSet => 'Alles eingerichtet';

  @override
  String get proPaywallRestoredBody =>
      'Patterns Pro wurde auf diesem Gerät wiederhergestellt.';

  @override
  String get proPaywallUnlockedBody =>
      'Patterns Pro ist freigeschaltet. Alle Recovery-Werkzeuge sind jetzt verfügbar.';

  @override
  String get proPaywallContinueAction => 'Weiter';

  @override
  String get proPaywallLoadingLabel => 'Patterns Pro wird geladen';

  @override
  String get proHeadlineSettings =>
      'Mehr als protokollieren: Recovery aktiv üben';

  @override
  String get proHeadlineTodayNextStep => 'Auf der heutigen Übung aufbauen';

  @override
  String get proHeadlineRecoveryMetrics => 'Ihre Recovery-Aktivitäten ansehen';

  @override
  String get proHeadlineExposureHierarchy =>
      'Eine klare Expositionshierarchie erstellen';

  @override
  String get proHeadlineExposureMaterials =>
      'Übungsmaterialien beisammenhalten';

  @override
  String get proHeadlineStructuredPrograms =>
      'Recovery in eine Routine integrieren';

  @override
  String get proHeadlineActionPlanner =>
      'Ihre Reaktion planen, bevor OCD auftaucht';

  @override
  String get proHeadlineImplementationIntentions =>
      'Die nächste Entscheidung erleichtern';

  @override
  String get proHeadlineUrgeSurfing => 'Üben, den Drang auszuhalten';

  @override
  String get proHeadlineResponsePrevention =>
      'Die gewählte Reaktion festhalten';

  @override
  String get proHeadlineUncertaintyTraining =>
      'Üben, dem Vielleicht Raum zu geben';

  @override
  String get proHeadlineBehavioralExperiments => 'OCD-Vorhersagen überprüfen';

  @override
  String get proHeadlineReflectionJournal =>
      'Festhalten, was jede Übung gezeigt hat';

  @override
  String get proBenefitGeneralPlans =>
      'Expositionshierarchien und Übungspläne erstellen';

  @override
  String get proBenefitGeneralResponsePrevention =>
      'Gezielte Werkzeuge zur Reaktionsverhinderung nutzen';

  @override
  String get proBenefitGeneralReview =>
      'Recovery-Aktivitäten und Reflexionen ansehen';

  @override
  String get proBenefitMetricsActivity =>
      'Übungsaktivitäten im Zeitverlauf ansehen';

  @override
  String get proBenefitMetricsNonjudgmental =>
      'Aufgezeichnete Aktivitäten ansehen, ohne einzelne Tage zu bewerten';

  @override
  String get proBenefitMetricsPatterns => 'Sachliche Recovery-Muster erkunden';

  @override
  String get proBenefitExposureLadder =>
      'Schritte von leichter bis schwieriger ordnen';

  @override
  String get proBenefitExposureMaterials =>
      'Skripte, Loops, Bilder und Links griffbereit halten';

  @override
  String get proBenefitExposureRepeatable =>
      'Einen Plan in wiederholbare Übungen umsetzen';

  @override
  String get proBenefitProgramsStructure =>
      'Einer ruhigen Wochenstruktur folgen';

  @override
  String get proBenefitProgramsTasks => 'Übungsaufgaben an einem Ort sammeln';

  @override
  String get proBenefitProgramsReview =>
      'Ansehen, was beim Weitermachen geholfen hat';

  @override
  String get proBenefitPlanningAhead =>
      'Vor einem schwierigen Moment eine Reaktion wählen';

  @override
  String get proBenefitPlanningIfThen => 'Praktische Wenn-dann-Pläne erstellen';

  @override
  String get proBenefitPlanningReturn =>
      'Bei wachsender Unsicherheit zum Plan zurückkehren';

  @override
  String get proBenefitInMomentTools =>
      'Im Moment gezielte Übungswerkzeuge nutzen';

  @override
  String get proBenefitInMomentPrivacy =>
      'Entscheidungen ohne sensible Einzelheiten festhalten';

  @override
  String get proBenefitInMomentRepetition =>
      'Toleranz durch wiederholbare Übungen aufbauen';

  @override
  String get proBenefitReflectionCompare =>
      'Vorhersagen mit dem tatsächlichen Verlauf vergleichen';

  @override
  String get proBenefitReflectionCapture =>
      'Erkenntnisse nach einer Übung festhalten';

  @override
  String get proBenefitReflectionPatterns =>
      'Hilfreiche Muster im Zeitverlauf erkennen';

  @override
  String get proRestoreChecking => 'Ihre Käufe werden geprüft…';

  @override
  String get proRestoreSucceeded =>
      'Patterns Pro wurde wiederhergestellt. Alle Recovery-Werkzeuge sind wieder freigeschaltet.';

  @override
  String get tipJarTitle => 'Patterns unterstützen';

  @override
  String get tipJarBody =>
      'Patterns ist unabhängig und werbefrei. Wenn es Ihnen geholfen hat, bedeutet ein kleines Trinkgeld viel. Trinkgelder sind freiwillig und schalten keine Funktionen frei.';

  @override
  String get tipJarLoadingLabel => 'Trinkgeldoptionen werden geladen';

  @override
  String get tipJarPurchasesUnavailable =>
      'In-App-Käufe sind auf diesem Gerät nicht verfügbar.';

  @override
  String get tipJarOptionsUnavailable =>
      'Es wurden keine Trinkgeldoptionen gefunden. Bitte versuchen Sie es später erneut.';

  @override
  String get tipJarLoadFailed =>
      'Die Trinkgeldoptionen konnten nicht geladen werden. Bitte versuchen Sie es später erneut.';

  @override
  String get tipJarPurchaseFailed =>
      'Das Trinkgeld konnte nicht abgeschlossen werden. Bitte versuchen Sie es erneut.';

  @override
  String get tipJarTryAgainAction => 'Erneut versuchen';

  @override
  String get tipSmallTitle => 'Kleines Trinkgeld';

  @override
  String get tipSmallDescription =>
      'Ein freiwilliges kleines Trinkgeld für die Entwicklung von Patterns. Schaltet keine Funktionen frei.';

  @override
  String get tipMediumTitle => 'Mittleres Trinkgeld';

  @override
  String get tipMediumDescription =>
      'Ein freiwilliges mittleres Trinkgeld für die Entwicklung von Patterns. Schaltet keine Funktionen frei.';

  @override
  String get tipLargeTitle => 'Großes Trinkgeld';

  @override
  String get tipLargeDescription =>
      'Ein freiwilliges großes Trinkgeld für die Entwicklung von Patterns. Schaltet keine Funktionen frei.';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title, $price. $description';
  }

  @override
  String get tipChoiceHint => 'Sendet dieses freiwillige Trinkgeld';

  @override
  String get tipThanksTitle => 'Vielen Dank';

  @override
  String get tipThanksBody =>
      'Ihre Unterstützung bedeutet viel. Dank Menschen wie Ihnen bleibt Patterns werbefrei und unabhängig.';

  @override
  String get tipThanksAction => 'Gern geschehen';

  @override
  String get desktopProTitle => 'Patterns Desktop Pro freischalten';

  @override
  String get desktopProSubtitle =>
      'Eine einmalige Lizenz für offline nutzbare, desktopoptimierte Recovery-Werkzeuge.';

  @override
  String get desktopFeatureHierarchyTitle => 'Hierarchie-Builder';

  @override
  String get desktopFeatureHierarchyDescription =>
      'Expositionsschritte und -hierarchien erstellen und festhalten.';

  @override
  String get desktopFeatureErpTitle => 'ERP-Übungsprotokolle';

  @override
  String get desktopFeatureErpDescription =>
      'Reaktionsverhinderung und zeitlich begrenzte Übungen festhalten.';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription =>
      'Veränderungen des Drangs mit einem Live-Timer festhalten.';

  @override
  String get desktopFeatureActivityTitle => 'Recovery-Aktivität';

  @override
  String get desktopFeatureActivityDescription =>
      'Sachliche Aktivitäten und Wochenmuster ansehen.';

  @override
  String get desktopOneTimeLicense => 'Einmalige Lizenz';

  @override
  String desktopOneTimePrice(String price) {
    return '$price, einmaliger Kauf';
  }

  @override
  String get desktopPurchaseLicenseAction => 'Lizenz kaufen';

  @override
  String get desktopCheckoutUnavailable =>
      'Die Kaufseite ist in diesem Build nicht verfügbar.';

  @override
  String get desktopAlreadyPurchased =>
      'Bereits gekauft? Geben Sie Ihren Lizenzschlüssel ein';

  @override
  String get desktopLicensePrompt =>
      'Geben Sie Ihren Lemon-Squeezy-Lizenzschlüssel ein:';

  @override
  String get desktopLicenseLabel => 'Lizenzschlüssel';

  @override
  String get desktopLicenseHint => 'Lizenzschlüssel aus dem Beleg einfügen';

  @override
  String get desktopLicenseActivating => 'Lizenz wird aktiviert…';

  @override
  String get desktopActivateLicenseAction => 'Lizenz aktivieren';

  @override
  String get desktopLicenseBackAction => 'Zurück';

  @override
  String get desktopLicenseInvalid =>
      'Geben Sie den vollständigen Lizenzschlüssel aus Ihrem Beleg ein.';

  @override
  String get desktopLicenseRejected =>
      'Diese Lizenz konnte nicht für Patterns Desktop Pro bestätigt werden. Prüfen Sie den Schlüssel und versuchen Sie es erneut.';

  @override
  String get desktopLicenseUnavailable =>
      'Der Lizenzdienst ist nicht erreichbar. Prüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get desktopLicenseNotConfigured =>
      'Die Lizenzaktivierung ist in diesem Build nicht verfügbar.';

  @override
  String get journalTitle => 'Tagebuch';

  @override
  String get journalSearchAction => 'Tagebuch durchsuchen';

  @override
  String get journalChooseDateAction => 'Datum auswählen';

  @override
  String get journalSearchHint => 'Einträge durchsuchen';

  @override
  String get journalClearSearchAction => 'Suche löschen';

  @override
  String get journalNoMatchesTitle => 'Keine Treffer';

  @override
  String journalNoMatchesBody(String query) {
    return 'Kein Eintrag passt zu „$query“.';
  }

  @override
  String get journalEmptyTitle => 'Noch keine Tagebucheinträge';

  @override
  String get journalEmptyBody =>
      'Ein paar ruhige Zeilen genügen für den Anfang.';

  @override
  String get journalLoadError =>
      'Die Tagebucheinträge konnten nicht geladen werden. Versuchen Sie es erneut.';

  @override
  String get journalLoadingLabel => 'Tagebucheinträge werden geladen';

  @override
  String get journalSavingStatus => 'Wird gespeichert…';

  @override
  String get journalSavedStatus => 'Gespeichert';

  @override
  String get journalUnsavedStatus => 'Nicht gespeichert';

  @override
  String get journalClearDayAction => 'Diesen Tag löschen';

  @override
  String get journalSaveAction => 'Speichern';

  @override
  String get journalStartWritingPlaceholder => 'Schreiben Sie los…';

  @override
  String get journalFormatSelectionHint => 'Text zum Formatieren auswählen';

  @override
  String get journalClearedMessage =>
      'Der Eintrag für diesen Tag wurde gelöscht.';

  @override
  String get journalNothingToSaveMessage =>
      'Noch gibt es nichts zu speichern. Schreiben Sie eine Zeile, wenn Sie bereit sind.';

  @override
  String get journalClearDayTitle => 'Diesen Tag löschen?';

  @override
  String journalClearDayBody(String date) {
    return 'Dadurch wird alles gelöscht, was für $date gespeichert ist. Sie können später jederzeit wieder für diesen Tag schreiben.';
  }

  @override
  String get journalKeepEntryAction => 'Behalten';

  @override
  String get journalTodayEntry => 'Heutiger Eintrag';

  @override
  String get journalOpenEntryAction => 'Eintrag öffnen';

  @override
  String journalOpenEntryHint(String date) {
    return 'Öffnet den Tagebucheintrag für $date.';
  }

  @override
  String get journalWorkspaceTitle => 'Tagebuch-Arbeitsbereich';

  @override
  String get journalSubtitle => 'Ihr Raum zum Nachdenken und Loslassen.';

  @override
  String get journalNewEntryAction => 'Neuer Eintrag';

  @override
  String get journalEarlierSection => 'Früher';

  @override
  String get journalNoEntryForDate =>
      'Für dieses Datum gibt es keinen Eintrag.';

  @override
  String get journalCreateEntryAction => 'Eintrag erstellen';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date um $time';
  }

  @override
  String get journalDeleteEntryAction => 'Eintrag löschen';

  @override
  String get journalDeleteEntryTitle => 'Eintrag löschen?';

  @override
  String get journalDeleteEntryBody =>
      'Dieser Tagebucheintrag wird dauerhaft gelöscht.';

  @override
  String get journalDeletedMessage => 'Der Tagebucheintrag wurde gelöscht.';

  @override
  String get journalEditAction => 'Bearbeiten';

  @override
  String journalEditingDate(String date) {
    return 'Bearbeitung: $date';
  }

  @override
  String get journalUnsavedChangesStatus => 'Ungespeicherte Änderungen';

  @override
  String get journalEntrySavedMessage => 'Tagebucheintrag gespeichert';

  @override
  String journalReadOnlyLabel(String date) {
    return 'Schreibgeschützter Tagebucheintrag für $date';
  }

  @override
  String get journalThemeContamination => 'Kontamination';

  @override
  String get journalThemeUncertainty => 'Unsicherheit';

  @override
  String get journalThemeChecking => 'Kontrollieren';

  @override
  String get journalThemeRelationship => 'Beziehung';

  @override
  String get journalThemeHealth => 'Gesundheit';

  @override
  String get todayGreetingMorning => 'Guten Morgen';

  @override
  String get todayGreetingAfternoon => 'Guten Tag';

  @override
  String get todayGreetingEvening => 'Guten Abend';

  @override
  String get todayEncouragement =>
      'Sie schaffen das. Eine Entscheidung nach der anderen.';

  @override
  String get todayContinuePractice => 'Praxis fortsetzen';

  @override
  String get todaySeeAllAction => 'Alle anzeigen';

  @override
  String get todayQuickActions => 'Schnellaktionen';

  @override
  String get todayChooseActivity => 'Was möchten Sie tun?';

  @override
  String get todayWriteSomethingTitle => 'Etwas aufschreiben';

  @override
  String get todayWriteSomethingBody =>
      'Bringen Sie einen Gedanken aus dem Kopf aufs Papier.';

  @override
  String get todayDelayUrgeTitle => 'Einen Drang aufschieben';

  @override
  String get todayDelayUrgeBody => 'Schaffen Sie Abstand, bevor Sie reagieren.';

  @override
  String get todayPracticeErpTitle => 'Üben (ERP)';

  @override
  String get todayPracticeErpBody => 'Eine kurze, angeleitete Übung.';

  @override
  String get todayFirstJournalTitle => 'Einen weiteren Moment notieren';

  @override
  String get todayFirstJournalBody =>
      'Einen Gedanken zu benennen kann helfen, ihn zu beobachten.';

  @override
  String get todayFirstErpTitle => 'Erneut üben';

  @override
  String get todayFirstErpBody =>
      'Probieren Sie eine weitere kurze, angeleitete ERP-Übung.';

  @override
  String get todayFirstDelayTitle => 'Zwei Minuten aufschieben';

  @override
  String get todayFirstDelayBody =>
      'Wenn der Drang stark ist, schaffen Sie etwas Abstand, bevor Sie handeln.';

  @override
  String get todayStartPracticeAction => 'Übung starten';

  @override
  String get todayStartDelayAction => 'Aufschub starten';

  @override
  String get todayProTitle => 'Mit Patterns Pro fortfahren';

  @override
  String get todayProBody =>
      'Erstellen Sie einen Plan, üben Sie und sehen Sie Ihre Aktivitäten im Zeitverlauf an.';

  @override
  String get todayHideSevenDays => '7 Tage ausblenden';

  @override
  String get todayPracticeProgress => 'Übungsverlauf';

  @override
  String get todaySteadyPractice => 'Regelmäßige Praxis';

  @override
  String get todayStartGently => 'Behutsam beginnen';

  @override
  String get todayPracticeActiveBody =>
      'Ihre erfassten Aktivitäten ergeben mit der Zeit ein längerfristiges Bild.';

  @override
  String get todayPracticeEmptyBody =>
      'Dies verändert sich, wenn Sie schreiben, erfassen und üben.';

  @override
  String get todayProgressDisclaimer =>
      'Dies spiegelt die Häufigkeit erfasster Übungen wider, keine Diagnose oder klinische Beurteilung. In einer schwierigen Woche kann der Wert niedriger sein.';

  @override
  String get todayProgressStartedTitle => 'Ihre Aktivitäten nehmen Gestalt an';

  @override
  String get todayProgressPendingBody =>
      'Ein Verlaufswert erscheint, nachdem an mehreren Tagen Aktivitäten erfasst wurden.';

  @override
  String get todayScoreNew => 'Neu';

  @override
  String get todayScoreStrong => 'Stark';

  @override
  String get todayScoreSteady => 'Stetig';

  @override
  String get todayScoreBuilding => 'Im Aufbau';

  @override
  String get todayScoreStarting => 'Am Anfang';

  @override
  String get todayBeginCheckIn => 'Beginnen Sie mit einem kurzen Check-in';

  @override
  String get todayNoChange => 'Keine Veränderung zum vorherigen Zeitraum';

  @override
  String todayPointsUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points Punkte höher',
      one: '1 Punkt höher',
    );
    return '$_temp0 als im vorherigen Zeitraum';
  }

  @override
  String todayPointsDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points Punkte niedriger',
      one: '1 Punkt niedriger',
    );
    return '$_temp0 als im vorherigen Zeitraum';
  }

  @override
  String get todayNextStep => 'Ihr nächster Schritt';

  @override
  String get todayNextSelfCheckTitle => 'Stand festhalten';

  @override
  String get todayNextSelfCheckBody =>
      'Ein Selbstcheck kann einen Ausgangswert für spätere Vergleiche festhalten.';

  @override
  String get todayNextSelfCheckAction => 'Selbstcheck starten';

  @override
  String get todayNextHierarchyTitle => 'Praxis vorbereiten';

  @override
  String get todayNextHierarchyBody =>
      'Erstellen Sie eine Expositionsleiter von leichteren zu schwierigeren Schritten.';

  @override
  String get todayNextHierarchyAction => 'Leiter erstellen';

  @override
  String get todayNextPracticeTitle => 'Heutige Übung auswählen';

  @override
  String get todayNextPracticeBody =>
      'Wählen Sie für heute eine machbare ERP-Übung.';

  @override
  String get todayNextPracticeAction => 'Übung starten';

  @override
  String get todayNextReflectTitle => 'Übung reflektieren';

  @override
  String get todayNextReflectBody =>
      'Halten Sie fest, was Ihnen bei der heutigen Übung aufgefallen ist.';

  @override
  String get todayNextReflectAction => 'Reflektieren';

  @override
  String get todayNextJournalTitle => 'Über den heutigen Tag nachdenken';

  @override
  String get todayNextJournalBody =>
      'Notieren Sie, was Ihnen bei Ihrer Übung aufgefallen ist.';

  @override
  String get todayNextJournalAction => 'Tagebuch öffnen';

  @override
  String get todayCompulsionDelay => 'Zwangsaufschub';

  @override
  String get todayStartErp => 'ERP-Übung starten';

  @override
  String get todayResistUrgeBody =>
      'Bleiben Sie beim Drang, bevor Sie entscheiden, was Sie tun.';

  @override
  String get todayBuildToleranceBody =>
      'Üben Sie einen machbaren Schritt in Ihrem Tempo.';

  @override
  String get todayResumeAction => 'Fortsetzen';

  @override
  String get todayStartAction => 'Starten';

  @override
  String get todayJournalBody =>
      'Schreiben und reflektieren Sie in Ihrem privaten Tagebuch.';

  @override
  String get todayExposureTools => 'Expositionswerkzeuge';

  @override
  String get todayExposureToolsBody =>
      'Hierarchie, Materialien und Unsicherheitsübungen.';

  @override
  String get todayInsightsBody => 'Sehen Sie Ihre erfassten Aktivitäten an.';

  @override
  String get todaySelfCheckTitle => 'Eigene Muster verstehen';

  @override
  String get todaySelfCheckDuration => 'Optional · etwa 10 Min.';

  @override
  String get todayInsightsPlaceholder =>
      'Ihre Einblicke erscheinen hier, sobald Sie Aktivitäten erfassen.';

  @override
  String get todayDailyCheckInComplete => 'Täglicher Check-in erfasst';

  @override
  String get todayDailyCheckIn => 'Täglicher Check-in';

  @override
  String get todayDailyCompleteBody =>
      'Für heute ist ein Tagebucheintrag erfasst.';

  @override
  String get todayDailyBody =>
      'Schreiben Sie einen kurzen Tagebucheintrag, wenn Sie bereit sind.';

  @override
  String get todayOpenAction => 'Öffnen';

  @override
  String get todayCheckInAction => 'Eintragen';

  @override
  String get todayRecoveryScore => 'Recovery-Wert';

  @override
  String todayActivitiesLastSevenDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aktivitäten in den letzten 7 Tagen',
      one: '1 Aktivität in den letzten 7 Tagen',
    );
    return '$_temp0';
  }

  @override
  String get todayActivityRecorded => 'Aus erfassten Aktivitäten berechnet';

  @override
  String get todayPracticesRecorded => 'Erfasste Übungen';

  @override
  String get todayPracticeStreak => 'Übungsserie';

  @override
  String todaySessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sitzungen',
      one: '1 Sitzung',
    );
    return '$_temp0';
  }

  @override
  String todayDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get todayPickUpBody => 'Fahren Sie bei der zuvor erfassten Zeit fort.';

  @override
  String get todayPracticeUrgesBody =>
      'Üben Sie zu warten, bevor Sie auf einen Drang reagieren.';

  @override
  String get todayReadCheckIn => 'Heutigen Check-in lesen';

  @override
  String get todayOpenJournalMore => 'Tagebuch zum Lesen oder Ergänzen öffnen';

  @override
  String get todayShortJournal => 'Einen kurzen Tagebucheintrag schreiben';

  @override
  String get todayExplore => 'Entdecken';

  @override
  String get todayReflectProcess => 'Reflektieren und verarbeiten';

  @override
  String get todayRecoveryTools => 'Recovery-Werkzeuge';

  @override
  String get todaySupportPractice => 'Unterstützung für Ihre Praxis';

  @override
  String get todayTrackBody => 'Gedanken und Dränge erfassen';

  @override
  String get todaySeePatterns => 'Erfasste Muster ansehen';

  @override
  String todayScoreA11y(int score, String label) {
    return 'Übungsverlauf: $score von 100, $label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return 'Übungszeit: $elapsed von $planned vergangen';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day: Aktivität erfasst';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day: keine Aktivität erfasst';
  }

  @override
  String get trackerTitle => 'Erfassen';

  @override
  String get trackerPauseUrgeAction => 'Vor einer Reaktion warten';

  @override
  String get trackerFilterGroupLabel => 'Erfasste Momente filtern';

  @override
  String get trackerFilterAll => 'Alle';

  @override
  String get trackerFilterObsessions => 'Zwangsgedanken';

  @override
  String get trackerFilterCompulsions => 'Zwangshandlungen';

  @override
  String get trackerLoadingLabel => 'Erfasste Momente werden geladen';

  @override
  String get trackerLoadError =>
      'Ihre erfassten Momente konnten nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get trackerEditTitle => 'Ereignis bearbeiten';

  @override
  String get trackerAddTitle => 'Ereignis erfassen';

  @override
  String get trackerTypeGroupLabel => 'Ereignistyp';

  @override
  String get trackerTypeObsession => 'Zwangsgedanke';

  @override
  String get trackerTypeCompulsion => 'Zwangshandlung';

  @override
  String get trackerThoughtLabel => 'Was sagte der Gedanke?';

  @override
  String get trackerUrgeLabel => 'Wie lautete der Drang?';

  @override
  String get trackerThoughtHint => 'Benennen Sie den Gedanken oder das Bild.';

  @override
  String get trackerUrgeHint =>
      'Benennen Sie den Drang oder die Zwangshandlung.';

  @override
  String get trackerActionLabel => 'Wozu hat die Zwangsstörung Sie gedrängt?';

  @override
  String get trackerActionHint => 'Eine kurze Notiz genügt.';

  @override
  String get trackerResponseLabel => 'Was Sie stattdessen getan haben';

  @override
  String get trackerResponseHint =>
      'Halten Sie jede gewählte Reaktion fest, auch ein teilweises Aufschieben.';

  @override
  String get trackerSavingAction => 'Speichern…';

  @override
  String get trackerUpdateAction => 'Ereignis aktualisieren';

  @override
  String get trackerSaveAction => 'Ereignis speichern';

  @override
  String get trackerContentRequired =>
      'Wenn Sie bereit sind, schreiben Sie ein paar Worte dazu, was passiert ist.';

  @override
  String get trackerSaveError =>
      'Ihr Ereignis konnte nicht gespeichert werden. Bitte versuchen Sie es erneut.';

  @override
  String get trackerUpdateError =>
      'Ihr Ereignis konnte nicht aktualisiert werden. Bitte versuchen Sie es erneut.';

  @override
  String get trackerEditTooltip => 'Ereignis bearbeiten';

  @override
  String get trackerDeleteTooltip => 'Ereignis löschen';

  @override
  String trackerDistressValue(int value) {
    return 'Belastung $value von 10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => 'Keine Reaktion notiert';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type. $date. Belastung $distress von 10. $content. Reaktion: $response';
  }

  @override
  String get trackerDeleteTitle => 'Ereignis löschen?';

  @override
  String get trackerDeleteBody =>
      'Dadurch wird das Ereignis aus Ihrem lokalen Verlauf auf diesem Gerät entfernt.';

  @override
  String get trackerDeleteAction => 'Löschen';

  @override
  String get trackerDeletedMessage => 'Ereignis gelöscht';

  @override
  String get trackerDeleteError =>
      'Ihr Ereignis konnte nicht gelöscht werden. Bitte versuchen Sie es erneut.';

  @override
  String get trackerDistressLabel => 'Belastung, 0 bis 10';

  @override
  String get trackerEmptyTitle => 'Noch keine Ereignisse';

  @override
  String get trackerEmptyBody =>
      'Erfassen Sie nur, was hilfreich erscheint. Eine kurze Notiz genügt.';

  @override
  String get trackerEmptyAction => 'OCD-Ereignis erfassen';

  @override
  String get insightsTitle => 'Einblicke';

  @override
  String get insightsExportReport => 'Bericht exportieren';

  @override
  String get insightsObsessionsLogged => 'Erfasste Zwangsgedanken';

  @override
  String get insightsThemesFound => 'Erkannte Themen';

  @override
  String get insightsCompulsions => 'Zwangshandlungen';

  @override
  String get insightsAverageIntensityShort => 'Durchschnittliche Intensität';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => 'Übungsverlauf';

  @override
  String get insightsScoreNeedsMoreActivity =>
      'Eine Punktzahl erscheint nach einigen Übungen an verschiedenen Tagen, damit sie einen Verlauf statt eines einzelnen Moments zeigt. Die Sitzungen unten werden bereits gezählt.';

  @override
  String get insightsScoreEmpty =>
      'Nach einigen Übungen erscheint hier eine Punktzahl. Im Moment gibt es noch nichts zu messen.';

  @override
  String insightsComparedPreviousDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'den vorherigen $count Tagen',
      one: 'dem vorherigen Tag',
    );
    return 'im Vergleich zu $_temp0';
  }

  @override
  String get insightsComparedPreviousRange =>
      'im Vergleich zum vorherigen Zeitraum';

  @override
  String get insightsPracticeProgressBoundary =>
      'Zeigt, wie oft Sie üben, nicht eine Diagnose oder Ihren klinischen Zustand. In einer schwierigen Woche kann die Zahl niedriger sein.';

  @override
  String get insightsMoodOverTime => 'Stimmung im Zeitverlauf';

  @override
  String get insightsMoodGood => 'Gut';

  @override
  String get insightsMoodOkay => 'Okay';

  @override
  String get insightsMoodLow => 'Niedrig';

  @override
  String get insightsYbocsOverTime => 'Y-BOCS im Zeitverlauf';

  @override
  String get insightsYbocsEmpty =>
      'Nach dem Selbsttest beginnt Ihr erfasster Gesamtwert hier eine Linie.';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return 'Bereich $severity. Wiederholen Sie den Selbsttest in einigen Wochen, um einen weiteren erfassten Punkt hinzuzufügen.';
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
      other: '$count Selbsttests',
      one: '1 Selbsttest',
    );
    return 'über $_temp0';
  }

  @override
  String get insightsYbocsBoundary =>
      'Eine Momentaufnahme, keine Diagnose. Erfasste Gesamtwerte können schwanken, und ein höherer Wert bestimmt nicht Ihren Verlauf.';

  @override
  String get insightsAverageUrgeIntensity =>
      'Durchschnittliche Drangintensität';

  @override
  String get insightsErpPractice => 'ERP-Übung';

  @override
  String insightsSessions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sitzungen',
      one: 'Sitzung',
    );
    return '$_temp0';
  }

  @override
  String get insightsConsistency => 'Regelmäßigkeit';

  @override
  String insightsActiveDays(int active, int total) {
    return '$active von $total Tagen';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return 'An $active von $total Tagen wurde Aktivität erfasst';
  }

  @override
  String get insightsTopThemes => 'Häufigste Themen';

  @override
  String get insightsThemesEmpty =>
      'Themen erscheinen, wenn Sie erfassen, worauf sich die Zwangsstörung richtet.';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme, $percent Prozent der erfassten Themen';
  }

  @override
  String get insightsChangeRange => 'Zeitraum ändern';

  @override
  String get insightsOverviewTab => 'Übersicht';

  @override
  String get insightsObsessionsTab => 'Zwangsgedanken';

  @override
  String get insightsCompulsionsTab => 'Zwangshandlungen';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ Anstieg um $value, $comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ Rückgang um $value, $comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ Keine Änderung, $comparison';
  }

  @override
  String get insightsNoData => 'Noch keine Daten';

  @override
  String get insightsLoading => 'Einblicke werden geladen';

  @override
  String get insightsLoadError =>
      'Ihre Einblicke konnten nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date: $value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title. Erfasste Punkte: $values';
  }

  @override
  String get ybocsSeveritySubclinical => 'Subklinisch';

  @override
  String get ybocsSeverityMild => 'Leicht';

  @override
  String get ybocsSeverityModerate => 'Mittelgradig';

  @override
  String get ybocsSeveritySevere => 'Schwer';

  @override
  String get ybocsSeverityExtreme => 'Extrem';

  @override
  String get insightsThemeContamination => 'Kontamination';

  @override
  String get insightsThemeHarm => 'Schaden';

  @override
  String get insightsThemeChecking => 'Kontrollieren';

  @override
  String get insightsThemeReassurance => 'Rückversicherung';

  @override
  String get insightsThemeHealth => 'Gesundheit';

  @override
  String get insightsThemeRelationship => 'Beziehung';

  @override
  String get insightsThemeSymmetry => 'Symmetrie';

  @override
  String get insightsThemeMoral => 'Moral';

  @override
  String get insightsThemeRumination => 'Grübeln';

  @override
  String get insightsThemeUncertainty => 'Unsicherheit';

  @override
  String get insightsThemeOther => 'Sonstiges';

  @override
  String get recoveryTitle => 'Recovery';

  @override
  String get recoverySubtitle =>
      'Hilfen und Übungen, passend zu deinem aktuellen Schritt.';

  @override
  String get recoveryImmediateHelpTitle =>
      'Unterstützung in einem schwierigen Moment';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Notfall-Toolkit',
      'copingLibrary': 'Hilfen zum Bewältigen',
      'compulsionDelay': 'Zwangshandlung aufschieben',
      'ybocsSelfCheck': 'OCD-Selbstcheck',
      'recoveryMetrics': 'Recovery-Aktivität',
      'exposureHierarchy': 'Expositionshierarchie',
      'exposureMaterials': 'Expositionsmaterialien',
      'structuredPrograms': 'Strukturierte Programme',
      'actionPlanner': 'Handlungsplan',
      'implementationIntentions': 'Wenn-dann-Pläne',
      'guidedErp': 'Begleitete ERP',
      'urgeSurfing': 'Drang surfen',
      'responsePrevention': 'Reaktionsverhinderung',
      'uncertaintyTraining': 'Unsicherheit üben',
      'behavioralExperiments': 'Verhaltensexperimente',
      'reflectionJournal': 'Reflexionstagebuch',
      'other': 'Recovery-Hilfe',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Schnelle Hilfe zum Stabilisieren.',
      'copingLibrary': 'Ankommen und neu orientieren.',
      'compulsionDelay': 'Vor dem Reagieren Raum schaffen.',
      'ybocsSelfCheck': 'Ein Y-BOCS-Check-in.',
      'recoveryMetrics': 'Aufgezeichnete Aktivität ansehen.',
      'exposureHierarchy': 'Deine Stufenleiter aufbauen.',
      'exposureMaterials': 'Skripte und Links sammeln.',
      'structuredPrograms': 'Begleitete Wochen durchgehen.',
      'actionPlanner': 'Reaktionen vorausplanen.',
      'implementationIntentions': 'Wenn-dann-Pläne erstellen.',
      'guidedErp': 'Einen Plan üben.',
      'urgeSurfing': 'Auf der Welle bleiben.',
      'responsePrevention': 'Festhalten, was du stattdessen getan hast.',
      'uncertaintyTraining': 'Dem Vielleicht Raum geben.',
      'behavioralExperiments': 'Die Vorhersage von OCD prüfen.',
      'reflectionJournal': 'Festhalten, was dir aufgefallen ist.',
      'other': 'Eine Recovery-Hilfe öffnen.',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Einschätzen',
      'plan': 'Planen',
      'practice': 'Üben',
      'review': 'Rückblick',
      'other': 'Hilfen',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Sieh, wo du gerade stehst.',
      'plan': 'Bereite deine Übung vor.',
      'practice': 'Mach eine Übung.',
      'review': 'Reflektiere und lerne.',
      'other': 'Wähle, was hilfreich ist.',
    });
    return '$_temp0';
  }

  @override
  String get recoveryProBadge => 'Patterns Pro';

  @override
  String recoveryOpenToolHint(String title) {
    return '$title öffnen';
  }

  @override
  String recoveryLockedToolHint(String title) {
    return '$title erfordert Patterns Pro';
  }

  @override
  String get delayNameUrgeValidation =>
      'Wenn du bereit bist, benenne den Drang, mit dem du sitzen möchtest.';

  @override
  String get delayOutcomeValidation =>
      'Wenn du bereit bist, wähle aus, was du am Ende getan hast.';

  @override
  String get delaySaveError =>
      'Deine Übung konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get delayStopEarlyTitle => 'Früher aufhören?';

  @override
  String get delayStopEarlyBody =>
      'Es ist in Ordnung aufzuhören. Die gewartete Zeit kann trotzdem gespeichert werden.';

  @override
  String get delayKeepGoingAction => 'Weitermachen';

  @override
  String get delayStopAction => 'Ich muss aufhören';

  @override
  String get delaySetupTitle => 'Den Drang pausieren';

  @override
  String get delayUrgeQuestion => 'Mit welchem Drang sitzt du gerade?';

  @override
  String get delayUrgeHint =>
      'Zum Beispiel: das Schloss prüfen, waschen oder online suchen';

  @override
  String get delayUrgeBeforeLabel => 'Wie stark ist der Drang gerade?';

  @override
  String get delayDurationQuestion => 'Wie lange möchtest du warten?';

  @override
  String get delayDurationGroupLabel => 'Dauer des Aufschubs';

  @override
  String get delayBeginAction => 'Beginnen';

  @override
  String get delayCountdownTitle => 'Du bleibst bei dem Gefühl';

  @override
  String get delayCountdownBody =>
      'Nimm den Drang wahr, ohne zu handeln. Du kannst entscheiden, was als Nächstes passiert.';

  @override
  String get delayReflectionTitle => 'Was ist passiert?';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed':
          'Die geplante Zeit ist beendet. Die Angaben unten sind freiwillig.',
      'early':
          'Du hast den Timer früher beendet. Die Angaben unten sind freiwillig.',
      'other': 'Der Timer ist beendet. Die Angaben unten sind freiwillig.',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel => 'Wie stark ist der Drang jetzt?';

  @override
  String get delayOutcomeQuestion => 'Was hast du mit dem Drang gemacht?';

  @override
  String get delayOutcomeGroupLabel => 'Aufgezeichnetes Ergebnis';

  @override
  String get delayNoteLabel => 'Ist dir etwas aufgefallen? (optional)';

  @override
  String get delayNoteHint => 'Eine kurze Notiz reicht.';

  @override
  String get delaySavingAction => 'Wird gespeichert…';

  @override
  String get delaySaveAction => 'Übung speichern';

  @override
  String delayMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Min.',
      one: '1 Min.',
    );
    return '$_temp0';
  }

  @override
  String get delayCustomAction => 'Eigene Dauer';

  @override
  String get delayCustomTitle => 'Eigener Aufschub';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Nicht ausgeführt',
      'delayed': 'Aufgeschoben',
      'performed': 'Ausgeführt',
      'other': 'Nicht ausgewählt',
    });
    return '$_temp0';
  }

  @override
  String delayUrgeValue(int value) {
    return 'Drang $value von 10';
  }

  @override
  String delayCustomMinutesValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten',
      one: '1 Minute',
    );
    return 'Eigener Aufschub: $_temp0';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation':
          'Wenn du bereit bist, wähle aus, was während der Übung passiert ist.',
      'saveError':
          'Deine ERP-Übung konnte nicht gespeichert werden. Bitte versuche es erneut.',
      'stopTitle': 'Früher aufhören?',
      'stopBody':
          'Es ist in Ordnung aufzuhören. Die geübte Zeit kann trotzdem gespeichert werden.',
      'keepGoing': 'Weitermachen',
      'stop': 'Aufhören',
      'anxietyBefore': 'Wie stark ist der Drang oder die Angst gerade?',
      'duration': 'Dauer',
      'start': 'Übung starten',
      'countdownCue': 'Üben ohne',
      'resisting': 'Reaktion, die du nicht ausführst',
      'countdownBody':
          'Du musst die Vorhersage nicht widerlegen, bevor der Timer endet.',
      'stopEarly': 'Früher aufhören',
      'reflectionTitle': 'Reflektieren',
      'reflectionBody':
          'Die Angaben unten sind freiwillig. Halte nur fest, was für dich hilfreich ist.',
      'anxietyAfter': 'Wie stark ist es jetzt?',
      'outcomeQuestion': 'Was hast du getan?',
      'whatHappened': 'Was ist tatsächlich passiert?',
      'whatHappenedHint':
          'Was ist dir während oder nach der Übung aufgefallen?',
      'learning': 'Für das nächste Mal',
      'learningHint':
          'Woran möchtest du dich erinnern, wenn OCD das nächste Mal fragt?',
      'exposure': 'Exposition',
      'prediction': 'Vorhersage',
      'commitment': 'Vorhaben',
      'saving': 'Wird gespeichert…',
      'save': 'Übung speichern',
      'other': 'ERP-Übung',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Die geplante Zeit ist beendet.',
      'early': 'Du hast den Timer früher beendet.',
      'other': 'Der Timer ist beendet.',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Reaktion nicht ausgeführt',
      'delayed': 'Reaktion aufgeschoben',
      'performed': 'Reaktion ausgeführt',
      'other': 'Nicht ausgewählt',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return 'Intensität $value von 10';
  }

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Geführte ERP',
      'subtitle':
          'Nutze einen Plan erneut, übe und halte fest, was passiert ist.',
      'myPlans': 'Meine ERP-Pläne',
      'newAction': 'Neu',
      'plansError': 'ERP-Pläne sind gerade nicht verfügbar.',
      'recentPractice': 'Letzte Übungen',
      'historyError': 'Der Übungsverlauf ist gerade nicht verfügbar.',
      'archiveTitle': 'Diesen Plan archivieren?',
      'archiveBody':
          'Er wird aus deinen aktiven Plänen entfernt, vergangene Übungen bleiben aber im Verlauf.',
      'keepAction': 'Behalten',
      'archiveAction': 'Archivieren',
      'exposureValidation':
          'Wenn du bereit bist, benenne die Situation, mit der du üben möchtest.',
      'commitmentValidation':
          'Wähle die Reaktion, die du nicht ausführen möchtest, damit der Plan gespeichert werden kann.',
      'saveError':
          'Dein ERP-Plan konnte nicht gespeichert werden. Bitte versuche es erneut.',
      'updated': 'ERP-Plan aktualisiert.',
      'created': 'ERP-Plan erstellt.',
      'editTitle': 'ERP-Plan bearbeiten',
      'createTitle': 'ERP-Plan erstellen',
      'exerciseType': 'Übungsart',
      'exposureTarget': 'Expositionsziel',
      'ocdPrediction': 'OCD-Vorhersage',
      'preventionCommitment': 'Vorhaben zur Reaktionsverhinderung',
      'defaultDuration': 'Standarddauer',
      'saving': 'Wird gespeichert…',
      'saveAction': 'Plan speichern',
      'createAction': 'Plan erstellen',
      'emptyTitle': 'Erstelle deinen ersten ERP-Plan',
      'emptyBody':
          'Notiere Exposition, Vorhersage und die Reaktion, die du nicht ausführen möchtest, einmal. Danach kannst du den Plan wiederverwenden.',
      'moreActions': 'Weitere Planaktionen',
      'editAction': 'Plan bearbeiten',
      'archivePlanAction': 'Plan archivieren',
      'practiceGuide': 'Übungsleitfaden',
      'historyEmpty': 'Abgeschlossene Übungen erscheinen hier.',
      'customDuration': 'Eigene Dauer',
      'other': 'ERP-Plan',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return 'Nicht ausführen: $response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction =>
      'OCD sagt, dass sich das Unbehagen nur ändert, wenn du reagierst.';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Kontrollieren aufschieben',
      'delayReassurance': 'Rückversicherung aufschieben',
      'delayGoogling': 'Googeln aufschieben',
      'delayRumination': 'Grübeln aufschieben',
      'delayWashing': 'Waschen aufschieben',
      'other': 'Geführte ERP',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Übe für kurze Zeit, etwas ungeprüft zu lassen.',
      'delayReassurance': 'Warte, bevor du jemanden um Gewissheit bittest.',
      'delayGoogling': 'Schiebe die Suche nach Gewissheit oder Beweisen auf.',
      'delayRumination': 'Bemerke mentales Problemlösen, ohne ihm zu folgen.',
      'delayWashing':
          'Warte, bevor du erneut wäschst, reinigst oder desinfizierst.',
      'other': 'Übe, eine Reaktion aufzuschieben.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Erstelle einen wiederverwendbaren Plan für Momente, in denen OCD dich drängt, Schlösser, Schalter, Nachrichten, Symptome oder Fehler erneut zu prüfen.',
      'delayReassurance':
          'Erstelle einen Plan für den Drang, zu fragen, zu gestehen, zu erklären oder dir bestätigen zu lassen, dass alles in Ordnung ist.',
      'delayGoogling':
          'Erstelle einen Plan für Momente, in denen OCD dich nach Symptomen, Bedeutungen, Risiken, Regeln oder Geschichten suchen lässt, bis du dich sicher fühlst.',
      'delayRumination':
          'Erstelle einen Plan für mentale Zwänge wie Wiederholen, Beweisen, Überprüfen oder Lösen.',
      'delayWashing':
          'Erstelle einen Plan für den Drang zu waschen, zu reinigen, zu desinfizieren oder neu anzufangen, weil sich etwas verunreinigt anfühlt.',
      'other': 'Erstelle einen wiederverwendbaren ERP-Übungsplan.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Mit ERP kannst du üben, Unsicherheit da sein zu lassen, ohne sofort ein Ritual auszuführen.',
      'delayReassurance':
          'Rückversicherung kann sich im Moment hilfreich anfühlen; wenn du sie aufschiebst, kannst du üben, etwas nicht zu wissen.',
      'delayGoogling':
          'Das Aufschieben der Suche unterbricht die Gewissheitsschleife und lässt dich üben, eine Frage unbeantwortet zu lassen.',
      'delayRumination':
          'Grübeln kann wie Denken wirken; ERP lässt dich üben, die Schleife zu verlassen, ohne das Argument zu Ende zu führen.',
      'delayWashing':
          'Durch Warten kannst du üben, ein Verunreinigungsgefühl da sein zu lassen, ohne sofort ein Ritual auszuführen.',
      'other':
          'Bei ERP übst du, Unsicherheit ohne ein sofortiges Ritual zuzulassen.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure':
          'Was lässt du ungeprüft oder prüfst du nur einmal?',
      'delayCheckingPrediction':
          'Was sagt OCD voraus, wenn du nicht erneut prüfst?',
      'delayCheckingCommitment':
          'Welches Kontrollritual möchtest du nicht ausführen?',
      'delayReassuranceExposure':
          'Welche Rückversicherung möchtest du erfragen?',
      'delayReassurancePrediction':
          'Was sagt OCD voraus, wenn du nicht fragst?',
      'delayReassuranceCommitment':
          'Welche Nachricht, welches Geständnis oder welche Frage wirst du zurückhalten?',
      'delayGooglingExposure':
          'Welche Suche oder Frage lässt du unbeantwortet?',
      'delayGooglingPrediction': 'Was musst du laut OCD jetzt wissen?',
      'delayGooglingCommitment':
          'Welche Suche, welchen Artikel oder welches Forum wirst du meiden?',
      'delayRuminationExposure':
          'Welche Gedankenschleife lässt du unvollendet?',
      'delayRuminationPrediction': 'Was musst du laut OCD lösen oder beweisen?',
      'delayRuminationCommitment':
          'Welche mentale Prüfung oder Argumentation wirst du nicht fortsetzen?',
      'delayWashingExposure':
          'Welche normale Hygienegrenze wirst du einhalten?',
      'delayWashingPrediction':
          'Was sagt OCD voraus, wenn du nicht erneut wäschst?',
      'delayWashingCommitment':
          'Welches zusätzliche Waschen, Reinigen oder Desinfizieren wirst du nicht ausführen?',
      'other': 'Welche Reaktion möchtest du nicht ausführen?',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Lege vor Beginn eine Kontrollregel fest.',
      'delayChecking2':
          'Prüfe einmal wie geplant, wenn dies zur normalen Sicherheit gehört.',
      'delayChecking3': 'Prüfe während des Timers nicht erneut.',
      'delayChecking4': 'Bemerke den Drang, ohne mit ihm zu verhandeln.',
      'delayReassurance1':
          'Lege die Bitte um Rückversicherung vor Beginn fest.',
      'delayReassurance2':
          'Sende während des Timers keine Nachricht und stelle die Frage nicht.',
      'delayReassurance3':
          'Lass das Unbehagen da sein, ohne Gewissheit zu suchen.',
      'delayReassurance4':
          'Kehre so sanft wie möglich zu deiner vorherigen Tätigkeit zurück.',
      'delayGoogling1': 'Lege die Suche fest, bevor du etwas anderes öffnest.',
      'delayGoogling2': 'Schließe das Suchfeld oder den Browser-Tab.',
      'delayGoogling3': 'Starte den Timer, bevor du etwas anderes liest.',
      'delayGoogling4': 'Lass die Frage vorerst unbeantwortet.',
      'delayRumination1':
          'Benenne die Schleife: überprüfen, lösen, beweisen oder kontrollieren.',
      'delayRumination2': 'Lass den Gedanken unvollendet.',
      'delayRumination3':
          'Lenke die Aufmerksamkeit auf eine gewöhnliche Aufgabe oder Empfindung zurück.',
      'delayRumination4':
          'Beginne jedes Mal sanft neu, wenn die Schleife dich zurückzieht.',
      'delayWashing1': 'Lege vor Beginn die normale Hygienegrenze fest.',
      'delayWashing2':
          'Beginne mit einer Verzögerung, die herausfordernd, aber möglich wirkt.',
      'delayWashing3':
          'Halte deine Hände während des Timers von Waschbecken und Desinfektionsmittel fern.',
      'delayWashing4':
          'Lass das Unbehagen da sein, ohne es perfekt machen zu wollen.',
      'other': 'Folge deinem gewählten Plan.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Einmal prüfen',
      'delayChecking2': 'Nicht erneut prüfen',
      'delayChecking3': 'Drang bemerken',
      'delayReassurance1': 'Frage zurückhalten',
      'delayReassurance2': 'Unsicherheit zulassen',
      'delayReassurance3': 'Sanft zurückkehren',
      'delayGoogling1': 'Suche schließen',
      'delayGoogling2': 'Timer starten',
      'delayGoogling3': 'Unbeantwortet lassen',
      'delayRumination1': 'Schleife benennen',
      'delayRumination2': 'Unvollendet lassen',
      'delayRumination3': 'Zur Aufgabe zurückkehren',
      'delayWashing1': 'Grenze festlegen',
      'delayWashing2': 'Waschen aufschieben',
      'delayWashing3': 'Unbehagen zulassen',
      'other': 'Plan folgen',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Strukturierte Programme',
      'subtitle':
          'Folge in deinem eigenen Tempo einem Plan von Woche zu Woche.',
      'themeGroup': 'Nach OCD-Thema',
      'themeGroupEmpty':
          'Wähle ein Thema, wenn es zu deiner gewünschten Übung passt.',
      'themeGroupMatched':
          'Themen aus deinem letzten Selbstcheck sind unten gekennzeichnet.',
      'generalGroup': 'Allgemeine Übungen',
      'generalCaption':
          'Fertigkeiten, die bei verschiedenen Themen genutzt werden können.',
      'enrollError':
          'Dieses Programm konnte nicht geöffnet werden. Bitte versuche es erneut.',
      'started': 'Begonnen',
      'notStarted': 'Nicht begonnen',
      'openHint': 'Programmdetails öffnen',
      'selfCheckMatch': 'Passt zu deinem Selbstcheck',
      'tapToStart': 'Zum Starten tippen',
      'progressLoadError':
          'Die Programmaktivität konnte nicht geladen werden. Bitte versuche es erneut.',
      'activityRecorded': 'Deine Aufgabenauswahl wird lokal gespeichert.',
      'taskSaveError':
          'Diese Aufgabenänderung konnte nicht gespeichert werden. Bitte versuche es erneut.',
      'weekComplete': 'Alle Aufgaben als abgeschlossen markiert',
      'weekNotComplete': 'Aufgaben verbleiben',
      'weekToggleHint': 'Diese Woche ein- oder ausklappen',
      'taskToggleHint': 'Diese Aufgabe markieren oder Markierung entfernen',
      'other': 'Programm',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$done von $total Aufgaben, $percent Prozent';
  }

  @override
  String structuredProgramSummary(int count, String subtitle) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wochen · $subtitle',
      one: '1 Woche · $subtitle',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramComplete(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aufgaben sind',
      one: '1 Aufgabe ist',
    );
    return 'Alle $_temp0 als abgeschlossen markiert.';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$done von $total Aufgaben als abgeschlossen markiert';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String emergencyToolkitText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Unterstützung für jetzt',
      'pauseTitle': 'Vor einer Reaktion innehalten',
      'pauseBody':
          'Sie müssen nicht sofort auf den Drang reagieren. Wählen Sie unten eine Selbsthilfeübung und gehen Sie langsam vor.',
      'boundary':
          'Diese Werkzeuge bieten keine Notfall- oder klinische Versorgung. Wenn Sie möglicherweise in unmittelbarer Gefahr sind, wenden Sie sich an die örtlichen Notfalldienste.',
      'breathe': 'Atmen',
      'breatheSubtitle': 'Einem ruhigen Atemrhythmus folgen',
      'delay': 'Den Drang aufschieben',
      'delaySubtitle': 'Mit einem Timer Abstand schaffen',
      'surf': 'Auf der Drangwelle bleiben',
      'surfSubtitle': 'Den Drang wahrnehmen, ohne danach zu handeln',
      'coping': 'Bewältigungstechniken',
      'copingSubtitle': 'Erdung, Akzeptanz und mehr',
      'remindersTitle': 'Ein paar Erinnerungen',
      'reminderThought':
          'Ein Gedanke verlangt keine Reaktion. Ich kann ihn wahrnehmen, ohne zu handeln.',
      'reminderUrge':
          'Ein Drang kann sich mit der Zeit verändern. Ich kann wählen, was ich als Nächstes tue.',
      'reminderUncertainty':
          'Ich kann der Unsicherheit in diesem Moment Raum geben.',
      'breatheIn': 'Einatmen',
      'hold': 'Halten',
      'breatheOut': 'Ausatmen',
      'breathingHint':
          'Folgen Sie dem Kreis: 4 Sekunden einatmen, halten, 4 Sekunden ausatmen, dann halten.',
      'other': 'Unterstützungswerkzeug',
    });
    return '$_temp0';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'OCD-Selbstcheck',
      'introBody':
          'Ein geführter Selbstcheck auf Grundlage der Yale-Brown Obsessive Compulsive Scale (Y-BOCS) zu den Mustern, die Sie bemerken, und dazu, wie sehr sie Sie beeinträchtigen.',
      'spotTitle': 'Muster wahrnehmen',
      'spotBody':
          'Wählen Sie Zwangsgedanken und Zwangshandlungen aus, die Sie erlebt haben.',
      'impactTitle': 'Auswirkungen festhalten',
      'impactBody':
          'Beantworten Sie 10 Fragen dazu, wie sehr sie Ihren Alltag beeinflussen.',
      'resultIntroTitle': 'Ergebnis ansehen',
      'resultIntroBody':
          'Sehen Sie erfasste Themen, Teilwerte und den Schweregradbereich.',
      'begin': 'Beginnen',
      'retakeAction': 'Erneut durchführen',
      'privacyDuration':
          'Dauert etwa 10 Minuten. Ihre Antworten bleiben auf diesem Gerät, sofern Sie sie nicht selbst exportieren.',
      'disclaimer':
          'Dieser Selbstcheck kann Ihnen helfen, Ihre Erfahrung zu beschreiben. Er stellt keine OCD-Diagnose und keine Notfallhilfe dar. Nur qualifizierte Fachpersonen können OCD diagnostizieren.',
      'historyTitle': 'Ihr Verlauf',
      'historyBody': 'Ihre zuvor erfassten Gesamtwerte werden hier angezeigt.',
      'deleteTitle': 'Selbstcheck löschen?',
      'deleteBody':
          'Dadurch wird dieser Selbstcheck dauerhaft von diesem Gerät entfernt.',
      'cancel': 'Abbrechen',
      'deleteAction': 'Löschen',
      'deleteTooltip': 'Selbstcheck löschen',
      'deleteSuccess': 'Selbstcheck gelöscht.',
      'deleteError':
          'Dieser Selbstcheck konnte nicht gelöscht werden. Bitte versuchen Sie es erneut.',
      'checklistTitle': 'Was kommt Ihnen bekannt vor?',
      'checklistBody':
          'Wählen Sie alles aus, was Sie jetzt oder früher erlebt haben. Überspringen Sie, was nicht passt.',
      'obsessions': 'Zwangsgedanken',
      'obsessionsDescription': 'Ungewollte Gedanken, Bilder oder Impulse',
      'compulsions': 'Zwangshandlungen',
      'compulsionsDescription':
          'Verhaltensweisen oder gedankliche Handlungen als Reaktion auf Belastung',
      'continueAction': 'Weiter',
      'seeResults': 'Ergebnis ansehen',
      'next': 'Weiter',
      'resultsTitle': 'Ihr Ergebnis',
      'retake': 'Wiederholen',
      'saved': 'Gespeichert',
      'saveHistory': 'In meinem Verlauf speichern',
      'saving': 'Wird gespeichert…',
      'saveSuccess': 'In Ihrem Verlauf gespeichert.',
      'saveError':
          'Dieser Selbstcheck konnte nicht gespeichert werden. Bitte versuchen Sie es erneut.',
      'breakdownTitle': 'Erfasste Teilwerte',
      'typesTitle': 'Erfasste Arten',
      'typesNone':
          'In diesem Selbstcheck wurde keine Art von Zwangsgedanken oder Zwangshandlungen erfasst.',
      'typesBoth':
          'In diesem Selbstcheck wurden Zwangsgedanken und Zwangshandlungen erfasst.',
      'typesObsessions': 'In diesem Selbstcheck wurden Zwangsgedanken erfasst.',
      'typesCompulsions':
          'In diesem Selbstcheck wurden Zwangshandlungen erfasst.',
      'themesTitle': 'Erfasste Themen',
      'themesBody':
          'Die Kategorien der Checkliste, in denen Sie Einträge ausgewählt haben.',
      'nextStepsTitle': 'Zu diesem Ergebnis',
      'nextStepsBody':
          'Dieses Ergebnis ist eine selbst berichtete Momentaufnahme, keine Diagnose und keine Notfallhilfe. Wenn diese Muster Ihr Leben beeinträchtigen, können Sie sie mit einer qualifizierten Fachperson besprechen. Wenn Sie möglicherweise in unmittelbarer Gefahr sind, wenden Sie sich an die örtlichen Notfalldienste.',
      'other': 'Y-BOCS-Selbstcheck',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Weiter · $count ausgewählt',
      one: 'Weiter · 1 ausgewählt',
      zero: 'Weiter',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return 'Frage $current von $total';
  }

  @override
  String ybocsScoreOutOf(int score, int maximum) {
    return '$score von $maximum';
  }

  @override
  String ybocsHistorySummary(String severity, int score, String date) {
    return '$severity · $score von 40 · $date';
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
      other: '$count Einträge ausgewählt',
      one: '1 Eintrag ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Aufgabe als abgeschlossen markiert.',
      'notCompleted': 'Aufgabe als nicht abgeschlossen markiert.',
      'other': 'Aufgabe aktualisiert.',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': '4 Wochen: Zwänge aufschieben',
      'uncertainty3wk': 'Unsicherheitstoleranz',
      'other': 'Strukturiertes Programm',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Übe Woche für Woche, Zwänge aufzuschieben',
      'uncertainty3wk': 'Übe, mit dem Nichtwissen zu leben',
      'other': 'Ein geführter Übungsplan',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': 'Woche 1 · Bemerken und benennen',
      'delayW2': 'Woche 2 · Den Abstand vergrößern',
      'delayW3': 'Woche 3 · Länger dabeibleiben',
      'delayW4': 'Woche 4 · Tägliche Übung',
      'uncertaintyW1': 'Woche 1 · Offenlassen',
      'uncertaintyW2': 'Woche 2 · Vielleicht, vielleicht nicht',
      'uncertaintyW3': 'Woche 3 · Sein lassen',
      'other': 'Programmwoche',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': '3 Dränge festhalten, ohne sofort zu handeln',
      'w1b': 'Einen Zwang dreimal um 1 Minute aufschieben',
      'w2a': 'Zwänge um 5 Minuten aufschieben',
      'w2b': 'Einmal Urge Surfing ausprobieren',
      'w3a': 'Um 15 Minuten aufschieben',
      'w3b': 'Einem Drang nach Rückversicherung widerstehen',
      'w4a': 'Jeden Tag eine Exposition durchführen',
      'w4b': 'Festhalten, was dir aufgefallen ist',
      'u1a': 'Eine Frage unbeantwortet lassen',
      'u1b': 'Einmaligem Kontrollieren widerstehen',
      'u2a': 'Dreimal mit „vielleicht, vielleicht nicht“ antworten',
      'u2b': 'Die Online-Suche zu einer Sorge aufschieben',
      'u3a': 'Einen Tag lang keine Gewissheit suchen',
      'u3b': 'Festhalten, was dir aufgefallen ist',
      'other': 'Programmaufgabe',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Verunreinigung und Waschen',
      'checking': 'Kontrollieren und Zweifel',
      'harm': 'Schadens- und Tabugedanken',
      'relationship': 'Beziehungszweifel',
      'justRight': 'Genau-richtig-Gefühl und Symmetrie',
      'other': 'OCD-Thema',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination':
          'Für Ängste, dass etwas schmutzig, ansteckend oder unsicher zu berühren ist, und das folgende Waschen oder Reinigen.',
      'checking':
          'Für Schlösser, Herdplatten, Schalter, Nachrichten und anderes, zu dem du zurückkehrst, weil es sich nicht sicher genug anfühlt.',
      'harm':
          'Für aufdringliche Gedanken über Schaden oder Themen, die gewalttätig, sexuell oder blasphemisch wirken, sowie folgende Zwänge oder Vermeidung.',
      'relationship':
          'Für wiederkehrende Zweifel daran, ob eine Beziehung richtig ist, ob du genug fühlst oder was der Zweifel bedeutet.',
      'justRight':
          'Für Dinge, die gleichmäßig, geordnet oder wiederholt sein müssen, bis sie sich richtig anfühlen.',
      'other': 'Ein nach einem OCD-Thema geordneter Übungspfad.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Verunreinigung',
      'checking': 'Kontrollieren',
      'harm': 'Schadens- und Tabugedanken',
      'relationship': 'Beziehungszweifel',
      'justRight': 'Genau richtig',
      'other': 'OCD-Thema',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'Die Y-BOCS-Checkliste entstand vor der Forschung zu Beziehungs-OCD, daher ist dieses Thema keine ihrer Kategorien. Du kannst diesen Übungspfad trotzdem nutzen.',
      'other':
          'Dieses Thema ist nicht als Kategorie der Y-BOCS-Checkliste vertreten.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': 'Woche 1 · Berühren, dann warten',
      'ct2': 'Woche 2 · Einmal waschen, nicht dreimal',
      'ct3': 'Woche 3 · Mit nach Hause nehmen',
      'ck1': 'Woche 1 · Einmal schauen',
      'ck2': 'Woche 2 · Kein mentales Wiederholen',
      'ck3': 'Woche 3 · Ungeklärt lassen',
      'hm1': 'Woche 1 · Da sein lassen',
      'hm2': 'Woche 2 · Nicht mehr fragen',
      'hm3': 'Woche 3 · Kein innerer Gerichtsprozess',
      'rl1': 'Woche 1 · Nicht mehr testen',
      'rl2': 'Woche 2 · Keine Rückversicherung',
      'rl3': 'Woche 3 · Mit Vielleicht leben',
      'jr1': 'Woche 1 · Schief lassen',
      'jr2': 'Woche 2 · Nicht wiederholen',
      'jr3': 'Woche 3 · Gut genug',
      'other': 'Themenwoche',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a':
          'Etwas leicht unsauber Wirkendes berühren und die Hände fünf Minuten nicht waschen',
      'ct1b': 'Den Drang davor und danach festhalten, ohne zu waschen',
      'ct2a':
          'Einmal normal waschen und nicht zu einer zweiten Runde zurückkehren',
      'ct2b': 'Eine Oberfläche zu Hause eine Woche lang ungereinigt lassen',
      'ct3a':
          'An einen Ort gehen, der danach meist zum Waschen anregt, und zu Hause nicht waschen',
      'ct3b': 'OCDs Vorhersage neben dem tatsächlichen Geschehen notieren',
      'ck1a': 'Eine Sache einmal prüfen und ohne zweiten Blick weggehen',
      'ck1b': 'Einmal das Haus ohne abschließenden Rundgang verlassen',
      'ck2a':
          'Wenn der Drang zum mentalen Wiederholen kommt, den Zweifel ungeklärt lassen',
      'ck2b':
          'Eine Nachricht senden, ohne sie davor oder danach erneut zu lesen',
      'ck3a': 'Einen Tag lang nichts ein zweites Mal prüfen',
      'ck3b': 'Festhalten, was geschah und was OCD vorhersagte',
      'hm1a':
          'Einen aufdringlichen Gedanken eine Minute da sein lassen, ohne mit ihm zu streiten oder ihn wegzudrängen',
      'hm1b':
          'Die mentale Prüfung bemerken, bevor sie beginnt, und sie sein lassen',
      'hm2a':
          'Nicht fragen, ob du ein guter Mensch bist, und auch nicht nach einer Antwort suchen',
      'hm2b':
          'In einer Situation bleiben, die du wegen des Gedankens gemieden hast',
      'hm3a': 'Einen Tag lang Gefühle nicht als Beweis über dich prüfen',
      'hm3b': 'Festhalten, wie die Woche war, ohne dich zu bewerten',
      'rl1a': 'Einen Verträglichkeitstest bemerken und einmal auslassen',
      'rl1b': 'Einen Beziehungszweifel zehn Minuten unbeantwortet lassen',
      'rl2a':
          'Einen Tag lang weder Partner, Freunde noch das Internet fragen, ob die Beziehung richtig ist',
      'rl2b': 'Etwas zusammen tun, ohne dabei deine Gefühle zu überwachen',
      'rl3a':
          'Mit „vielleicht, vielleicht nicht“ antworten, wenn die Frage kommt',
      'rl3b':
          'Über die Woche nachdenken, ohne eine Zukunftsentscheidung zu treffen',
      'jr1a':
          'Einen Gegenstand leicht versetzt lassen und das Gefühl da sein lassen',
      'jr1b': 'Etwas einmal tun, obwohl es sich nicht abgeschlossen anfühlt',
      'jr2a':
          'Eine Handlung nicht wiederholen, um sie richtig wirken zu lassen',
      'jr2b': 'Etwas schreiben, ohne den Wortlaut nachträglich auszugleichen',
      'jr3a': 'Einen Tag lang mehrere Dinge absichtlich unvollendet lassen',
      'jr3b':
          'Festhalten, was mit dem Nicht-richtig-Gefühl geschah, ohne es zu verändern',
      'other': 'Themenaufgabe',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time': 'Wie viel meiner Zeit nehmen Zwangsgedanken ein?',
      'o_interfere': 'Wie sehr beeinträchtigen die Zwangsgedanken mein Leben?',
      'o_distress':
          'Wie viel Belastung verursachen die Zwangsgedanken bei mir?',
      'o_resist': 'Wie sehr versuche ich, den Zwangsgedanken zu widerstehen?',
      'o_control': 'Wie viel Kontrolle habe ich über die Zwangsgedanken?',
      'c_time':
          'Wie viel Zeit verbringe ich mit Zwangshandlungen wie Ritualen oder Kontrollieren?',
      'c_interfere':
          'Wie sehr beeinträchtigen die Zwangshandlungen mein Leben?',
      'c_distress':
          'Wie ängstlich oder aufgewühlt wäre ich, wenn ich die Zwangshandlung nicht ausführen könnte?',
      'c_resist': 'Wie sehr versuche ich, den Zwangshandlungen zu widerstehen?',
      'c_control': 'Wie viel Kontrolle habe ich über die Zwangshandlungen?',
      'other': 'Frage des Selbstchecks',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'Gar nicht',
      'o_time_1': 'Wenig: weniger als eine Stunde täglich oder gelegentlich',
      'o_time_2': 'Mäßig: 1 bis 3 Stunden täglich oder häufiges Eindringen',
      'o_time_3': 'Viel: 3 bis 8 Stunden täglich oder sehr häufiges Eindringen',
      'o_time_4': 'Fast ständig: mehr als 8 Stunden täglich',
      'o_interfere_0': 'Gar nicht',
      'o_interfere_1': 'Wenig: Sie beeinflussen mein Handeln kaum',
      'o_interfere_2':
          'Etwas: Sie beeinträchtigen mich, aber ich komme noch zurecht',
      'o_interfere_3': 'Stark: Sie behindern meinen Alltag deutlich',
      'o_interfere_4': 'So stark, dass ich kaum funktionieren kann',
      'o_distress_0': 'Keine',
      'o_distress_1': 'Wenig: nicht sehr beunruhigend',
      'o_distress_2': 'Mäßig: beunruhigend, aber handhabbar',
      'o_distress_3': 'Stark: sehr beunruhigend',
      'o_distress_4': 'Fast ständige, stark einschränkende Belastung',
      'o_resist_0':
          'Ich versuche immer zu widerstehen, oder sie treten kaum auf',
      'o_resist_1': 'Ich versuche meistens zu widerstehen',
      'o_resist_2': 'Ich bemühe mich teilweise zu widerstehen',
      'o_resist_3': 'Ich gebe fast allen ohne großen Widerstand nach',
      'o_resist_4': 'Ich gebe ihnen vollständig und bereitwillig nach',
      'o_control_0': 'Volle Kontrolle: Ich kann sie leicht beiseiteschieben',
      'o_control_1': 'Viel Kontrolle: Meist kann ich sie stoppen oder umlenken',
      'o_control_2': 'Etwas Kontrolle: Manchmal gelingt es, manchmal nicht',
      'o_control_3': 'Wenig Kontrolle: Ich kann sie selten stoppen',
      'o_control_4': 'Keine Kontrolle: Sie fühlen sich völlig unfreiwillig an',
      'c_time_0': 'Gar nicht',
      'c_time_1': 'Wenig: weniger als eine Stunde täglich oder gelegentlich',
      'c_time_2': 'Mäßig: 1 bis 3 Stunden täglich oder häufige Rituale',
      'c_time_3': 'Viel: 3 bis 8 Stunden täglich oder sehr häufige Rituale',
      'c_time_4': 'Fast ständig: mehr als 8 Stunden täglich',
      'c_interfere_0': 'Gar nicht',
      'c_interfere_1': 'Wenig: Sie beeinflussen mein Handeln kaum',
      'c_interfere_2':
          'Etwas: Sie beeinträchtigen mich, aber ich komme noch zurecht',
      'c_interfere_3': 'Stark: Sie behindern meinen Alltag deutlich',
      'c_interfere_4': 'So stark, dass ich kaum funktionieren kann',
      'c_distress_0': 'Gar nicht',
      'c_distress_1': 'Etwas unruhig',
      'c_distress_2': 'Mäßig ängstlich',
      'c_distress_3': 'Sehr ängstlich',
      'c_distress_4': 'Überwältigende, stark einschränkende Angst',
      'c_resist_0':
          'Ich versuche immer zu widerstehen, oder sie treten kaum auf',
      'c_resist_1': 'Ich versuche meistens zu widerstehen',
      'c_resist_2': 'Ich bemühe mich teilweise zu widerstehen',
      'c_resist_3': 'Ich gebe fast allen ohne großen Widerstand nach',
      'c_resist_4': 'Ich gebe ihnen vollständig und bereitwillig nach',
      'c_control_0': 'Volle Kontrolle: Ich kann mich leicht davon abhalten',
      'c_control_1': 'Viel Kontrolle: Meist kann ich aufhören oder aufschieben',
      'c_control_2': 'Etwas Kontrolle: Manchmal gelingt es, manchmal nicht',
      'c_control_3':
          'Wenig Kontrolle: Ich kann selten aufhören oder aufschieben',
      'c_control_4': 'Keine Kontrolle: Ich muss sie zu Ende führen',
      'other': 'Antwortoption',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': 'Aggressive oder schadensbezogene Themen',
      'contamination': 'Kontamination',
      'sexual': 'Sexuelle Themen',
      'hoarding_obs': 'Horten oder Aufbewahren',
      'religious': 'Religiöse oder moralische Skrupulosität',
      'symmetry_obs': 'Symmetrie oder Genauigkeit',
      'somatic': 'Körper oder Krankheit',
      'misc_obs': 'Andere Zwangsgedanken',
      'washing': 'Waschen oder Reinigen',
      'checking': 'Kontrollieren',
      'repeating': 'Wiederholungsrituale',
      'counting': 'Zählen',
      'ordering': 'Ordnen oder Ausrichten',
      'misc_comp': 'Andere Zwangshandlungen',
      'other': 'Anderes Thema',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': 'Angst, ich könnte mir selbst schaden',
      'agg_harm_others': 'Angst, ich könnte jemand anderem schaden',
      'agg_violent': 'Gewalttätige oder schreckliche Bilder in meinem Kopf',
      'agg_blurt': 'Angst, Beleidigungen oder Obszönitäten herauszuplatzen',
      'agg_impulse': 'Angst, einem ungewollten Impuls zu folgen',
      'agg_responsible':
          'Angst, für etwas Schreckliches verantwortlich zu sein',
      'con_dirt': 'Sorge wegen Schmutz oder Keimen',
      'con_bodily': 'Ekel vor Körperausscheidungen oder Sekreten',
      'con_chemicals': 'Sorge wegen Haushaltschemikalien oder Reinigern',
      'con_ill': 'Angst, durch Kontamination krank zu werden',
      'con_spread': 'Angst, Kontamination auf andere zu übertragen',
      'con_sticky': 'Klebrige Stoffe oder Rückstände stören mich',
      'sex_forbidden':
          'Verbotene oder ungewollte sexuelle Gedanken oder Bilder',
      'sex_others': 'Sexuelle Gedanken über andere, die mich belasten',
      'sex_orientation': 'Ungewollte Zweifel an meiner sexuellen Orientierung',
      'sex_aggressive': 'Aggressive sexuelle Gedanken gegenüber anderen',
      'hoard_discard': 'Angst, etwas wegzuwerfen, das ich brauchen könnte',
      'hoard_value':
          'Gefühl, Dinge hätten einen Wert, den ich nicht loslassen kann',
      'rel_sacrilege': 'Sorge wegen Sakrileg oder Gotteslästerung',
      'rel_rightwrong': 'Übermäßige Sorge um Richtig und Falsch oder Moral',
      'rel_punish': 'Angst vor Strafe durch Gott oder das Schicksal',
      'sym_even':
          'Bedürfnis, dass Dinge gleichmäßig, ausgewogen oder „genau richtig“ sind',
      'sym_exact': 'Bedürfnis nach Genauigkeit, Ordnung oder Präzision',
      'sym_incomplete':
          'Gefühl der Unvollständigkeit, bis es sich richtig anfühlt',
      'som_illness': 'Übermäßige Sorge um Krankheit',
      'som_body': 'Übermäßige Sorge um ein Körperteil oder das Aussehen',
      'misc_know': 'Bedürfnis, Dinge zu wissen oder sich zu erinnern',
      'misc_saywrong': 'Angst, etwas Falsches zu sagen',
      'misc_lucky': 'Glücks- oder Unglückszahlen, Wörter oder Farben',
      'misc_sounds':
          'Aufdringliche Geräusche, Wörter oder Musik, die ich nicht stoppen kann',
      'misc_lose': 'Angst, Dinge zu verlieren',
      'wash_hands': 'Übermäßiges oder ritualisiertes Händewaschen',
      'wash_shower': 'Übermäßiges Duschen, Baden oder Pflegen',
      'wash_clean': 'Übermäßiges Reinigen von Haushaltsgegenständen',
      'wash_avoid': 'Dinge vermeiden, die ich als kontaminiert ansehe',
      'chk_locks': 'Schlösser, Geräte, Wasserhähne oder Herd kontrollieren',
      'chk_harm':
          'Kontrollieren, dass ich niemandem geschadet habe oder schaden werde',
      'chk_mistake': 'Kontrollieren, dass ich keinen Fehler gemacht habe',
      'chk_body': 'Meinen Körper auf Krankheitszeichen kontrollieren',
      'rep_reread': 'Erneutes Lesen oder Schreiben',
      'rep_routine':
          'Routinehandlungen wiederholen, etwa durch Türen gehen oder auf und ab gehen',
      'rep_untilright': 'Wiederholen, bis es sich „genau richtig“ anfühlt',
      'cnt_count': 'Gegenstände, Schritte oder Handlungen zählen',
      'cnt_numbers': 'Dinge eine bestimmte Anzahl von Malen tun',
      'ord_arrange': 'Dinge anordnen, bis sie symmetrisch oder genau sind',
      'ord_align': 'Gegenstände wiederholt ausrichten oder gerade stellen',
      'mc_mental':
          'Gedankliche Rituale wie stille Gebete, Sätze oder Überprüfen',
      'mc_reassure': 'Wiederholt um Bestätigung bitten oder beichten',
      'mc_touch': 'Dinge berühren, antippen oder reiben müssen',
      'mc_lists': 'Übermäßiges Erstellen von Listen',
      'mc_avoid': 'Situationen vermeiden, um einen Impuls zu verhindern',
      'other': 'Anderes Symptom',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical':
          'Dieser Gesamtwert liegt im subklinischen Y-BOCS-Bereich. Das Ergebnis ist eine Momentaufnahme, keine Diagnose.',
      'mild':
          'Dieser Gesamtwert liegt im leichten Y-BOCS-Bereich. Das Ergebnis ist eine Momentaufnahme, keine Diagnose.',
      'moderate':
          'Dieser Gesamtwert liegt im mittleren Y-BOCS-Bereich. Das Ergebnis ist eine Momentaufnahme, keine Diagnose.',
      'severe':
          'Dieser Gesamtwert liegt im schweren Y-BOCS-Bereich. Erwägen Sie, die Auswirkungen mit einer qualifizierten Fachperson zu besprechen.',
      'extreme':
          'Dieser Gesamtwert liegt im extremen Y-BOCS-Bereich. Erwägen Sie, eine qualifizierte Fachperson zu kontaktieren. Wenn Sie möglicherweise in unmittelbarer Gefahr sind, wenden Sie sich an die örtlichen Notfalldienste.',
      'other':
          'Dieser erfasste Gesamtwert ist eine Momentaufnahme, keine Diagnose.',
    });
    return '$_temp0';
  }
}
