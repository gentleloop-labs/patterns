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

  @override
  String get journalTitle => 'Diário';

  @override
  String get journalSearchAction => 'Pesquisar no diário';

  @override
  String get journalChooseDateAction => 'Escolher data';

  @override
  String get journalSearchHint => 'Pesquisar registros';

  @override
  String get journalClearSearchAction => 'Limpar pesquisa';

  @override
  String get journalNoMatchesTitle => 'Nenhum resultado';

  @override
  String journalNoMatchesBody(String query) {
    return 'Nenhum registro corresponde a “$query”.';
  }

  @override
  String get journalEmptyTitle => 'Ainda não há registros no diário';

  @override
  String get journalEmptyBody => 'Algumas linhas tranquilas já são um começo.';

  @override
  String get journalLoadError =>
      'Não foi possível carregar os registros do diário. Tente novamente.';

  @override
  String get journalLoadingLabel => 'Carregando registros do diário';

  @override
  String get journalSavingStatus => 'Salvando…';

  @override
  String get journalSavedStatus => 'Salvo';

  @override
  String get journalUnsavedStatus => 'Não salvo';

  @override
  String get journalClearDayAction => 'Limpar este dia';

  @override
  String get journalSaveAction => 'Salvar';

  @override
  String get journalStartWritingPlaceholder => 'Comece a escrever…';

  @override
  String get journalFormatSelectionHint => 'Selecione um texto para formatar';

  @override
  String get journalClearedMessage => 'O registro desse dia foi apagado.';

  @override
  String get journalNothingToSaveMessage =>
      'Ainda não há nada para salvar. Escreva uma linha quando se sentir à vontade.';

  @override
  String get journalClearDayTitle => 'Limpar este dia?';

  @override
  String journalClearDayBody(String date) {
    return 'Isso apaga tudo o que foi salvo em $date. Você poderá escrever nesse dia novamente quando quiser.';
  }

  @override
  String get journalKeepEntryAction => 'Manter';

  @override
  String get journalTodayEntry => 'Registro de hoje';

  @override
  String get journalOpenEntryAction => 'Abrir registro';

  @override
  String journalOpenEntryHint(String date) {
    return 'Abre o registro do diário de $date.';
  }

  @override
  String get journalWorkspaceTitle => 'Espaço do diário';

  @override
  String get journalSubtitle => 'Seu espaço para refletir e colocar para fora.';

  @override
  String get journalNewEntryAction => 'Novo registro';

  @override
  String get journalEarlierSection => 'Anteriores';

  @override
  String get journalNoEntryForDate => 'Não há registro para esta data.';

  @override
  String get journalCreateEntryAction => 'Criar registro';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date às $time';
  }

  @override
  String get journalDeleteEntryAction => 'Excluir registro';

  @override
  String get journalDeleteEntryTitle => 'Excluir registro?';

  @override
  String get journalDeleteEntryBody =>
      'Este registro do diário será excluído permanentemente.';

  @override
  String get journalDeletedMessage => 'O registro do diário foi excluído.';

  @override
  String get journalEditAction => 'Editar';

  @override
  String journalEditingDate(String date) {
    return 'Editando: $date';
  }

  @override
  String get journalUnsavedChangesStatus => 'Alterações não salvas';

  @override
  String get journalEntrySavedMessage => 'Registro do diário salvo';

  @override
  String journalReadOnlyLabel(String date) {
    return 'Registro do diário de $date, somente leitura';
  }

  @override
  String get journalThemeContamination => 'Contaminação';

  @override
  String get journalThemeUncertainty => 'Incerteza';

  @override
  String get journalThemeChecking => 'Verificação';

  @override
  String get journalThemeRelationship => 'Relacionamento';

  @override
  String get journalThemeHealth => 'Saúde';

  @override
  String get todayGreetingMorning => 'Bom dia';

  @override
  String get todayGreetingAfternoon => 'Boa tarde';

  @override
  String get todayGreetingEvening => 'Boa noite';

  @override
  String get todayEncouragement => 'Você consegue. Uma escolha de cada vez.';

  @override
  String get todayContinuePractice => 'Continue sua prática';

  @override
  String get todaySeeAllAction => 'Ver tudo';

  @override
  String get todayQuickActions => 'Ações rápidas';

  @override
  String get todayChooseActivity => 'O que você gostaria de fazer?';

  @override
  String get todayWriteSomethingTitle => 'Anotar algo';

  @override
  String get todayWriteSomethingBody =>
      'Tire um pensamento da cabeça e coloque no papel.';

  @override
  String get todayDelayUrgeTitle => 'Adiar um impulso';

  @override
  String get todayDelayUrgeBody => 'Crie um espaço antes de responder.';

  @override
  String get todayPracticeErpTitle => 'Praticar (ERP)';

  @override
  String get todayPracticeErpBody => 'Um exercício curto e guiado.';

  @override
  String get todayFirstJournalTitle => 'Anote outro momento';

  @override
  String get todayFirstJournalBody =>
      'Dar nome a um pensamento pode facilitar observá-lo.';

  @override
  String get todayFirstErpTitle => 'Pratique novamente';

  @override
  String get todayFirstErpBody =>
      'Experimente outra prática curta e guiada de ERP.';

  @override
  String get todayFirstDelayTitle => 'Experimente adiar por dois minutos';

  @override
  String get todayFirstDelayBody =>
      'Quando o impulso estiver forte, crie um pequeno espaço antes de agir.';

  @override
  String get todayStartPracticeAction => 'Iniciar prática';

  @override
  String get todayStartDelayAction => 'Iniciar adiamento';

  @override
  String get todayProTitle => 'Continue com o Patterns Pro';

  @override
  String get todayProBody =>
      'Crie um plano, pratique e reveja sua atividade ao longo do tempo.';

  @override
  String get todayHideSevenDays => 'Ocultar por 7 dias';

  @override
  String get todayPracticeProgress => 'Progresso da prática';

  @override
  String get todaySteadyPractice => 'Prática constante';

  @override
  String get todayStartGently => 'Comece com calma';

  @override
  String get todayPracticeActiveBody =>
      'Suas atividades registradas estão formando uma visão de longo prazo.';

  @override
  String get todayPracticeEmptyBody =>
      'Isso muda conforme você escreve, registra e pratica.';

  @override
  String get todayProgressDisclaimer =>
      'Isso reflete a frequência das práticas registradas, não um diagnóstico ou avaliação clínica. Um número menor pode ocorrer durante uma semana difícil.';

  @override
  String get todayProgressStartedTitle => 'Sua atividade está tomando forma';

  @override
  String get todayProgressPendingBody =>
      'Um número de progresso aparecerá depois que houver atividades registradas em mais de um dia.';

  @override
  String get todayScoreNew => 'Novo';

  @override
  String get todayScoreStrong => 'Forte';

  @override
  String get todayScoreSteady => 'Constante';

  @override
  String get todayScoreBuilding => 'Em construção';

  @override
  String get todayScoreStarting => 'Começando';

  @override
  String get todayBeginCheckIn => 'Comece com um pequeno check-in';

  @override
  String get todayNoChange => 'Sem mudança em relação ao período anterior';

  @override
  String todayPointsUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points pontos acima',
      one: '1 ponto acima',
    );
    return '$_temp0 do período anterior';
  }

  @override
  String todayPointsDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points pontos abaixo',
      one: '1 ponto abaixo',
    );
    return '$_temp0 do período anterior';
  }

  @override
  String get todayNextStep => 'Seu próximo passo';

  @override
  String get todayNextSelfCheckTitle => 'Veja como você está';

  @override
  String get todayNextSelfCheckBody =>
      'Uma autoavaliação pode registrar uma referência para comparação futura.';

  @override
  String get todayNextSelfCheckAction => 'Fazer autoavaliação';

  @override
  String get todayNextHierarchyTitle => 'Prepare sua prática';

  @override
  String get todayNextHierarchyBody =>
      'Monte uma escada de exposição, dos passos mais fáceis aos mais difíceis.';

  @override
  String get todayNextHierarchyAction => 'Montar escada';

  @override
  String get todayNextPracticeTitle => 'Escolha a prática de hoje';

  @override
  String get todayNextPracticeBody =>
      'Escolha um exercício de ERP possível para hoje.';

  @override
  String get todayNextPracticeAction => 'Iniciar prática';

  @override
  String get todayNextReflectTitle => 'Reflita sobre a prática';

  @override
  String get todayNextReflectBody =>
      'Registre o que você percebeu durante a prática de hoje.';

  @override
  String get todayNextReflectAction => 'Refletir';

  @override
  String get todayNextJournalTitle => 'Reflita sobre hoje';

  @override
  String get todayNextJournalBody =>
      'Escreva uma linha sobre o que percebeu na sua prática.';

  @override
  String get todayNextJournalAction => 'Abrir diário';

  @override
  String get todayCompulsionDelay => 'Adiamento de compulsão';

  @override
  String get todayStartErp => 'Iniciar prática de ERP';

  @override
  String get todayResistUrgeBody =>
      'Fique com o impulso antes de decidir o que fazer.';

  @override
  String get todayBuildToleranceBody =>
      'Pratique um passo possível no seu ritmo.';

  @override
  String get todayResumeAction => 'Retomar';

  @override
  String get todayStartAction => 'Iniciar';

  @override
  String get todayJournalBody => 'Escreva e reflita no seu diário privado.';

  @override
  String get todayExposureTools => 'Ferramentas de exposição';

  @override
  String get todayExposureToolsBody =>
      'Hierarquia, materiais e prática de incerteza.';

  @override
  String get todayInsightsBody => 'Reveja sua atividade registrada.';

  @override
  String get todaySelfCheckTitle => 'Entenda seus padrões';

  @override
  String get todaySelfCheckDuration => 'Opcional · cerca de 10 min';

  @override
  String get todayInsightsPlaceholder =>
      'Seus insights aparecerão aqui conforme você registrar atividades.';

  @override
  String get todayDailyCheckInComplete => 'Check-in diário registrado';

  @override
  String get todayDailyCheckIn => 'Check-in diário';

  @override
  String get todayDailyCompleteBody =>
      'Há uma entrada no diário registrada para hoje.';

  @override
  String get todayDailyBody =>
      'Escreva uma entrada curta quando estiver pronto.';

  @override
  String get todayOpenAction => 'Abrir';

  @override
  String get todayCheckInAction => 'Fazer check-in';

  @override
  String get todayRecoveryScore => 'Pontuação de recuperação';

  @override
  String todayActivitiesLastSevenDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atividades nos últimos 7 dias',
      one: '1 atividade nos últimos 7 dias',
    );
    return '$_temp0';
  }

  @override
  String get todayActivityRecorded =>
      'Calculado a partir da atividade registrada';

  @override
  String get todayPracticesRecorded => 'Práticas registradas';

  @override
  String get todayPracticeStreak => 'Sequência de prática';

  @override
  String todaySessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessões',
      one: '1 sessão',
    );
    return '$_temp0';
  }

  @override
  String todayDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String get todayPickUpBody =>
      'Continue a partir do tempo registrado anteriormente.';

  @override
  String get todayPracticeUrgesBody =>
      'Pratique esperar antes de responder a um impulso.';

  @override
  String get todayReadCheckIn => 'Ler o check-in de hoje';

  @override
  String get todayOpenJournalMore => 'Abra o Diário para ler ou adicionar mais';

  @override
  String get todayShortJournal => 'Escreva uma entrada curta no diário';

  @override
  String get todayExplore => 'Explorar';

  @override
  String get todayReflectProcess => 'Reflita e processe';

  @override
  String get todayRecoveryTools => 'Ferramentas de recuperação';

  @override
  String get todaySupportPractice => 'Apoie sua prática';

  @override
  String get todayTrackBody => 'Registre pensamentos e impulsos';

  @override
  String get todaySeePatterns => 'Reveja seus padrões registrados';

  @override
  String todayScoreA11y(int score, String label) {
    return 'Progresso da prática: $score de 100, $label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return 'Temporizador da prática: $elapsed decorridos de $planned';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day: atividade registrada';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day: nenhuma atividade registrada';
  }

  @override
  String get trackerTitle => 'Registrar';

  @override
  String get trackerPauseUrgeAction => 'Pausar antes de responder';

  @override
  String get trackerFilterGroupLabel => 'Filtrar momentos registrados';

  @override
  String get trackerFilterAll => 'Todos';

  @override
  String get trackerFilterObsessions => 'Obsessões';

  @override
  String get trackerFilterCompulsions => 'Compulsões';

  @override
  String get trackerLoadingLabel => 'Carregando momentos registrados';

  @override
  String get trackerLoadError =>
      'Não foi possível carregar seus momentos registrados. Tente novamente.';

  @override
  String get trackerEditTitle => 'Editar evento';

  @override
  String get trackerAddTitle => 'Registrar evento';

  @override
  String get trackerTypeGroupLabel => 'Tipo de evento';

  @override
  String get trackerTypeObsession => 'Obsessão';

  @override
  String get trackerTypeCompulsion => 'Compulsão';

  @override
  String get trackerThoughtLabel => 'O que o pensamento dizia?';

  @override
  String get trackerUrgeLabel => 'Qual era o impulso?';

  @override
  String get trackerThoughtHint => 'Descreva o pensamento ou a imagem.';

  @override
  String get trackerUrgeHint => 'Descreva o impulso ou a compulsão.';

  @override
  String get trackerActionLabel => 'O que o TOC levou você a fazer?';

  @override
  String get trackerActionHint => 'Uma anotação breve é suficiente.';

  @override
  String get trackerResponseLabel => 'O que você fez em vez disso';

  @override
  String get trackerResponseHint =>
      'Registre qualquer resposta que escolheu, inclusive um adiamento parcial.';

  @override
  String get trackerSavingAction => 'Salvando…';

  @override
  String get trackerUpdateAction => 'Atualizar evento';

  @override
  String get trackerSaveAction => 'Salvar evento';

  @override
  String get trackerContentRequired =>
      'Quando você se sentir pronto, escreva algumas palavras sobre o que aconteceu.';

  @override
  String get trackerSaveError =>
      'Não foi possível salvar seu evento. Tente novamente.';

  @override
  String get trackerUpdateError =>
      'Não foi possível atualizar seu evento. Tente novamente.';

  @override
  String get trackerEditTooltip => 'Editar evento';

  @override
  String get trackerDeleteTooltip => 'Excluir evento';

  @override
  String trackerDistressValue(int value) {
    return 'Desconforto $value de 10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => 'Nenhuma resposta registrada';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type. $date. Desconforto $distress de 10. $content. Resposta: $response';
  }

  @override
  String get trackerDeleteTitle => 'Excluir evento?';

  @override
  String get trackerDeleteBody =>
      'Isso remove o evento do histórico local neste dispositivo.';

  @override
  String get trackerDeleteAction => 'Excluir';

  @override
  String get trackerDeletedMessage => 'Evento excluído';

  @override
  String get trackerDeleteError =>
      'Não foi possível excluir seu evento. Tente novamente.';

  @override
  String get trackerDistressLabel => 'Desconforto, de 0 a 10';

  @override
  String get trackerEmptyTitle => 'Ainda não há eventos';

  @override
  String get trackerEmptyBody =>
      'Registre apenas o que parecer útil. Uma anotação breve é suficiente.';

  @override
  String get trackerEmptyAction => 'Registrar evento de TOC';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsExportReport => 'Exportar relatório';

  @override
  String get insightsObsessionsLogged => 'Obsessões registradas';

  @override
  String get insightsThemesFound => 'Temas encontrados';

  @override
  String get insightsCompulsions => 'Compulsões';

  @override
  String get insightsAverageIntensityShort => 'Intensidade média';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => 'Progresso da prática';

  @override
  String get insightsScoreNeedsMoreActivity =>
      'Uma pontuação aparece depois de algumas práticas em dias diferentes, para mostrar uma tendência em vez de um único momento. As sessões abaixo já estão sendo contadas.';

  @override
  String get insightsScoreEmpty =>
      'Uma pontuação aparecerá aqui depois de algumas práticas. Ainda não há nada para medir.';

  @override
  String insightsComparedPreviousDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'os $count dias anteriores',
      one: 'o dia anterior',
    );
    return 'em comparação com $_temp0';
  }

  @override
  String get insightsComparedPreviousRange =>
      'em comparação com o período anterior';

  @override
  String get insightsPracticeProgressBoundary =>
      'Reflete a frequência da prática, não um diagnóstico nem como você está clinicamente. Um número menor em uma semana difícil pode acontecer.';

  @override
  String get insightsMoodOverTime => 'Humor ao longo do tempo';

  @override
  String get insightsMoodGood => 'Bem';

  @override
  String get insightsMoodOkay => 'Razoável';

  @override
  String get insightsMoodLow => 'Baixo';

  @override
  String get insightsYbocsOverTime => 'Y-BOCS ao longo do tempo';

  @override
  String get insightsYbocsEmpty =>
      'Faça a autoavaliação e o total registrado iniciará uma linha aqui.';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return 'Faixa $severity. Faça a autoavaliação novamente em algumas semanas para adicionar outro ponto registrado.';
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
      other: '$count autoavaliações',
      one: '1 autoavaliação',
    );
    return 'em $_temp0';
  }

  @override
  String get insightsYbocsBoundary =>
      'É um retrato do momento, não um diagnóstico. Os totais registrados podem variar, e um total mais alto não define seu progresso.';

  @override
  String get insightsAverageUrgeIntensity => 'Intensidade média do impulso';

  @override
  String get insightsErpPractice => 'Prática de ERP';

  @override
  String insightsSessions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sessões',
      one: 'sessão',
    );
    return '$_temp0';
  }

  @override
  String get insightsConsistency => 'Consistência';

  @override
  String insightsActiveDays(int active, int total) {
    return '$active de $total dias';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return 'Atividade registrada em $active de $total dias';
  }

  @override
  String get insightsTopThemes => 'Principais temas';

  @override
  String get insightsThemesEmpty =>
      'Os temas aparecerão conforme você registrar o foco do TOC.';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme, $percent por cento dos temas registrados';
  }

  @override
  String get insightsChangeRange => 'Alterar período';

  @override
  String get insightsOverviewTab => 'Visão geral';

  @override
  String get insightsObsessionsTab => 'Obsessões';

  @override
  String get insightsCompulsionsTab => 'Compulsões';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ aumento de $value, $comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ redução de $value, $comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ Sem mudança, $comparison';
  }

  @override
  String get insightsNoData => 'Ainda não há dados';

  @override
  String get insightsLoading => 'Carregando insights';

  @override
  String get insightsLoadError =>
      'Não foi possível carregar seus insights. Tente novamente.';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date: $value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title. Pontos registrados: $values';
  }

  @override
  String get ybocsSeveritySubclinical => 'Subclínica';

  @override
  String get ybocsSeverityMild => 'Leve';

  @override
  String get ybocsSeverityModerate => 'Moderada';

  @override
  String get ybocsSeveritySevere => 'Grave';

  @override
  String get ybocsSeverityExtreme => 'Extrema';

  @override
  String get insightsThemeContamination => 'Contaminação';

  @override
  String get insightsThemeHarm => 'Dano';

  @override
  String get insightsThemeChecking => 'Verificação';

  @override
  String get insightsThemeReassurance => 'Busca de confirmação';

  @override
  String get insightsThemeHealth => 'Saúde';

  @override
  String get insightsThemeRelationship => 'Relacionamento';

  @override
  String get insightsThemeSymmetry => 'Simetria';

  @override
  String get insightsThemeMoral => 'Moralidade';

  @override
  String get insightsThemeRumination => 'Ruminação';

  @override
  String get insightsThemeUncertainty => 'Incerteza';

  @override
  String get insightsThemeOther => 'Outro';
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

  @override
  String get journalTitle => 'Diário';

  @override
  String get journalSearchAction => 'Pesquisar no diário';

  @override
  String get journalChooseDateAction => 'Escolher data';

  @override
  String get journalSearchHint => 'Pesquisar registros';

  @override
  String get journalClearSearchAction => 'Limpar pesquisa';

  @override
  String get journalNoMatchesTitle => 'Nenhum resultado';

  @override
  String journalNoMatchesBody(String query) {
    return 'Nenhum registro corresponde a “$query”.';
  }

  @override
  String get journalEmptyTitle => 'Ainda não há registros no diário';

  @override
  String get journalEmptyBody => 'Algumas linhas tranquilas já são um começo.';

  @override
  String get journalLoadError =>
      'Não foi possível carregar os registros do diário. Tente novamente.';

  @override
  String get journalLoadingLabel => 'Carregando registros do diário';

  @override
  String get journalSavingStatus => 'Salvando…';

  @override
  String get journalSavedStatus => 'Salvo';

  @override
  String get journalUnsavedStatus => 'Não salvo';

  @override
  String get journalClearDayAction => 'Limpar este dia';

  @override
  String get journalSaveAction => 'Salvar';

  @override
  String get journalStartWritingPlaceholder => 'Comece a escrever…';

  @override
  String get journalFormatSelectionHint => 'Selecione um texto para formatar';

  @override
  String get journalClearedMessage => 'O registro desse dia foi apagado.';

  @override
  String get journalNothingToSaveMessage =>
      'Ainda não há nada para salvar. Escreva uma linha quando se sentir à vontade.';

  @override
  String get journalClearDayTitle => 'Limpar este dia?';

  @override
  String journalClearDayBody(String date) {
    return 'Isso apaga tudo o que foi salvo em $date. Você poderá escrever nesse dia novamente quando quiser.';
  }

  @override
  String get journalKeepEntryAction => 'Manter';

  @override
  String get journalTodayEntry => 'Registro de hoje';

  @override
  String get journalOpenEntryAction => 'Abrir registro';

  @override
  String journalOpenEntryHint(String date) {
    return 'Abre o registro do diário de $date.';
  }

  @override
  String get journalWorkspaceTitle => 'Espaço do diário';

  @override
  String get journalSubtitle => 'Seu espaço para refletir e colocar para fora.';

  @override
  String get journalNewEntryAction => 'Novo registro';

  @override
  String get journalEarlierSection => 'Anteriores';

  @override
  String get journalNoEntryForDate => 'Não há registro para esta data.';

  @override
  String get journalCreateEntryAction => 'Criar registro';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date às $time';
  }

  @override
  String get journalDeleteEntryAction => 'Excluir registro';

  @override
  String get journalDeleteEntryTitle => 'Excluir registro?';

  @override
  String get journalDeleteEntryBody =>
      'Este registro do diário será excluído permanentemente.';

  @override
  String get journalDeletedMessage => 'O registro do diário foi excluído.';

  @override
  String get journalEditAction => 'Editar';

  @override
  String journalEditingDate(String date) {
    return 'Editando: $date';
  }

  @override
  String get journalUnsavedChangesStatus => 'Alterações não salvas';

  @override
  String get journalEntrySavedMessage => 'Registro do diário salvo';

  @override
  String journalReadOnlyLabel(String date) {
    return 'Registro do diário de $date, somente leitura';
  }

  @override
  String get journalThemeContamination => 'Contaminação';

  @override
  String get journalThemeUncertainty => 'Incerteza';

  @override
  String get journalThemeChecking => 'Verificação';

  @override
  String get journalThemeRelationship => 'Relacionamento';

  @override
  String get journalThemeHealth => 'Saúde';

  @override
  String get todayGreetingMorning => 'Bom dia';

  @override
  String get todayGreetingAfternoon => 'Boa tarde';

  @override
  String get todayGreetingEvening => 'Boa noite';

  @override
  String get todayEncouragement => 'Você consegue. Uma escolha de cada vez.';

  @override
  String get todayContinuePractice => 'Continue sua prática';

  @override
  String get todaySeeAllAction => 'Ver tudo';

  @override
  String get todayQuickActions => 'Ações rápidas';

  @override
  String get todayChooseActivity => 'O que você gostaria de fazer?';

  @override
  String get todayWriteSomethingTitle => 'Anotar algo';

  @override
  String get todayWriteSomethingBody =>
      'Tire um pensamento da cabeça e coloque no papel.';

  @override
  String get todayDelayUrgeTitle => 'Adiar um impulso';

  @override
  String get todayDelayUrgeBody => 'Crie um espaço antes de responder.';

  @override
  String get todayPracticeErpTitle => 'Praticar (ERP)';

  @override
  String get todayPracticeErpBody => 'Um exercício curto e guiado.';

  @override
  String get todayFirstJournalTitle => 'Anote outro momento';

  @override
  String get todayFirstJournalBody =>
      'Dar nome a um pensamento pode facilitar observá-lo.';

  @override
  String get todayFirstErpTitle => 'Pratique novamente';

  @override
  String get todayFirstErpBody =>
      'Experimente outra prática curta e guiada de ERP.';

  @override
  String get todayFirstDelayTitle => 'Experimente adiar por dois minutos';

  @override
  String get todayFirstDelayBody =>
      'Quando o impulso estiver forte, crie um pequeno espaço antes de agir.';

  @override
  String get todayStartPracticeAction => 'Iniciar prática';

  @override
  String get todayStartDelayAction => 'Iniciar adiamento';

  @override
  String get todayProTitle => 'Continue com o Patterns Pro';

  @override
  String get todayProBody =>
      'Crie um plano, pratique e reveja sua atividade ao longo do tempo.';

  @override
  String get todayHideSevenDays => 'Ocultar por 7 dias';

  @override
  String get todayPracticeProgress => 'Progresso da prática';

  @override
  String get todaySteadyPractice => 'Prática constante';

  @override
  String get todayStartGently => 'Comece com calma';

  @override
  String get todayPracticeActiveBody =>
      'Suas atividades registradas estão formando uma visão de longo prazo.';

  @override
  String get todayPracticeEmptyBody =>
      'Isso muda conforme você escreve, registra e pratica.';

  @override
  String get todayProgressDisclaimer =>
      'Isso reflete a frequência das práticas registradas, não um diagnóstico ou avaliação clínica. Um número menor pode ocorrer durante uma semana difícil.';

  @override
  String get todayProgressStartedTitle => 'Sua atividade está tomando forma';

  @override
  String get todayProgressPendingBody =>
      'Um número de progresso aparecerá depois que houver atividades registradas em mais de um dia.';

  @override
  String get todayScoreNew => 'Novo';

  @override
  String get todayScoreStrong => 'Forte';

  @override
  String get todayScoreSteady => 'Constante';

  @override
  String get todayScoreBuilding => 'Em construção';

  @override
  String get todayScoreStarting => 'Começando';

  @override
  String get todayBeginCheckIn => 'Comece com um pequeno check-in';

  @override
  String get todayNoChange => 'Sem mudança em relação ao período anterior';

  @override
  String todayPointsUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points pontos acima',
      one: '1 ponto acima',
    );
    return '$_temp0 do período anterior';
  }

  @override
  String todayPointsDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points pontos abaixo',
      one: '1 ponto abaixo',
    );
    return '$_temp0 do período anterior';
  }

  @override
  String get todayNextStep => 'Seu próximo passo';

  @override
  String get todayNextSelfCheckTitle => 'Veja como você está';

  @override
  String get todayNextSelfCheckBody =>
      'Uma autoavaliação pode registrar uma referência para comparação futura.';

  @override
  String get todayNextSelfCheckAction => 'Fazer autoavaliação';

  @override
  String get todayNextHierarchyTitle => 'Prepare sua prática';

  @override
  String get todayNextHierarchyBody =>
      'Monte uma escada de exposição, dos passos mais fáceis aos mais difíceis.';

  @override
  String get todayNextHierarchyAction => 'Montar escada';

  @override
  String get todayNextPracticeTitle => 'Escolha a prática de hoje';

  @override
  String get todayNextPracticeBody =>
      'Escolha um exercício de ERP possível para hoje.';

  @override
  String get todayNextPracticeAction => 'Iniciar prática';

  @override
  String get todayNextReflectTitle => 'Reflita sobre a prática';

  @override
  String get todayNextReflectBody =>
      'Registre o que você percebeu durante a prática de hoje.';

  @override
  String get todayNextReflectAction => 'Refletir';

  @override
  String get todayNextJournalTitle => 'Reflita sobre hoje';

  @override
  String get todayNextJournalBody =>
      'Escreva uma linha sobre o que percebeu na sua prática.';

  @override
  String get todayNextJournalAction => 'Abrir diário';

  @override
  String get todayCompulsionDelay => 'Adiamento de compulsão';

  @override
  String get todayStartErp => 'Iniciar prática de ERP';

  @override
  String get todayResistUrgeBody =>
      'Fique com o impulso antes de decidir o que fazer.';

  @override
  String get todayBuildToleranceBody =>
      'Pratique um passo possível no seu ritmo.';

  @override
  String get todayResumeAction => 'Retomar';

  @override
  String get todayStartAction => 'Iniciar';

  @override
  String get todayJournalBody => 'Escreva e reflita no seu diário privado.';

  @override
  String get todayExposureTools => 'Ferramentas de exposição';

  @override
  String get todayExposureToolsBody =>
      'Hierarquia, materiais e prática de incerteza.';

  @override
  String get todayInsightsBody => 'Reveja sua atividade registrada.';

  @override
  String get todaySelfCheckTitle => 'Entenda seus padrões';

  @override
  String get todaySelfCheckDuration => 'Opcional · cerca de 10 min';

  @override
  String get todayInsightsPlaceholder =>
      'Seus insights aparecerão aqui conforme você registrar atividades.';

  @override
  String get todayDailyCheckInComplete => 'Check-in diário registrado';

  @override
  String get todayDailyCheckIn => 'Check-in diário';

  @override
  String get todayDailyCompleteBody =>
      'Há uma entrada no diário registrada para hoje.';

  @override
  String get todayDailyBody =>
      'Escreva uma entrada curta quando estiver pronto.';

  @override
  String get todayOpenAction => 'Abrir';

  @override
  String get todayCheckInAction => 'Fazer check-in';

  @override
  String get todayRecoveryScore => 'Pontuação de recuperação';

  @override
  String todayActivitiesLastSevenDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atividades nos últimos 7 dias',
      one: '1 atividade nos últimos 7 dias',
    );
    return '$_temp0';
  }

  @override
  String get todayActivityRecorded =>
      'Calculado a partir da atividade registrada';

  @override
  String get todayPracticesRecorded => 'Práticas registradas';

  @override
  String get todayPracticeStreak => 'Sequência de prática';

  @override
  String todaySessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessões',
      one: '1 sessão',
    );
    return '$_temp0';
  }

  @override
  String todayDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String get todayPickUpBody =>
      'Continue a partir do tempo registrado anteriormente.';

  @override
  String get todayPracticeUrgesBody =>
      'Pratique esperar antes de responder a um impulso.';

  @override
  String get todayReadCheckIn => 'Ler o check-in de hoje';

  @override
  String get todayOpenJournalMore => 'Abra o Diário para ler ou adicionar mais';

  @override
  String get todayShortJournal => 'Escreva uma entrada curta no diário';

  @override
  String get todayExplore => 'Explorar';

  @override
  String get todayReflectProcess => 'Reflita e processe';

  @override
  String get todayRecoveryTools => 'Ferramentas de recuperação';

  @override
  String get todaySupportPractice => 'Apoie sua prática';

  @override
  String get todayTrackBody => 'Registre pensamentos e impulsos';

  @override
  String get todaySeePatterns => 'Reveja seus padrões registrados';

  @override
  String todayScoreA11y(int score, String label) {
    return 'Progresso da prática: $score de 100, $label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return 'Temporizador da prática: $elapsed decorridos de $planned';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day: atividade registrada';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day: nenhuma atividade registrada';
  }

  @override
  String get trackerTitle => 'Registrar';

  @override
  String get trackerPauseUrgeAction => 'Pausar antes de responder';

  @override
  String get trackerFilterGroupLabel => 'Filtrar momentos registrados';

  @override
  String get trackerFilterAll => 'Todos';

  @override
  String get trackerFilterObsessions => 'Obsessões';

  @override
  String get trackerFilterCompulsions => 'Compulsões';

  @override
  String get trackerLoadingLabel => 'Carregando momentos registrados';

  @override
  String get trackerLoadError =>
      'Não foi possível carregar seus momentos registrados. Tente novamente.';

  @override
  String get trackerEditTitle => 'Editar evento';

  @override
  String get trackerAddTitle => 'Registrar evento';

  @override
  String get trackerTypeGroupLabel => 'Tipo de evento';

  @override
  String get trackerTypeObsession => 'Obsessão';

  @override
  String get trackerTypeCompulsion => 'Compulsão';

  @override
  String get trackerThoughtLabel => 'O que o pensamento dizia?';

  @override
  String get trackerUrgeLabel => 'Qual era o impulso?';

  @override
  String get trackerThoughtHint => 'Descreva o pensamento ou a imagem.';

  @override
  String get trackerUrgeHint => 'Descreva o impulso ou a compulsão.';

  @override
  String get trackerActionLabel => 'O que o TOC levou você a fazer?';

  @override
  String get trackerActionHint => 'Uma anotação breve é suficiente.';

  @override
  String get trackerResponseLabel => 'O que você fez em vez disso';

  @override
  String get trackerResponseHint =>
      'Registre qualquer resposta que escolheu, inclusive um adiamento parcial.';

  @override
  String get trackerSavingAction => 'Salvando…';

  @override
  String get trackerUpdateAction => 'Atualizar evento';

  @override
  String get trackerSaveAction => 'Salvar evento';

  @override
  String get trackerContentRequired =>
      'Quando você se sentir pronto, escreva algumas palavras sobre o que aconteceu.';

  @override
  String get trackerSaveError =>
      'Não foi possível salvar seu evento. Tente novamente.';

  @override
  String get trackerUpdateError =>
      'Não foi possível atualizar seu evento. Tente novamente.';

  @override
  String get trackerEditTooltip => 'Editar evento';

  @override
  String get trackerDeleteTooltip => 'Excluir evento';

  @override
  String trackerDistressValue(int value) {
    return 'Desconforto $value de 10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => 'Nenhuma resposta registrada';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type. $date. Desconforto $distress de 10. $content. Resposta: $response';
  }

  @override
  String get trackerDeleteTitle => 'Excluir evento?';

  @override
  String get trackerDeleteBody =>
      'Isso remove o evento do histórico local neste dispositivo.';

  @override
  String get trackerDeleteAction => 'Excluir';

  @override
  String get trackerDeletedMessage => 'Evento excluído';

  @override
  String get trackerDeleteError =>
      'Não foi possível excluir seu evento. Tente novamente.';

  @override
  String get trackerDistressLabel => 'Desconforto, de 0 a 10';

  @override
  String get trackerEmptyTitle => 'Ainda não há eventos';

  @override
  String get trackerEmptyBody =>
      'Registre apenas o que parecer útil. Uma anotação breve é suficiente.';

  @override
  String get trackerEmptyAction => 'Registrar evento de TOC';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsExportReport => 'Exportar relatório';

  @override
  String get insightsObsessionsLogged => 'Obsessões registradas';

  @override
  String get insightsThemesFound => 'Temas encontrados';

  @override
  String get insightsCompulsions => 'Compulsões';

  @override
  String get insightsAverageIntensityShort => 'Intensidade média';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => 'Progresso da prática';

  @override
  String get insightsScoreNeedsMoreActivity =>
      'Uma pontuação aparece depois de algumas práticas em dias diferentes, para mostrar uma tendência em vez de um único momento. As sessões abaixo já estão sendo contadas.';

  @override
  String get insightsScoreEmpty =>
      'Uma pontuação aparecerá aqui depois de algumas práticas. Ainda não há nada para medir.';

  @override
  String insightsComparedPreviousDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'os $count dias anteriores',
      one: 'o dia anterior',
    );
    return 'em comparação com $_temp0';
  }

  @override
  String get insightsComparedPreviousRange =>
      'em comparação com o período anterior';

  @override
  String get insightsPracticeProgressBoundary =>
      'Reflete a frequência da prática, não um diagnóstico nem como você está clinicamente. Um número menor em uma semana difícil pode acontecer.';

  @override
  String get insightsMoodOverTime => 'Humor ao longo do tempo';

  @override
  String get insightsMoodGood => 'Bem';

  @override
  String get insightsMoodOkay => 'Razoável';

  @override
  String get insightsMoodLow => 'Baixo';

  @override
  String get insightsYbocsOverTime => 'Y-BOCS ao longo do tempo';

  @override
  String get insightsYbocsEmpty =>
      'Faça a autoavaliação e o total registrado iniciará uma linha aqui.';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return 'Faixa $severity. Faça a autoavaliação novamente em algumas semanas para adicionar outro ponto registrado.';
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
      other: '$count autoavaliações',
      one: '1 autoavaliação',
    );
    return 'em $_temp0';
  }

  @override
  String get insightsYbocsBoundary =>
      'É um retrato do momento, não um diagnóstico. Os totais registrados podem variar, e um total mais alto não define seu progresso.';

  @override
  String get insightsAverageUrgeIntensity => 'Intensidade média do impulso';

  @override
  String get insightsErpPractice => 'Prática de ERP';

  @override
  String insightsSessions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sessões',
      one: 'sessão',
    );
    return '$_temp0';
  }

  @override
  String get insightsConsistency => 'Consistência';

  @override
  String insightsActiveDays(int active, int total) {
    return '$active de $total dias';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return 'Atividade registrada em $active de $total dias';
  }

  @override
  String get insightsTopThemes => 'Principais temas';

  @override
  String get insightsThemesEmpty =>
      'Os temas aparecerão conforme você registrar o foco do TOC.';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme, $percent por cento dos temas registrados';
  }

  @override
  String get insightsChangeRange => 'Alterar período';

  @override
  String get insightsOverviewTab => 'Visão geral';

  @override
  String get insightsObsessionsTab => 'Obsessões';

  @override
  String get insightsCompulsionsTab => 'Compulsões';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ aumento de $value, $comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ redução de $value, $comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ Sem mudança, $comparison';
  }

  @override
  String get insightsNoData => 'Ainda não há dados';

  @override
  String get insightsLoading => 'Carregando insights';

  @override
  String get insightsLoadError =>
      'Não foi possível carregar seus insights. Tente novamente.';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date: $value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title. Pontos registrados: $values';
  }

  @override
  String get ybocsSeveritySubclinical => 'Subclínica';

  @override
  String get ybocsSeverityMild => 'Leve';

  @override
  String get ybocsSeverityModerate => 'Moderada';

  @override
  String get ybocsSeveritySevere => 'Grave';

  @override
  String get ybocsSeverityExtreme => 'Extrema';

  @override
  String get insightsThemeContamination => 'Contaminação';

  @override
  String get insightsThemeHarm => 'Dano';

  @override
  String get insightsThemeChecking => 'Verificação';

  @override
  String get insightsThemeReassurance => 'Busca de confirmação';

  @override
  String get insightsThemeHealth => 'Saúde';

  @override
  String get insightsThemeRelationship => 'Relacionamento';

  @override
  String get insightsThemeSymmetry => 'Simetria';

  @override
  String get insightsThemeMoral => 'Moralidade';

  @override
  String get insightsThemeRumination => 'Ruminação';

  @override
  String get insightsThemeUncertainty => 'Incerteza';

  @override
  String get insightsThemeOther => 'Outro';
}
