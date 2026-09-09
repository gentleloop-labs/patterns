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
}
