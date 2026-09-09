// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get appearanceTitle => 'Apparence';

  @override
  String get appearanceSystem => 'Système';

  @override
  String get appearanceLight => 'Clair';

  @override
  String get appearanceDark => 'Sombre';

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageSubtitle => 'Choisissez la langue de Patterns';

  @override
  String get calmInsightsTitle => 'Insights apaisés';

  @override
  String get calmInsightsSubtitle =>
      'Masque les séries et les scores calculés. Vos données enregistrées restent disponibles.';

  @override
  String get calmRecentActivityTitle => 'Votre activité récente';

  @override
  String get calmNoRecentActivity =>
      'Aucune activité enregistrée ces 7 derniers jours. Cet espace reste disponible quand vous en avez besoin.';

  @override
  String calmJournalActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrées de journal',
      one: '1 entrée de journal',
    );
    return '$_temp0';
  }

  @override
  String calmTrackedActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count moments enregistrés',
      one: '1 moment enregistré',
    );
    return '$_temp0';
  }

  @override
  String calmDelayActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compulsions différées',
      one: '1 compulsion différée',
    );
    return '$_temp0';
  }

  @override
  String calmErpActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pratiques d’ERP',
      one: '1 pratique d’ERP',
    );
    return '$_temp0';
  }

  @override
  String calmExposureActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count expositions terminées',
      one: '1 exposition terminée',
    );
    return '$_temp0';
  }

  @override
  String get recoveryMetricsTitle => 'Activité de rétablissement';

  @override
  String get recoveryMetricsTeaserTitle =>
      'Votre activité de rétablissement réunie';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'Consultez les expositions, les séances d’exercice et les changements d’envie enregistrés dans vos outils d’ERP. Débloquez avec Patterns Pro.';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'Consultez les séries d’exercice, les expositions terminées et les changements d’envie enregistrés dans vos outils d’ERP. Débloquez avec Patterns Pro.';

  @override
  String get recoveryMetricsUnlockPro => 'Débloquer Patterns Pro';

  @override
  String get recoveryMetricsEmptyTitle =>
      'Votre activité de rétablissement apparaîtra ici';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      'Pratiquez un délai, une séance d’ERP ou une étape d’exposition pour voir ici des nombres d’activités factuels.';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      'Pratiquez un délai, une séance d’ERP ou une étape d’exposition pour commencer votre historique et votre série d’exercice.';

  @override
  String get recoveryMetricsExposuresDone => 'Expositions terminées';

  @override
  String get recoveryMetricsSessionsPracticed => 'Séances pratiquées';

  @override
  String get recoveryMetricsAverageUrgeDrop =>
      'Changement moyen de l’envie enregistré';

  @override
  String get recoveryMetricsThisWeek => 'Cette semaine';

  @override
  String recoveryMetricsDayStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Série de $days jours',
      one: 'Série de 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Réglage du système';

  @override
  String get cancelAction => 'Annuler';

  @override
  String get doneAction => 'Terminé';

  @override
  String get doneForNowAction => 'Terminer pour le moment';

  @override
  String get completionSavedTitle => 'Enregistré';

  @override
  String get completionPracticeTitle => 'Exercice enregistré';

  @override
  String get completionJournalBody =>
      'Votre entrée de journal est enregistrée sur cet appareil.';

  @override
  String get completionTrackedBody =>
      'Le moment suivi est enregistré sur cet appareil.';

  @override
  String get completionTrackedUpdatedBody =>
      'Le moment suivi a été mis à jour.';

  @override
  String get completionDelayBody =>
      'Votre exercice de report de compulsion a été enregistré.';

  @override
  String get completionErpBody => 'Votre exercice d’ERP a été enregistré.';

  @override
  String get notificationOpenAction => 'Ouvrir la notification';

  @override
  String get dailyReminderChannelName => 'Rappel quotidien';

  @override
  String get dailyReminderChannelDescription =>
      'Un rappel quotidien bienveillant pour prendre un moment avec Patterns.';

  @override
  String get dailyReminderTitle => 'Un moment au calme';

  @override
  String get dailyReminderBody =>
      'Prenez un moment paisible avec Patterns lorsque vous vous sentez prêt.';

  @override
  String get practiceTimerChannelName => 'Minuteur de pratique';

  @override
  String get practiceTimerChannelDescription =>
      'Une alerte discrète lorsque la période de pratique est terminée.';

  @override
  String get appUpdatesChannelName => 'Mises à jour de l’application';

  @override
  String get appUpdatesChannelDescription =>
      'Des informations occasionnelles lorsque Patterns propose de nouveaux outils de rétablissement importants.';

  @override
  String get updateAnnouncementTitle => 'Patterns s’est amélioré';

  @override
  String get updateAnnouncementBody =>
      'De nouveaux outils de rétablissement, des informations sur vos progrès et un accueil plus apaisé sont disponibles.';

  @override
  String get practiceWindowCompleteTitle => 'Temps de pratique terminé';

  @override
  String get practiceWindowCompleteBody =>
      'Prenez un moment pour observer ce qui s’est passé.';

  @override
  String get erpWindowCompleteTitle => 'Temps de pratique ERP terminé';

  @override
  String get erpWindowCompleteBody =>
      'Prenez un moment pour réfléchir à ce qui s’est passé.';

  @override
  String get navToday => 'Aujourd’hui';

  @override
  String get navHome => 'Accueil';

  @override
  String get navJournal => 'Journal';

  @override
  String get navTrack => 'Suivi';

  @override
  String get navTracker => 'Suivi';

  @override
  String get navRecovery => 'Rétablissement';

  @override
  String get navInsights => 'Analyses';

  @override
  String get navSettings => 'Réglages';

  @override
  String get exportReportTitle => 'Exporter le rapport';

  @override
  String get exportReportDescription =>
      'Enregistrez un PDF regroupant votre journal, votre suivi OCD et vos analyses. Vous choisissez où l’enregistrer et si vous souhaitez le partager.';

  @override
  String get exportTimeWindow => 'Période';

  @override
  String get exportStart => 'Début';

  @override
  String get exportEnd => 'Fin';

  @override
  String get exportIncludeSections => 'Sections à inclure';

  @override
  String get exportAnalyticsSummary => 'Résumé analytique';

  @override
  String get exportJournalEntries => 'Entrées du journal';

  @override
  String get exportOcdEvents => 'Événements OCD';

  @override
  String get exportYbocsSelfChecks => 'Auto-évaluations Y-BOCS';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total entrées',
      one: '1 entrée',
      zero: 'Aucune entrée',
    );
    return '$_temp0 sur cette période ($journal journal, $ocd OCD, $selfChecks auto-évaluations)';
  }

  @override
  String get exportLargeReport =>
      'Ce rapport est volumineux et sa création peut prendre un moment.';

  @override
  String get exportPrivacyWarning =>
      'Cela crée un PDF non chiffré. Enregistrez-le dans un endroit privé.';

  @override
  String get exportSavePdf => 'Enregistrer le PDF';

  @override
  String get exportSelectSectionError =>
      'Sélectionnez au moins une section à exporter.';

  @override
  String get exportNoEntriesError =>
      'Aucune entrée ne correspond à cette période et à cette sélection.';

  @override
  String get exportReportSaved => 'Rapport enregistré';

  @override
  String get exportReportFailed => 'Impossible de créer le rapport';

  @override
  String get rangeSevenDays => '7 j';

  @override
  String get rangeThirtyDays => '30 j';

  @override
  String get rangeNinetyDays => '90 j';

  @override
  String get rangeYear => 'Année';

  @override
  String get rangeAll => 'Tout';

  @override
  String get rangeCustom => 'Personnalisé';

  @override
  String get rangeLastSevenDays => '7 derniers jours';

  @override
  String get rangeLastThirtyDays => '30 derniers jours';

  @override
  String get rangeLastNinetyDays => '90 derniers jours';

  @override
  String get rangeLastYear => 'Dernière année';

  @override
  String get rangeAllTime => 'Toute la période';

  @override
  String get pdfPersonalReport => 'Rapport personnel';

  @override
  String pdfGenerated(String date) {
    return 'Généré le $date';
  }

  @override
  String get pdfDisclaimer =>
      'Ce rapport contient des notes personnelles créées dans Patterns à des fins d’autoréflexion. Il ne constitue pas un avis médical et ne remplace pas les soins d’un professionnel qualifié.';

  @override
  String get pdfJournalCount => 'Entrées du journal';

  @override
  String get pdfOcdCount => 'Événements OCD';

  @override
  String get pdfAverageDistress => 'Détresse moyenne';

  @override
  String get pdfObsessions => 'Obsessions';

  @override
  String get pdfCompulsions => 'Compulsions';

  @override
  String get pdfNoJournalEntries =>
      'Aucune entrée de journal sur cette période.';

  @override
  String get pdfNoOcdEvents => 'Aucun événement OCD sur cette période.';

  @override
  String get pdfObsession => 'Obsession';

  @override
  String get pdfCompulsion => 'Compulsion';

  @override
  String pdfDistressScore(int score) {
    return 'Détresse $score/10';
  }

  @override
  String get pdfThought => 'Pensée';

  @override
  String get pdfUrge => 'Envie';

  @override
  String pdfResponse(String text) {
    return 'Réponse : $text';
  }

  @override
  String pdfActionTaken(String text) {
    return 'Action entreprise : $text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scale, auto-évaluée dans l’app. Le total est sur 40, dont 20 pour les obsessions et 20 pour les compulsions.';

  @override
  String get pdfMostRecentTotal => 'Total le plus récent';

  @override
  String get pdfTakenOn => 'Réalisée le';

  @override
  String get pdfObsessionsSubtotal => 'Sous-total obsessions';

  @override
  String get pdfCompulsionsSubtotal => 'Sous-total compulsions';

  @override
  String get pdfChangeAcrossRange => 'Évolution sur la période';

  @override
  String get pdfSelfChecksInRange => 'Auto-évaluations sur la période';

  @override
  String get pdfThemesFlagged => 'Thèmes signalés';

  @override
  String get pdfSingleSelfCheck => 'Une auto-évaluation sur cette période';

  @override
  String pdfChangeSince(String change, String date) {
    return '$change depuis le $date';
  }

  @override
  String get pdfDate => 'Date';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfBand => 'Niveau';

  @override
  String get severitySubclinical => 'Subclinique';

  @override
  String get severityMild => 'Léger';

  @override
  String get severityModerate => 'Modéré';

  @override
  String get severitySevere => 'Sévère';

  @override
  String get severityExtreme => 'Extrême';

  @override
  String get backAction => 'Retour';

  @override
  String get onboardingSafetyFootnote =>
      'La confidentialité est intégrée. Ni diagnostic ni remplacement d’un suivi professionnel.';

  @override
  String get onboardingHeadline => 'Un espace calme pour pratiquer avec l’OCD.';

  @override
  String get onboardingIntroduction =>
      'Notez la pensée intrusive, retardez la compulsion et entraînez-vous à répondre autrement, un petit pas à la fois.';

  @override
  String get onboardingPrivacy =>
      'Vos données OCD restent sur cet appareil. Aucun compte. Aucune synchronisation cloud.';

  @override
  String get getStartedAction => 'Commencer';

  @override
  String get importExistingDataAction => 'Importer des données existantes';

  @override
  String get onboardingQuestion => 'Qu’est-ce qui vous aiderait maintenant ?';

  @override
  String get onboardingPickOne =>
      'Choisissez une option. Vous pourrez essayer le reste quand vous le souhaiterez.';

  @override
  String get onboardingUrgeTitle => 'Je lutte contre une envie en ce moment';

  @override
  String get onboardingUrgeSubtitle =>
      'Créez un peu de distance entre l’envie et le rituel.';

  @override
  String get onboardingJournalTitle => 'Je veux écrire quelque chose';

  @override
  String get onboardingJournalSubtitle =>
      'Sortez la pensée de votre tête et posez-la sur une page.';

  @override
  String get onboardingErpTitle =>
      'Je veux m’entraîner à ne pas faire une compulsion';

  @override
  String get onboardingErpSubtitle => 'Une courte exposition guidée.';

  @override
  String get onboardingSelfCheckTitle => 'Je veux savoir où en est mon OCD';

  @override
  String get onboardingSelfCheckSubtitle =>
      'L’auto-évaluation Y-BOCS. Environ 10 minutes.';

  @override
  String get onboardingExploreTitle => 'Je découvre simplement';

  @override
  String get onboardingExploreSubtitle =>
      'Commencez par explorer tranquillement.';

  @override
  String get whatsNewTitle => 'Pratiquer sans pression';

  @override
  String get whatsNewBody =>
      'Patterns 1.10 apporte des insights apaisés, des fins de session plus sobres, une meilleure accessibilité et un choix de langue facultatif.';

  @override
  String get whatsNewLanguagesTitle => 'Insights apaisés';

  @override
  String get whatsNewLanguagesBody =>
      'Choisissez des résumés factuels d’activité plutôt que des scores, séries et pourcentages de régularité calculés.';

  @override
  String get whatsNewPrivateTitle => 'Une fin claire';

  @override
  String get whatsNewPrivateBody =>
      'Le journal, le suivi, le report de compulsion et les sessions d’ERP se terminent par une confirmation factuelle et Terminer pour le moment.';

  @override
  String get whatsNewReportsTitle => 'Plus accessible, dans votre langue';

  @override
  String get whatsNewReportsBody =>
      'Des libellés améliorés et moins de mouvement s’ajoutent à l’anglais, au portugais brésilien, à l’allemand, au japonais, à l’espagnol et au français.';

  @override
  String get whatsNewExploreAction => 'Découvrir Patterns 1.10';

  @override
  String get continueToPatternsAction => 'Continuer vers Patterns';

  @override
  String get whatsNewNotificationNote =>
      'Vos entrées restent inchangées. La langue et les Insights apaisés restent sur cet appareil et ne figurent ni dans les analyses ni dans les sauvegardes.';

  @override
  String get formatBold => 'Gras';

  @override
  String get formatItalic => 'Italique';

  @override
  String get formatBulletedList => 'Liste à puces';

  @override
  String get formatToggleHint =>
      'Touchez deux fois pour activer ou désactiver cette mise en forme.';

  @override
  String get journalEditorLabel => 'Éditeur du journal';

  @override
  String get journalEditorHint =>
      'Saisissez le texte du journal. Les commandes de mise en forme suivent l’éditeur.';

  @override
  String timerRemaining(String time) {
    return 'Temps restant : $time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return 'Score de récupération : $score sur 100.';
  }

  @override
  String get privacySafetyTitle => 'Confidentialité et sécurité';

  @override
  String get privacyLocalContent =>
      'Les entrées de journal, événements OCD, niveaux de détresse, réflexions et préférences sont stockés localement sur cet appareil.';

  @override
  String get privacyPurchases =>
      'Patterns Pro et les pourboires sont traités par la boutique d’apps. Patterns ne reçoit pas les données de votre carte de paiement.';

  @override
  String get privacyExports =>
      'Un export manuel crée une sauvegarde JSON ou un rapport PDF non chiffré uniquement à l’endroit où vous choisissez de l’enregistrer ou de le partager.';

  @override
  String get privacyAnalytics =>
      'Les analyses d’usage anonymes sont désactivées sauf si vous les activez. Patterns envoie alors des événements de fonctionnalité nommés, un identifiant d’installation aléatoire, la plateforme, la version et l’heure à son service propriétaire. Les entrées, données OCD, résumés générés, paramètres régionaux et choix de langue ne sont jamais inclus. La désactivation efface les événements en attente et l’identifiant local.';

  @override
  String get privacyClinicalBoundary =>
      'Patterns est un outil d’auto-assistance pour la réflexion personnelle et la pratique de l’ERP. Il ne diagnostique ni ne traite l’OCD, ne remplace pas un professionnel qualifié et ne fournit pas d’aide d’urgence.';

  @override
  String get viewPrivacyPolicyAction => 'Voir la Politique de confidentialité';

  @override
  String get closeAction => 'Fermer';
}
