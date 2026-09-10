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
}
