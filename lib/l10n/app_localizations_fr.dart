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
  String get settingsDataSection => 'Données';

  @override
  String get settingsExportDataTitle => 'Exporter les données';

  @override
  String get settingsExportDataSubtitle =>
      'Enregistrez vos données dans une sauvegarde JSON locale';

  @override
  String get settingsImportDataTitle => 'Importer des données';

  @override
  String get settingsImportDataSubtitle =>
      'Restaurez des entrées depuis une sauvegarde ZIP ou JSON';

  @override
  String get settingsRemindersSection => 'Rappels';

  @override
  String get settingsDailyReminderTitle => 'Rappel quotidien';

  @override
  String settingsDailyReminderAt(String time) {
    return 'Un rappel bienveillant à $time';
  }

  @override
  String get settingsDailyReminderOff =>
      'Un rappel bienveillant pour faire le point chaque jour';

  @override
  String get settingsReminderTimeTitle => 'Heure du rappel';

  @override
  String get settingsPrivacySection => 'Confidentialité';

  @override
  String get settingsPrivacySafetySubtitle =>
      'Comment vos données locales sont traitées';

  @override
  String get settingsAnalyticsTitle =>
      'Partager des données d’utilisation anonymes';

  @override
  String get settingsAnalyticsSubtitle =>
      'Partage uniquement l’utilisation des fonctionnalités. Les données personnelles liées à l’OCD ne sont jamais incluses.';

  @override
  String get settingsAppLockTitle => 'Verrouillage de l’application';

  @override
  String get settingsAppLockSubtitle =>
      'Exiger le déverrouillage de l’appareil à la réouverture de Patterns';

  @override
  String get settingsWipeTitle => 'Effacer toutes les données';

  @override
  String get settingsWipeSubtitle =>
      'Supprimer les entrées locales et réinitialiser les réglages';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Pro est actif';

  @override
  String get settingsProActiveSubtitle =>
      'Tous les outils de rétablissement sont déverrouillés. Merci.';

  @override
  String get settingsUnlockProTitle => 'Déverrouiller Patterns Pro';

  @override
  String get settingsUnlockProSubtitle =>
      'Achat unique pour tous les outils de rétablissement';

  @override
  String get settingsRestorePurchasesTitle => 'Restaurer les achats';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Restaurer un déverrouillage antérieur de Patterns Pro';

  @override
  String get settingsHelpSection => 'Aide';

  @override
  String get settingsReplayTourTitle => 'Revoir la visite de l’application';

  @override
  String get settingsReplayTourSubtitle => 'Revoir le rôle de chaque onglet';

  @override
  String get settingsShowWelcomeTitle => 'Afficher les écrans de bienvenue';

  @override
  String get settingsShowWelcomeSubtitle =>
      'Afficher l’introduction à la prochaine ouverture de Patterns';

  @override
  String get settingsFeedbackSection => 'Commentaires';

  @override
  String get settingsRateTitle => 'Évaluer Patterns';

  @override
  String get settingsRateSubtitle => 'Donnez votre avis dans l’App Store';

  @override
  String get settingsSendFeedbackTitle => 'Envoyer des commentaires';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Partagez une idée ou signalez un problème';

  @override
  String get settingsSupportTitle => 'Soutenir Patterns';

  @override
  String get settingsSupportSubtitle =>
      'Laissez un pourboire facultatif pour soutenir le développement';

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

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools =>
      'Inclut aussi tous les outils Pro de planification, de pratique, de mesures et de réflexion.';

  @override
  String get proPaywallAlreadyPurchased =>
      'Vous avez déjà acheté Pro? Aucun nouveau paiement ne sera effectué.';

  @override
  String get proPaywallTryAgainAction => 'Réessayer';

  @override
  String get proPaywallRestorePurchasesAction => 'Restaurer les achats';

  @override
  String get proPaywallRestoreShortAction => 'Restaurer';

  @override
  String get proPaywallUnlockAction => 'Débloquer Pro';

  @override
  String proPaywallUnlockWithPrice(String price) {
    return 'Débloquer Pro · $price';
  }

  @override
  String get proPaywallPurchasesUnavailable =>
      'Les achats intégrés ne sont pas disponibles sur cet appareil.';

  @override
  String get proPaywallProductUnavailable =>
      'Patterns Pro est indisponible pour le moment. Veuillez réessayer plus tard.';

  @override
  String get proPaywallProductLoadFailed =>
      'Impossible de charger Patterns Pro. Veuillez réessayer plus tard.';

  @override
  String get proPaywallPurchaseStartFailed => 'Impossible de lancer l’achat.';

  @override
  String get proPaywallPurchaseFailed =>
      'Impossible de terminer l’achat. Veuillez réessayer.';

  @override
  String get proPaywallRestoreNotFound =>
      'Aucun achat antérieur n’a été trouvé sur ce compte. Si vous avez acheté Pro avec un autre compte, connectez-vous à celui-ci et réessayez.';

  @override
  String get proPaywallRestoreFailed =>
      'Impossible de restaurer les achats. Veuillez réessayer.';

  @override
  String get proPaywallWelcomeBack => 'Heureux de vous revoir';

  @override
  String get proPaywallAllSet => 'Tout est prêt';

  @override
  String get proPaywallRestoredBody =>
      'Patterns Pro a été restauré sur cet appareil.';

  @override
  String get proPaywallUnlockedBody =>
      'Patterns Pro est débloqué. Tous les outils de rétablissement sont maintenant disponibles.';

  @override
  String get proPaywallContinueAction => 'Continuer';

  @override
  String get proPaywallLoadingLabel => 'Chargement de Patterns Pro';

  @override
  String get proHeadlineSettings =>
      'Passer du suivi à la pratique du rétablissement';

  @override
  String get proHeadlineTodayNextStep => 'Poursuivre la pratique d’aujourd’hui';

  @override
  String get proHeadlineRecoveryMetrics =>
      'Consulter votre activité de rétablissement';

  @override
  String get proHeadlineExposureHierarchy =>
      'Créer une hiérarchie d’exposition claire';

  @override
  String get proHeadlineExposureMaterials =>
      'Regrouper le matériel de pratique';

  @override
  String get proHeadlineStructuredPrograms =>
      'Intégrer le rétablissement à une routine';

  @override
  String get proHeadlineActionPlanner =>
      'Planifier votre réponse avant l’arrivée du TOC';

  @override
  String get proHeadlineImplementationIntentions =>
      'Faciliter votre prochain choix';

  @override
  String get proHeadlineUrgeSurfing => 'Vous exercer à laisser passer l’envie';

  @override
  String get proHeadlineResponsePrevention => 'Noter la réponse choisie';

  @override
  String get proHeadlineUncertaintyTraining =>
      'Vous exercer à laisser une place au peut-être';

  @override
  String get proHeadlineBehavioralExperiments =>
      'Mettre à l’épreuve les prédictions du TOC';

  @override
  String get proHeadlineReflectionJournal =>
      'Noter ce que chaque pratique vous a appris';

  @override
  String get proBenefitGeneralPlans =>
      'Créer des hiérarchies d’exposition et des plans de pratique';

  @override
  String get proBenefitGeneralResponsePrevention =>
      'Utiliser des outils ciblés de prévention de la réponse';

  @override
  String get proBenefitGeneralReview =>
      'Consulter l’activité de rétablissement et les réflexions';

  @override
  String get proBenefitMetricsActivity =>
      'Consulter l’activité de pratique au fil du temps';

  @override
  String get proBenefitMetricsNonjudgmental =>
      'Voir l’activité enregistrée sans juger chaque journée';

  @override
  String get proBenefitMetricsPatterns =>
      'Explorer des tendances factuelles de rétablissement';

  @override
  String get proBenefitExposureLadder =>
      'Classer les étapes de la plus douce à la plus difficile';

  @override
  String get proBenefitExposureMaterials =>
      'Garder scripts, pistes en boucle, images et liens à portée de main';

  @override
  String get proBenefitExposureRepeatable =>
      'Transformer un plan en pratique reproductible';

  @override
  String get proBenefitProgramsStructure =>
      'Suivre une structure calme semaine après semaine';

  @override
  String get proBenefitProgramsTasks =>
      'Regrouper les tâches de pratique au même endroit';

  @override
  String get proBenefitProgramsReview => 'Revoir ce qui a aidé en poursuivant';

  @override
  String get proBenefitPlanningAhead =>
      'Choisir une réponse avant le moment difficile';

  @override
  String get proBenefitPlanningIfThen => 'Créer des plans si-alors concrets';

  @override
  String get proBenefitPlanningReturn =>
      'Revenir au plan lorsque l’incertitude augmente';

  @override
  String get proBenefitInMomentTools =>
      'Utiliser des outils de pratique ciblés sur le moment';

  @override
  String get proBenefitInMomentPrivacy =>
      'Noter vos choix sans écrire de détails sensibles';

  @override
  String get proBenefitInMomentRepetition =>
      'Développer la tolérance par une pratique répétable';

  @override
  String get proBenefitReflectionCompare =>
      'Comparer les prédictions à ce qui s’est passé';

  @override
  String get proBenefitReflectionCapture =>
      'Noter les apprentissages après la pratique';

  @override
  String get proBenefitReflectionPatterns =>
      'Repérer des tendances utiles au fil du temps';

  @override
  String get proRestoreChecking => 'Vérification de vos achats…';

  @override
  String get proRestoreSucceeded =>
      'Patterns Pro a été restauré. Tous les outils de rétablissement sont de nouveau débloqués.';

  @override
  String get tipJarTitle => 'Soutenir Patterns';

  @override
  String get tipJarBody =>
      'Patterns est indépendant et sans publicité. Si l’app vous a aidé, un petit pourboire compte beaucoup. Les pourboires sont facultatifs et ne débloquent rien.';

  @override
  String get tipJarLoadingLabel => 'Chargement des options de pourboire';

  @override
  String get tipJarPurchasesUnavailable =>
      'Les achats intégrés ne sont pas disponibles sur cet appareil.';

  @override
  String get tipJarOptionsUnavailable =>
      'Aucune option de pourboire n’a été trouvée. Veuillez réessayer plus tard.';

  @override
  String get tipJarLoadFailed =>
      'Impossible de charger les options de pourboire. Veuillez réessayer plus tard.';

  @override
  String get tipJarPurchaseFailed =>
      'Impossible d’envoyer le pourboire. Veuillez réessayer.';

  @override
  String get tipJarTryAgainAction => 'Réessayer';

  @override
  String get tipSmallTitle => 'Petit pourboire';

  @override
  String get tipSmallDescription =>
      'Un petit pourboire facultatif pour soutenir le développement de Patterns. Ne débloque aucune fonction.';

  @override
  String get tipMediumTitle => 'Pourboire moyen';

  @override
  String get tipMediumDescription =>
      'Un pourboire moyen et facultatif pour soutenir le développement de Patterns. Ne débloque aucune fonction.';

  @override
  String get tipLargeTitle => 'Grand pourboire';

  @override
  String get tipLargeDescription =>
      'Un grand pourboire facultatif pour soutenir le développement de Patterns. Ne débloque aucune fonction.';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title, $price. $description';
  }

  @override
  String get tipChoiceHint => 'Envoie ce pourboire facultatif';

  @override
  String get tipThanksTitle => 'Merci';

  @override
  String get tipThanksBody =>
      'Votre soutien compte beaucoup. Grâce à des personnes comme vous, Patterns reste sans publicité et indépendant.';

  @override
  String get tipThanksAction => 'Avec plaisir';

  @override
  String get desktopProTitle => 'Débloquer Patterns Desktop Pro';

  @override
  String get desktopProSubtitle =>
      'Une licence à paiement unique pour des outils de rétablissement hors ligne optimisés pour ordinateur.';

  @override
  String get desktopFeatureHierarchyTitle => 'Créateur de hiérarchies';

  @override
  String get desktopFeatureHierarchyDescription =>
      'Créer et consigner des étapes et hiérarchies d’exposition.';

  @override
  String get desktopFeatureErpTitle => 'Journaux d’exercices ERP';

  @override
  String get desktopFeatureErpDescription =>
      'Consigner la prévention de la réponse et les exercices chronométrés.';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription =>
      'Suivre les changements de l’envie avec un chronomètre en direct.';

  @override
  String get desktopFeatureActivityTitle => 'Activité de rétablissement';

  @override
  String get desktopFeatureActivityDescription =>
      'Consulter l’activité factuelle et les tendances hebdomadaires.';

  @override
  String get desktopOneTimeLicense => 'Licence à paiement unique';

  @override
  String desktopOneTimePrice(String price) {
    return '$price, achat unique';
  }

  @override
  String get desktopPurchaseLicenseAction => 'Acheter la licence';

  @override
  String get desktopCheckoutUnavailable =>
      'La page d’achat n’est pas disponible dans cette version.';

  @override
  String get desktopAlreadyPurchased =>
      'Déjà achetée? Saisissez votre clé de licence';

  @override
  String get desktopLicensePrompt =>
      'Saisissez votre clé de licence Lemon Squeezy :';

  @override
  String get desktopLicenseLabel => 'Clé de licence';

  @override
  String get desktopLicenseHint =>
      'Collez la clé de licence indiquée sur votre reçu';

  @override
  String get desktopLicenseActivating => 'Activation de la licence…';

  @override
  String get desktopActivateLicenseAction => 'Activer la licence';

  @override
  String get desktopLicenseBackAction => 'Retour';

  @override
  String get desktopLicenseInvalid =>
      'Saisissez la clé de licence complète indiquée sur votre reçu.';

  @override
  String get desktopLicenseRejected =>
      'Cette licence n’a pas pu être vérifiée pour Patterns Desktop Pro. Vérifiez la clé et réessayez.';

  @override
  String get desktopLicenseUnavailable =>
      'Le service de licences est inaccessible. Vérifiez votre connexion et réessayez.';

  @override
  String get desktopLicenseNotConfigured =>
      'L’activation de licence n’est pas disponible dans cette version.';

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalSearchAction => 'Rechercher dans le journal';

  @override
  String get journalChooseDateAction => 'Choisir une date';

  @override
  String get journalSearchHint => 'Rechercher des entrées';

  @override
  String get journalClearSearchAction => 'Effacer la recherche';

  @override
  String get journalNoMatchesTitle => 'Aucun résultat';

  @override
  String journalNoMatchesBody(String query) {
    return 'Aucune entrée ne correspond à « $query ».';
  }

  @override
  String get journalEmptyTitle => 'Aucune entrée pour le moment';

  @override
  String get journalEmptyBody => 'Quelques lignes suffisent pour commencer.';

  @override
  String get journalLoadError =>
      'Impossible de charger les entrées du journal. Réessayez.';

  @override
  String get journalLoadingLabel => 'Chargement des entrées du journal';

  @override
  String get journalSavingStatus => 'Enregistrement…';

  @override
  String get journalSavedStatus => 'Enregistré';

  @override
  String get journalUnsavedStatus => 'Non enregistré';

  @override
  String get journalClearDayAction => 'Effacer cette journée';

  @override
  String get journalSaveAction => 'Enregistrer';

  @override
  String get journalStartWritingPlaceholder => 'Commencez à écrire…';

  @override
  String get journalFormatSelectionHint =>
      'Sélectionnez du texte pour le mettre en forme';

  @override
  String get journalClearedMessage =>
      'L’entrée de cette journée a été effacée.';

  @override
  String get journalNothingToSaveMessage =>
      'Il n’y a encore rien à enregistrer. Ajoutez une ligne quand vous vous sentez prêt.';

  @override
  String get journalClearDayTitle => 'Effacer cette journée ?';

  @override
  String journalClearDayBody(String date) {
    return 'Cela efface tout ce qui a été enregistré pour le $date. Vous pourrez écrire de nouveau pour cette journée à tout moment.';
  }

  @override
  String get journalKeepEntryAction => 'Conserver';

  @override
  String get journalTodayEntry => 'Entrée du jour';

  @override
  String get journalOpenEntryAction => 'Ouvrir l’entrée';

  @override
  String journalOpenEntryHint(String date) {
    return 'Ouvre l’entrée de journal du $date.';
  }

  @override
  String get journalWorkspaceTitle => 'Espace journal';

  @override
  String get journalSubtitle =>
      'Votre espace pour réfléchir et déposer ce qui pèse.';

  @override
  String get journalNewEntryAction => 'Nouvelle entrée';

  @override
  String get journalEarlierSection => 'Plus tôt';

  @override
  String get journalNoEntryForDate => 'Aucune entrée pour cette date.';

  @override
  String get journalCreateEntryAction => 'Créer une entrée';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date à $time';
  }

  @override
  String get journalDeleteEntryAction => 'Supprimer l’entrée';

  @override
  String get journalDeleteEntryTitle => 'Supprimer l’entrée ?';

  @override
  String get journalDeleteEntryBody =>
      'Cette entrée du journal sera supprimée définitivement.';

  @override
  String get journalDeletedMessage => 'L’entrée du journal a été supprimée.';

  @override
  String get journalEditAction => 'Modifier';

  @override
  String journalEditingDate(String date) {
    return 'Modification : $date';
  }

  @override
  String get journalUnsavedChangesStatus => 'Modifications non enregistrées';

  @override
  String get journalEntrySavedMessage => 'Entrée du journal enregistrée';

  @override
  String journalReadOnlyLabel(String date) {
    return 'Entrée du journal en lecture seule pour le $date';
  }

  @override
  String get journalThemeContamination => 'Contamination';

  @override
  String get journalThemeUncertainty => 'Incertitude';

  @override
  String get journalThemeChecking => 'Vérification';

  @override
  String get journalThemeRelationship => 'Relation';

  @override
  String get journalThemeHealth => 'Santé';

  @override
  String get todayGreetingMorning => 'Bonjour';

  @override
  String get todayGreetingAfternoon => 'Bon après-midi';

  @override
  String get todayGreetingEvening => 'Bonsoir';

  @override
  String get todayEncouragement => 'Vous pouvez avancer. Un choix à la fois.';

  @override
  String get todayContinuePractice => 'Continuer votre pratique';

  @override
  String get todaySeeAllAction => 'Tout voir';

  @override
  String get todayQuickActions => 'Actions rapides';

  @override
  String get todayChooseActivity => 'Que souhaitez-vous faire ?';

  @override
  String get todayWriteSomethingTitle => 'Écrire quelque chose';

  @override
  String get todayWriteSomethingBody => 'Posez une pensée par écrit.';

  @override
  String get todayDelayUrgeTitle => 'Différer une envie';

  @override
  String get todayDelayUrgeBody => 'Créez un espace avant de réagir.';

  @override
  String get todayPracticeErpTitle => 'Pratiquer (ERP)';

  @override
  String get todayPracticeErpBody => 'Un exercice court et guidé.';

  @override
  String get todayFirstJournalTitle => 'Noter un autre moment';

  @override
  String get todayFirstJournalBody =>
      'Nommer une pensée peut aider à l’observer.';

  @override
  String get todayFirstErpTitle => 'Pratiquer à nouveau';

  @override
  String get todayFirstErpBody =>
      'Essayez une autre courte pratique ERP guidée.';

  @override
  String get todayFirstDelayTitle => 'Essayer un délai de deux minutes';

  @override
  String get todayFirstDelayBody =>
      'Quand l’envie est forte, laissez un peu d’espace avant d’agir.';

  @override
  String get todayStartPracticeAction => 'Commencer la pratique';

  @override
  String get todayStartDelayAction => 'Commencer le délai';

  @override
  String get todayProTitle => 'Continuer avec Patterns Pro';

  @override
  String get todayProBody =>
      'Créez un plan, pratiquez et consultez votre activité au fil du temps.';

  @override
  String get todayHideSevenDays => 'Masquer pendant 7 jours';

  @override
  String get todayPracticeProgress => 'Progression de la pratique';

  @override
  String get todaySteadyPractice => 'Pratique régulière';

  @override
  String get todayStartGently => 'Commencer en douceur';

  @override
  String get todayPracticeActiveBody =>
      'Vos activités enregistrées construisent une vue à plus long terme.';

  @override
  String get todayPracticeEmptyBody =>
      'Cette vue évolue à mesure que vous écrivez, suivez et pratiquez.';

  @override
  String get todayProgressDisclaimer =>
      'Ceci reflète la fréquence des pratiques enregistrées, et non un diagnostic ou une évaluation clinique. La valeur peut être plus basse pendant une semaine difficile.';

  @override
  String get todayProgressStartedTitle => 'Votre activité prend forme';

  @override
  String get todayProgressPendingBody =>
      'Une valeur de progression apparaîtra après l’enregistrement d’activités sur plusieurs jours.';

  @override
  String get todayScoreNew => 'Nouveau';

  @override
  String get todayScoreStrong => 'Fort';

  @override
  String get todayScoreSteady => 'Régulier';

  @override
  String get todayScoreBuilding => 'En construction';

  @override
  String get todayScoreStarting => 'Début';

  @override
  String get todayBeginCheckIn => 'Commencez par un bref bilan';

  @override
  String get todayNoChange =>
      'Aucun changement par rapport à la période précédente';

  @override
  String todayPointsUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points points de plus',
      one: '1 point de plus',
    );
    return '$_temp0 que la période précédente';
  }

  @override
  String todayPointsDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points points de moins',
      one: '1 point de moins',
    );
    return '$_temp0 que la période précédente';
  }

  @override
  String get todayNextStep => 'Votre prochaine étape';

  @override
  String get todayNextSelfCheckTitle => 'Faire le point';

  @override
  String get todayNextSelfCheckBody =>
      'Une auto-évaluation peut enregistrer un repère pour une comparaison ultérieure.';

  @override
  String get todayNextSelfCheckAction => 'Faire l’auto-évaluation';

  @override
  String get todayNextHierarchyTitle => 'Préparer votre pratique';

  @override
  String get todayNextHierarchyBody =>
      'Créez une hiérarchie d’exposition, des étapes plus faciles aux plus difficiles.';

  @override
  String get todayNextHierarchyAction => 'Créer la hiérarchie';

  @override
  String get todayNextPracticeTitle => 'Choisir la pratique du jour';

  @override
  String get todayNextPracticeBody =>
      'Choisissez un exercice ERP abordable pour aujourd’hui.';

  @override
  String get todayNextPracticeAction => 'Commencer la pratique';

  @override
  String get todayNextReflectTitle => 'Réfléchir à la pratique';

  @override
  String get todayNextReflectBody =>
      'Notez ce que vous avez remarqué pendant la pratique du jour.';

  @override
  String get todayNextReflectAction => 'Réfléchir';

  @override
  String get todayNextJournalTitle => 'Réfléchir à la journée';

  @override
  String get todayNextJournalBody =>
      'Écrivez une ligne sur ce que vous avez remarqué pendant votre pratique.';

  @override
  String get todayNextJournalAction => 'Ouvrir le journal';

  @override
  String get todayCompulsionDelay => 'Délai de compulsion';

  @override
  String get todayStartErp => 'Commencer une pratique ERP';

  @override
  String get todayResistUrgeBody =>
      'Restez avec l’envie avant de décider quoi faire.';

  @override
  String get todayBuildToleranceBody =>
      'Pratiquez une étape abordable à votre rythme.';

  @override
  String get todayResumeAction => 'Reprendre';

  @override
  String get todayStartAction => 'Commencer';

  @override
  String get todayJournalBody =>
      'Écrivez et réfléchissez dans votre journal privé.';

  @override
  String get todayExposureTools => 'Outils d’exposition';

  @override
  String get todayExposureToolsBody =>
      'Hiérarchie, supports et pratique de l’incertitude.';

  @override
  String get todayInsightsBody => 'Consultez votre activité enregistrée.';

  @override
  String get todaySelfCheckTitle => 'Comprendre vos schémas';

  @override
  String get todaySelfCheckDuration => 'Facultatif · environ 10 min';

  @override
  String get todayInsightsPlaceholder =>
      'Vos insights apparaîtront ici à mesure que vous enregistrerez des activités.';

  @override
  String get todayDailyCheckInComplete => 'Bilan quotidien enregistré';

  @override
  String get todayDailyCheckIn => 'Bilan quotidien';

  @override
  String get todayDailyCompleteBody =>
      'Une note de journal est enregistrée pour aujourd’hui.';

  @override
  String get todayDailyBody => 'Écrivez une courte note quand vous êtes prêt.';

  @override
  String get todayOpenAction => 'Ouvrir';

  @override
  String get todayCheckInAction => 'Faire le bilan';

  @override
  String get todayRecoveryScore => 'Score de rétablissement';

  @override
  String todayActivitiesLastSevenDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count activités au cours des 7 derniers jours',
      one: '1 activité au cours des 7 derniers jours',
    );
    return '$_temp0';
  }

  @override
  String get todayActivityRecorded =>
      'Calculé à partir de l’activité enregistrée';

  @override
  String get todayPracticesRecorded => 'Pratiques enregistrées';

  @override
  String get todayPracticeStreak => 'Série de pratique';

  @override
  String todaySessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count séances',
      one: '1 séance',
    );
    return '$_temp0';
  }

  @override
  String todayDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String get todayPickUpBody =>
      'Reprenez à partir du temps précédemment enregistré.';

  @override
  String get todayPracticeUrgesBody =>
      'Entraînez-vous à attendre avant de répondre à une envie.';

  @override
  String get todayReadCheckIn => 'Lire le bilan du jour';

  @override
  String get todayOpenJournalMore =>
      'Ouvrez le Journal pour lire ou ajouter une note';

  @override
  String get todayShortJournal => 'Écrivez une courte note de journal';

  @override
  String get todayExplore => 'Explorer';

  @override
  String get todayReflectProcess => 'Réfléchir et mettre en perspective';

  @override
  String get todayRecoveryTools => 'Outils de rétablissement';

  @override
  String get todaySupportPractice => 'Soutenir votre pratique';

  @override
  String get todayTrackBody => 'Enregistrer les pensées et les envies';

  @override
  String get todaySeePatterns => 'Consulter vos schémas enregistrés';

  @override
  String todayScoreA11y(int score, String label) {
    return 'Progression de la pratique : $score sur 100, $label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return 'Minuteur de pratique : $elapsed écoulé sur $planned';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day : activité enregistrée';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day : aucune activité enregistrée';
  }

  @override
  String get trackerTitle => 'Suivi';

  @override
  String get trackerPauseUrgeAction => 'Attendre avant de répondre';

  @override
  String get trackerFilterGroupLabel => 'Filtrer les moments enregistrés';

  @override
  String get trackerFilterAll => 'Tous';

  @override
  String get trackerFilterObsessions => 'Obsessions';

  @override
  String get trackerFilterCompulsions => 'Compulsions';

  @override
  String get trackerLoadingLabel => 'Chargement des moments enregistrés';

  @override
  String get trackerLoadError =>
      'Impossible de charger vos moments enregistrés. Veuillez réessayer.';

  @override
  String get trackerEditTitle => 'Modifier l’événement';

  @override
  String get trackerAddTitle => 'Enregistrer un événement';

  @override
  String get trackerTypeGroupLabel => 'Type d’événement';

  @override
  String get trackerTypeObsession => 'Obsession';

  @override
  String get trackerTypeCompulsion => 'Compulsion';

  @override
  String get trackerThoughtLabel => 'Que disait la pensée ?';

  @override
  String get trackerUrgeLabel => 'Quelle était l’envie ?';

  @override
  String get trackerThoughtHint => 'Décrivez la pensée ou l’image.';

  @override
  String get trackerUrgeHint => 'Décrivez l’envie ou la compulsion.';

  @override
  String get trackerActionLabel =>
      'Qu’est-ce que le TOC vous a poussé à faire ?';

  @override
  String get trackerActionHint => 'Une courte note suffit.';

  @override
  String get trackerResponseLabel => 'Ce que vous avez fait à la place';

  @override
  String get trackerResponseHint =>
      'Notez toute réponse choisie, même un délai partiel.';

  @override
  String get trackerSavingAction => 'Enregistrement…';

  @override
  String get trackerUpdateAction => 'Mettre à jour';

  @override
  String get trackerSaveAction => 'Enregistrer';

  @override
  String get trackerContentRequired =>
      'Quand vous vous sentez prêt, ajoutez quelques mots sur ce qui s’est passé.';

  @override
  String get trackerSaveError =>
      'Impossible d’enregistrer votre événement. Veuillez réessayer.';

  @override
  String get trackerUpdateError =>
      'Impossible de mettre à jour votre événement. Veuillez réessayer.';

  @override
  String get trackerEditTooltip => 'Modifier l’événement';

  @override
  String get trackerDeleteTooltip => 'Supprimer l’événement';

  @override
  String trackerDistressValue(int value) {
    return 'Détresse $value sur 10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => 'Aucune réponse notée';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type. $date. Détresse $distress sur 10. $content. Réponse : $response';
  }

  @override
  String get trackerDeleteTitle => 'Supprimer l’événement ?';

  @override
  String get trackerDeleteBody =>
      'Cela supprime l’événement de votre historique local sur cet appareil.';

  @override
  String get trackerDeleteAction => 'Supprimer';

  @override
  String get trackerDeletedMessage => 'Événement supprimé';

  @override
  String get trackerDeleteError =>
      'Impossible de supprimer votre événement. Veuillez réessayer.';

  @override
  String get trackerDistressLabel => 'Détresse, de 0 à 10';

  @override
  String get trackerEmptyTitle => 'Aucun événement pour le moment';

  @override
  String get trackerEmptyBody =>
      'Notez seulement ce qui vous semble utile. Une courte note suffit.';

  @override
  String get trackerEmptyAction => 'Enregistrer un événement de TOC';

  @override
  String get insightsTitle => 'Aperçu';

  @override
  String get insightsExportReport => 'Exporter le rapport';

  @override
  String get insightsObsessionsLogged => 'Obsessions enregistrées';

  @override
  String get insightsThemesFound => 'Thèmes repérés';

  @override
  String get insightsCompulsions => 'Compulsions';

  @override
  String get insightsAverageIntensityShort => 'Intensité moyenne';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => 'Progression de la pratique';

  @override
  String get insightsScoreNeedsMoreActivity =>
      'Un score apparaît après plusieurs pratiques sur différents jours afin de montrer une tendance plutôt qu’un seul moment. Les séances ci-dessous sont déjà comptées.';

  @override
  String get insightsScoreEmpty =>
      'Un score apparaîtra ici après plusieurs pratiques. Il n’y a encore rien à mesurer.';

  @override
  String insightsComparedPreviousDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'aux $count jours précédents',
      one: 'au jour précédent',
    );
    return 'par rapport $_temp0';
  }

  @override
  String get insightsComparedPreviousRange =>
      'par rapport à la période précédente';

  @override
  String get insightsPracticeProgressBoundary =>
      'Reflète la fréquence de votre pratique, pas un diagnostic ni votre état clinique. Le chiffre peut être plus bas pendant une semaine difficile.';

  @override
  String get insightsMoodOverTime => 'Humeur au fil du temps';

  @override
  String get insightsMoodGood => 'Bonne';

  @override
  String get insightsMoodOkay => 'Moyenne';

  @override
  String get insightsMoodLow => 'Basse';

  @override
  String get insightsYbocsOverTime => 'Y-BOCS au fil du temps';

  @override
  String get insightsYbocsEmpty =>
      'Effectuez l’auto-évaluation et votre total enregistré commencera une courbe ici.';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return 'Plage $severity. Refaites l’auto-évaluation dans quelques semaines pour ajouter un autre point enregistré.';
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
      other: '$count auto-évaluations',
      one: '1 auto-évaluation',
    );
    return 'sur $_temp0';
  }

  @override
  String get insightsYbocsBoundary =>
      'Un instantané, pas un diagnostic. Les totaux enregistrés peuvent varier et un total plus élevé ne définit pas votre progression.';

  @override
  String get insightsAverageUrgeIntensity => 'Intensité moyenne de l’envie';

  @override
  String get insightsErpPractice => 'Pratique de l’ERP';

  @override
  String insightsSessions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'séances',
      one: 'séance',
    );
    return '$_temp0';
  }

  @override
  String get insightsConsistency => 'Régularité';

  @override
  String insightsActiveDays(int active, int total) {
    return '$active jours sur $total';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return 'Activité enregistrée pendant $active jours sur $total';
  }

  @override
  String get insightsTopThemes => 'Thèmes principaux';

  @override
  String get insightsThemesEmpty =>
      'Les thèmes apparaîtront à mesure que vous noterez ce sur quoi le TOC se concentre.';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme, $percent pour cent des thèmes enregistrés';
  }

  @override
  String get insightsChangeRange => 'Modifier la période';

  @override
  String get insightsOverviewTab => 'Vue d’ensemble';

  @override
  String get insightsObsessionsTab => 'Obsessions';

  @override
  String get insightsCompulsionsTab => 'Compulsions';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ hausse de $value, $comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ baisse de $value, $comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ Aucun changement, $comparison';
  }

  @override
  String get insightsNoData => 'Aucune donnée pour le moment';

  @override
  String get insightsLoading => 'Chargement de l’aperçu';

  @override
  String get insightsLoadError =>
      'Impossible de charger votre aperçu. Veuillez réessayer.';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date : $value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title. Points enregistrés : $values';
  }

  @override
  String get ybocsSeveritySubclinical => 'Subclinique';

  @override
  String get ybocsSeverityMild => 'Léger';

  @override
  String get ybocsSeverityModerate => 'Modéré';

  @override
  String get ybocsSeveritySevere => 'Sévère';

  @override
  String get ybocsSeverityExtreme => 'Extrême';

  @override
  String get insightsThemeContamination => 'Contamination';

  @override
  String get insightsThemeHarm => 'Préjudice';

  @override
  String get insightsThemeChecking => 'Vérification';

  @override
  String get insightsThemeReassurance => 'Recherche de réassurance';

  @override
  String get insightsThemeHealth => 'Santé';

  @override
  String get insightsThemeRelationship => 'Relation';

  @override
  String get insightsThemeSymmetry => 'Symétrie';

  @override
  String get insightsThemeMoral => 'Moralité';

  @override
  String get insightsThemeRumination => 'Rumination';

  @override
  String get insightsThemeUncertainty => 'Incertitude';

  @override
  String get insightsThemeOther => 'Autre';

  @override
  String get recoveryTitle => 'Rétablissement';

  @override
  String get recoverySubtitle =>
      'Des outils et des exercices regroupés selon l’étape où vous vous trouvez.';

  @override
  String get recoveryImmediateHelpTitle =>
      'Du soutien dans un moment difficile';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Kit pour les moments difficiles',
      'copingLibrary': 'Bibliothèque d’adaptation',
      'compulsionDelay': 'Reporter la compulsion',
      'ybocsSelfCheck': 'Auto-évaluation OCD',
      'recoveryMetrics': 'Activité de rétablissement',
      'exposureHierarchy': 'Hiérarchie d’exposition',
      'exposureMaterials': 'Supports d’exposition',
      'structuredPrograms': 'Programmes structurés',
      'actionPlanner': 'Plan d’action',
      'implementationIntentions': 'Plans si-alors',
      'guidedErp': 'ERP guidée',
      'urgeSurfing': 'Surfer sur l’envie',
      'responsePrevention': 'Prévention de la réponse',
      'uncertaintyTraining': 'Entraînement à l’incertitude',
      'behavioralExperiments': 'Expériences comportementales',
      'reflectionJournal': 'Journal de réflexion',
      'other': 'Outil de rétablissement',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Un soutien rapide pour vous recentrer.',
      'copingLibrary': 'Revenez au présent et repartez.',
      'compulsionDelay': 'Créez un espace avant de répondre.',
      'ybocsSelfCheck': 'Un point Y-BOCS.',
      'recoveryMetrics': 'Consultez l’activité enregistrée.',
      'exposureHierarchy': 'Construisez votre échelle.',
      'exposureMaterials': 'Gardez vos scripts et vos liens.',
      'structuredPrograms': 'Suivez des semaines guidées.',
      'actionPlanner': 'Planifiez vos réponses.',
      'implementationIntentions': 'Créez des plans si-alors.',
      'guidedErp': 'Exercez-vous avec un plan.',
      'urgeSurfing': 'Accompagnez la vague.',
      'responsePrevention': 'Notez ce que vous avez fait à la place.',
      'uncertaintyTraining': 'Entraînez-vous à laisser une place au peut-être.',
      'behavioralExperiments': 'Testez la prédiction de l’OCD.',
      'reflectionJournal': 'Notez ce que vous avez observé.',
      'other': 'Ouvrez un outil de rétablissement.',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Évaluer',
      'plan': 'Planifier',
      'practice': 'S’exercer',
      'review': 'Faire le point',
      'other': 'Outils',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Voyez où vous en êtes.',
      'plan': 'Préparez votre exercice.',
      'practice': 'Faites un exercice.',
      'review': 'Réfléchissez et apprenez.',
      'other': 'Choisissez ce qui vous est utile.',
    });
    return '$_temp0';
  }

  @override
  String get recoveryProBadge => 'Patterns Pro';

  @override
  String recoveryOpenToolHint(String title) {
    return 'Ouvrir $title';
  }

  @override
  String recoveryLockedToolHint(String title) {
    return '$title nécessite Patterns Pro';
  }

  @override
  String get delayNameUrgeValidation =>
      'Quand vous êtes prêt, nommez l’envie avec laquelle vous voulez rester.';

  @override
  String get delayOutcomeValidation =>
      'Quand vous êtes prêt, choisissez ce que vous avez finalement fait.';

  @override
  String get delaySaveError =>
      'Votre exercice n’a pas pu être enregistré. Réessayez.';

  @override
  String get delayStopEarlyTitle => 'Arrêter plus tôt ?';

  @override
  String get delayStopEarlyBody =>
      'Vous pouvez vous arrêter. Le temps d’attente peut tout de même être enregistré.';

  @override
  String get delayKeepGoingAction => 'Continuer';

  @override
  String get delayStopAction => 'J’ai besoin d’arrêter';

  @override
  String get delaySetupTitle => 'Mettre l’envie en pause';

  @override
  String get delayUrgeQuestion => 'Avec quelle envie restez-vous ?';

  @override
  String get delayUrgeHint =>
      'Par exemple : vérifier la serrure, se laver ou chercher en ligne';

  @override
  String get delayUrgeBeforeLabel =>
      'Quelle est l’intensité de l’envie maintenant ?';

  @override
  String get delayDurationQuestion => 'Combien de temps allez-vous attendre ?';

  @override
  String get delayDurationGroupLabel => 'Durée du report';

  @override
  String get delayBeginAction => 'Commencer';

  @override
  String get delayCountdownTitle => 'Vous laissez de la place à l’envie';

  @override
  String get delayCountdownBody =>
      'Observez l’envie sans agir. Vous pouvez choisir la suite.';

  @override
  String get delayReflectionTitle => 'Que s’est-il passé ?';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed':
          'Le temps prévu est terminé. Les détails ci-dessous sont facultatifs.',
      'early':
          'Vous avez arrêté le minuteur plus tôt. Les détails ci-dessous sont facultatifs.',
      'other':
          'Le minuteur est terminé. Les détails ci-dessous sont facultatifs.',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel =>
      'Quelle est l’intensité de l’envie maintenant ?';

  @override
  String get delayOutcomeQuestion => 'Qu’avez-vous fait avec l’envie ?';

  @override
  String get delayOutcomeGroupLabel => 'Résultat enregistré';

  @override
  String get delayNoteLabel =>
      'Avez-vous remarqué quelque chose ? (facultatif)';

  @override
  String get delayNoteHint => 'Une courte note suffit.';

  @override
  String get delaySavingAction => 'Enregistrement…';

  @override
  String get delaySaveAction => 'Enregistrer l’exercice';

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
  String get delayCustomAction => 'Personnaliser';

  @override
  String get delayCustomTitle => 'Report personnalisé';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Je ne l’ai pas fait',
      'delayed': 'Je l’ai reporté',
      'performed': 'Je l’ai fait',
      'other': 'Non sélectionné',
    });
    return '$_temp0';
  }

  @override
  String delayUrgeValue(int value) {
    return 'Envie $value sur 10';
  }

  @override
  String delayCustomMinutesValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return 'Report personnalisé : $_temp0';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation':
          'Quand vous êtes prêt, choisissez ce qui s’est passé pendant l’exercice.',
      'saveError':
          'Votre exercice d’ERP n’a pas pu être enregistré. Réessayez.',
      'stopTitle': 'Arrêter plus tôt ?',
      'stopBody':
          'Vous pouvez vous arrêter. Le temps d’exercice peut tout de même être enregistré.',
      'keepGoing': 'Continuer',
      'stop': 'Arrêter',
      'anxietyBefore':
          'Quelle est l’intensité de l’envie ou de l’anxiété maintenant ?',
      'duration': 'Durée',
      'start': 'Commencer l’exercice',
      'countdownCue': 'S’exercer sans',
      'resisting': 'Réponse que vous ne faites pas',
      'countdownBody':
          'Vous n’avez pas besoin de prouver que la prédiction est fausse avant la fin du minuteur.',
      'stopEarly': 'Arrêter plus tôt',
      'reflectionTitle': 'Réfléchir',
      'reflectionBody':
          'Les détails ci-dessous sont facultatifs. Notez uniquement ce qui vous est utile.',
      'anxietyAfter': 'Quelle est son intensité maintenant ?',
      'outcomeQuestion': 'Qu’avez-vous fait ?',
      'whatHappened': 'Que s’est-il réellement passé ?',
      'whatHappenedHint': 'Qu’avez-vous remarqué pendant ou après l’exercice ?',
      'learning': 'Pour la prochaine fois',
      'learningHint':
          'Que voulez-vous garder en tête la prochaine fois que l’OCD demande ?',
      'exposure': 'Exposition',
      'prediction': 'Prédiction',
      'commitment': 'Engagement',
      'saving': 'Enregistrement…',
      'save': 'Enregistrer l’exercice',
      'other': 'Exercice d’ERP',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Le temps prévu est terminé.',
      'early': 'Vous avez arrêté le minuteur plus tôt.',
      'other': 'Le minuteur est terminé.',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Je n’ai pas fait la réponse',
      'delayed': 'J’ai reporté la réponse',
      'performed': 'J’ai fait la réponse',
      'other': 'Non sélectionné',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return 'Intensité $value sur 10';
  }

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'ERP guidée',
      'subtitle':
          'Réutilisez un plan, exercez-vous et notez ce qui s’est passé.',
      'myPlans': 'Mes plans d’ERP',
      'newAction': 'Nouveau',
      'plansError': 'Les plans d’ERP sont indisponibles pour le moment.',
      'recentPractice': 'Exercices récents',
      'historyError':
          'L’historique des exercices est indisponible pour le moment.',
      'archiveTitle': 'Archiver ce plan ?',
      'archiveBody':
          'Il quittera vos plans actifs, mais les exercices passés resteront dans votre historique.',
      'keepAction': 'Conserver',
      'archiveAction': 'Archiver',
      'exposureValidation':
          'Quand vous êtes prêt, décrivez la situation avec laquelle vous souhaitez vous exercer.',
      'commitmentValidation':
          'Choisissez la réponse que vous souhaitez vous exercer à ne pas faire afin d’enregistrer le plan.',
      'saveError': 'Votre plan d’ERP n’a pas pu être enregistré. Réessayez.',
      'updated': 'Plan d’ERP mis à jour.',
      'created': 'Plan d’ERP créé.',
      'editTitle': 'Modifier le plan d’ERP',
      'createTitle': 'Créer un plan d’ERP',
      'exerciseType': 'Type d’exercice',
      'exposureTarget': 'Cible d’exposition',
      'ocdPrediction': 'Prédiction du TOC',
      'preventionCommitment': 'Engagement de prévention de la réponse',
      'defaultDuration': 'Durée par défaut',
      'saving': 'Enregistrement…',
      'saveAction': 'Enregistrer le plan',
      'createAction': 'Créer le plan',
      'emptyTitle': 'Créez votre premier plan d’ERP',
      'emptyBody':
          'Notez une fois l’exposition, la prédiction et la réponse que vous souhaitez vous exercer à ne pas faire. Vous pourrez ensuite réutiliser ce plan.',
      'moreActions': 'Autres actions du plan',
      'editAction': 'Modifier le plan',
      'archivePlanAction': 'Archiver le plan',
      'practiceGuide': 'Guide de l’exercice',
      'historyEmpty': 'Les exercices terminés apparaîtront ici.',
      'customDuration': 'Durée personnalisée',
      'other': 'Plan d’ERP',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return 'Ne pas faire : $response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction =>
      'Le TOC dit que l’inconfort ne changera pas si vous ne réagissez pas.';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Retarder la vérification',
      'delayReassurance': 'Retarder la recherche de réassurance',
      'delayGoogling': 'Retarder la recherche en ligne',
      'delayRumination': 'Retarder la rumination',
      'delayWashing': 'Retarder le lavage',
      'other': 'ERP guidée',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Exercez-vous à laisser quelque chose sans vérification pendant un court moment.',
      'delayReassurance':
          'Attendez avant de demander à quelqu’un de rendre la peur certaine.',
      'delayGoogling':
          'Remettez à plus tard la recherche de certitude ou de preuve.',
      'delayRumination':
          'Remarquez la résolution mentale de problèmes sans la suivre.',
      'delayWashing':
          'Attendez avant de vous laver, nettoyer ou désinfecter à nouveau.',
      'other': 'Exercez-vous à retarder une réponse.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Créez un plan réutilisable pour les moments où le TOC vous pousse à revérifier serrures, interrupteurs, messages, symptômes ou erreurs.',
      'delayReassurance':
          'Créez un plan pour les envies de demander, avouer, expliquer ou faire confirmer par quelqu’un que tout va bien.',
      'delayGoogling':
          'Créez un plan pour les moments où le TOC veut vous faire rechercher symptômes, significations, risques, règles ou récits jusqu’à obtenir une certitude.',
      'delayRumination':
          'Créez un plan pour les compulsions mentales comme repasser, prouver, vérifier ou résoudre.',
      'delayWashing':
          'Créez un plan pour les envies de laver, nettoyer, désinfecter ou recommencer parce que quelque chose semble contaminé.',
      'other': 'Créez un plan d’exercice d’ERP réutilisable.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'L’ERP vous permet de vous exercer à laisser l’incertitude présente sans accomplir immédiatement un rituel.',
      'delayReassurance':
          'La réassurance peut sembler utile sur le moment ; la retarder vous permet de vous exercer à ne pas savoir.',
      'delayGoogling':
          'Reporter la recherche interrompt la boucle de certitude et vous permet de laisser une question sans réponse.',
      'delayRumination':
          'La rumination peut ressembler à de la réflexion ; l’ERP vous permet de quitter la boucle sans terminer l’argument.',
      'delayWashing':
          'Attendre vous permet de laisser la sensation de contamination présente sans accomplir immédiatement un rituel.',
      'other':
          'L’ERP permet de laisser une place à l’incertitude sans rituel immédiat.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure':
          'Que laisserez-vous sans vérifier ou ne vérifierez-vous qu’une fois ?',
      'delayCheckingPrediction':
          'Que prédit le TOC si vous ne vérifiez pas à nouveau ?',
      'delayCheckingCommitment':
          'À quel rituel de vérification allez-vous vous exercer à résister ?',
      'delayReassuranceExposure':
          'Quelle réassurance souhaitez-vous demander ?',
      'delayReassurancePrediction':
          'D’après le TOC, que se passera-t-il si vous ne demandez pas ?',
      'delayReassuranceCommitment':
          'À quel message, aveu ou question allez-vous résister ?',
      'delayGooglingExposure':
          'Quelle recherche ou question laisserez-vous sans réponse ?',
      'delayGooglingPrediction':
          'D’après le TOC, que devez-vous savoir maintenant ?',
      'delayGooglingCommitment':
          'Quelle recherche, quel article ou quel forum éviterez-vous ?',
      'delayRuminationExposure':
          'Quelle boucle de pensée laisserez-vous inachevée ?',
      'delayRuminationPrediction':
          'D’après le TOC, que devez-vous résoudre ou prouver ?',
      'delayRuminationCommitment':
          'À quelle vérification mentale ou argumentation allez-vous résister ?',
      'delayWashingExposure':
          'Quelle limite d’hygiène normale respecterez-vous ?',
      'delayWashingPrediction':
          'Que prédit le TOC si vous ne vous lavez pas à nouveau ?',
      'delayWashingCommitment':
          'À quel lavage, nettoyage ou désinfection supplémentaire allez-vous résister ?',
      'other': 'À quelle réponse allez-vous vous exercer à résister ?',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1':
          'Définissez une règle de vérification avant de commencer.',
      'delayChecking2':
          'Effectuez une fois la vérification prévue si elle relève de la sécurité normale.',
      'delayChecking3':
          'Résistez à une nouvelle vérification pendant le minuteur.',
      'delayChecking4': 'Remarquez l’envie sans négocier avec elle.',
      'delayReassurance1':
          'Définissez la demande de réassurance avant de commencer.',
      'delayReassurance2':
          'N’envoyez pas le message et ne posez pas la question pendant le minuteur.',
      'delayReassurance3':
          'Laissez l’inconfort présent sans chercher de certitude.',
      'delayReassurance4':
          'Revenez aussi doucement que possible à ce que vous faisiez.',
      'delayGoogling1': 'Définissez la recherche avant d’ouvrir autre chose.',
      'delayGoogling2':
          'Fermez le champ de recherche ou l’onglet du navigateur.',
      'delayGoogling3': 'Lancez le minuteur avant de lire autre chose.',
      'delayGoogling4': 'Laissez la question sans réponse pour le moment.',
      'delayRumination1':
          'Nommez la boucle : repasser, résoudre, prouver ou vérifier.',
      'delayRumination2': 'Laissez la pensée inachevée.',
      'delayRumination3':
          'Ramenez votre attention vers une tâche ou une sensation ordinaire.',
      'delayRumination4':
          'Recommencez doucement chaque fois que la boucle vous ramène.',
      'delayWashing1':
          'Définissez la limite d’hygiène normale avant de commencer.',
      'delayWashing2':
          'Commencez par un délai qui semble difficile mais possible.',
      'delayWashing3':
          'Gardez les mains loin du lavabo ou du désinfectant pendant le minuteur.',
      'delayWashing4':
          'Laissez l’inconfort présent sans chercher à le rendre parfait.',
      'other': 'Suivez le plan que vous avez choisi.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Vérifier une fois',
      'delayChecking2': 'Ne pas revérifier',
      'delayChecking3': 'Remarquer l’envie',
      'delayReassurance1': 'Retenir la demande',
      'delayReassurance2': 'Laisser l’incertitude',
      'delayReassurance3': 'Revenir doucement',
      'delayGoogling1': 'Fermer la recherche',
      'delayGoogling2': 'Lancer le minuteur',
      'delayGoogling3': 'Laisser sans réponse',
      'delayRumination1': 'Nommer la boucle',
      'delayRumination2': 'Laisser inachevé',
      'delayRumination3': 'Revenir à la tâche',
      'delayWashing1': 'Définir la limite',
      'delayWashing2': 'Retarder le lavage',
      'delayWashing3': 'Laisser l’inconfort',
      'other': 'Suivre le plan',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Programmes structurés',
      'subtitle':
          'Suivez un plan guidé, semaine après semaine, à votre rythme.',
      'themeGroup': 'Par thème de TOC',
      'themeGroupEmpty':
          'Choisissez un thème s’il correspond à ce que vous souhaitez pratiquer.',
      'themeGroupMatched':
          'Les thèmes consignés dans votre dernière auto-évaluation sont signalés ci-dessous.',
      'generalGroup': 'Pratique générale',
      'generalCaption': 'Des compétences utilisables pour différents thèmes.',
      'enrollError': 'Impossible d’ouvrir ce programme. Réessayez.',
      'started': 'Commencé',
      'notStarted': 'Non commencé',
      'openHint': 'Ouvrir les détails du programme',
      'selfCheckMatch': 'Correspond à votre auto-évaluation',
      'tapToStart': 'Touchez pour commencer',
      'progressLoadError':
          'Impossible de charger l’activité du programme. Réessayez.',
      'activityRecorded': 'Vos choix de tâches sont enregistrés localement.',
      'taskSaveError':
          'Impossible d’enregistrer cette modification. Réessayez.',
      'weekComplete': 'Toutes les tâches sont marquées comme terminées',
      'weekNotComplete': 'Il reste des tâches',
      'weekToggleHint': 'Développer ou réduire cette semaine',
      'taskToggleHint': 'Marquer ou démarquer cette tâche',
      'other': 'Programme',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$done tâches sur $total, $percent pour cent';
  }

  @override
  String structuredProgramSummary(int count, String subtitle) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semaines · $subtitle',
      one: '1 semaine · $subtitle',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramComplete(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Les $count tâches sont marquées comme terminées.',
      one: 'La tâche est marquée comme terminée.',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$done tâches sur $total marquées comme terminées';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String exposureHierarchyText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Hiérarchie d’exposition',
      'newAction': 'Nouvelle',
      'subtitle':
          'Créez une échelle d’expositions possibles et pratiquez une étape à la fois.',
      'loadError':
          'Vos hiérarchies sont indisponibles pour le moment. Réessayez.',
      'archiveTitle': 'Archiver cette hiérarchie ?',
      'archiveBody':
          'La hiérarchie sera retirée de votre liste active. Ses étapes enregistrées resteront sur cet appareil.',
      'keepAction': 'Conserver',
      'archiveAction': 'Archiver',
      'archiveSuccess': 'Hiérarchie archivée.',
      'archiveError': 'Impossible d’archiver cette hiérarchie. Réessayez.',
      'emptyTitle': 'Créez votre première échelle',
      'emptyBody':
          'Listez des expositions possibles de la plus facile à la plus difficile et choisissez votre rythme.',
      'buildAction': 'Créer une hiérarchie',
      'newTitle': 'Nouvelle hiérarchie',
      'nameLabel': 'Nom',
      'nameHint': 'Par exemple, toucher des poignées de porte',
      'themeLabel': 'Thème (facultatif)',
      'themeHint': 'Par exemple, contamination',
      'generalTheme': 'Général',
      'stepsTitle': 'Étapes, les plus faciles d’abord',
      'addAction': 'Ajouter',
      'createAction': 'Créer la hiérarchie',
      'saving': 'Enregistrement…',
      'titleValidation': 'Ajoutez un nom à cette échelle.',
      'stepValidation': 'Ajoutez au moins une étape d’exposition.',
      'createSuccess': 'Hiérarchie enregistrée.',
      'createError': 'Impossible d’enregistrer cette hiérarchie. Réessayez.',
      'stepHint': 'Quelle exposition pourriez-vous pratiquer ?',
      'difficulty': 'Difficulté',
      'anxiety': 'Anxiété anticipée',
      'materialAction': 'Matériel',
      'statusNotStarted': 'Non commencée',
      'statusInProgress': 'En cours',
      'statusDone': 'Terminée',
      'statusError':
          'Impossible d’enregistrer l’état de cette étape. Réessayez.',
      'moveUp': 'Monter l’étape',
      'moveDown': 'Descendre l’étape',
      'removeStep': 'Supprimer l’étape',
      'openHierarchy': 'Ouvrir la hiérarchie',
      'archiveHierarchy': 'Archiver la hiérarchie',
      'other': 'Hiérarchie d’exposition',
    });
    return '$_temp0';
  }

  @override
  String exposureHierarchySummary(int done, int count, String theme) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$done étapes sur $count · $theme',
      one: '$done étape sur 1 · $theme',
      zero: '$theme',
    );
    return '$_temp0';
  }

  @override
  String exposureStepLabel(int number) {
    return 'Étape $number';
  }

  @override
  String exposureRating(int value) {
    return '$value sur 10';
  }

  @override
  String exposureStepMetrics(int difficulty, int anxiety) {
    return 'Difficulté $difficulty sur 10 · Anxiété anticipée $anxiety sur 10';
  }

  @override
  String exposureProgress(int percent) {
    return '$percent % des étapes marquées comme terminées';
  }

  @override
  String exposureMaterialsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Matériel d’exposition',
      'newAction': 'Nouveau',
      'subtitle':
          'Regroupez vos scripts, enregistrements en boucle, images et liens pour les utiliser pendant une exposition.',
      'loadError': 'Votre matériel est indisponible pour le moment. Réessayez.',
      'typeScript': 'Script',
      'typeLoopTape': 'Enregistrement en boucle',
      'typeImage': 'Image',
      'typeLink': 'Lien',
      'deleteTitle': 'Supprimer ce matériel ?',
      'deleteBody':
          'Cette action supprime le matériel de cet appareil, y compris son fichier enregistré le cas échéant.',
      'cancel': 'Annuler',
      'deleteAction': 'Supprimer',
      'deleteTooltip': 'Supprimer le matériel',
      'deleteSuccess': 'Matériel supprimé.',
      'deleteError': 'Impossible de supprimer ce matériel. Réessayez.',
      'emptyTitle': 'Rassemblez votre matériel',
      'emptyBody':
          'Enregistrez un script, un enregistrement en boucle, une image ou un lien pour une exposition de votre choix.',
      'addAction': 'Ajouter du matériel',
      'readScript': 'Lire le script',
      'openLink': 'Ouvrir le lien',
      'viewImage': 'Voir l’image',
      'linkError': 'Impossible d’ouvrir ce lien.',
      'imageMissing': 'Cette image n’est plus disponible sur cet appareil.',
      'recordingMissing':
          'Cet enregistrement n’est plus disponible sur cet appareil.',
      'stop': 'Arrêter',
      'playLoop': 'Lire en boucle',
      'microphoneNeeded':
          'L’accès au microphone est nécessaire pour enregistrer une boucle. Vous pouvez le modifier dans les réglages de l’appareil.',
      'nameValidation': 'Ajoutez un nom à ce matériel.',
      'scriptValidation': 'Ajoutez le texte du script.',
      'linkValidation': 'Collez un lien.',
      'imageValidation': 'Choisissez une image.',
      'recordingValidation': 'Enregistrez une boucle avant de sauvegarder.',
      'saveSuccess': 'Matériel enregistré.',
      'saveError': 'Impossible d’enregistrer ce matériel. Réessayez.',
      'titleLabel': 'Titre',
      'titleHint': 'Un nom court que vous reconnaîtrez',
      'saveAction': 'Enregistrer le matériel',
      'scriptLabel': 'Script',
      'scriptHint': 'Le texte à lire pendant l’exposition',
      'linkLabel': 'Lien',
      'pickImage': 'Choisir une image',
      'changeImage': 'Changer l’image',
      'rerecord': 'Réenregistrer',
      'recorderHint': 'Enregistrez un court extrait à lire en boucle.',
      'record': 'Enregistrer',
      'recording': 'Enregistrement',
      'other': 'Matériel d’exposition',
    });
    return '$_temp0';
  }

  @override
  String exposureMaterialEditorTitle(String type) {
    return 'Nouveau : $type';
  }

  @override
  String exposureRecordingSeconds(int seconds) {
    return 'Enregistrement · $seconds s';
  }

  @override
  String responsePreventionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Prévention de la réponse',
      'logAction': 'Noter',
      'subtitle':
          'Notez le déclencheur, la réponse choisie et la détresse ressentie à ce moment-là.',
      'loadError':
          'Vos relevés de réponse sont indisponibles pour le moment. Veuillez réessayer.',
      'deleteTitle': 'Supprimer ce relevé de réponse ?',
      'deleteBody': 'Cela supprime définitivement le relevé de cet appareil.',
      'cancel': 'Annuler',
      'deleteAction': 'Supprimer',
      'deleteTooltip': 'Supprimer le relevé de réponse',
      'deleteSuccess': 'Relevé de réponse supprimé.',
      'deleteError':
          'Ce relevé de réponse n’a pas pu être supprimé. Veuillez réessayer.',
      'outcomeResisted': 'Non effectuée',
      'outcomeDelayed': 'Retardée',
      'outcomePartial': 'Partiellement effectuée',
      'outcomePerformed': 'Effectuée',
      'emptyTitle': 'Noter une réponse',
      'emptyBody':
          'Après un déclencheur, notez votre choix et la détresse ressentie.',
      'emptyAction': 'Noter une réponse',
      'editorTitle': 'Noter une réponse',
      'situationLabel': 'Quel a été le déclencheur ?',
      'situationHint': 'Le déclencheur et la réponse suggérée par le TOC',
      'outcomeQuestion': 'Qu’avez-vous fait ?',
      'distressLabel': 'Détresse à ce moment-là',
      'noteLabel': 'Note (facultative)',
      'noteHint': 'Ce que vous souhaitez retenir',
      'saveAction': 'Enregistrer le relevé',
      'situationValidation': 'Ajoutez une brève description du déclencheur.',
      'saveSuccess': 'Relevé de réponse enregistré.',
      'saveError':
          'Ce relevé de réponse n’a pas pu être enregistré. Veuillez réessayer.',
      'other': 'Prévention de la réponse',
    });
    return '$_temp0';
  }

  @override
  String responsePreventionDistress(int value) {
    return 'Détresse $value sur 10';
  }

  @override
  String responsePreventionLogSummary(
    String outcome,
    String date,
    int distress,
    String situation,
  ) {
    return '$outcome · $date · détresse $distress sur 10 · $situation';
  }

  @override
  String urgeSurfText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Surfer sur l’envie compulsive',
      'subtitle':
          'Observez une envie compulsive pendant la durée choisie, sans devoir la modifier ni y répondre.',
      'startAction': 'Commencer',
      'historyTitle': 'Sessions précédentes',
      'emptyHistory':
          'Aucune session enregistrée pour le moment. Une session enregistrée apparaîtra ici.',
      'loadError':
          'Vos sessions enregistrées sont indisponibles pour le moment. Veuillez réessayer.',
      'triggerFallback': 'Une envie compulsive',
      'setupTitle': 'Avant de commencer',
      'triggerLabel': 'Quelle est l’envie ? (facultatif)',
      'triggerHint': 'Par exemple, l’envie de me laver à nouveau les mains',
      'initialUrgeLabel': 'Envie au début',
      'durationQuestion':
          'Pendant combien de temps souhaitez-vous l’observer ?',
      'begin': 'Commencer',
      'surfingTitle': 'Observer l’envie',
      'surfingBody':
          'Remarquez les pensées et les sensations, puis choisissez ce que vous faites ensuite. Vous pouvez arrêter à tout moment.',
      'currentUrgeLabel': 'Envie maintenant',
      'doneAction': 'Terminer pour l’instant',
      'reflectionTitle': 'Noter ce que vous avez remarqué',
      'waveTitle': 'Niveaux d’envie relevés',
      'finalUrgeLabel': 'Envie à la fin',
      'noteLabel': 'Note (facultative)',
      'noteHint': 'Qu’avez-vous remarqué ?',
      'saveAction': 'Enregistrer la session',
      'finishAction': 'Terminer',
      'saveSuccess': 'Session enregistrée.',
      'finishSuccess': 'Exercice terminé.',
      'saveError':
          'Cette session n’a pas pu être enregistrée. Veuillez réessayer.',
      'timerComplete': 'Temps d’observation terminé.',
      'other': 'Surfer sur l’envie compulsive',
    });
    return '$_temp0';
  }

  @override
  String urgeSurfRating(int value) {
    return 'Envie $value sur 10';
  }

  @override
  String urgeSurfDuration(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String urgeSurfRecordedDuration(int minutes, int seconds) {
    return '$minutes min $seconds s';
  }

  @override
  String urgeSurfHistorySummary(
    int initial,
    int peak,
    int finalLevel,
    String duration,
  ) {
    return 'Début à $initial sur 10 · valeur maximale relevée $peak sur 10 · fin à $finalLevel sur 10 · $duration';
  }

  @override
  String urgeSurfSessionSemantics(String trigger, String date, String summary) {
    return '$trigger · $date · $summary';
  }

  @override
  String urgeSurfWaveSummary(int initial, int peak) {
    return 'Début à $initial sur 10 · valeur maximale relevée $peak sur 10';
  }

  @override
  String urgeSurfTimerDisplay(int minutes, String seconds) {
    return '$minutes:$seconds';
  }

  @override
  String urgeSurfTimeRemaining(int minutes, int seconds) {
    return 'Il reste $minutes min et $seconds s';
  }

  @override
  String emergencyToolkitText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Soutien pour maintenant',
      'pauseTitle': 'Faire une pause avant de réagir',
      'pauseBody':
          'Vous n’avez pas à répondre immédiatement à l’impulsion. Choisissez un exercice d’auto-assistance ci-dessous et avancez doucement.',
      'boundary':
          'Ces outils ne fournissent pas de soins d’urgence ou cliniques. En cas de danger immédiat, contactez les services d’urgence locaux.',
      'breathe': 'Respirer',
      'breatheSubtitle': 'Suivre un cycle respiratoire rythmé',
      'delay': 'Retarder l’impulsion',
      'delaySubtitle': 'Créer un espace avec un minuteur',
      'surf': 'Observer l’impulsion',
      'surfSubtitle': 'Remarquer l’impulsion sans agir',
      'coping': 'Techniques d’adaptation',
      'copingSubtitle': 'Ancrage, acceptation et plus',
      'remindersTitle': 'Quelques rappels',
      'reminderThought':
          'Une pensée n’exige pas de réponse. Je peux la remarquer sans agir.',
      'reminderUrge':
          'Une impulsion peut changer avec le temps. Je peux choisir la suite.',
      'reminderUncertainty':
          'Je peux laisser une place à l’incertitude dans ce moment.',
      'breatheIn': 'Inspirer',
      'hold': 'Retenir',
      'breatheOut': 'Expirer',
      'breathingHint':
          'Suivez le cercle : inspirez pendant 4 secondes, retenez, expirez pendant 4 secondes, puis retenez.',
      'other': 'Outil de soutien',
    });
    return '$_temp0';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Auto-évaluation du TOC',
      'introBody':
          'Une auto-évaluation guidée fondée sur l’échelle d’obsession-compulsion de Yale-Brown (Y-BOCS), concernant les schémas que vous remarquez et leur impact sur vous.',
      'spotTitle': 'Repérer les schémas',
      'spotBody':
          'Sélectionnez les obsessions et compulsions que vous avez vécues.',
      'impactTitle': 'Noter l’impact',
      'impactBody':
          'Répondez à 10 questions sur leur impact dans votre journée.',
      'resultIntroTitle': 'Consulter le résultat',
      'resultIntroBody':
          'Consultez les thèmes, sous-totaux et la plage de sévérité enregistrés.',
      'begin': 'Commencer',
      'retakeAction': 'Refaire l’évaluation',
      'privacyDuration':
          'Durée approximative : 10 minutes. Vos réponses restent sur cet appareil, sauf si vous choisissez de les exporter.',
      'disclaimer':
          'Cette auto-évaluation peut vous aider à décrire votre expérience. Elle ne diagnostique pas le TOC et ne constitue pas une aide d’urgence. Seul un professionnel qualifié peut diagnostiquer le TOC.',
      'historyTitle': 'Votre historique',
      'historyBody': 'Vos totaux précédemment enregistrés apparaissent ici.',
      'deleteTitle': 'Supprimer l’évaluation ?',
      'deleteBody':
          'Cette action supprime définitivement cette évaluation de cet appareil.',
      'cancel': 'Annuler',
      'deleteAction': 'Supprimer',
      'deleteTooltip': 'Supprimer l’évaluation',
      'deleteSuccess': 'Évaluation supprimée.',
      'deleteError': 'Impossible de supprimer cette évaluation. Réessayez.',
      'checklistTitle': 'Qu’est-ce qui vous semble familier ?',
      'checklistBody':
          'Sélectionnez toute expérience actuelle ou passée. Ignorez ce qui ne correspond pas.',
      'obsessions': 'Obsessions',
      'obsessionsDescription': 'Pensées, images ou impulsions non désirées',
      'compulsions': 'Compulsions',
      'compulsionsDescription':
          'Comportements ou actes mentaux accomplis en réponse à la détresse',
      'continueAction': 'Continuer',
      'seeResults': 'Voir le résultat',
      'next': 'Suivant',
      'resultsTitle': 'Votre résultat',
      'retake': 'Recommencer',
      'saved': 'Enregistré',
      'saveHistory': 'Enregistrer dans mon historique',
      'saving': 'Enregistrement…',
      'saveSuccess': 'Enregistré dans votre historique.',
      'saveError': 'Impossible d’enregistrer cette évaluation. Réessayez.',
      'breakdownTitle': 'Sous-totaux enregistrés',
      'typesTitle': 'Types enregistrés',
      'typesNone':
          'Aucun type d’obsession ou de compulsion n’a été enregistré dans cette auto-évaluation.',
      'typesBoth':
          'Des obsessions et des compulsions ont été enregistrées dans cette auto-évaluation.',
      'typesObsessions':
          'Des obsessions ont été enregistrées dans cette auto-évaluation.',
      'typesCompulsions':
          'Des compulsions ont été enregistrées dans cette auto-évaluation.',
      'themesTitle': 'Thèmes enregistrés',
      'themesBody':
          'Les catégories de la liste contenant les éléments sélectionnés.',
      'nextStepsTitle': 'À propos de ce résultat',
      'nextStepsBody':
          'Ce résultat est un instantané autodéclaré, pas un diagnostic ni une aide d’urgence. Si ces schémas affectent votre vie, vous pouvez en parler avec un professionnel qualifié. En cas de danger immédiat, contactez les services d’urgence locaux.',
      'other': 'Auto-évaluation Y-BOCS',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuer · $count sélectionnés',
      one: 'Continuer · 1 sélectionné',
      zero: 'Continuer',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return 'Question $current sur $total';
  }

  @override
  String ybocsScoreOutOf(int score, int maximum) {
    return '$score sur $maximum';
  }

  @override
  String ybocsHistorySummary(String severity, int score, String date) {
    return '$severity · $score sur 40 · $date';
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
      other: '$count éléments sélectionnés',
      one: '1 élément sélectionné',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Tâche marquée comme terminée.',
      'notCompleted': 'Tâche marquée comme non terminée.',
      'other': 'Tâche mise à jour.',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Retarder les compulsions en 4 semaines',
      'uncertainty3wk': 'Tolérance à l’incertitude',
      'other': 'Programme structuré',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk':
          'Entraînez-vous à retarder les compulsions, semaine après semaine',
      'uncertainty3wk': 'Entraînez-vous à vivre sans savoir',
      'other': 'Un plan de pratique guidé',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': 'Semaine 1 · Remarquer et nommer',
      'delayW2': 'Semaine 2 · Allonger l’intervalle',
      'delayW3': 'Semaine 3 · Attendre plus longtemps',
      'delayW4': 'Semaine 4 · Pratique quotidienne',
      'uncertaintyW1': 'Semaine 1 · Laisser la question ouverte',
      'uncertaintyW2': 'Semaine 2 · Peut-être, peut-être pas',
      'uncertaintyW3': 'Semaine 3 · Laisser être',
      'other': 'Semaine du programme',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': 'Consignez 3 envies sans agir immédiatement',
      'w1b': 'Retardez une compulsion d’une minute, 3 fois',
      'w2a': 'Retardez les compulsions de 5 minutes',
      'w2b': 'Essayez une fois d’observer l’envie comme une vague',
      'w3a': 'Retardez la réponse de 15 minutes',
      'w3b': 'Résistez une fois à l’envie de demander à être rassuré·e',
      'w4a': 'Effectuez une exposition chaque jour',
      'w4b': 'Réfléchissez à ce que vous avez remarqué',
      'u1a': 'Laissez une question sans réponse',
      'u1b': 'Résistez une fois à une vérification',
      'u2a': 'Utilisez 3 fois une réponse « peut-être, peut-être pas »',
      'u2b': 'Retardez une recherche en ligne liée à une inquiétude',
      'u3a': 'Passez une journée sans chercher de certitude',
      'u3b': 'Réfléchissez à ce que vous avez remarqué',
      'other': 'Tâche du programme',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contamination et lavage',
      'checking': 'Vérification et doute',
      'harm': 'Atteinte et pensées taboues',
      'relationship': 'Doutes relationnels',
      'justRight': 'Sensation d’exactitude et symétrie',
      'other': 'Thème de TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination':
          'Pour les craintes qu’une chose soit sale, contagieuse ou dangereuse à toucher, et le lavage ou le nettoyage qui s’ensuit.',
      'checking':
          'Pour les serrures, plaques de cuisson, interrupteurs, messages et autres éléments que vous revérifiez parce que le geste ne semble pas assez certain.',
      'harm':
          'Pour les pensées intrusives liées à une atteinte ou à des thèmes vécus comme violents, sexuels ou blasphématoires, ainsi que les compulsions ou l’évitement qui suivent.',
      'relationship':
          'Pour les doutes récurrents sur la pertinence d’une relation, l’intensité de vos sentiments ou le sens du doute.',
      'justRight':
          'Pour les choses qui semblent devoir être égales, ordonnées ou répétées jusqu’à ce qu’elles paraissent exactes.',
      'other': 'Un parcours de pratique organisé autour d’un thème de TOC.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contamination',
      'checking': 'Vérification',
      'harm': 'Atteinte et pensées taboues',
      'relationship': 'Doutes relationnels',
      'justRight': 'Sensation d’exactitude',
      'other': 'Thème de TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'La liste Y-BOCS est antérieure aux recherches sur le TOC relationnel ; ce thème ne fait donc pas partie de ses catégories. Vous pouvez néanmoins utiliser ce parcours de pratique.',
      'other':
          'Ce thème n’est pas représenté comme catégorie dans la liste Y-BOCS.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': 'Semaine 1 · Toucher, puis attendre',
      'ct2': 'Semaine 2 · Un lavage, pas trois',
      'ct3': 'Semaine 3 · Le ramener chez soi',
      'ck1': 'Semaine 1 · Regarder une fois',
      'ck2': 'Semaine 2 · Sans relecture mentale',
      'ck3': 'Semaine 3 · Laisser sans réponse',
      'hm1': 'Semaine 1 · Laisser être',
      'hm2': 'Semaine 2 · Cesser de demander',
      'hm3': 'Semaine 3 · Sans procès intérieur',
      'rl1': 'Semaine 1 · Cesser de tester',
      'rl2': 'Semaine 2 · Sans demander à être rassuré·e',
      'rl3': 'Semaine 3 · Vivre avec le peut-être',
      'jr1': 'Semaine 1 · Laisser de travers',
      'jr2': 'Semaine 2 · Sans répéter',
      'jr3': 'Semaine 3 · Suffisamment bien',
      'other': 'Semaine du parcours',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a':
          'Touchez quelque chose qui semble légèrement sale et attendez cinq minutes avant de vous laver les mains',
      'ct1b': 'Consignez l’envie avant et après sans vous laver',
      'ct2a':
          'Lavez-vous une fois, normalement, sans recommencer une deuxième fois',
      'ct2b':
          'Laissez une surface de la maison non nettoyée pendant la semaine',
      'ct3a':
          'Allez dans un lieu qui vous incite habituellement à vous laver ensuite et ne vous lavez pas en rentrant',
      'ct3b': 'Notez la prédiction du TOC à côté de ce qui s’est passé',
      'ck1a':
          'Vérifiez une chose une fois, puis éloignez-vous sans regarder une deuxième fois',
      'ck1b': 'Quittez la maison une fois sans inspection finale des pièces',
      'ck2a':
          'Lorsque l’envie de repasser le souvenir arrive, laissez le doute sans réponse',
      'ck2b': 'Envoyez un message sans le relire avant ni après',
      'ck3a':
          'Passez une journée sans revenir vérifier deux fois quoi que ce soit',
      'ck3b': 'Notez ce qui s’est passé et ce que le TOC avait prédit',
      'hm1a':
          'Laissez une pensée intrusive présente pendant une minute sans débattre avec elle ni la repousser',
      'hm1b':
          'Remarquez la révision mentale avant qu’elle ne commence et laissez-la tranquille',
      'hm2a':
          'Résistez à l’envie de demander si vous êtes une bonne personne et ne cherchez pas non plus de réponse',
      'hm2b': 'Restez dans une situation que vous évitiez à cause de la pensée',
      'hm3a':
          'Passez une journée sans vérifier vos sentiments pour chercher des preuves sur vous-même',
      'hm3b': 'Notez comment s’est passée la semaine sans vous évaluer',
      'rl1a':
          'Repérez un test de compatibilité que vous utilisez et omettez-le une fois',
      'rl1b': 'Laissez un doute relationnel sans réponse pendant dix minutes',
      'rl2a':
          'Passez une journée sans demander à votre partenaire, à un proche ou sur internet si la relation est la bonne',
      'rl2b':
          'Faites une activité ensemble sans surveiller ce que vous ressentez pendant celle-ci',
      'rl3a':
          'Utilisez une réponse « peut-être, peut-être pas » lorsque la question survient',
      'rl3b': 'Réfléchissez à la semaine sans prendre de décision sur l’avenir',
      'jr1a':
          'Laissez un objet légèrement déplacé et laissez la sensation être présente',
      'jr1b':
          'Faites une chose une seule fois, même si elle ne semble pas terminée',
      'jr2a': 'Résistez à la répétition d’un geste pour qu’il semble exact',
      'jr2b':
          'Écrivez quelque chose sans revenir modifier la formulation pour la rendre uniforme',
      'jr3a':
          'Passez une journée en laissant volontairement plusieurs choses inachevées',
      'jr3b':
          'Consignez ce qui est arrivé à la sensation d’inexactitude sans la modifier',
      'other': 'Tâche du parcours',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time':
          'Quelle part de mon temps est occupée par des pensées obsessionnelles ?',
      'o_interfere':
          'Dans quelle mesure les obsessions perturbent-elles ma vie ?',
      'o_distress':
          'Quelle détresse les pensées obsessionnelles me causent-elles ?',
      'o_resist':
          'Dans quelle mesure est-ce que j’essaie de résister aux pensées obsessionnelles ?',
      'o_control': 'Quel contrôle ai-je sur les pensées obsessionnelles ?',
      'c_time':
          'Combien de temps est-ce que je consacre aux compulsions, comme les rituels ou les vérifications ?',
      'c_interfere':
          'Dans quelle mesure les compulsions perturbent-elles ma vie ?',
      'c_distress':
          'À quel point serais-je anxieux ou bouleversé si je ne pouvais pas effectuer la compulsion ?',
      'c_resist':
          'Dans quelle mesure est-ce que j’essaie de résister aux compulsions ?',
      'c_control': 'Quel contrôle ai-je sur les compulsions ?',
      'other': 'Question d’auto-évaluation',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'Pas du tout',
      'o_time_1': 'Un peu : moins d’une heure par jour ou quelques fois',
      'o_time_2': 'Modérément : 1 à 3 heures par jour ou intrusions fréquentes',
      'o_time_3':
          'Beaucoup : 3 à 8 heures par jour ou intrusions très fréquentes',
      'o_time_4': 'Presque constamment : plus de 8 heures par jour',
      'o_interfere_0': 'Pas du tout',
      'o_interfere_1': 'Un peu : elles n’affectent pas vraiment ce que je fais',
      'o_interfere_2':
          'Quelque peu : elles interfèrent, mais je peux encore gérer',
      'o_interfere_3': 'Beaucoup : elles gênent clairement ma journée',
      'o_interfere_4': 'Au point que je peux à peine fonctionner',
      'o_distress_0': 'Aucune',
      'o_distress_1': 'Un peu : pas trop perturbante',
      'o_distress_2': 'Modérée : perturbante, mais gérable',
      'o_distress_3': 'Beaucoup : très perturbante',
      'o_distress_4': 'Détresse presque constante et invalidante',
      'o_resist_0':
          'J’essaie toujours de résister, ou elles surviennent à peine',
      'o_resist_1': 'J’essaie de résister la plupart du temps',
      'o_resist_2': 'Je fais quelques efforts pour résister',
      'o_resist_3': 'Je cède à presque toutes sans vraiment lutter',
      'o_resist_4': 'J’y cède complètement et volontairement',
      'o_control_0': 'Contrôle total : je peux facilement les écarter',
      'o_control_1':
          'Beaucoup de contrôle : je peux généralement les arrêter ou les détourner',
      'o_control_2': 'Un certain contrôle : parfois je peux, parfois non',
      'o_control_3': 'Peu de contrôle : j’arrive rarement à les arrêter',
      'o_control_4':
          'Aucun contrôle : elles semblent complètement involontaires',
      'c_time_0': 'Pas du tout',
      'c_time_1': 'Un peu : moins d’une heure par jour ou quelques fois',
      'c_time_2': 'Modérément : 1 à 3 heures par jour ou rituels fréquents',
      'c_time_3': 'Beaucoup : 3 à 8 heures par jour ou rituels très fréquents',
      'c_time_4': 'Presque constamment : plus de 8 heures par jour',
      'c_interfere_0': 'Pas du tout',
      'c_interfere_1': 'Un peu : elles n’affectent pas vraiment ce que je fais',
      'c_interfere_2':
          'Quelque peu : elles interfèrent, mais je peux encore gérer',
      'c_interfere_3': 'Beaucoup : elles gênent clairement ma journée',
      'c_interfere_4': 'Au point que je peux à peine fonctionner',
      'c_distress_0': 'Pas du tout',
      'c_distress_1': 'Un peu mal à l’aise',
      'c_distress_2': 'Modérément anxieux',
      'c_distress_3': 'Très anxieux',
      'c_distress_4': 'Anxiété accablante et invalidante',
      'c_resist_0':
          'J’essaie toujours de résister, ou elles surviennent à peine',
      'c_resist_1': 'J’essaie de résister la plupart du temps',
      'c_resist_2': 'Je fais quelques efforts pour résister',
      'c_resist_3': 'Je cède à presque toutes sans vraiment lutter',
      'c_resist_4': 'J’y cède complètement et volontairement',
      'c_control_0': 'Contrôle total : je peux facilement m’arrêter',
      'c_control_1':
          'Beaucoup de contrôle : je peux généralement arrêter ou retarder',
      'c_control_2': 'Un certain contrôle : parfois je peux, parfois non',
      'c_control_3': 'Peu de contrôle : je peux rarement arrêter ou retarder',
      'c_control_4': 'Aucun contrôle : je dois les terminer',
      'other': 'Option de réponse',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': 'Agressivité ou préjudice',
      'contamination': 'Contamination',
      'sexual': 'Sexuel',
      'hoarding_obs': 'Accumulation ou conservation',
      'religious': 'Scrupulosité religieuse ou morale',
      'symmetry_obs': 'Symétrie ou exactitude',
      'somatic': 'Corps ou maladie',
      'misc_obs': 'Autres obsessions',
      'washing': 'Lavage ou nettoyage',
      'checking': 'Vérification',
      'repeating': 'Rituels de répétition',
      'counting': 'Comptage',
      'ordering': 'Ordre ou agencement',
      'misc_comp': 'Autres compulsions',
      'other': 'Autre thème',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': 'Peur de me faire du mal',
      'agg_harm_others': 'Peur de faire du mal à quelqu’un',
      'agg_violent': 'Images violentes ou horribles dans mon esprit',
      'agg_blurt': 'Peur de lancer des insultes ou des obscénités',
      'agg_impulse': 'Peur d’agir selon une impulsion non désirée',
      'agg_responsible': 'Peur d’être responsable d’un événement terrible',
      'con_dirt': 'Préoccupation liée à la saleté ou aux microbes',
      'con_bodily': 'Dégoût des déchets ou sécrétions corporels',
      'con_chemicals':
          'Préoccupation liée aux produits chimiques ou nettoyants ménagers',
      'con_ill': 'Peur de tomber malade à cause d’une contamination',
      'con_spread': 'Peur de transmettre une contamination à d’autres',
      'con_sticky': 'Gêne liée aux substances ou résidus collants',
      'sex_forbidden': 'Pensées ou images sexuelles interdites ou non désirées',
      'sex_others':
          'Pensées sexuelles concernant d’autres personnes qui me perturbent',
      'sex_orientation': 'Doutes non désirés sur mon orientation sexuelle',
      'sex_aggressive':
          'Pensées sexuelles agressives envers d’autres personnes',
      'hoard_discard':
          'Peur de jeter quelque chose dont je pourrais avoir besoin',
      'hoard_value':
          'Sentiment que des objets ont une valeur dont je ne peux pas me détacher',
      'rel_sacrilege': 'Préoccupation liée au sacrilège ou au blasphème',
      'rel_rightwrong':
          'Préoccupation excessive liée au bien, au mal ou à la morale',
      'rel_punish': 'Peur d’une punition de Dieu ou du destin',
      'sym_even':
          'Besoin que les choses soient équilibrées ou « juste comme il faut »',
      'sym_exact': 'Besoin d’exactitude, d’ordre ou de précision',
      'sym_incomplete':
          'Sentiment d’inachèvement jusqu’à ce que tout semble juste',
      'som_illness': 'Préoccupation excessive liée à une maladie',
      'som_body':
          'Préoccupation excessive liée à une partie du corps ou à l’apparence',
      'misc_know': 'Besoin de savoir ou de se souvenir de choses',
      'misc_saywrong': 'Peur de dire quelque chose d’inapproprié',
      'misc_lucky': 'Nombres, mots ou couleurs porte-bonheur ou porte-malheur',
      'misc_sounds':
          'Sons, mots ou musique intrusifs que je ne peux pas arrêter',
      'misc_lose': 'Peur de perdre des choses',
      'wash_hands': 'Lavage des mains excessif ou ritualisé',
      'wash_shower': 'Douche, bain ou soins corporels excessifs',
      'wash_clean': 'Nettoyage excessif d’objets domestiques',
      'wash_avoid': 'Éviter des choses que je considère contaminées',
      'chk_locks': 'Vérifier serrures, appareils, robinets ou cuisinière',
      'chk_harm':
          'Vérifier que je n’ai pas fait ou ne ferai pas de mal à quelqu’un',
      'chk_mistake': 'Vérifier que je n’ai pas fait d’erreur',
      'chk_body': 'Vérifier mon corps pour rechercher des signes de maladie',
      'rep_reread': 'Relire ou réécrire',
      'rep_routine':
          'Répéter des gestes habituels, comme franchir des portes ou monter et descendre',
      'rep_untilright':
          'Répéter jusqu’à ce que cela semble « juste comme il faut »',
      'cnt_count': 'Compter des objets, des pas ou des actions',
      'cnt_numbers': 'Faire quelque chose un certain nombre de fois',
      'ord_arrange':
          'Disposer des objets jusqu’à ce qu’ils soient symétriques ou exacts',
      'ord_align': 'Aligner ou redresser des objets à répétition',
      'mc_mental':
          'Rituels mentaux, comme des prières silencieuses, des phrases ou des vérifications',
      'mc_reassure': 'Demander à être rassuré ou se confesser à répétition',
      'mc_touch': 'Besoin de toucher, tapoter ou frotter des objets',
      'mc_lists': 'Faire des listes de manière excessive',
      'mc_avoid': 'Éviter des situations pour prévenir une impulsion',
      'other': 'Autre symptôme',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical':
          'Ce total se situe dans la plage subclinique de la Y-BOCS. Le résultat est un instantané, pas un diagnostic.',
      'mild':
          'Ce total se situe dans la plage légère de la Y-BOCS. Le résultat est un instantané, pas un diagnostic.',
      'moderate':
          'Ce total se situe dans la plage modérée de la Y-BOCS. Le résultat est un instantané, pas un diagnostic.',
      'severe':
          'Ce total se situe dans la plage sévère de la Y-BOCS. Envisagez de discuter de cet impact avec un professionnel qualifié.',
      'extreme':
          'Ce total se situe dans la plage extrême de la Y-BOCS. Envisagez de contacter un professionnel qualifié. En cas de danger immédiat, contactez les services d’urgence locaux.',
      'other': 'Ce total enregistré est un instantané, pas un diagnostic.',
    });
    return '$_temp0';
  }
}
