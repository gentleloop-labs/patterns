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
}
