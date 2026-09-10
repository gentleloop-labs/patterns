// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsDataSection => 'Dados';

  @override
  String get settingsExportDataTitle => 'Exportar dados';

  @override
  String get settingsExportDataSubtitle =>
      'Salve seus registros em um backup JSON local';

  @override
  String get settingsImportDataTitle => 'Importar dados';

  @override
  String get settingsImportDataSubtitle =>
      'Restaure registros de um backup ZIP ou JSON';

  @override
  String get settingsRemindersSection => 'Lembretes';

  @override
  String get settingsDailyReminderTitle => 'Lembrete diário';

  @override
  String settingsDailyReminderAt(String time) {
    return 'Um lembrete gentil às $time';
  }

  @override
  String get settingsDailyReminderOff =>
      'Um lembrete gentil para fazer um check-in diário';

  @override
  String get settingsReminderTimeTitle => 'Horário do lembrete';

  @override
  String get settingsPrivacySection => 'Privacidade';

  @override
  String get settingsPrivacySafetySubtitle =>
      'Como seus dados locais são tratados';

  @override
  String get settingsAnalyticsTitle => 'Compartilhar análise de uso anônima';

  @override
  String get settingsAnalyticsSubtitle =>
      'Compartilhe apenas eventos de uso de recursos. Dados pessoais de OCD nunca são incluídos.';

  @override
  String get settingsAppLockTitle => 'Bloqueio do aplicativo';

  @override
  String get settingsAppLockSubtitle =>
      'Exija o desbloqueio do dispositivo ao reabrir o Patterns';

  @override
  String get settingsWipeTitle => 'Apagar todos os dados';

  @override
  String get settingsWipeSubtitle =>
      'Exclua registros locais e redefina as preferências';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Pro está ativo';

  @override
  String get settingsProActiveSubtitle =>
      'Todas as ferramentas de recuperação estão desbloqueadas. Obrigado.';

  @override
  String get settingsUnlockProTitle => 'Desbloquear Patterns Pro';

  @override
  String get settingsUnlockProSubtitle =>
      'Compra única para todas as ferramentas de recuperação';

  @override
  String get settingsRestorePurchasesTitle => 'Restaurar compras';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Restaure uma compra anterior do Patterns Pro';

  @override
  String get settingsHelpSection => 'Ajuda';

  @override
  String get settingsReplayTourTitle => 'Rever o tour do aplicativo';

  @override
  String get settingsReplayTourSubtitle => 'Veja novamente o que cada aba faz';

  @override
  String get settingsShowWelcomeTitle => 'Mostrar telas de boas-vindas';

  @override
  String get settingsShowWelcomeSubtitle =>
      'Veja a introdução na próxima vez que abrir o Patterns';

  @override
  String get settingsFeedbackSection => 'Feedback';

  @override
  String get settingsRateTitle => 'Avaliar o Patterns';

  @override
  String get settingsRateSubtitle => 'Conte à loja o que você achou';

  @override
  String get settingsSendFeedbackTitle => 'Enviar feedback';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Compartilhe uma ideia ou conte o que deu errado';

  @override
  String get settingsSupportTitle => 'Apoiar o Patterns';

  @override
  String get settingsSupportSubtitle =>
      'Deixe uma contribuição opcional para apoiar o desenvolvimento';

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get appearanceSystem => 'Sistema';

  @override
  String get appearanceLight => 'Claro';

  @override
  String get appearanceDark => 'Escuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSubtitle => 'Escolha o idioma usado pelo Patterns';

  @override
  String get calmInsightsTitle => 'Insights tranquilos';

  @override
  String get calmInsightsSubtitle =>
      'Oculta sequências e pontuações calculadas. Seus dados registrados continuam disponíveis.';

  @override
  String get calmRecentActivityTitle => 'Sua atividade recente';

  @override
  String get calmNoRecentActivity =>
      'Nada foi registrado nos últimos 7 dias. Este espaço estará pronto quando você precisar.';

  @override
  String calmJournalActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros no diário',
      one: '1 registro no diário',
    );
    return '$_temp0';
  }

  @override
  String calmTrackedActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count momentos registrados',
      one: '1 momento registrado',
    );
    return '$_temp0';
  }

  @override
  String calmDelayActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count adiamentos de compulsão',
      one: '1 adiamento de compulsão',
    );
    return '$_temp0';
  }

  @override
  String calmErpActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas de ERP',
      one: '1 prática de ERP',
    );
    return '$_temp0';
  }

  @override
  String calmExposureActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count exposições concluídas',
      one: '1 exposição concluída',
    );
    return '$_temp0';
  }

  @override
  String get recoveryMetricsTitle => 'Atividade de recuperação';

  @override
  String get recoveryMetricsTeaserTitle =>
      'Veja sua atividade de recuperação reunida';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'Veja exposições, sessões de prática e mudanças registradas no impulso em suas ferramentas de ERP. Desbloqueie com o Patterns Pro.';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'Veja sequências de prática, exposições concluídas e mudanças registradas no impulso em suas ferramentas de ERP. Desbloqueie com o Patterns Pro.';

  @override
  String get recoveryMetricsUnlockPro => 'Desbloquear Patterns Pro';

  @override
  String get recoveryMetricsEmptyTitle =>
      'Sua atividade de recuperação aparecerá aqui';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      'Pratique um adiamento, uma sessão de ERP ou uma etapa de exposição para ver aqui contagens objetivas de atividade.';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      'Pratique um adiamento, uma sessão de ERP ou uma etapa de exposição para começar seu histórico e sua sequência de prática.';

  @override
  String get recoveryMetricsExposuresDone => 'Exposições concluídas';

  @override
  String get recoveryMetricsSessionsPracticed => 'Sessões praticadas';

  @override
  String get recoveryMetricsAverageUrgeDrop =>
      'Mudança média registrada no impulso';

  @override
  String get recoveryMetricsThisWeek => 'Esta semana';

  @override
  String recoveryMetricsDayStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Sequência de $days dias',
      one: 'Sequência de 1 dia',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get doneAction => 'Concluir';

  @override
  String get doneForNowAction => 'Concluir por enquanto';

  @override
  String get completionSavedTitle => 'Salvo';

  @override
  String get completionPracticeTitle => 'Prática registrada';

  @override
  String get completionJournalBody =>
      'Seu registro do diário foi salvo neste dispositivo.';

  @override
  String get completionTrackedBody =>
      'O momento registrado foi salvo neste dispositivo.';

  @override
  String get completionTrackedUpdatedBody =>
      'O momento registrado foi atualizado.';

  @override
  String get completionDelayBody =>
      'Sua prática de adiamento de compulsão foi registrada.';

  @override
  String get completionErpBody => 'Sua prática de ERP foi registrada.';

  @override
  String get notificationOpenAction => 'Abrir notificação';

  @override
  String get dailyReminderChannelName => 'Lembrete diário';

  @override
  String get dailyReminderChannelDescription =>
      'Um lembrete diário gentil para você se conectar com o Patterns.';

  @override
  String get dailyReminderTitle => 'Um momento de pausa';

  @override
  String get dailyReminderBody =>
      'Reserve um momento tranquilo com o Patterns quando estiver pronto.';

  @override
  String get practiceTimerChannelName => 'Temporizador de prática';

  @override
  String get practiceTimerChannelDescription =>
      'Um aviso gentil quando o tempo da prática terminar.';

  @override
  String get appUpdatesChannelName => 'Atualizações do app';

  @override
  String get appUpdatesChannelDescription =>
      'Avisos ocasionais quando o Patterns recebe novas ferramentas relevantes de recuperação.';

  @override
  String get updateAnnouncementTitle => 'O Patterns melhorou';

  @override
  String get updateAnnouncementBody =>
      'Novas ferramentas de recuperação, insights de progresso e uma tela inicial mais tranquila estão disponíveis.';

  @override
  String get practiceWindowCompleteTitle => 'Tempo de prática concluído';

  @override
  String get practiceWindowCompleteBody =>
      'Reserve um momento para observar o que aconteceu.';

  @override
  String get erpWindowCompleteTitle => 'Tempo de prática de ERP concluído';

  @override
  String get erpWindowCompleteBody =>
      'Reserve um momento para refletir sobre o que aconteceu.';

  @override
  String get navToday => 'Hoje';

  @override
  String get navHome => 'Início';

  @override
  String get navJournal => 'Diário';

  @override
  String get navTrack => 'Registrar';

  @override
  String get navTracker => 'Registros';

  @override
  String get navRecovery => 'Recuperação';

  @override
  String get navInsights => 'Análises';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get exportReportTitle => 'Exportar relatório';

  @override
  String get exportReportDescription =>
      'Salve um PDF combinado do seu diário, registro de OCD e análises. Você escolhe onde salvar e se deseja compartilhar.';

  @override
  String get exportTimeWindow => 'Período';

  @override
  String get exportStart => 'Início';

  @override
  String get exportEnd => 'Fim';

  @override
  String get exportIncludeSections => 'Incluir seções';

  @override
  String get exportAnalyticsSummary => 'Resumo das análises';

  @override
  String get exportJournalEntries => 'Registros do diário';

  @override
  String get exportOcdEvents => 'Eventos de OCD';

  @override
  String get exportYbocsSelfChecks => 'Autoavaliações Y-BOCS';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total registros',
      one: '1 registro',
      zero: 'Nenhum registro',
    );
    return '$_temp0 neste período ($journal diário, $ocd OCD, $selfChecks autoavaliações)';
  }

  @override
  String get exportLargeReport =>
      'Este relatório é grande e pode levar um momento para ser gerado.';

  @override
  String get exportPrivacyWarning =>
      'Isso cria um PDF sem criptografia. Salve-o em um local privado.';

  @override
  String get exportSavePdf => 'Salvar PDF';

  @override
  String get exportSelectSectionError =>
      'Selecione pelo menos uma seção para exportar.';

  @override
  String get exportNoEntriesError =>
      'Nenhum registro corresponde a este período e seleção.';

  @override
  String get exportReportSaved => 'Relatório salvo';

  @override
  String get exportReportFailed => 'Não foi possível criar o relatório';

  @override
  String get rangeSevenDays => '7 d';

  @override
  String get rangeThirtyDays => '30 d';

  @override
  String get rangeNinetyDays => '90 d';

  @override
  String get rangeYear => 'Ano';

  @override
  String get rangeAll => 'Tudo';

  @override
  String get rangeCustom => 'Personalizado';

  @override
  String get rangeLastSevenDays => 'Últimos 7 dias';

  @override
  String get rangeLastThirtyDays => 'Últimos 30 dias';

  @override
  String get rangeLastNinetyDays => 'Últimos 90 dias';

  @override
  String get rangeLastYear => 'Último ano';

  @override
  String get rangeAllTime => 'Todo o período';

  @override
  String get pdfPersonalReport => 'Relatório pessoal';

  @override
  String pdfGenerated(String date) {
    return 'Gerado em $date';
  }

  @override
  String get pdfDisclaimer =>
      'Este relatório contém anotações pessoais criadas no Patterns para autorreflexão. Não é orientação médica e não substitui o cuidado de um profissional qualificado.';

  @override
  String get pdfJournalCount => 'Registros do diário';

  @override
  String get pdfOcdCount => 'Eventos de OCD';

  @override
  String get pdfAverageDistress => 'Desconforto médio';

  @override
  String get pdfObsessions => 'Obsessões';

  @override
  String get pdfCompulsions => 'Compulsões';

  @override
  String get pdfNoJournalEntries => 'Nenhum registro do diário neste período.';

  @override
  String get pdfNoOcdEvents => 'Nenhum evento de OCD neste período.';

  @override
  String get pdfObsession => 'Obsessão';

  @override
  String get pdfCompulsion => 'Compulsão';

  @override
  String pdfDistressScore(int score) {
    return 'Desconforto $score/10';
  }

  @override
  String get pdfThought => 'Pensamento';

  @override
  String get pdfUrge => 'Impulso';

  @override
  String pdfResponse(String text) {
    return 'Resposta: $text';
  }

  @override
  String pdfActionTaken(String text) {
    return 'Ação realizada: $text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scale, autoavaliada no app. O total é de 40, com 20 para obsessões e 20 para compulsões.';

  @override
  String get pdfMostRecentTotal => 'Total mais recente';

  @override
  String get pdfTakenOn => 'Realizada em';

  @override
  String get pdfObsessionsSubtotal => 'Subtotal de obsessões';

  @override
  String get pdfCompulsionsSubtotal => 'Subtotal de compulsões';

  @override
  String get pdfChangeAcrossRange => 'Mudança no período';

  @override
  String get pdfSelfChecksInRange => 'Autoavaliações no período';

  @override
  String get pdfThemesFlagged => 'Temas marcados';

  @override
  String get pdfSingleSelfCheck => 'Uma autoavaliação neste período';

  @override
  String pdfChangeSince(String change, String date) {
    return '$change desde $date';
  }

  @override
  String get pdfDate => 'Data';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfBand => 'Faixa';

  @override
  String get severitySubclinical => 'Subclínico';

  @override
  String get severityMild => 'Leve';

  @override
  String get severityModerate => 'Moderado';

  @override
  String get severitySevere => 'Grave';

  @override
  String get severityExtreme => 'Extremo';

  @override
  String get backAction => 'Voltar';

  @override
  String get onboardingSafetyFootnote =>
      'Privacidade desde a concepção. Não é diagnóstico nem substitui o cuidado profissional.';

  @override
  String get onboardingHeadline =>
      'Um lugar tranquilo para praticar com o OCD.';

  @override
  String get onboardingIntroduction =>
      'Registre o pensamento intrusivo, adie a compulsão e pratique uma resposta diferente, um pequeno passo de cada vez.';

  @override
  String get onboardingPrivacy =>
      'Seus dados de OCD ficam neste dispositivo. Sem conta. Sem sincronização na nuvem.';

  @override
  String get getStartedAction => 'Começar';

  @override
  String get importExistingDataAction => 'Importar dados existentes';

  @override
  String get onboardingQuestion => 'O que ajudaria você agora?';

  @override
  String get onboardingPickOne =>
      'Escolha uma opção. Você poderá fazer o restante quando quiser.';

  @override
  String get onboardingUrgeTitle => 'Estou enfrentando um impulso agora';

  @override
  String get onboardingUrgeSubtitle =>
      'Crie algum tempo entre o impulso e o ritual.';

  @override
  String get onboardingJournalTitle => 'Quero escrever algo';

  @override
  String get onboardingJournalSubtitle =>
      'Tire o pensamento da cabeça e coloque-o na página.';

  @override
  String get onboardingErpTitle =>
      'Quero praticar deixar uma compulsão sem fazer';

  @override
  String get onboardingErpSubtitle => 'Uma exposição curta e guiada.';

  @override
  String get onboardingSelfCheckTitle => 'Quero ver como está meu OCD agora';

  @override
  String get onboardingSelfCheckSubtitle =>
      'A autoavaliação Y-BOCS. Cerca de 10 minutos.';

  @override
  String get onboardingExploreTitle => 'Estou apenas explorando';

  @override
  String get onboardingExploreSubtitle => 'Primeiro, dê uma olhada.';

  @override
  String get whatsNewTitle => 'Pratique sem pressão';

  @override
  String get whatsNewBody =>
      'O Patterns 1.10 traz Insights tranquilos, finais de sessão mais discretos, melhorias de acessibilidade e seleção opcional de idioma.';

  @override
  String get whatsNewLanguagesTitle => 'Insights tranquilos';

  @override
  String get whatsNewLanguagesBody =>
      'Escolha resumos factuais de atividade em vez de pontuações, sequências e percentuais de consistência calculados.';

  @override
  String get whatsNewPrivateTitle => 'Um final claro';

  @override
  String get whatsNewPrivateBody =>
      'Diário, registro, adiamento de compulsão e sessões de ERP agora terminam com uma confirmação factual e Concluir por enquanto.';

  @override
  String get whatsNewReportsTitle => 'Mais acessível, no seu idioma';

  @override
  String get whatsNewReportsBody =>
      'Rótulos aprimorados e menos movimento se unem ao inglês, português do Brasil, alemão, japonês, espanhol e francês.';

  @override
  String get whatsNewExploreAction => 'Explorar o Patterns 1.10';

  @override
  String get continueToPatternsAction => 'Continuar para o Patterns';

  @override
  String get whatsNewNotificationNote =>
      'Seus registros permanecem como foram escritos. Idioma e Insights tranquilos ficam neste dispositivo e não são incluídos em análises nem backups.';

  @override
  String get formatBold => 'Negrito';

  @override
  String get formatItalic => 'Itálico';

  @override
  String get formatBulletedList => 'Lista com marcadores';

  @override
  String get formatToggleHint =>
      'Toque duas vezes para ativar ou desativar esta formatação.';

  @override
  String get journalEditorLabel => 'Editor do diário';

  @override
  String get journalEditorHint =>
      'Digite o texto do diário. Os controles de formatação vêm depois do editor.';

  @override
  String timerRemaining(String time) {
    return 'Tempo restante: $time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return 'Pontuação de recuperação: $score de 100.';
  }

  @override
  String get privacySafetyTitle => 'Privacidade e segurança';

  @override
  String get privacyLocalContent =>
      'Registros do diário, eventos de OCD, níveis de desconforto, reflexões e preferências ficam armazenados localmente neste dispositivo.';

  @override
  String get privacyPurchases =>
      'O Patterns Pro e as gorjetas são processados pela loja de aplicativos. O Patterns não recebe os dados do seu cartão.';

  @override
  String get privacyExports =>
      'Uma exportação manual cria um backup JSON ou relatório PDF sem criptografia apenas onde você escolher salvar ou compartilhar.';

  @override
  String get privacyAnalytics =>
      'A análise anônima de uso fica desativada até você habilitá-la. Se habilitada, o Patterns envia eventos nomeados de uso, um ID aleatório de instalação, plataforma, versão e horário ao serviço próprio. Registros, dados de OCD, resumos gerados, localidade e idioma nunca são incluídos. Desativar apaga eventos pendentes e o ID local.';

  @override
  String get privacyClinicalBoundary =>
      'O Patterns é uma ferramenta de autoajuda para reflexão pessoal e prática de ERP. Não diagnostica nem trata OCD, não substitui o cuidado de um profissional qualificado e não oferece suporte de emergência.';

  @override
  String get viewPrivacyPolicyAction => 'Ver a Política de Privacidade';

  @override
  String get closeAction => 'Fechar';

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools =>
      'Também inclui todas as ferramentas Pro de planejamento, prática, métricas e reflexão.';

  @override
  String get proPaywallAlreadyPurchased =>
      'Já comprou o Pro? Você não será cobrado novamente.';

  @override
  String get proPaywallTryAgainAction => 'Tentar novamente';

  @override
  String get proPaywallRestorePurchasesAction => 'Restaurar compras';

  @override
  String get proPaywallRestoreShortAction => 'Restaurar';

  @override
  String get proPaywallUnlockAction => 'Desbloquear Pro';

  @override
  String proPaywallUnlockWithPrice(String price) {
    return 'Desbloquear Pro · $price';
  }

  @override
  String get proPaywallPurchasesUnavailable =>
      'As compras no app não estão disponíveis neste dispositivo.';

  @override
  String get proPaywallProductUnavailable =>
      'O Patterns Pro não está disponível agora. Tente novamente mais tarde.';

  @override
  String get proPaywallProductLoadFailed =>
      'Não foi possível carregar o Patterns Pro. Tente novamente mais tarde.';

  @override
  String get proPaywallPurchaseStartFailed =>
      'Não foi possível iniciar a compra.';

  @override
  String get proPaywallPurchaseFailed =>
      'Não foi possível concluir a compra. Tente novamente.';

  @override
  String get proPaywallRestoreNotFound =>
      'Nenhuma compra anterior foi encontrada nesta conta. Se você comprou o Pro com outra conta, entre nela e tente novamente.';

  @override
  String get proPaywallRestoreFailed =>
      'Não foi possível restaurar as compras. Tente novamente.';

  @override
  String get proPaywallWelcomeBack => 'Boas-vindas de volta';

  @override
  String get proPaywallAllSet => 'Tudo pronto';

  @override
  String get proPaywallRestoredBody =>
      'O Patterns Pro foi restaurado neste dispositivo.';

  @override
  String get proPaywallUnlockedBody =>
      'O Patterns Pro está desbloqueado. Todas as ferramentas de recuperação estão disponíveis.';

  @override
  String get proPaywallContinueAction => 'Continuar';

  @override
  String get proPaywallLoadingLabel => 'Carregando o Patterns Pro';

  @override
  String get proHeadlineSettings =>
      'Ir além dos registros e praticar a recuperação';

  @override
  String get proHeadlineTodayNextStep => 'Continuar a prática de hoje';

  @override
  String get proHeadlineRecoveryMetrics =>
      'Revisar sua atividade de recuperação';

  @override
  String get proHeadlineExposureHierarchy =>
      'Criar uma hierarquia de exposição clara';

  @override
  String get proHeadlineExposureMaterials =>
      'Manter os materiais de prática juntos';

  @override
  String get proHeadlineStructuredPrograms =>
      'Transformar a recuperação em uma rotina';

  @override
  String get proHeadlineActionPlanner =>
      'Planejar sua resposta antes que o TOC apareça';

  @override
  String get proHeadlineImplementationIntentions =>
      'Facilitar sua próxima escolha';

  @override
  String get proHeadlineUrgeSurfing => 'Praticar como deixar o impulso passar';

  @override
  String get proHeadlineResponsePrevention => 'Registrar a resposta escolhida';

  @override
  String get proHeadlineUncertaintyTraining =>
      'Praticar como abrir espaço para o talvez';

  @override
  String get proHeadlineBehavioralExperiments => 'Testar as previsões do TOC';

  @override
  String get proHeadlineReflectionJournal =>
      'Registrar o que cada prática ensinou';

  @override
  String get proBenefitGeneralPlans =>
      'Criar hierarquias de exposição e planos de prática';

  @override
  String get proBenefitGeneralResponsePrevention =>
      'Usar ferramentas específicas de prevenção de resposta';

  @override
  String get proBenefitGeneralReview =>
      'Revisar a atividade de recuperação e as reflexões';

  @override
  String get proBenefitMetricsActivity =>
      'Revisar a atividade de prática ao longo do tempo';

  @override
  String get proBenefitMetricsNonjudgmental =>
      'Ver a atividade registrada sem julgar dias específicos';

  @override
  String get proBenefitMetricsPatterns =>
      'Explorar padrões objetivos de recuperação';

  @override
  String get proBenefitExposureLadder =>
      'Organizar as etapas das mais leves às mais difíceis';

  @override
  String get proBenefitExposureMaterials =>
      'Manter roteiros, áudios em loop, imagens e links por perto';

  @override
  String get proBenefitExposureRepeatable =>
      'Transformar um plano em prática repetível';

  @override
  String get proBenefitProgramsStructure =>
      'Seguir uma estrutura semanal tranquila';

  @override
  String get proBenefitProgramsTasks =>
      'Manter as tarefas de prática em um só lugar';

  @override
  String get proBenefitProgramsReview => 'Revisar o que ajudou ao continuar';

  @override
  String get proBenefitPlanningAhead =>
      'Escolher uma resposta antes do momento difícil';

  @override
  String get proBenefitPlanningIfThen => 'Criar planos práticos de se-então';

  @override
  String get proBenefitPlanningReturn =>
      'Voltar ao plano quando a incerteza aumentar';

  @override
  String get proBenefitInMomentTools =>
      'Usar ferramentas de prática focadas no momento';

  @override
  String get proBenefitInMomentPrivacy =>
      'Registrar escolhas sem escrever detalhes sensíveis';

  @override
  String get proBenefitInMomentRepetition =>
      'Desenvolver tolerância com práticas repetíveis';

  @override
  String get proBenefitReflectionCompare =>
      'Comparar as previsões com o que aconteceu';

  @override
  String get proBenefitReflectionCapture =>
      'Registrar aprendizados depois da prática';

  @override
  String get proBenefitReflectionPatterns =>
      'Perceber padrões úteis ao longo do tempo';

  @override
  String get proRestoreChecking => 'Verificando suas compras…';

  @override
  String get proRestoreSucceeded =>
      'O Patterns Pro foi restaurado. Todas as ferramentas de recuperação estão desbloqueadas novamente.';

  @override
  String get tipJarTitle => 'Apoiar o Patterns';

  @override
  String get tipJarBody =>
      'O Patterns é independente e não tem anúncios. Se ele ajudou você, uma pequena gorjeta significa muito. As gorjetas são opcionais e não desbloqueiam nada.';

  @override
  String get tipJarLoadingLabel => 'Carregando opções de gorjeta';

  @override
  String get tipJarPurchasesUnavailable =>
      'As compras no app não estão disponíveis neste dispositivo.';

  @override
  String get tipJarOptionsUnavailable =>
      'Nenhuma opção de gorjeta foi encontrada. Tente novamente mais tarde.';

  @override
  String get tipJarLoadFailed =>
      'Não foi possível carregar as opções de gorjeta. Tente novamente mais tarde.';

  @override
  String get tipJarPurchaseFailed =>
      'Não foi possível concluir a gorjeta. Tente novamente.';

  @override
  String get tipJarTryAgainAction => 'Tentar novamente';

  @override
  String get tipSmallTitle => 'Gorjeta pequena';

  @override
  String get tipSmallDescription =>
      'Uma gorjeta pequena e opcional para apoiar o desenvolvimento do Patterns. Não libera recursos.';

  @override
  String get tipMediumTitle => 'Gorjeta média';

  @override
  String get tipMediumDescription =>
      'Uma gorjeta média e opcional para apoiar o desenvolvimento do Patterns. Não libera recursos.';

  @override
  String get tipLargeTitle => 'Gorjeta grande';

  @override
  String get tipLargeDescription =>
      'Uma gorjeta grande e opcional para apoiar o desenvolvimento do Patterns. Não libera recursos.';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title, $price. $description';
  }

  @override
  String get tipChoiceHint => 'Envia esta gorjeta opcional';

  @override
  String get tipThanksTitle => 'Obrigado';

  @override
  String get tipThanksBody =>
      'Seu apoio significa muito. Graças a pessoas como você, o Patterns continua independente e sem anúncios.';

  @override
  String get tipThanksAction => 'Foi um prazer';

  @override
  String get desktopProTitle => 'Desbloquear o Patterns Desktop Pro';

  @override
  String get desktopProSubtitle =>
      'Uma licença de compra única para ferramentas de recuperação offline otimizadas para computador.';

  @override
  String get desktopFeatureHierarchyTitle => 'Criador de hierarquias';

  @override
  String get desktopFeatureHierarchyDescription =>
      'Criar e registrar etapas e hierarquias de exposição.';

  @override
  String get desktopFeatureErpTitle => 'Registros de exercícios ERP';

  @override
  String get desktopFeatureErpDescription =>
      'Registrar prevenção de resposta e exercícios cronometrados.';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription =>
      'Registrar mudanças no impulso com um cronômetro ao vivo.';

  @override
  String get desktopFeatureActivityTitle => 'Atividade de recuperação';

  @override
  String get desktopFeatureActivityDescription =>
      'Revisar atividades objetivas e padrões semanais.';

  @override
  String get desktopOneTimeLicense => 'Licença de compra única';

  @override
  String desktopOneTimePrice(String price) {
    return '$price, compra única';
  }

  @override
  String get desktopPurchaseLicenseAction => 'Comprar licença';

  @override
  String get desktopCheckoutUnavailable =>
      'A página de compra não está disponível nesta versão.';

  @override
  String get desktopAlreadyPurchased =>
      'Já comprou? Digite sua chave de licença';

  @override
  String get desktopLicensePrompt =>
      'Digite sua chave de licença do Lemon Squeezy:';

  @override
  String get desktopLicenseLabel => 'Chave de licença';

  @override
  String get desktopLicenseHint => 'Cole a chave de licença do seu recibo';

  @override
  String get desktopLicenseActivating => 'Ativando a licença…';

  @override
  String get desktopActivateLicenseAction => 'Ativar licença';

  @override
  String get desktopLicenseBackAction => 'Voltar';

  @override
  String get desktopLicenseInvalid =>
      'Digite a chave de licença completa que está no seu recibo.';

  @override
  String get desktopLicenseRejected =>
      'Não foi possível verificar esta licença para o Patterns Desktop Pro. Confira a chave e tente novamente.';

  @override
  String get desktopLicenseUnavailable =>
      'Não foi possível acessar o serviço de licenças. Confira sua conexão e tente novamente.';

  @override
  String get desktopLicenseNotConfigured =>
      'A ativação da licença não está disponível nesta versão.';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsDataSection => 'Dados';

  @override
  String get settingsExportDataTitle => 'Exportar dados';

  @override
  String get settingsExportDataSubtitle =>
      'Salve seus registros em um backup JSON local';

  @override
  String get settingsImportDataTitle => 'Importar dados';

  @override
  String get settingsImportDataSubtitle =>
      'Restaure registros de um backup ZIP ou JSON';

  @override
  String get settingsRemindersSection => 'Lembretes';

  @override
  String get settingsDailyReminderTitle => 'Lembrete diário';

  @override
  String settingsDailyReminderAt(String time) {
    return 'Um lembrete gentil às $time';
  }

  @override
  String get settingsDailyReminderOff =>
      'Um lembrete gentil para fazer um check-in diário';

  @override
  String get settingsReminderTimeTitle => 'Horário do lembrete';

  @override
  String get settingsPrivacySection => 'Privacidade';

  @override
  String get settingsPrivacySafetySubtitle =>
      'Como seus dados locais são tratados';

  @override
  String get settingsAnalyticsTitle => 'Compartilhar análise de uso anônima';

  @override
  String get settingsAnalyticsSubtitle =>
      'Compartilhe apenas eventos de uso de recursos. Dados pessoais de OCD nunca são incluídos.';

  @override
  String get settingsAppLockTitle => 'Bloqueio do aplicativo';

  @override
  String get settingsAppLockSubtitle =>
      'Exija o desbloqueio do dispositivo ao reabrir o Patterns';

  @override
  String get settingsWipeTitle => 'Apagar todos os dados';

  @override
  String get settingsWipeSubtitle =>
      'Exclua registros locais e redefina as preferências';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Pro está ativo';

  @override
  String get settingsProActiveSubtitle =>
      'Todas as ferramentas de recuperação estão desbloqueadas. Obrigado.';

  @override
  String get settingsUnlockProTitle => 'Desbloquear Patterns Pro';

  @override
  String get settingsUnlockProSubtitle =>
      'Compra única para todas as ferramentas de recuperação';

  @override
  String get settingsRestorePurchasesTitle => 'Restaurar compras';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Restaure uma compra anterior do Patterns Pro';

  @override
  String get settingsHelpSection => 'Ajuda';

  @override
  String get settingsReplayTourTitle => 'Rever o tour do aplicativo';

  @override
  String get settingsReplayTourSubtitle => 'Veja novamente o que cada aba faz';

  @override
  String get settingsShowWelcomeTitle => 'Mostrar telas de boas-vindas';

  @override
  String get settingsShowWelcomeSubtitle =>
      'Veja a introdução na próxima vez que abrir o Patterns';

  @override
  String get settingsFeedbackSection => 'Feedback';

  @override
  String get settingsRateTitle => 'Avaliar o Patterns';

  @override
  String get settingsRateSubtitle => 'Conte à loja o que você achou';

  @override
  String get settingsSendFeedbackTitle => 'Enviar feedback';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Compartilhe uma ideia ou conte o que deu errado';

  @override
  String get settingsSupportTitle => 'Apoiar o Patterns';

  @override
  String get settingsSupportSubtitle =>
      'Deixe uma contribuição opcional para apoiar o desenvolvimento';

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get appearanceSystem => 'Sistema';

  @override
  String get appearanceLight => 'Claro';

  @override
  String get appearanceDark => 'Escuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSubtitle => 'Escolha o idioma usado pelo Patterns';

  @override
  String get calmInsightsTitle => 'Insights tranquilos';

  @override
  String get calmInsightsSubtitle =>
      'Oculta sequências e pontuações calculadas. Seus dados registrados continuam disponíveis.';

  @override
  String get calmRecentActivityTitle => 'Sua atividade recente';

  @override
  String get calmNoRecentActivity =>
      'Nada foi registrado nos últimos 7 dias. Este espaço estará pronto quando você precisar.';

  @override
  String calmJournalActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros no diário',
      one: '1 registro no diário',
    );
    return '$_temp0';
  }

  @override
  String calmTrackedActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count momentos registrados',
      one: '1 momento registrado',
    );
    return '$_temp0';
  }

  @override
  String calmDelayActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count adiamentos de compulsão',
      one: '1 adiamento de compulsão',
    );
    return '$_temp0';
  }

  @override
  String calmErpActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas de ERP',
      one: '1 prática de ERP',
    );
    return '$_temp0';
  }

  @override
  String calmExposureActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count exposições concluídas',
      one: '1 exposição concluída',
    );
    return '$_temp0';
  }

  @override
  String get recoveryMetricsTitle => 'Atividade de recuperação';

  @override
  String get recoveryMetricsTeaserTitle =>
      'Veja sua atividade de recuperação reunida';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'Veja exposições, sessões de prática e mudanças registradas no impulso em suas ferramentas de ERP. Desbloqueie com o Patterns Pro.';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'Veja sequências de prática, exposições concluídas e mudanças registradas no impulso em suas ferramentas de ERP. Desbloqueie com o Patterns Pro.';

  @override
  String get recoveryMetricsUnlockPro => 'Desbloquear Patterns Pro';

  @override
  String get recoveryMetricsEmptyTitle =>
      'Sua atividade de recuperação aparecerá aqui';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      'Pratique um adiamento, uma sessão de ERP ou uma etapa de exposição para ver aqui contagens objetivas de atividade.';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      'Pratique um adiamento, uma sessão de ERP ou uma etapa de exposição para começar seu histórico e sua sequência de prática.';

  @override
  String get recoveryMetricsExposuresDone => 'Exposições concluídas';

  @override
  String get recoveryMetricsSessionsPracticed => 'Sessões praticadas';

  @override
  String get recoveryMetricsAverageUrgeDrop =>
      'Mudança média registrada no impulso';

  @override
  String get recoveryMetricsThisWeek => 'Esta semana';

  @override
  String recoveryMetricsDayStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Sequência de $days dias',
      one: 'Sequência de 1 dia',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get doneAction => 'Concluir';

  @override
  String get doneForNowAction => 'Concluir por enquanto';

  @override
  String get completionSavedTitle => 'Salvo';

  @override
  String get completionPracticeTitle => 'Prática registrada';

  @override
  String get completionJournalBody =>
      'Seu registro do diário foi salvo neste dispositivo.';

  @override
  String get completionTrackedBody =>
      'O momento registrado foi salvo neste dispositivo.';

  @override
  String get completionTrackedUpdatedBody =>
      'O momento registrado foi atualizado.';

  @override
  String get completionDelayBody =>
      'Sua prática de adiamento de compulsão foi registrada.';

  @override
  String get completionErpBody => 'Sua prática de ERP foi registrada.';

  @override
  String get notificationOpenAction => 'Abrir notificação';

  @override
  String get dailyReminderChannelName => 'Lembrete diário';

  @override
  String get dailyReminderChannelDescription =>
      'Um lembrete diário gentil para você se conectar com o Patterns.';

  @override
  String get dailyReminderTitle => 'Um momento de pausa';

  @override
  String get dailyReminderBody =>
      'Reserve um momento tranquilo com o Patterns quando estiver pronto.';

  @override
  String get practiceTimerChannelName => 'Temporizador de prática';

  @override
  String get practiceTimerChannelDescription =>
      'Um aviso gentil quando o tempo da prática terminar.';

  @override
  String get appUpdatesChannelName => 'Atualizações do app';

  @override
  String get appUpdatesChannelDescription =>
      'Avisos ocasionais quando o Patterns recebe novas ferramentas relevantes de recuperação.';

  @override
  String get updateAnnouncementTitle => 'O Patterns melhorou';

  @override
  String get updateAnnouncementBody =>
      'Novas ferramentas de recuperação, insights de progresso e uma tela inicial mais tranquila estão disponíveis.';

  @override
  String get practiceWindowCompleteTitle => 'Tempo de prática concluído';

  @override
  String get practiceWindowCompleteBody =>
      'Reserve um momento para observar o que aconteceu.';

  @override
  String get erpWindowCompleteTitle => 'Tempo de prática de ERP concluído';

  @override
  String get erpWindowCompleteBody =>
      'Reserve um momento para refletir sobre o que aconteceu.';

  @override
  String get navToday => 'Hoje';

  @override
  String get navHome => 'Início';

  @override
  String get navJournal => 'Diário';

  @override
  String get navTrack => 'Registrar';

  @override
  String get navTracker => 'Registros';

  @override
  String get navRecovery => 'Recuperação';

  @override
  String get navInsights => 'Análises';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get exportReportTitle => 'Exportar relatório';

  @override
  String get exportReportDescription =>
      'Salve um PDF combinado do seu diário, registro de OCD e análises. Você escolhe onde salvar e se deseja compartilhar.';

  @override
  String get exportTimeWindow => 'Período';

  @override
  String get exportStart => 'Início';

  @override
  String get exportEnd => 'Fim';

  @override
  String get exportIncludeSections => 'Incluir seções';

  @override
  String get exportAnalyticsSummary => 'Resumo das análises';

  @override
  String get exportJournalEntries => 'Registros do diário';

  @override
  String get exportOcdEvents => 'Eventos de OCD';

  @override
  String get exportYbocsSelfChecks => 'Autoavaliações Y-BOCS';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total registros',
      one: '1 registro',
      zero: 'Nenhum registro',
    );
    return '$_temp0 neste período ($journal diário, $ocd OCD, $selfChecks autoavaliações)';
  }

  @override
  String get exportLargeReport =>
      'Este relatório é grande e pode levar um momento para ser gerado.';

  @override
  String get exportPrivacyWarning =>
      'Isso cria um PDF sem criptografia. Salve-o em um local privado.';

  @override
  String get exportSavePdf => 'Salvar PDF';

  @override
  String get exportSelectSectionError =>
      'Selecione pelo menos uma seção para exportar.';

  @override
  String get exportNoEntriesError =>
      'Nenhum registro corresponde a este período e seleção.';

  @override
  String get exportReportSaved => 'Relatório salvo';

  @override
  String get exportReportFailed => 'Não foi possível criar o relatório';

  @override
  String get rangeSevenDays => '7 d';

  @override
  String get rangeThirtyDays => '30 d';

  @override
  String get rangeNinetyDays => '90 d';

  @override
  String get rangeYear => 'Ano';

  @override
  String get rangeAll => 'Tudo';

  @override
  String get rangeCustom => 'Personalizado';

  @override
  String get rangeLastSevenDays => 'Últimos 7 dias';

  @override
  String get rangeLastThirtyDays => 'Últimos 30 dias';

  @override
  String get rangeLastNinetyDays => 'Últimos 90 dias';

  @override
  String get rangeLastYear => 'Último ano';

  @override
  String get rangeAllTime => 'Todo o período';

  @override
  String get pdfPersonalReport => 'Relatório pessoal';

  @override
  String pdfGenerated(String date) {
    return 'Gerado em $date';
  }

  @override
  String get pdfDisclaimer =>
      'Este relatório contém anotações pessoais criadas no Patterns para autorreflexão. Não é orientação médica e não substitui o cuidado de um profissional qualificado.';

  @override
  String get pdfJournalCount => 'Registros do diário';

  @override
  String get pdfOcdCount => 'Eventos de OCD';

  @override
  String get pdfAverageDistress => 'Desconforto médio';

  @override
  String get pdfObsessions => 'Obsessões';

  @override
  String get pdfCompulsions => 'Compulsões';

  @override
  String get pdfNoJournalEntries => 'Nenhum registro do diário neste período.';

  @override
  String get pdfNoOcdEvents => 'Nenhum evento de OCD neste período.';

  @override
  String get pdfObsession => 'Obsessão';

  @override
  String get pdfCompulsion => 'Compulsão';

  @override
  String pdfDistressScore(int score) {
    return 'Desconforto $score/10';
  }

  @override
  String get pdfThought => 'Pensamento';

  @override
  String get pdfUrge => 'Impulso';

  @override
  String pdfResponse(String text) {
    return 'Resposta: $text';
  }

  @override
  String pdfActionTaken(String text) {
    return 'Ação realizada: $text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scale, autoavaliada no app. O total é de 40, com 20 para obsessões e 20 para compulsões.';

  @override
  String get pdfMostRecentTotal => 'Total mais recente';

  @override
  String get pdfTakenOn => 'Realizada em';

  @override
  String get pdfObsessionsSubtotal => 'Subtotal de obsessões';

  @override
  String get pdfCompulsionsSubtotal => 'Subtotal de compulsões';

  @override
  String get pdfChangeAcrossRange => 'Mudança no período';

  @override
  String get pdfSelfChecksInRange => 'Autoavaliações no período';

  @override
  String get pdfThemesFlagged => 'Temas marcados';

  @override
  String get pdfSingleSelfCheck => 'Uma autoavaliação neste período';

  @override
  String pdfChangeSince(String change, String date) {
    return '$change desde $date';
  }

  @override
  String get pdfDate => 'Data';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfBand => 'Faixa';

  @override
  String get severitySubclinical => 'Subclínico';

  @override
  String get severityMild => 'Leve';

  @override
  String get severityModerate => 'Moderado';

  @override
  String get severitySevere => 'Grave';

  @override
  String get severityExtreme => 'Extremo';

  @override
  String get backAction => 'Voltar';

  @override
  String get onboardingSafetyFootnote =>
      'Privacidade desde a concepção. Não é diagnóstico nem substitui o cuidado profissional.';

  @override
  String get onboardingHeadline =>
      'Um lugar tranquilo para praticar com o OCD.';

  @override
  String get onboardingIntroduction =>
      'Registre o pensamento intrusivo, adie a compulsão e pratique uma resposta diferente, um pequeno passo de cada vez.';

  @override
  String get onboardingPrivacy =>
      'Seus dados de OCD ficam neste dispositivo. Sem conta. Sem sincronização na nuvem.';

  @override
  String get getStartedAction => 'Começar';

  @override
  String get importExistingDataAction => 'Importar dados existentes';

  @override
  String get onboardingQuestion => 'O que ajudaria você agora?';

  @override
  String get onboardingPickOne =>
      'Escolha uma opção. Você poderá fazer o restante quando quiser.';

  @override
  String get onboardingUrgeTitle => 'Estou enfrentando um impulso agora';

  @override
  String get onboardingUrgeSubtitle =>
      'Crie algum tempo entre o impulso e o ritual.';

  @override
  String get onboardingJournalTitle => 'Quero escrever algo';

  @override
  String get onboardingJournalSubtitle =>
      'Tire o pensamento da cabeça e coloque-o na página.';

  @override
  String get onboardingErpTitle =>
      'Quero praticar deixar uma compulsão sem fazer';

  @override
  String get onboardingErpSubtitle => 'Uma exposição curta e guiada.';

  @override
  String get onboardingSelfCheckTitle => 'Quero ver como está meu OCD agora';

  @override
  String get onboardingSelfCheckSubtitle =>
      'A autoavaliação Y-BOCS. Cerca de 10 minutos.';

  @override
  String get onboardingExploreTitle => 'Estou apenas explorando';

  @override
  String get onboardingExploreSubtitle => 'Primeiro, dê uma olhada.';

  @override
  String get whatsNewTitle => 'Pratique sem pressão';

  @override
  String get whatsNewBody =>
      'O Patterns 1.10 traz Insights tranquilos, finais de sessão mais discretos, melhorias de acessibilidade e seleção opcional de idioma.';

  @override
  String get whatsNewLanguagesTitle => 'Insights tranquilos';

  @override
  String get whatsNewLanguagesBody =>
      'Escolha resumos factuais de atividade em vez de pontuações, sequências e percentuais de consistência calculados.';

  @override
  String get whatsNewPrivateTitle => 'Um final claro';

  @override
  String get whatsNewPrivateBody =>
      'Diário, registro, adiamento de compulsão e sessões de ERP agora terminam com uma confirmação factual e Concluir por enquanto.';

  @override
  String get whatsNewReportsTitle => 'Mais acessível, no seu idioma';

  @override
  String get whatsNewReportsBody =>
      'Rótulos aprimorados e menos movimento se unem ao inglês, português do Brasil, alemão, japonês, espanhol e francês.';

  @override
  String get whatsNewExploreAction => 'Explorar o Patterns 1.10';

  @override
  String get continueToPatternsAction => 'Continuar para o Patterns';

  @override
  String get whatsNewNotificationNote =>
      'Seus registros permanecem como foram escritos. Idioma e Insights tranquilos ficam neste dispositivo e não são incluídos em análises nem backups.';

  @override
  String get formatBold => 'Negrito';

  @override
  String get formatItalic => 'Itálico';

  @override
  String get formatBulletedList => 'Lista com marcadores';

  @override
  String get formatToggleHint =>
      'Toque duas vezes para ativar ou desativar esta formatação.';

  @override
  String get journalEditorLabel => 'Editor do diário';

  @override
  String get journalEditorHint =>
      'Digite o texto do diário. Os controles de formatação vêm depois do editor.';

  @override
  String timerRemaining(String time) {
    return 'Tempo restante: $time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return 'Pontuação de recuperação: $score de 100.';
  }

  @override
  String get privacySafetyTitle => 'Privacidade e segurança';

  @override
  String get privacyLocalContent =>
      'Registros do diário, eventos de OCD, níveis de desconforto, reflexões e preferências ficam armazenados localmente neste dispositivo.';

  @override
  String get privacyPurchases =>
      'O Patterns Pro e as gorjetas são processados pela loja de aplicativos. O Patterns não recebe os dados do seu cartão.';

  @override
  String get privacyExports =>
      'Uma exportação manual cria um backup JSON ou relatório PDF sem criptografia apenas onde você escolher salvar ou compartilhar.';

  @override
  String get privacyAnalytics =>
      'A análise anônima de uso fica desativada até você habilitá-la. Se habilitada, o Patterns envia eventos nomeados de uso, um ID aleatório de instalação, plataforma, versão e horário ao serviço próprio. Registros, dados de OCD, resumos gerados, localidade e idioma nunca são incluídos. Desativar apaga eventos pendentes e o ID local.';

  @override
  String get privacyClinicalBoundary =>
      'O Patterns é uma ferramenta de autoajuda para reflexão pessoal e prática de ERP. Não diagnostica nem trata OCD, não substitui o cuidado de um profissional qualificado e não oferece suporte de emergência.';

  @override
  String get viewPrivacyPolicyAction => 'Ver a Política de Privacidade';

  @override
  String get closeAction => 'Fechar';

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools =>
      'Também inclui todas as ferramentas Pro de planejamento, prática, métricas e reflexão.';

  @override
  String get proPaywallAlreadyPurchased =>
      'Já comprou o Pro? Você não será cobrado novamente.';

  @override
  String get proPaywallTryAgainAction => 'Tentar novamente';

  @override
  String get proPaywallRestorePurchasesAction => 'Restaurar compras';

  @override
  String get proPaywallRestoreShortAction => 'Restaurar';

  @override
  String get proPaywallUnlockAction => 'Desbloquear Pro';

  @override
  String proPaywallUnlockWithPrice(String price) {
    return 'Desbloquear Pro · $price';
  }

  @override
  String get proPaywallPurchasesUnavailable =>
      'As compras no app não estão disponíveis neste dispositivo.';

  @override
  String get proPaywallProductUnavailable =>
      'O Patterns Pro não está disponível agora. Tente novamente mais tarde.';

  @override
  String get proPaywallProductLoadFailed =>
      'Não foi possível carregar o Patterns Pro. Tente novamente mais tarde.';

  @override
  String get proPaywallPurchaseStartFailed =>
      'Não foi possível iniciar a compra.';

  @override
  String get proPaywallPurchaseFailed =>
      'Não foi possível concluir a compra. Tente novamente.';

  @override
  String get proPaywallRestoreNotFound =>
      'Nenhuma compra anterior foi encontrada nesta conta. Se você comprou o Pro com outra conta, entre nela e tente novamente.';

  @override
  String get proPaywallRestoreFailed =>
      'Não foi possível restaurar as compras. Tente novamente.';

  @override
  String get proPaywallWelcomeBack => 'Boas-vindas de volta';

  @override
  String get proPaywallAllSet => 'Tudo pronto';

  @override
  String get proPaywallRestoredBody =>
      'O Patterns Pro foi restaurado neste dispositivo.';

  @override
  String get proPaywallUnlockedBody =>
      'O Patterns Pro está desbloqueado. Todas as ferramentas de recuperação estão disponíveis.';

  @override
  String get proPaywallContinueAction => 'Continuar';

  @override
  String get proPaywallLoadingLabel => 'Carregando o Patterns Pro';

  @override
  String get proHeadlineSettings =>
      'Ir além dos registros e praticar a recuperação';

  @override
  String get proHeadlineTodayNextStep => 'Continuar a prática de hoje';

  @override
  String get proHeadlineRecoveryMetrics =>
      'Revisar sua atividade de recuperação';

  @override
  String get proHeadlineExposureHierarchy =>
      'Criar uma hierarquia de exposição clara';

  @override
  String get proHeadlineExposureMaterials =>
      'Manter os materiais de prática juntos';

  @override
  String get proHeadlineStructuredPrograms =>
      'Transformar a recuperação em uma rotina';

  @override
  String get proHeadlineActionPlanner =>
      'Planejar sua resposta antes que o TOC apareça';

  @override
  String get proHeadlineImplementationIntentions =>
      'Facilitar sua próxima escolha';

  @override
  String get proHeadlineUrgeSurfing => 'Praticar como deixar o impulso passar';

  @override
  String get proHeadlineResponsePrevention => 'Registrar a resposta escolhida';

  @override
  String get proHeadlineUncertaintyTraining =>
      'Praticar como abrir espaço para o talvez';

  @override
  String get proHeadlineBehavioralExperiments => 'Testar as previsões do TOC';

  @override
  String get proHeadlineReflectionJournal =>
      'Registrar o que cada prática ensinou';

  @override
  String get proBenefitGeneralPlans =>
      'Criar hierarquias de exposição e planos de prática';

  @override
  String get proBenefitGeneralResponsePrevention =>
      'Usar ferramentas específicas de prevenção de resposta';

  @override
  String get proBenefitGeneralReview =>
      'Revisar a atividade de recuperação e as reflexões';

  @override
  String get proBenefitMetricsActivity =>
      'Revisar a atividade de prática ao longo do tempo';

  @override
  String get proBenefitMetricsNonjudgmental =>
      'Ver a atividade registrada sem julgar dias específicos';

  @override
  String get proBenefitMetricsPatterns =>
      'Explorar padrões objetivos de recuperação';

  @override
  String get proBenefitExposureLadder =>
      'Organizar as etapas das mais leves às mais difíceis';

  @override
  String get proBenefitExposureMaterials =>
      'Manter roteiros, áudios em loop, imagens e links por perto';

  @override
  String get proBenefitExposureRepeatable =>
      'Transformar um plano em prática repetível';

  @override
  String get proBenefitProgramsStructure =>
      'Seguir uma estrutura semanal tranquila';

  @override
  String get proBenefitProgramsTasks =>
      'Manter as tarefas de prática em um só lugar';

  @override
  String get proBenefitProgramsReview => 'Revisar o que ajudou ao continuar';

  @override
  String get proBenefitPlanningAhead =>
      'Escolher uma resposta antes do momento difícil';

  @override
  String get proBenefitPlanningIfThen => 'Criar planos práticos de se-então';

  @override
  String get proBenefitPlanningReturn =>
      'Voltar ao plano quando a incerteza aumentar';

  @override
  String get proBenefitInMomentTools =>
      'Usar ferramentas de prática focadas no momento';

  @override
  String get proBenefitInMomentPrivacy =>
      'Registrar escolhas sem escrever detalhes sensíveis';

  @override
  String get proBenefitInMomentRepetition =>
      'Desenvolver tolerância com práticas repetíveis';

  @override
  String get proBenefitReflectionCompare =>
      'Comparar as previsões com o que aconteceu';

  @override
  String get proBenefitReflectionCapture =>
      'Registrar aprendizados depois da prática';

  @override
  String get proBenefitReflectionPatterns =>
      'Perceber padrões úteis ao longo do tempo';

  @override
  String get proRestoreChecking => 'Verificando suas compras…';

  @override
  String get proRestoreSucceeded =>
      'O Patterns Pro foi restaurado. Todas as ferramentas de recuperação estão desbloqueadas novamente.';

  @override
  String get tipJarTitle => 'Apoiar o Patterns';

  @override
  String get tipJarBody =>
      'O Patterns é independente e não tem anúncios. Se ele ajudou você, uma pequena gorjeta significa muito. As gorjetas são opcionais e não desbloqueiam nada.';

  @override
  String get tipJarLoadingLabel => 'Carregando opções de gorjeta';

  @override
  String get tipJarPurchasesUnavailable =>
      'As compras no app não estão disponíveis neste dispositivo.';

  @override
  String get tipJarOptionsUnavailable =>
      'Nenhuma opção de gorjeta foi encontrada. Tente novamente mais tarde.';

  @override
  String get tipJarLoadFailed =>
      'Não foi possível carregar as opções de gorjeta. Tente novamente mais tarde.';

  @override
  String get tipJarPurchaseFailed =>
      'Não foi possível concluir a gorjeta. Tente novamente.';

  @override
  String get tipJarTryAgainAction => 'Tentar novamente';

  @override
  String get tipSmallTitle => 'Gorjeta pequena';

  @override
  String get tipSmallDescription =>
      'Uma gorjeta pequena e opcional para apoiar o desenvolvimento do Patterns. Não libera recursos.';

  @override
  String get tipMediumTitle => 'Gorjeta média';

  @override
  String get tipMediumDescription =>
      'Uma gorjeta média e opcional para apoiar o desenvolvimento do Patterns. Não libera recursos.';

  @override
  String get tipLargeTitle => 'Gorjeta grande';

  @override
  String get tipLargeDescription =>
      'Uma gorjeta grande e opcional para apoiar o desenvolvimento do Patterns. Não libera recursos.';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title, $price. $description';
  }

  @override
  String get tipChoiceHint => 'Envia esta gorjeta opcional';

  @override
  String get tipThanksTitle => 'Obrigado';

  @override
  String get tipThanksBody =>
      'Seu apoio significa muito. Graças a pessoas como você, o Patterns continua independente e sem anúncios.';

  @override
  String get tipThanksAction => 'Foi um prazer';

  @override
  String get desktopProTitle => 'Desbloquear o Patterns Desktop Pro';

  @override
  String get desktopProSubtitle =>
      'Uma licença de compra única para ferramentas de recuperação offline otimizadas para computador.';

  @override
  String get desktopFeatureHierarchyTitle => 'Criador de hierarquias';

  @override
  String get desktopFeatureHierarchyDescription =>
      'Criar e registrar etapas e hierarquias de exposição.';

  @override
  String get desktopFeatureErpTitle => 'Registros de exercícios ERP';

  @override
  String get desktopFeatureErpDescription =>
      'Registrar prevenção de resposta e exercícios cronometrados.';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription =>
      'Registrar mudanças no impulso com um cronômetro ao vivo.';

  @override
  String get desktopFeatureActivityTitle => 'Atividade de recuperação';

  @override
  String get desktopFeatureActivityDescription =>
      'Revisar atividades objetivas e padrões semanais.';

  @override
  String get desktopOneTimeLicense => 'Licença de compra única';

  @override
  String desktopOneTimePrice(String price) {
    return '$price, compra única';
  }

  @override
  String get desktopPurchaseLicenseAction => 'Comprar licença';

  @override
  String get desktopCheckoutUnavailable =>
      'A página de compra não está disponível nesta versão.';

  @override
  String get desktopAlreadyPurchased =>
      'Já comprou? Digite sua chave de licença';

  @override
  String get desktopLicensePrompt =>
      'Digite sua chave de licença do Lemon Squeezy:';

  @override
  String get desktopLicenseLabel => 'Chave de licença';

  @override
  String get desktopLicenseHint => 'Cole a chave de licença do seu recibo';

  @override
  String get desktopLicenseActivating => 'Ativando a licença…';

  @override
  String get desktopActivateLicenseAction => 'Ativar licença';

  @override
  String get desktopLicenseBackAction => 'Voltar';

  @override
  String get desktopLicenseInvalid =>
      'Digite a chave de licença completa que está no seu recibo.';

  @override
  String get desktopLicenseRejected =>
      'Não foi possível verificar esta licença para o Patterns Desktop Pro. Confira a chave e tente novamente.';

  @override
  String get desktopLicenseUnavailable =>
      'Não foi possível acessar o serviço de licenças. Confira sua conexão e tente novamente.';

  @override
  String get desktopLicenseNotConfigured =>
      'A ativação da licença não está disponível nesta versão.';
}
