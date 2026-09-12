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
      'Salve seus registros em um backup ZIP local';

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

  @override
  String get recoveryTitle => 'Recuperação';

  @override
  String get recoverySubtitle =>
      'Ferramentas e práticas agrupadas conforme o ponto em que você está.';

  @override
  String get recoveryImmediateHelpTitle => 'Apoio para um momento difícil';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Kit para momentos difíceis',
      'copingLibrary': 'Biblioteca de enfrentamento',
      'compulsionDelay': 'Adiar a compulsão',
      'ybocsSelfCheck': 'Autoavaliação de OCD',
      'recoveryMetrics': 'Atividade de recuperação',
      'exposureHierarchy': 'Hierarquia de exposição',
      'exposureMaterials': 'Materiais de exposição',
      'structuredPrograms': 'Programas estruturados',
      'actionPlanner': 'Plano de ação',
      'implementationIntentions': 'Planos se-então',
      'guidedErp': 'ERP guiada',
      'urgeSurfing': 'Surfar o impulso',
      'responsePrevention': 'Prevenção de resposta',
      'uncertaintyTraining': 'Prática da incerteza',
      'behavioralExperiments': 'Experimentos comportamentais',
      'reflectionJournal': 'Diário de reflexão',
      'other': 'Ferramenta de recuperação',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Apoio rápido para voltar ao presente.',
      'copingLibrary': 'Volte ao presente e recomece.',
      'compulsionDelay': 'Crie espaço antes de responder.',
      'ybocsSelfCheck': 'Um registro Y-BOCS.',
      'recoveryMetrics': 'Veja a atividade registrada.',
      'exposureHierarchy': 'Monte sua escada.',
      'exposureMaterials': 'Guarde roteiros e links.',
      'structuredPrograms': 'Siga semanas guiadas.',
      'actionPlanner': 'Planeje suas respostas.',
      'implementationIntentions': 'Crie planos se-então.',
      'guidedErp': 'Pratique um plano.',
      'urgeSurfing': 'Acompanhe a onda.',
      'responsePrevention': 'Registre o que você fez no lugar.',
      'uncertaintyTraining': 'Pratique dar espaço ao talvez.',
      'behavioralExperiments': 'Teste a previsão do OCD.',
      'reflectionJournal': 'Registre o que você percebeu.',
      'other': 'Abra uma ferramenta de recuperação.',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Avaliar',
      'plan': 'Planejar',
      'practice': 'Praticar',
      'review': 'Revisar',
      'other': 'Ferramentas',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Veja onde você está.',
      'plan': 'Prepare sua prática.',
      'practice': 'Faça uma prática.',
      'review': 'Reflita e aprenda.',
      'other': 'Escolha o que for útil.',
    });
    return '$_temp0';
  }

  @override
  String get recoveryProBadge => 'Patterns Pro';

  @override
  String recoveryOpenToolHint(String title) {
    return 'Abrir $title';
  }

  @override
  String recoveryLockedToolHint(String title) {
    return '$title requer Patterns Pro';
  }

  @override
  String get delayNameUrgeValidation =>
      'Quando quiser, dê um nome ao impulso com o qual você quer ficar.';

  @override
  String get delayOutcomeValidation =>
      'Quando quiser, escolha o que você acabou fazendo.';

  @override
  String get delaySaveError =>
      'Não foi possível salvar sua prática. Tente novamente.';

  @override
  String get delayStopEarlyTitle => 'Parar antes?';

  @override
  String get delayStopEarlyBody =>
      'Tudo bem parar. O tempo que você esperou ainda pode ser registrado.';

  @override
  String get delayKeepGoingAction => 'Continuar';

  @override
  String get delayStopAction => 'Preciso parar';

  @override
  String get delaySetupTitle => 'Pausar o impulso';

  @override
  String get delayUrgeQuestion => 'Com qual impulso você está ficando?';

  @override
  String get delayUrgeHint =>
      'Por exemplo: verificar a fechadura, lavar ou pesquisar online';

  @override
  String get delayUrgeBeforeLabel => 'Qual é a intensidade do impulso agora?';

  @override
  String get delayDurationQuestion => 'Quanto tempo você vai esperar?';

  @override
  String get delayDurationGroupLabel => 'Duração da espera';

  @override
  String get delayBeginAction => 'Começar';

  @override
  String get delayCountdownTitle => 'Você está dando espaço ao impulso';

  @override
  String get delayCountdownBody =>
      'Perceba o impulso sem agir. Você pode escolher o que acontece depois.';

  @override
  String get delayReflectionTitle => 'O que aconteceu?';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed':
          'O tempo planejado terminou. Os detalhes abaixo são opcionais.',
      'early':
          'Você encerrou o cronômetro antes. Os detalhes abaixo são opcionais.',
      'other': 'O cronômetro terminou. Os detalhes abaixo são opcionais.',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel => 'Qual é a intensidade do impulso agora?';

  @override
  String get delayOutcomeQuestion => 'O que você fez com o impulso?';

  @override
  String get delayOutcomeGroupLabel => 'Resultado registrado';

  @override
  String get delayNoteLabel => 'Percebeu alguma coisa? (opcional)';

  @override
  String get delayNoteHint => 'Uma nota curta é suficiente.';

  @override
  String get delaySavingAction => 'Salvando…';

  @override
  String get delaySaveAction => 'Salvar prática';

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
  String get delayCustomAction => 'Personalizar';

  @override
  String get delayCustomTitle => 'Espera personalizada';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Não fiz',
      'delayed': 'Adiei',
      'performed': 'Fiz',
      'other': 'Não selecionado',
    });
    return '$_temp0';
  }

  @override
  String delayUrgeValue(int value) {
    return 'Impulso $value de 10';
  }

  @override
  String delayCustomMinutesValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '1 minuto',
    );
    return 'Espera personalizada: $_temp0';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation':
          'Quando quiser, escolha o que aconteceu durante a prática.',
      'saveError':
          'Não foi possível salvar sua prática de ERP. Tente novamente.',
      'stopTitle': 'Parar antes?',
      'stopBody':
          'Tudo bem parar. O tempo que você praticou ainda pode ser registrado.',
      'keepGoing': 'Continuar',
      'stop': 'Parar',
      'anxietyBefore': 'Qual é a intensidade do impulso ou da ansiedade agora?',
      'duration': 'Duração',
      'start': 'Começar prática',
      'countdownCue': 'Pratique sem',
      'resisting': 'Resposta que você não está fazendo',
      'countdownBody':
          'Você não precisa provar que a previsão está errada antes de o cronômetro terminar.',
      'stopEarly': 'Parar antes',
      'reflectionTitle': 'Refletir',
      'reflectionBody':
          'Os detalhes abaixo são opcionais. Registre apenas o que parecer útil.',
      'anxietyAfter': 'Qual é a intensidade agora?',
      'outcomeQuestion': 'O que você fez?',
      'whatHappened': 'O que realmente aconteceu?',
      'whatHappenedHint': 'O que você percebeu durante ou depois da prática?',
      'learning': 'Para a próxima vez',
      'learningHint': 'O que você quer lembrar na próxima vez que o OCD pedir?',
      'exposure': 'Exposição',
      'prediction': 'Previsão',
      'commitment': 'Compromisso',
      'saving': 'Salvando…',
      'save': 'Salvar prática',
      'other': 'Prática de ERP',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'O tempo planejado terminou.',
      'early': 'Você encerrou o cronômetro antes.',
      'other': 'O cronômetro terminou.',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Não fiz a resposta',
      'delayed': 'Adiei a resposta',
      'performed': 'Fiz a resposta',
      'other': 'Não selecionado',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return 'Intensidade $value de 10';
  }

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'ERP guiada',
      'subtitle': 'Reutilize um plano, pratique e registre o que aconteceu.',
      'myPlans': 'Meus planos de ERP',
      'newAction': 'Novo',
      'plansError': 'Os planos de ERP não estão disponíveis agora.',
      'recentPractice': 'Práticas recentes',
      'historyError': 'O histórico de práticas não está disponível agora.',
      'archiveTitle': 'Arquivar este plano?',
      'archiveBody':
          'Ele sairá dos seus planos ativos, mas as práticas anteriores continuarão no histórico.',
      'keepAction': 'Manter',
      'archiveAction': 'Arquivar',
      'exposureValidation':
          'Quando quiser, descreva a situação com a qual deseja praticar.',
      'commitmentValidation':
          'Escolha a resposta que deseja praticar não fazer para salvar o plano.',
      'saveError': 'Não foi possível salvar seu plano de ERP. Tente novamente.',
      'updated': 'Plano de ERP atualizado.',
      'created': 'Plano de ERP criado.',
      'editTitle': 'Editar plano de ERP',
      'createTitle': 'Criar plano de ERP',
      'exerciseType': 'Tipo de exercício',
      'exposureTarget': 'Alvo da exposição',
      'ocdPrediction': 'Previsão do TOC',
      'preventionCommitment': 'Compromisso de prevenção de resposta',
      'defaultDuration': 'Duração padrão',
      'saving': 'Salvando…',
      'saveAction': 'Salvar plano',
      'createAction': 'Criar plano',
      'emptyTitle': 'Crie seu primeiro plano de ERP',
      'emptyBody':
          'Escreva uma vez a exposição, a previsão e a resposta que deseja praticar não fazer. Depois, reutilize o plano quando precisar.',
      'moreActions': 'Mais ações do plano',
      'editAction': 'Editar plano',
      'archivePlanAction': 'Arquivar plano',
      'practiceGuide': 'Guia da prática',
      'historyEmpty': 'As práticas concluídas aparecerão aqui.',
      'customDuration': 'Duração personalizada',
      'other': 'Plano de ERP',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return 'Não fazer: $response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction =>
      'O TOC diz que o desconforto não vai mudar se você não responder.';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Adiar a verificação',
      'delayReassurance': 'Adiar a busca por reafirmação',
      'delayGoogling': 'Adiar a pesquisa na internet',
      'delayRumination': 'Adiar a ruminação',
      'delayWashing': 'Adiar a lavagem',
      'other': 'ERP guiada',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Pratique deixar algo sem verificar por um curto período.',
      'delayReassurance':
          'Espere antes de pedir a alguém que elimine a incerteza.',
      'delayGoogling': 'Adie a busca por certeza ou provas.',
      'delayRumination':
          'Perceba a resolução mental de problemas sem segui-la.',
      'delayWashing': 'Espere antes de lavar, limpar ou higienizar novamente.',
      'other': 'Pratique adiar uma resposta.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Crie um plano reutilizável para quando o TOC pressionar você a verificar novamente fechaduras, interruptores, mensagens, sintomas ou erros.',
      'delayReassurance':
          'Crie um plano para a vontade de perguntar, confessar, explicar ou pedir que alguém confirme que está tudo bem.',
      'delayGoogling':
          'Crie um plano para quando o TOC quiser que você pesquise sintomas, significados, riscos, regras ou relatos até sentir certeza.',
      'delayRumination':
          'Crie um plano para compulsões mentais como repassar, provar, revisar ou resolver.',
      'delayWashing':
          'Crie um plano para a vontade de lavar, limpar, higienizar ou recomeçar porque algo parece contaminado.',
      'other': 'Crie um plano reutilizável de prática de ERP.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'A ERP permite praticar com a incerteza presente sem fazer um ritual imediatamente.',
      'delayReassurance':
          'A reafirmação pode parecer útil no momento; adiá-la permite praticar sem saber com certeza.',
      'delayGoogling':
          'Adiar a pesquisa interrompe o ciclo de certeza e permite praticar deixando uma pergunta sem resposta.',
      'delayRumination':
          'A ruminação pode parecer pensamento; a ERP permite praticar sair do ciclo sem terminar o argumento.',
      'delayWashing':
          'Esperar permite praticar com a sensação de contaminação presente sem fazer um ritual imediatamente.',
      'other': 'A ERP permite dar espaço à incerteza sem um ritual imediato.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure':
          'O que você deixará sem verificar ou verificará apenas uma vez?',
      'delayCheckingPrediction':
          'O que o TOC prevê se você não verificar novamente?',
      'delayCheckingCommitment':
          'Qual ritual de verificação você praticará não fazer?',
      'delayReassuranceExposure': 'Que reafirmação você quer pedir?',
      'delayReassurancePrediction':
          'O que o TOC diz que acontecerá se você não perguntar?',
      'delayReassuranceCommitment':
          'Que mensagem, confissão ou pergunta você evitará?',
      'delayGooglingExposure':
          'Que pesquisa ou pergunta você deixará sem resposta?',
      'delayGooglingPrediction':
          'O que o TOC diz que você precisa saber agora?',
      'delayGooglingCommitment': 'Que pesquisa, artigo ou fórum você evitará?',
      'delayRuminationExposure':
          'Que ciclo de pensamento você deixará inacabado?',
      'delayRuminationPrediction':
          'O que o TOC diz que você precisa resolver ou provar?',
      'delayRuminationCommitment':
          'Que revisão mental ou argumento você evitará?',
      'delayWashingExposure': 'Qual limite normal de higiene você seguirá?',
      'delayWashingPrediction':
          'O que o TOC prevê se você não lavar novamente?',
      'delayWashingCommitment':
          'Que lavagem, limpeza ou higienização extra você evitará?',
      'other': 'Que resposta você praticará não fazer?',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Defina uma regra de verificação antes de começar.',
      'delayChecking2':
          'Faça a verificação planejada uma vez se ela fizer parte da segurança normal.',
      'delayChecking3':
          'Evite verificar novamente enquanto o cronômetro estiver ativo.',
      'delayChecking4': 'Perceba a vontade sem negociar com ela.',
      'delayReassurance1': 'Defina o pedido de reafirmação antes de começar.',
      'delayReassurance2':
          'Não envie a mensagem nem faça a pergunta durante o cronômetro.',
      'delayReassurance3': 'Deixe o desconforto presente sem buscar certeza.',
      'delayReassurance4':
          'Volte ao que estava fazendo da forma mais gentil possível.',
      'delayGoogling1':
          'Defina a pesquisa antes de abrir qualquer outra coisa.',
      'delayGoogling2': 'Feche a caixa de pesquisa ou a aba do navegador.',
      'delayGoogling3':
          'Inicie o cronômetro antes de ler qualquer outra coisa.',
      'delayGoogling4': 'Deixe a pergunta sem resposta por enquanto.',
      'delayRumination1':
          'Nomeie o ciclo: revisar, resolver, provar ou verificar.',
      'delayRumination2': 'Deixe o pensamento inacabado.',
      'delayRumination3':
          'Leve a atenção de volta a uma tarefa ou sensação comum.',
      'delayRumination4':
          'Recomece com gentileza sempre que o ciclo puxar você de volta.',
      'delayWashing1': 'Defina o limite normal de higiene antes de começar.',
      'delayWashing2':
          'Comece com um adiamento que pareça desafiador, mas possível.',
      'delayWashing3':
          'Mantenha as mãos longe da pia ou do higienizador durante o cronômetro.',
      'delayWashing4':
          'Deixe o desconforto presente sem tentar torná-lo perfeito.',
      'other': 'Siga o plano que você escolheu.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Verificar uma vez',
      'delayChecking2': 'Não reverificar',
      'delayChecking3': 'Perceber a vontade',
      'delayReassurance1': 'Segurar a pergunta',
      'delayReassurance2': 'Deixar a incerteza',
      'delayReassurance3': 'Voltar com gentileza',
      'delayGoogling1': 'Fechar a pesquisa',
      'delayGoogling2': 'Iniciar cronômetro',
      'delayGoogling3': 'Deixar sem resposta',
      'delayRumination1': 'Nomear o ciclo',
      'delayRumination2': 'Deixar inacabado',
      'delayRumination3': 'Voltar à tarefa',
      'delayWashing1': 'Definir o limite',
      'delayWashing2': 'Adiar a lavagem',
      'delayWashing3': 'Permitir o desconforto',
      'other': 'Seguir o plano',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Programas estruturados',
      'subtitle': 'Siga um plano guiado, semana a semana, no seu ritmo.',
      'themeGroup': 'Por tema de TOC',
      'themeGroupEmpty':
          'Escolha um tema se ele combinar com o que você quer praticar.',
      'themeGroupMatched':
          'Os temas registrados na sua última autoavaliação estão sinalizados abaixo.',
      'generalGroup': 'Prática geral',
      'generalCaption': 'Habilidades que podem ser usadas em diferentes temas.',
      'enrollError': 'Não foi possível abrir este programa. Tente novamente.',
      'started': 'Iniciado',
      'notStarted': 'Não iniciado',
      'openHint': 'Abrir detalhes do programa',
      'selfCheckMatch': 'Corresponde à sua autoavaliação',
      'tapToStart': 'Toque para começar',
      'progressLoadError':
          'Não foi possível carregar a atividade do programa. Tente novamente.',
      'activityRecorded':
          'Suas escolhas de tarefas são registradas localmente.',
      'taskSaveError':
          'Não foi possível salvar esta alteração. Tente novamente.',
      'weekComplete': 'Todas as tarefas estão marcadas como concluídas',
      'weekNotComplete': 'Há tarefas restantes',
      'weekToggleHint': 'Expandir ou recolher esta semana',
      'taskToggleHint': 'Marcar ou desmarcar esta tarefa',
      'other': 'Programa',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$done de $total tarefas, $percent por cento';
  }

  @override
  String structuredProgramSummary(int count, String subtitle) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas · $subtitle',
      one: '1 semana · $subtitle',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramComplete(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'As $count tarefas estão marcadas como concluídas.',
      one: 'A tarefa está marcada como concluída.',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$done de $total tarefas marcadas como concluídas';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String exposureHierarchyText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Hierarquia de exposição',
      'newAction': 'Nova',
      'subtitle':
          'Crie uma escala de possíveis exposições e pratique um passo de cada vez.',
      'loadError':
          'Suas hierarquias não estão disponíveis agora. Tente novamente.',
      'archiveTitle': 'Arquivar esta hierarquia?',
      'archiveBody':
          'Isso remove a hierarquia da sua lista ativa. Os passos salvos permanecem neste dispositivo.',
      'keepAction': 'Manter',
      'archiveAction': 'Arquivar',
      'archiveSuccess': 'Hierarquia arquivada.',
      'archiveError':
          'Não foi possível arquivar esta hierarquia. Tente novamente.',
      'emptyTitle': 'Crie sua primeira escala',
      'emptyBody':
          'Liste possíveis exposições da mais fácil à mais difícil e escolha seu próprio ritmo.',
      'buildAction': 'Criar uma hierarquia',
      'newTitle': 'Nova hierarquia',
      'nameLabel': 'Nome',
      'nameHint': 'Por exemplo, tocar maçanetas',
      'themeLabel': 'Tema (opcional)',
      'themeHint': 'Por exemplo, contaminação',
      'generalTheme': 'Geral',
      'stepsTitle': 'Passos, os mais fáceis primeiro',
      'addAction': 'Adicionar',
      'createAction': 'Criar hierarquia',
      'saving': 'Salvando…',
      'titleValidation': 'Adicione um nome para esta escala.',
      'stepValidation': 'Adicione pelo menos um passo de exposição.',
      'createSuccess': 'Hierarquia salva.',
      'createError':
          'Não foi possível salvar esta hierarquia. Tente novamente.',
      'stepHint': 'Que exposição você poderia praticar?',
      'difficulty': 'Dificuldade',
      'anxiety': 'Ansiedade prevista',
      'materialAction': 'Material',
      'statusNotStarted': 'Não iniciado',
      'statusInProgress': 'Em andamento',
      'statusDone': 'Concluído',
      'statusError':
          'Não foi possível salvar o estado deste passo. Tente novamente.',
      'moveUp': 'Mover passo para cima',
      'moveDown': 'Mover passo para baixo',
      'removeStep': 'Remover passo',
      'openHierarchy': 'Abrir hierarquia',
      'archiveHierarchy': 'Arquivar hierarquia',
      'other': 'Hierarquia de exposição',
    });
    return '$_temp0';
  }

  @override
  String exposureHierarchySummary(int done, int count, String theme) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$done de $count passos · $theme',
      one: '$done de 1 passo · $theme',
      zero: '$theme',
    );
    return '$_temp0';
  }

  @override
  String exposureStepLabel(int number) {
    return 'Passo $number';
  }

  @override
  String exposureRating(int value) {
    return '$value de 10';
  }

  @override
  String exposureStepMetrics(int difficulty, int anxiety) {
    return 'Dificuldade $difficulty de 10 · Ansiedade prevista $anxiety de 10';
  }

  @override
  String exposureProgress(int percent) {
    return '$percent% dos passos marcados como concluídos';
  }

  @override
  String exposureMaterialsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Materiais de exposição',
      'newAction': 'Novo',
      'subtitle':
          'Mantenha roteiros, gravações em loop, imagens e links juntos para usar durante uma exposição.',
      'loadError':
          'Seus materiais não estão disponíveis agora. Tente novamente.',
      'typeScript': 'Roteiro',
      'typeLoopTape': 'Gravação em loop',
      'typeImage': 'Imagem',
      'typeLink': 'Link',
      'deleteTitle': 'Excluir este material?',
      'deleteBody':
          'Isso remove o material deste dispositivo, incluindo o arquivo armazenado, se houver.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir material',
      'deleteSuccess': 'Material excluído.',
      'deleteError': 'Não foi possível excluir este material. Tente novamente.',
      'emptyTitle': 'Reúna seus materiais',
      'emptyBody':
          'Salve um roteiro, uma gravação em loop, uma imagem ou um link para uma exposição escolhida por você.',
      'addAction': 'Adicionar material',
      'readScript': 'Ler roteiro',
      'openLink': 'Abrir link',
      'viewImage': 'Ver imagem',
      'linkError': 'Não foi possível abrir esse link.',
      'imageMissing': 'Esta imagem não está mais disponível neste dispositivo.',
      'recordingMissing':
          'Esta gravação não está mais disponível neste dispositivo.',
      'stop': 'Parar',
      'playLoop': 'Reproduzir loop',
      'microphoneNeeded':
          'O acesso ao microfone é necessário para gravar um loop. Você pode mudar isso nas configurações do dispositivo.',
      'nameValidation': 'Adicione um nome para este material.',
      'scriptValidation': 'Adicione o texto do roteiro.',
      'linkValidation': 'Cole um link.',
      'imageValidation': 'Escolha uma imagem.',
      'recordingValidation': 'Grave um loop antes de salvar.',
      'saveSuccess': 'Material salvo.',
      'saveError': 'Não foi possível salvar este material. Tente novamente.',
      'titleLabel': 'Título',
      'titleHint': 'Um nome curto que você reconhecerá',
      'saveAction': 'Salvar material',
      'scriptLabel': 'Roteiro',
      'scriptHint': 'O texto que você quer ler durante a exposição',
      'linkLabel': 'Link',
      'pickImage': 'Escolher imagem',
      'changeImage': 'Trocar imagem',
      'rerecord': 'Gravar novamente',
      'recorderHint': 'Grave um trecho curto para repetir em loop.',
      'record': 'Gravar',
      'recording': 'Gravando',
      'other': 'Material de exposição',
    });
    return '$_temp0';
  }

  @override
  String exposureMaterialEditorTitle(String type) {
    return 'Novo: $type';
  }

  @override
  String exposureRecordingSeconds(int seconds) {
    return 'Gravando · $seconds s';
  }

  @override
  String responsePreventionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Prevenção de resposta',
      'logAction': 'Registrar',
      'subtitle':
          'Registre o gatilho, a resposta que você escolheu e o desconforto naquele momento.',
      'loadError':
          'Seus registros de resposta não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este registro de resposta?',
      'deleteBody': 'Isso remove o registro permanentemente deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir registro de resposta',
      'deleteSuccess': 'Registro de resposta excluído.',
      'deleteError':
          'Não foi possível excluir este registro de resposta. Tente novamente.',
      'outcomeResisted': 'Não realizada',
      'outcomeDelayed': 'Adiada',
      'outcomePartial': 'Realizada em parte',
      'outcomePerformed': 'Realizada',
      'emptyTitle': 'Registre uma resposta',
      'emptyBody':
          'Depois de um gatilho, registre o que você escolheu e o desconforto que percebeu.',
      'emptyAction': 'Registrar uma resposta',
      'editorTitle': 'Registrar uma resposta',
      'situationLabel': 'O que desencadeou isso?',
      'situationHint': 'O gatilho e a resposta que o TOC sugeriu',
      'outcomeQuestion': 'O que você fez?',
      'distressLabel': 'Desconforto naquele momento',
      'noteLabel': 'Observação (opcional)',
      'noteHint': 'Algo que você queira lembrar',
      'saveAction': 'Salvar registro',
      'situationValidation': 'Adicione uma breve descrição do gatilho.',
      'saveSuccess': 'Registro de resposta salvo.',
      'saveError':
          'Não foi possível salvar este registro de resposta. Tente novamente.',
      'other': 'Prevenção de resposta',
    });
    return '$_temp0';
  }

  @override
  String responsePreventionDistress(int value) {
    return 'Desconforto $value de 10';
  }

  @override
  String responsePreventionLogSummary(
    String outcome,
    String date,
    int distress,
    String situation,
  ) {
    return '$outcome · $date · desconforto $distress de 10 · $situation';
  }

  @override
  String urgeSurfText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Surfar o impulso',
      'subtitle':
          'Observe um impulso pelo tempo que você escolher, sem precisar mudá-lo ou agir em resposta.',
      'startAction': 'Começar',
      'historyTitle': 'Sessões anteriores',
      'emptyHistory':
          'Ainda não há sessões salvas. Uma sessão registrada aparecerá aqui.',
      'loadError':
          'Suas sessões salvas não estão disponíveis agora. Tente novamente.',
      'triggerFallback': 'Um impulso',
      'setupTitle': 'Antes de começar',
      'triggerLabel': 'Qual é o impulso? (opcional)',
      'triggerHint': 'Por exemplo, o impulso de lavar as mãos novamente',
      'initialUrgeLabel': 'Impulso no início',
      'durationQuestion': 'Por quanto tempo você quer observá-lo?',
      'begin': 'Começar',
      'surfingTitle': 'Observe o impulso',
      'surfingBody':
          'Perceba pensamentos e sensações e escolha o que fazer a seguir. Você pode parar a qualquer momento.',
      'currentUrgeLabel': 'Impulso agora',
      'doneAction': 'Concluir por enquanto',
      'reflectionTitle': 'Registre o que percebeu',
      'waveTitle': 'Níveis de impulso registrados',
      'finalUrgeLabel': 'Impulso no fim',
      'noteLabel': 'Observação (opcional)',
      'noteHint': 'O que você percebeu?',
      'saveAction': 'Salvar sessão',
      'finishAction': 'Concluir',
      'saveSuccess': 'Sessão salva.',
      'finishSuccess': 'Prática concluída.',
      'saveError': 'Não foi possível salvar esta sessão. Tente novamente.',
      'timerComplete': 'Tempo de observação concluído.',
      'other': 'Surfar o impulso',
    });
    return '$_temp0';
  }

  @override
  String urgeSurfRating(int value) {
    return 'Impulso $value de 10';
  }

  @override
  String urgeSurfDuration(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minutos',
      one: '1 minuto',
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
    return 'Início em $initial de 10 · maior valor registrado $peak de 10 · fim em $finalLevel de 10 · $duration';
  }

  @override
  String urgeSurfSessionSemantics(String trigger, String date, String summary) {
    return '$trigger · $date · $summary';
  }

  @override
  String urgeSurfWaveSummary(int initial, int peak) {
    return 'Início em $initial de 10 · maior valor registrado $peak de 10';
  }

  @override
  String urgeSurfTimerDisplay(int minutes, String seconds) {
    return '$minutes:$seconds';
  }

  @override
  String urgeSurfTimeRemaining(int minutes, int seconds) {
    return 'Restam $minutes min e $seconds s';
  }

  @override
  String emergencyToolkitText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Apoio para este momento',
      'pauseTitle': 'Faça uma pausa antes de responder',
      'pauseBody':
          'Você não precisa responder ao impulso imediatamente. Escolha um exercício de autoajuda abaixo e vá devagar.',
      'boundary':
          'Estas ferramentas não oferecem atendimento clínico ou de emergência. Se houver perigo imediato, entre em contato com os serviços de emergência locais.',
      'breathe': 'Respirar',
      'breatheSubtitle': 'Siga um ciclo de respiração ritmada',
      'delay': 'Adiar o impulso',
      'delaySubtitle': 'Crie espaço com um temporizador',
      'surf': 'Observar o impulso',
      'surfSubtitle': 'Perceba o impulso sem agir',
      'coping': 'Técnicas de enfrentamento',
      'copingSubtitle': 'Aterramento, aceitação e mais',
      'remindersTitle': 'Alguns lembretes',
      'reminderThought':
          'Um pensamento não exige uma resposta. Posso percebê-lo sem agir.',
      'reminderUrge':
          'Um impulso pode mudar com o tempo. Posso escolher o que fazer em seguida.',
      'reminderUncertainty':
          'Posso abrir espaço para a incerteza neste momento.',
      'breatheIn': 'Inspire',
      'hold': 'Segure',
      'breatheOut': 'Expire',
      'breathingHint':
          'Siga o círculo: inspire por 4 segundos, segure, expire por 4 segundos e segure.',
      'other': 'Ferramenta de apoio',
    });
    return '$_temp0';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Autoavaliação de TOC',
      'introBody':
          'Uma autoavaliação guiada baseada na Escala Obsessivo-Compulsiva de Yale-Brown (Y-BOCS), sobre os padrões que você percebe e o quanto eles afetam você.',
      'spotTitle': 'Observe os padrões',
      'spotBody': 'Selecione obsessões e compulsões que você já vivenciou.',
      'impactTitle': 'Registre o impacto',
      'impactBody':
          'Responda a 10 perguntas sobre o quanto elas afetam o seu dia.',
      'resultIntroTitle': 'Veja o resultado',
      'resultIntroBody':
          'Confira os temas, subtotais e a faixa de gravidade registrados.',
      'begin': 'Começar',
      'retakeAction': 'Fazer novamente',
      'privacyDuration':
          'Leva cerca de 10 minutos. Suas respostas ficam neste dispositivo, a menos que você escolha exportá-las.',
      'disclaimer':
          'Esta autoavaliação pode ajudar você a descrever sua experiência. Ela não diagnostica TOC nem oferece apoio de emergência. Somente um profissional qualificado pode diagnosticar TOC.',
      'historyTitle': 'Seu histórico',
      'historyBody': 'Seus totais registrados anteriormente aparecem aqui.',
      'deleteTitle': 'Excluir avaliação?',
      'deleteBody':
          'Isso remove permanentemente esta avaliação deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir avaliação',
      'deleteSuccess': 'Avaliação excluída.',
      'deleteError':
          'Não foi possível excluir esta avaliação. Tente novamente.',
      'checklistTitle': 'O que parece familiar?',
      'checklistBody':
          'Selecione qualquer experiência atual ou passada. Ignore o que não se aplica.',
      'obsessions': 'Obsessões',
      'obsessionsDescription': 'Pensamentos, imagens ou impulsos indesejados',
      'compulsions': 'Compulsões',
      'compulsionsDescription':
          'Comportamentos ou atos mentais realizados em resposta ao sofrimento',
      'continueAction': 'Continuar',
      'seeResults': 'Ver resultado',
      'next': 'Avançar',
      'resultsTitle': 'Seu resultado',
      'retake': 'Refazer',
      'saved': 'Salvo',
      'saveHistory': 'Salvar no meu histórico',
      'saving': 'Salvando…',
      'saveSuccess': 'Salvo no seu histórico.',
      'saveError': 'Não foi possível salvar esta avaliação. Tente novamente.',
      'breakdownTitle': 'Subtotais registrados',
      'typesTitle': 'Tipos registrados',
      'typesNone':
          'Nenhum tipo de obsessão ou compulsão foi registrado nesta autoavaliação.',
      'typesBoth':
          'Obsessões e compulsões foram registradas nesta autoavaliação.',
      'typesObsessions': 'Obsessões foram registradas nesta autoavaliação.',
      'typesCompulsions': 'Compulsões foram registradas nesta autoavaliação.',
      'themesTitle': 'Temas registrados',
      'themesBody': 'As categorias da lista que contêm os itens selecionados.',
      'nextStepsTitle': 'Sobre este resultado',
      'nextStepsBody':
          'Este resultado é um retrato autorrelatado, não um diagnóstico nem apoio de emergência. Se esses padrões afetam sua vida, você pode conversar com um profissional qualificado. Se houver perigo imediato, entre em contato com os serviços de emergência locais.',
      'other': 'Autoavaliação Y-BOCS',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuar · $count selecionados',
      one: 'Continuar · 1 selecionado',
      zero: 'Continuar',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return 'Pergunta $current de $total';
  }

  @override
  String ybocsScoreOutOf(int score, int maximum) {
    return '$score de $maximum';
  }

  @override
  String ybocsHistorySummary(String severity, int score, String date) {
    return '$severity · $score de 40 · $date';
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
      other: '$count itens selecionados',
      one: '1 item selecionado',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Tarefa marcada como concluída.',
      'notCompleted': 'Tarefa marcada como não concluída.',
      'other': 'Tarefa atualizada.',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Adiamento de compulsões em 4 semanas',
      'uncertainty3wk': 'Tolerância à incerteza',
      'other': 'Programa estruturado',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Pratique adiar compulsões, uma semana de cada vez',
      'uncertainty3wk': 'Pratique viver sem ter certeza',
      'other': 'Um plano de prática guiado',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': 'Semana 1 · Perceber e nomear',
      'delayW2': 'Semana 2 · Aumentar o intervalo',
      'delayW3': 'Semana 3 · Esperar mais',
      'delayW4': 'Semana 4 · Prática diária',
      'uncertaintyW1': 'Semana 1 · Deixar em aberto',
      'uncertaintyW2': 'Semana 2 · Talvez sim, talvez não',
      'uncertaintyW3': 'Semana 3 · Deixar estar',
      'other': 'Semana do programa',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': 'Registre 3 vontades sem agir imediatamente',
      'w1b': 'Adie uma compulsão por 1 minuto, 3 vezes',
      'w2a': 'Adie compulsões por 5 minutos',
      'w2b': 'Experimente uma vez observar a vontade como uma onda',
      'w3a': 'Adie a resposta por 15 minutos',
      'w3b': 'Resista uma vez à vontade de buscar reafirmação',
      'w4a': 'Faça uma exposição por dia',
      'w4b': 'Reflita sobre o que você percebeu',
      'u1a': 'Deixe uma pergunta sem resposta',
      'u1b': 'Resista a verificar uma vez',
      'u2a': 'Use uma resposta “talvez sim, talvez não” 3 vezes',
      'u2b': 'Adie a pesquisa online sobre uma preocupação',
      'u3a': 'Passe um dia sem buscar certeza',
      'u3b': 'Reflita sobre o que você percebeu',
      'other': 'Tarefa do programa',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contaminação e lavagem',
      'checking': 'Verificação e dúvida',
      'harm': 'Dano e pensamentos tabu',
      'relationship': 'Dúvidas no relacionamento',
      'justRight': 'Sensação de exatidão e simetria',
      'other': 'Tema de TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination':
          'Para medos de que algo esteja sujo, seja contagioso ou não seja seguro tocar, e para a lavagem ou limpeza que vem depois.',
      'checking':
          'Para fechaduras, fogões, interruptores, mensagens e outras coisas que você verifica novamente porque não parecem certas o bastante.',
      'harm':
          'Para pensamentos intrusivos sobre dano ou temas que parecem violentos, sexuais ou blasfemos, e para as compulsões ou a evitação que vêm depois.',
      'relationship':
          'Para dúvidas recorrentes sobre se um relacionamento é certo, se você sente o bastante ou o que a dúvida significa.',
      'justRight':
          'Para coisas que parecem precisar estar iguais, ordenadas ou ser repetidas até parecerem certas.',
      'other': 'Uma trilha de prática organizada em torno de um tema de TOC.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contaminação',
      'checking': 'Verificação',
      'harm': 'Dano e pensamentos tabu',
      'relationship': 'Dúvidas no relacionamento',
      'justRight': 'Sensação de exatidão',
      'other': 'Tema de TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'A lista Y-BOCS é anterior às pesquisas sobre TOC de relacionamento, por isso esse tema não aparece entre as categorias. Você ainda pode usar esta trilha de prática.',
      'other': 'Este tema não aparece como uma categoria da lista Y-BOCS.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': 'Semana 1 · Tocar e esperar',
      'ct2': 'Semana 2 · Uma lavagem, não três',
      'ct3': 'Semana 3 · Levar para casa',
      'ck1': 'Semana 1 · Olhar uma vez',
      'ck2': 'Semana 2 · Sem revisão mental',
      'ck3': 'Semana 3 · Deixar sem resolver',
      'hm1': 'Semana 1 · Deixar estar',
      'hm2': 'Semana 2 · Parar de perguntar',
      'hm3': 'Semana 3 · Sem julgamento interno',
      'rl1': 'Semana 1 · Parar de testar',
      'rl2': 'Semana 2 · Sem buscar reafirmação',
      'rl3': 'Semana 3 · Viver com o talvez',
      'jr1': 'Semana 1 · Deixar torto',
      'jr2': 'Semana 2 · Sem repetir',
      'jr3': 'Semana 3 · Bom o suficiente',
      'other': 'Semana da trilha',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a':
          'Toque em algo que pareça um pouco sujo e espere cinco minutos antes de lavar as mãos',
      'ct1b': 'Registre a vontade antes e depois sem lavar',
      'ct2a': 'Lave uma vez, normalmente, e não volte para uma segunda rodada',
      'ct2b': 'Deixe uma superfície de casa sem limpar durante a semana',
      'ct3a':
          'Vá a um lugar que costuma levar você a se lavar depois e não se lave ao chegar em casa',
      'ct3b': 'Anote o que o TOC previu ao lado do que aconteceu',
      'ck1a': 'Verifique uma coisa uma vez e se afaste sem olhar de novo',
      'ck1b': 'Saia de casa uma vez sem fazer uma inspeção final dos cômodos',
      'ck2a':
          'Quando vier a vontade de rever a memória, deixe a dúvida sem resposta',
      'ck2b': 'Envie uma mensagem sem reler antes ou depois',
      'ck3a': 'Passe um dia sem voltar para verificar nada duas vezes',
      'ck3b': 'Anote o que aconteceu e o que o TOC previu',
      'hm1a':
          'Deixe um pensamento intrusivo presente por um minuto sem discutir com ele nem afastá-lo',
      'hm1b': 'Perceba a revisão mental antes de começar e deixe-a quieta',
      'hm2a':
          'Resista a perguntar se você é uma boa pessoa e também não procure uma resposta',
      'hm2b':
          'Permaneça em uma situação que você vinha evitando por causa do pensamento',
      'hm3a':
          'Passe um dia sem verificar seus sentimentos em busca de provas sobre você',
      'hm3b': 'Anote como foi a semana sem se avaliar',
      'rl1a':
          'Perceba um teste de compatibilidade que você usa e deixe de fazê-lo uma vez',
      'rl1b':
          'Deixe uma dúvida sobre o relacionamento sem resposta por dez minutos',
      'rl2a':
          'Passe um dia sem perguntar ao seu par, a uma amizade ou à internet se o relacionamento é certo',
      'rl2b':
          'Façam algo juntos sem monitorar como você se sente durante a atividade',
      'rl3a':
          'Use uma resposta “talvez sim, talvez não” quando a pergunta vier',
      'rl3b': 'Reflita sobre a semana sem tomar uma decisão sobre o futuro',
      'jr1a':
          'Deixe um objeto um pouco fora do lugar e permita que a sensação esteja presente',
      'jr1b': 'Faça algo uma vez mesmo que não pareça terminado',
      'jr2a': 'Resista a repetir uma ação para que ela pareça certa',
      'jr2b': 'Escreva algo sem voltar para deixar a redação uniforme',
      'jr3a': 'Passe um dia deixando várias coisas deliberadamente inacabadas',
      'jr3b':
          'Registre o que aconteceu com a sensação de que algo não estava certo sem mudá-la',
      'other': 'Tarefa da trilha',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time': 'Quanto do meu tempo é ocupado por pensamentos obsessivos?',
      'o_interfere': 'Quanto as obsessões interferem na minha vida?',
      'o_distress': 'Quanto sofrimento os pensamentos obsessivos me causam?',
      'o_resist': 'Quanto tento resistir aos pensamentos obsessivos?',
      'o_control': 'Quanto controle tenho sobre os pensamentos obsessivos?',
      'c_time':
          'Quanto tempo passo em compulsões, como rituais ou verificações?',
      'c_interfere': 'Quanto as compulsões interferem na minha vida?',
      'c_distress':
          'Quão ansioso ou perturbado eu me sentiria se não pudesse realizar a compulsão?',
      'c_resist': 'Quanto tento resistir às compulsões?',
      'c_control': 'Quanto controle tenho sobre as compulsões?',
      'other': 'Pergunta da autoavaliação',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'Nenhum',
      'o_time_1': 'Pouco: menos de uma hora por dia ou algumas vezes',
      'o_time_2': 'Moderado: de 1 a 3 horas por dia ou intrusões frequentes',
      'o_time_3': 'Muito: de 3 a 8 horas por dia ou intrusões muito frequentes',
      'o_time_4': 'Quase constante: mais de 8 horas por dia',
      'o_interfere_0': 'Nada',
      'o_interfere_1': 'Pouco: quase não afetam o que faço',
      'o_interfere_2': 'Um pouco: interferem, mas ainda consigo lidar',
      'o_interfere_3': 'Muito: atrapalham claramente o meu dia',
      'o_interfere_4': 'Tanto que mal consigo funcionar',
      'o_distress_0': 'Nenhum',
      'o_distress_1': 'Pouco: não muito perturbador',
      'o_distress_2': 'Moderado: perturbador, mas administrável',
      'o_distress_3': 'Muito: muito perturbador',
      'o_distress_4': 'Sofrimento quase constante e incapacitante',
      'o_resist_0': 'Sempre tento resistir, ou quase não acontecem',
      'o_resist_1': 'Tento resistir na maior parte do tempo',
      'o_resist_2': 'Faço algum esforço para resistir',
      'o_resist_3': 'Cedo a quase todos sem muita resistência',
      'o_resist_4': 'Cedo completamente e por vontade própria',
      'o_control_0': 'Controle total: consigo afastá-los facilmente',
      'o_control_1':
          'Muito controle: geralmente consigo pará-los ou redirecioná-los',
      'o_control_2': 'Algum controle: às vezes consigo, às vezes não',
      'o_control_3': 'Pouco controle: raramente consigo pará-los',
      'o_control_4': 'Nenhum controle: parecem totalmente involuntários',
      'c_time_0': 'Nenhum',
      'c_time_1': 'Pouco: menos de uma hora por dia ou algumas vezes',
      'c_time_2': 'Moderado: de 1 a 3 horas por dia ou rituais frequentes',
      'c_time_3': 'Muito: de 3 a 8 horas por dia ou rituais muito frequentes',
      'c_time_4': 'Quase constante: mais de 8 horas por dia',
      'c_interfere_0': 'Nada',
      'c_interfere_1': 'Pouco: quase não afetam o que faço',
      'c_interfere_2': 'Um pouco: interferem, mas ainda consigo lidar',
      'c_interfere_3': 'Muito: atrapalham claramente o meu dia',
      'c_interfere_4': 'Tanto que mal consigo funcionar',
      'c_distress_0': 'Nada',
      'c_distress_1': 'Um pouco inquieto',
      'c_distress_2': 'Moderadamente ansioso',
      'c_distress_3': 'Muito ansioso',
      'c_distress_4': 'Ansiedade esmagadora e incapacitante',
      'c_resist_0': 'Sempre tento resistir, ou quase não acontecem',
      'c_resist_1': 'Tento resistir na maior parte do tempo',
      'c_resist_2': 'Faço algum esforço para resistir',
      'c_resist_3': 'Cedo a quase todas sem muita resistência',
      'c_resist_4': 'Cedo completamente e por vontade própria',
      'c_control_0': 'Controle total: consigo me impedir facilmente',
      'c_control_1': 'Muito controle: geralmente consigo parar ou adiar',
      'c_control_2': 'Algum controle: às vezes consigo, às vezes não',
      'c_control_3': 'Pouco controle: raramente consigo parar ou adiar',
      'c_control_4': 'Nenhum controle: preciso concluí-las',
      'other': 'Opção de resposta',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': 'Agressividade ou dano',
      'contamination': 'Contaminação',
      'sexual': 'Sexual',
      'hoarding_obs': 'Acumulação ou guarda',
      'religious': 'Escrupulosidade religiosa ou moral',
      'symmetry_obs': 'Simetria ou exatidão',
      'somatic': 'Corpo ou doença',
      'misc_obs': 'Outras obsessões',
      'washing': 'Lavagem ou limpeza',
      'checking': 'Verificação',
      'repeating': 'Rituais de repetição',
      'counting': 'Contagem',
      'ordering': 'Ordenação ou organização',
      'misc_comp': 'Outras compulsões',
      'other': 'Outro tema',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': 'Medo de machucar a mim mesmo',
      'agg_harm_others': 'Medo de machucar outra pessoa',
      'agg_violent': 'Imagens violentas ou horríveis na minha mente',
      'agg_blurt': 'Medo de falar insultos ou obscenidades de repente',
      'agg_impulse': 'Medo de agir por um impulso indesejado',
      'agg_responsible': 'Medo de ser responsável por algo terrível',
      'con_dirt': 'Preocupação com sujeira ou germes',
      'con_bodily': 'Nojo de resíduos ou secreções corporais',
      'con_chemicals':
          'Preocupação com produtos químicos ou de limpeza doméstica',
      'con_ill': 'Medo de adoecer por contaminação',
      'con_spread': 'Medo de transmitir contaminação a outras pessoas',
      'con_sticky': 'Incômodo com substâncias ou resíduos pegajosos',
      'sex_forbidden':
          'Pensamentos ou imagens sexuais proibidos ou indesejados',
      'sex_others': 'Pensamentos sexuais sobre outras pessoas que me perturbam',
      'sex_orientation': 'Dúvidas indesejadas sobre minha orientação sexual',
      'sex_aggressive': 'Pensamentos sexuais agressivos sobre outras pessoas',
      'hoard_discard': 'Medo de jogar fora algo de que eu possa precisar',
      'hoard_value':
          'Sensação de que objetos têm um valor do qual não consigo abrir mão',
      'rel_sacrilege': 'Preocupação com sacrilégio ou blasfêmia',
      'rel_rightwrong': 'Preocupação excessiva com certo, errado ou moralidade',
      'rel_punish': 'Medo de punição por Deus ou pelo destino',
      'sym_even':
          'Necessidade de que as coisas estejam equilibradas ou “do jeito certo”',
      'sym_exact': 'Necessidade de exatidão, ordem ou precisão',
      'sym_incomplete': 'Sensação de incompletude até que tudo pareça certo',
      'som_illness': 'Preocupação excessiva com doença',
      'som_body': 'Preocupação excessiva com uma parte do corpo ou aparência',
      'misc_know': 'Necessidade de saber ou lembrar de coisas',
      'misc_saywrong': 'Medo de dizer algo errado',
      'misc_lucky': 'Números, palavras ou cores de sorte ou azar',
      'misc_sounds':
          'Sons, palavras ou músicas intrusivos que não consigo parar',
      'misc_lose': 'Medo de perder coisas',
      'wash_hands': 'Lavagem excessiva ou ritualizada das mãos',
      'wash_shower': 'Banho ou cuidados pessoais excessivos',
      'wash_clean': 'Limpeza excessiva de itens domésticos',
      'wash_avoid': 'Evitar coisas que considero contaminadas',
      'chk_locks': 'Verificar fechaduras, aparelhos, torneiras ou fogão',
      'chk_harm': 'Verificar se não machuquei ou não vou machucar alguém',
      'chk_mistake': 'Verificar se não cometi um erro',
      'chk_body': 'Verificar meu corpo em busca de sinais de doença',
      'rep_reread': 'Reler ou reescrever',
      'rep_routine':
          'Repetir ações rotineiras, como passar por portas ou subir e descer',
      'rep_untilright': 'Repetir até parecer “do jeito certo”',
      'cnt_count': 'Contar objetos, passos ou ações',
      'cnt_numbers': 'Fazer algo um determinado número de vezes',
      'ord_arrange': 'Organizar objetos até ficarem simétricos ou exatos',
      'ord_align': 'Alinhar ou endireitar objetos repetidamente',
      'mc_mental':
          'Rituais mentais, como orações silenciosas, frases ou revisões',
      'mc_reassure': 'Pedir reafirmação ou confessar repetidamente',
      'mc_touch': 'Precisar tocar, bater ou esfregar objetos',
      'mc_lists': 'Fazer listas excessivamente',
      'mc_avoid': 'Evitar situações para impedir um impulso',
      'other': 'Outro sintoma',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical':
          'Este total está na faixa subclínica da Y-BOCS. O resultado é um retrato do momento, não um diagnóstico.',
      'mild':
          'Este total está na faixa leve da Y-BOCS. O resultado é um retrato do momento, não um diagnóstico.',
      'moderate':
          'Este total está na faixa moderada da Y-BOCS. O resultado é um retrato do momento, não um diagnóstico.',
      'severe':
          'Este total está na faixa grave da Y-BOCS. Considere conversar sobre o impacto com um profissional qualificado.',
      'extreme':
          'Este total está na faixa extrema da Y-BOCS. Considere entrar em contato com um profissional qualificado. Se houver perigo imediato, contate os serviços de emergência locais.',
      'other':
          'Este total registrado é um retrato do momento, não um diagnóstico.',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Experimentos comportamentais',
      'newAction': 'Novo',
      'subtitle':
          'Compare uma previsão do OCD com o que você observa depois de uma ação planejada.',
      'loadError':
          'Seus experimentos não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este experimento?',
      'deleteBody':
          'Isso remove o experimento permanentemente deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir experimento',
      'deleteSuccess': 'Experimento excluído.',
      'deleteError':
          'Não foi possível excluir este experimento. Tente novamente.',
      'statusPlanned': 'Planejado',
      'statusCompleted': 'Concluído',
      'outcomeLabel': 'O que aconteceu',
      'learningLabel': 'O que anotei',
      'recordAction': 'Registrar o que aconteceu',
      'emptyTitle': 'Planeje um experimento comportamental',
      'emptyBody':
          'Anote a previsão do OCD, escolha uma pequena ação e depois registre o que você observou.',
      'emptyAction': 'Novo experimento',
      'outcomeEditorTitle': 'Registrar o que aconteceu',
      'newEditorTitle': 'Novo experimento',
      'predictedLabel': 'O OCD previu',
      'testActionLabel': 'Ação planejada',
      'outcomeInputLabel': 'O que realmente aconteceu?',
      'outcomeInputHint':
          'Registre o que você observou, sem avaliar o resultado',
      'learningInputLabel': 'Quer anotar algo? (opcional)',
      'learningInputHint': 'Um detalhe que você queira lembrar',
      'predictionInputLabel': 'O que o OCD prevê?',
      'predictionInputHint':
          'Por exemplo: Se eu não conferir de novo, a casa vai alagar',
      'confidenceQuestion': 'Quão certa parece a previsão?',
      'experimentInputLabel': 'Que ação vai testar a previsão?',
      'experimentInputHint':
          'Por exemplo: Sair após uma verificação normal e observar o que acontece',
      'saveOutcome': 'Salvar observação',
      'saveExperiment': 'Salvar experimento',
      'outcomeValidation': 'Adicione uma nota curta sobre o que você observou.',
      'planValidation':
          'Adicione a previsão do OCD e a ação que você planeja realizar.',
      'outcomeSaveSuccess': 'Observação salva.',
      'planSaveSuccess':
          'Experimento salvo. Registre o que aconteceu depois de realizá-lo.',
      'saveError':
          'Não foi possível salvar este experimento. Seu texto continua aqui. Tente novamente.',
      'other': 'Experimento comportamental',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentConfidence(String percent) {
    return '$percent de certeza';
  }

  @override
  String behavioralExperimentCardSummary(
    String status,
    String date,
    String confidence,
    String prediction,
    String experiment,
  ) {
    return '$status · $date · $confidence. Previsão: $prediction. Ação planejada: $experiment.';
  }

  @override
  String exposureReflectionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Reflexões sobre exposições',
      'newAction': 'Nova',
      'subtitle':
          'Registre o que você notou após uma exposição. Acrescente apenas os detalhes que parecerem úteis.',
      'loadError':
          'Suas reflexões não estão disponíveis no momento. Tente novamente.',
      'deleteTitle': 'Excluir esta reflexão?',
      'deleteBody': 'Isso exclui permanentemente a reflexão deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir reflexão',
      'deleteSuccess': 'Reflexão excluída.',
      'deleteError': 'Não foi possível excluir esta reflexão. Tente novamente.',
      'emptyTitle': 'Refletir sobre uma exposição',
      'emptyBody':
          'Registre o que aconteceu, o que o OCD previu e tudo o que você quiser lembrar. Apenas a primeira pergunta é obrigatória.',
      'emptyAction': 'Nova reflexão',
      'editorTitle': 'Nova reflexão',
      'whatHappenedLabel': 'O que aconteceu?',
      'whatHappenedHint': 'A exposição ou prática que você realizou',
      'predictionLabel': 'O que o OCD previu?',
      'predictionHint': 'O resultado que o OCD disse que poderia acontecer',
      'actualLabel': 'O que você observou?',
      'actualHint': 'O que aconteceu durante ou após a exposição',
      'learningLabel': 'Algo que você queira lembrar? (opcional)',
      'learningHint': 'Um detalhe que pode ser útil mais tarde',
      'nextTimeLabel': 'Algo que você pode mudar? (opcional)',
      'nextTimeHint': 'Deixe em branco se nada vier à mente',
      'saveAction': 'Salvar reflexão',
      'validation':
          'Comece com uma breve anotação sobre o que aconteceu. As outras perguntas são opcionais.',
      'saveSuccess': 'Reflexão salva.',
      'saveError':
          'Não foi possível salvar esta reflexão. Seu texto continua aqui. Tente novamente.',
      'other': 'Reflexão sobre uma exposição',
    });
    return '$_temp0';
  }

  @override
  String exposureReflectionCardSummary(String date, String whatHappened) {
    return '$date. O que aconteceu: $whatHappened.';
  }

  @override
  String implementationIntentionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Planos se-então',
      'newAction': 'Novo',
      'subtitle':
          'Associe uma situação a uma resposta que você queira experimentar quando ela acontecer.',
      'loadError':
          'Seus planos se-então não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este plano se-então?',
      'deleteBody': 'Isso exclui permanentemente o plano deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir plano se-então',
      'deleteSuccess': 'Plano se-então excluído.',
      'deleteError':
          'Não foi possível excluir este plano se-então. Tente novamente.',
      'emptyTitle': 'Crie um plano se-então',
      'emptyBody':
          'Escreva uma situação e a resposta que você queira experimentar quando ela acontecer.',
      'emptyAction': 'Novo plano se-então',
      'editorTitle': 'Novo plano se-então',
      'triggerLabel': 'Se…',
      'triggerHint':
          'A situação, por exemplo: noto a vontade de buscar confirmação',
      'responseLabel': 'então eu vou…',
      'responseHint':
          'A resposta que você quer experimentar, por exemplo: anotar o que estou percebendo',
      'saveAction': 'Salvar plano se-então',
      'validation':
          'Adicione a situação e a resposta que você quer experimentar.',
      'saveSuccess': 'Plano se-então salvo.',
      'saveError':
          'Não foi possível salvar este plano se-então. Seu texto continua aqui. Tente novamente.',
      'other': 'Plano se-então',
    });
    return '$_temp0';
  }

  @override
  String implementationIntentionStatement(String trigger, String response) {
    return 'Se $trigger, então $response.';
  }

  @override
  String uncertaintyTrainingText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Prática da incerteza',
      'subtitle': 'Pratique dar espaço ao não saber.',
      'loadError':
          'As contagens de práticas não estão disponíveis agora. Você ainda pode abrir os exercícios.',
      'whyLabel': 'SOBRE ESTA PRÁTICA',
      'willingnessLabel': 'Quão disposto você estava a permanecer sem saber?',
      'noteLabel': 'Nota (opcional)',
      'noteHint': 'O que você percebeu?',
      'saveAction': 'Registrar esta prática',
      'saveSuccess': 'Prática registrada.',
      'saveError':
          'Não foi possível registrar esta prática. Sua nota continua aqui. Tente novamente.',
      'other': 'Prática da incerteza',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseTitle(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': 'Talvez sim, talvez não',
      'unanswered': 'Deixe sem resposta',
      'resist': 'Pause a busca por certeza',
      'other': 'Exercício de incerteza',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseIntro(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Quando o OCD pedir certeza, experimente responder “talvez sim, talvez não” e volte a atenção ao que você estava fazendo.',
      'unanswered':
          'Deixe uma pergunta recorrente em aberto em vez de resolvê-la.',
      'resist':
          'Perceba a vontade de conferir, pesquisar ou buscar confirmação e escolha não segui-la durante esta prática.',
      'other': 'Uma prática para permitir que a incerteza continue presente.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseWhy(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Este exercício pratica deixar uma pergunta sem resposta, sem acrescentar confirmação.',
      'unanswered':
          'Este exercício pratica permitir que uma pergunta continue em aberto.',
      'resist':
          'Este exercício registra a prática deliberada de não buscar certeza.',
      'other': 'Este é um exercício de autoajuda para dar espaço à incerteza.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExercisePrompt(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Escolha uma preocupação e responda “talvez sim, talvez não”. Perceba o que está presente sem tentar resolver.',
      'unanswered':
          'Escolha uma pergunta que você normalmente resolveria e deixe-a sem resposta durante esta prática.',
      'resist':
          'Perceba uma vontade de buscar certeza e deixe-a sem resposta durante esta prática.',
      'other':
          'Escolha uma pequena forma de deixar a incerteza sem resposta durante esta prática.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyPracticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas',
      one: '1 prática',
    );
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseSummary(String title, String intro) {
    return '$title. $intro';
  }

  @override
  String uncertaintyExerciseSummaryWithCount(
    String title,
    String intro,
    int count,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas registradas.',
      one: '1 prática registrada.',
    );
    return '$title. $intro $_temp0';
  }

  @override
  String uncertaintyWillingness(int value) {
    return 'Disposição: $value de 10';
  }

  @override
  String actionPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Planejador de ações',
      'newAction': 'Novo',
      'subtitle':
          'Registre uma situação e a resposta que você quer experimentar.',
      'loadError':
          'Seus planos de ação não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este plano de ação?',
      'deleteBody': 'Isso exclui permanentemente o plano deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir plano de ação',
      'deleteSuccess': 'Plano de ação excluído.',
      'deleteError':
          'Não foi possível excluir este plano de ação. Tente novamente.',
      'statePlanned': 'Planejado',
      'stateCompleted': 'Marcado como concluído',
      'toggleMarkComplete': 'Marcar plano de ação como concluído',
      'toggleMarkIncomplete': 'Marcar plano de ação como não concluído',
      'toggleSuccessComplete': 'Plano de ação marcado como concluído.',
      'toggleSuccessIncomplete': 'Plano de ação marcado como não concluído.',
      'toggleError':
          'Não foi possível atualizar este plano de ação. O estado anterior continua sendo exibido. Tente novamente.',
      'emptyTitle': 'Crie um plano de ação',
      'emptyBody':
          'Escreva uma situação e a resposta que você quer experimentar quando ela acontecer.',
      'emptyAction': 'Novo plano de ação',
      'editorTitle': 'Novo plano de ação',
      'situationLabel': 'Quando o OCD aparecer',
      'situationHint': 'Por exemplo: percebo a vontade de pesquisar um sintoma',
      'actionLabel': 'Resposta que quero experimentar',
      'actionHint':
          'Por exemplo: esperar 15 minutos antes de decidir se pesquiso',
      'dateLabel': 'Data (opcional)',
      'pickDate': 'Escolher uma data',
      'clearDate': 'Remover data',
      'notesLabel': 'Notas (opcional)',
      'notesHint': 'Qualquer coisa que você queira lembrar',
      'saveAction': 'Salvar plano de ação',
      'validation':
          'Adicione a situação e a resposta que você quer experimentar.',
      'saveSuccess': 'Plano de ação salvo.',
      'saveError':
          'Não foi possível salvar este plano de ação. Seu texto continua aqui. Tente novamente.',
      'other': 'Plano de ação',
    });
    return '$_temp0';
  }

  @override
  String actionPlanCardSummary(String status, String situation, String action) {
    return '$status. Situação: $situation. Resposta planejada: $action.';
  }

  @override
  String actionPlanDateSummary(String date) {
    return 'Data planejada: $date.';
  }

  @override
  String settingsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'proActiveMessage': 'O Patterns Pro está ativo neste dispositivo.',
      'welcomeScheduled':
          'As telas de boas-vindas aparecerão na próxima vez que você abrir o Patterns.',
      'exportPromptTitle': 'Exportar dados?',
      'exportPromptBody':
          'O Patterns cria um backup ZIP não criptografado dos seus registros locais. Salve-o em um local privado.',
      'exportBackupAction': 'Exportar backup ZIP',
      'exportDialogTitle': 'Exportar dados do Patterns',
      'exportSucceeded': 'Dados exportados.',
      'exportFailed':
          'A exportação falhou. Seus dados não foram alterados. Tente novamente.',
      'importPromptTitle': 'Importar dados?',
      'importPromptBody':
          'Escolha um backup do Patterns em ZIP ou JSON. Você poderá revisar o conteúdo antes de substituir seus registros atuais.',
      'chooseBackupAction': 'Escolher backup',
      'importDialogTitle': 'Selecionar backup do Patterns',
      'backupUnreadable':
          'O Patterns não conseguiu ler este arquivo de backup. Escolha outro arquivo.',
      'backupInvalid':
          'Este não é um backup válido do Patterns. Seus dados atuais não foram alterados.',
      'importFailed':
          'A importação falhou. Seus dados atuais não foram alterados. Tente novamente.',
      'importPreviewTitle': 'Substituir os dados atuais?',
      'importPreviewIntro':
          'Este backup contém os seguintes registros locais. A importação substituirá seus registros atuais.',
      'replaceAction': 'Substituir dados',
      'importSucceeded': 'Dados importados.',
      'wipePromptTitle': 'Apagar todos os dados locais?',
      'wipePromptBody':
          'Isso exclui permanentemente deste dispositivo as entradas do diário, os registros de OCD, o histórico de práticas de recuperação, os materiais salvos localmente e as preferências do aplicativo. Não é possível desfazer. Sua compra do Patterns Pro continua vinculada à conta da loja, mas este dispositivo esquecerá o desbloqueio local. Você poderá restaurá-lo depois.',
      'wipeAction': 'Apagar dados',
      'wipeSucceeded': 'Dados locais apagados.',
      'wipeFailed':
          'O Patterns não conseguiu terminar de apagar os dados locais. Tente novamente.',
      'appLockDisabled': 'Bloqueio do aplicativo desativado.',
      'deviceLockUnavailable':
          'O bloqueio do dispositivo não está disponível. Configure um código ou biometria e tente novamente.',
      'appLockReason':
          'Desbloqueie o Patterns para ativar o bloqueio do aplicativo.',
      'appLockEnabled': 'Bloqueio do aplicativo ativado.',
      'appLockTemporaryLockout':
          'Muitas tentativas. Tente novamente em instantes.',
      'appLockBiometricLockout':
          'A autenticação biométrica está bloqueada. Primeiro desbloqueie o dispositivo com o código.',
      'appLockEnableFailed':
          'O Patterns não conseguiu alterar o bloqueio do aplicativo. Tente novamente.',
      'reminderOff': 'Lembrete diário desativado.',
      'notificationsUnavailable':
          'As notificações do Patterns estão desativadas. Ative-as nas configurações do dispositivo para receber lembretes.',
      'reminderOn': 'Lembrete diário ativado.',
      'reminderChangeFailed':
          'O Patterns não conseguiu alterar o lembrete. A configuração anterior continua em vigor.',
      'analyticsChangeFailed':
          'O Patterns não conseguiu alterar o compartilhamento anônimo. A configuração anterior continua em vigor.',
      'privacyPolicyFailed':
          'O Patterns não conseguiu abrir a política de privacidade. Tente novamente.',
      'other': 'Configurações',
    });
    return '$_temp0';
  }

  @override
  String settingsBackupJournalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas no diário',
      one: '1 entrada no diário',
      zero: 'Nenhuma entrada no diário',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupOcdCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos de OCD',
      one: '1 evento de OCD',
      zero: 'Nenhum evento de OCD',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupDelayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessões de adiamento',
      one: '1 sessão de adiamento',
      zero: 'Nenhuma sessão de adiamento',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupErpPlanCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count planos de ERP',
      one: '1 plano de ERP',
      zero: 'Nenhum plano de ERP',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupErpPracticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas de ERP',
      one: '1 prática de ERP',
      zero: 'Nenhuma prática de ERP',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupRecoveryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count outros registros de ferramentas de recuperação',
      one: '1 outro registro de ferramenta de recuperação',
      zero: 'Nenhum outro registro de ferramentas de recuperação',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupSelfCheckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count autoquestionários Y-BOCS',
      one: '1 autoquestionário Y-BOCS',
      zero: 'Nenhum autoquestionário Y-BOCS',
    );
    return '$_temp0';
  }

  @override
  String settingsReminderSetFor(String time) {
    return 'Lembrete definido para $time.';
  }

  @override
  String get appUnlockReason => 'Desbloqueie o Patterns para continuar.';

  @override
  String get appLockUnavailableDisabled =>
      'A autenticação biométrica não está disponível. O bloqueio do aplicativo foi desativado.';

  @override
  String get appUnlockFailed =>
      'Não foi possível desbloquear o Patterns. Tente novamente.';

  @override
  String get privacyScreenLabel => 'Tela de privacidade do Patterns';

  @override
  String get unlockingAction => 'Desbloqueando…';

  @override
  String get unlockAction => 'Desbloquear';

  @override
  String get analyticsPromptTitle => 'Ajudar a melhorar o Patterns?';

  @override
  String get analyticsPromptBody =>
      'Compartilhe eventos anônimos de uso de recursos para ajudar a melhorar o Patterns. Entradas do diário, conteúdo de OCD, avaliações, notas, resumos gerados, região e idioma escolhido nunca são incluídos. O compartilhamento permanece desativado até você escolher ativá-lo.';

  @override
  String get notNowAction => 'Agora não';

  @override
  String get shareAnonymousUsageAction => 'Compartilhar uso anônimo';
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
      'Salve seus registros em um backup ZIP local';

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

  @override
  String get recoveryTitle => 'Recuperação';

  @override
  String get recoverySubtitle =>
      'Ferramentas e práticas agrupadas conforme o ponto em que você está.';

  @override
  String get recoveryImmediateHelpTitle => 'Apoio para um momento difícil';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Kit para momentos difíceis',
      'copingLibrary': 'Biblioteca de enfrentamento',
      'compulsionDelay': 'Adiar a compulsão',
      'ybocsSelfCheck': 'Autoavaliação de OCD',
      'recoveryMetrics': 'Atividade de recuperação',
      'exposureHierarchy': 'Hierarquia de exposição',
      'exposureMaterials': 'Materiais de exposição',
      'structuredPrograms': 'Programas estruturados',
      'actionPlanner': 'Plano de ação',
      'implementationIntentions': 'Planos se-então',
      'guidedErp': 'ERP guiada',
      'urgeSurfing': 'Surfar o impulso',
      'responsePrevention': 'Prevenção de resposta',
      'uncertaintyTraining': 'Prática da incerteza',
      'behavioralExperiments': 'Experimentos comportamentais',
      'reflectionJournal': 'Diário de reflexão',
      'other': 'Ferramenta de recuperação',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Apoio rápido para voltar ao presente.',
      'copingLibrary': 'Volte ao presente e recomece.',
      'compulsionDelay': 'Crie espaço antes de responder.',
      'ybocsSelfCheck': 'Um registro Y-BOCS.',
      'recoveryMetrics': 'Veja a atividade registrada.',
      'exposureHierarchy': 'Monte sua escada.',
      'exposureMaterials': 'Guarde roteiros e links.',
      'structuredPrograms': 'Siga semanas guiadas.',
      'actionPlanner': 'Planeje suas respostas.',
      'implementationIntentions': 'Crie planos se-então.',
      'guidedErp': 'Pratique um plano.',
      'urgeSurfing': 'Acompanhe a onda.',
      'responsePrevention': 'Registre o que você fez no lugar.',
      'uncertaintyTraining': 'Pratique dar espaço ao talvez.',
      'behavioralExperiments': 'Teste a previsão do OCD.',
      'reflectionJournal': 'Registre o que você percebeu.',
      'other': 'Abra uma ferramenta de recuperação.',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Avaliar',
      'plan': 'Planejar',
      'practice': 'Praticar',
      'review': 'Revisar',
      'other': 'Ferramentas',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Veja onde você está.',
      'plan': 'Prepare sua prática.',
      'practice': 'Faça uma prática.',
      'review': 'Reflita e aprenda.',
      'other': 'Escolha o que for útil.',
    });
    return '$_temp0';
  }

  @override
  String get recoveryProBadge => 'Patterns Pro';

  @override
  String recoveryOpenToolHint(String title) {
    return 'Abrir $title';
  }

  @override
  String recoveryLockedToolHint(String title) {
    return '$title requer Patterns Pro';
  }

  @override
  String get delayNameUrgeValidation =>
      'Quando quiser, dê um nome ao impulso com o qual você quer ficar.';

  @override
  String get delayOutcomeValidation =>
      'Quando quiser, escolha o que você acabou fazendo.';

  @override
  String get delaySaveError =>
      'Não foi possível salvar sua prática. Tente novamente.';

  @override
  String get delayStopEarlyTitle => 'Parar antes?';

  @override
  String get delayStopEarlyBody =>
      'Tudo bem parar. O tempo que você esperou ainda pode ser registrado.';

  @override
  String get delayKeepGoingAction => 'Continuar';

  @override
  String get delayStopAction => 'Preciso parar';

  @override
  String get delaySetupTitle => 'Pausar o impulso';

  @override
  String get delayUrgeQuestion => 'Com qual impulso você está ficando?';

  @override
  String get delayUrgeHint =>
      'Por exemplo: verificar a fechadura, lavar ou pesquisar online';

  @override
  String get delayUrgeBeforeLabel => 'Qual é a intensidade do impulso agora?';

  @override
  String get delayDurationQuestion => 'Quanto tempo você vai esperar?';

  @override
  String get delayDurationGroupLabel => 'Duração da espera';

  @override
  String get delayBeginAction => 'Começar';

  @override
  String get delayCountdownTitle => 'Você está dando espaço ao impulso';

  @override
  String get delayCountdownBody =>
      'Perceba o impulso sem agir. Você pode escolher o que acontece depois.';

  @override
  String get delayReflectionTitle => 'O que aconteceu?';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed':
          'O tempo planejado terminou. Os detalhes abaixo são opcionais.',
      'early':
          'Você encerrou o cronômetro antes. Os detalhes abaixo são opcionais.',
      'other': 'O cronômetro terminou. Os detalhes abaixo são opcionais.',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel => 'Qual é a intensidade do impulso agora?';

  @override
  String get delayOutcomeQuestion => 'O que você fez com o impulso?';

  @override
  String get delayOutcomeGroupLabel => 'Resultado registrado';

  @override
  String get delayNoteLabel => 'Percebeu alguma coisa? (opcional)';

  @override
  String get delayNoteHint => 'Uma nota curta é suficiente.';

  @override
  String get delaySavingAction => 'Salvando…';

  @override
  String get delaySaveAction => 'Salvar prática';

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
  String get delayCustomAction => 'Personalizar';

  @override
  String get delayCustomTitle => 'Espera personalizada';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Não fiz',
      'delayed': 'Adiei',
      'performed': 'Fiz',
      'other': 'Não selecionado',
    });
    return '$_temp0';
  }

  @override
  String delayUrgeValue(int value) {
    return 'Impulso $value de 10';
  }

  @override
  String delayCustomMinutesValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '1 minuto',
    );
    return 'Espera personalizada: $_temp0';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation':
          'Quando quiser, escolha o que aconteceu durante a prática.',
      'saveError':
          'Não foi possível salvar sua prática de ERP. Tente novamente.',
      'stopTitle': 'Parar antes?',
      'stopBody':
          'Tudo bem parar. O tempo que você praticou ainda pode ser registrado.',
      'keepGoing': 'Continuar',
      'stop': 'Parar',
      'anxietyBefore': 'Qual é a intensidade do impulso ou da ansiedade agora?',
      'duration': 'Duração',
      'start': 'Começar prática',
      'countdownCue': 'Pratique sem',
      'resisting': 'Resposta que você não está fazendo',
      'countdownBody':
          'Você não precisa provar que a previsão está errada antes de o cronômetro terminar.',
      'stopEarly': 'Parar antes',
      'reflectionTitle': 'Refletir',
      'reflectionBody':
          'Os detalhes abaixo são opcionais. Registre apenas o que parecer útil.',
      'anxietyAfter': 'Qual é a intensidade agora?',
      'outcomeQuestion': 'O que você fez?',
      'whatHappened': 'O que realmente aconteceu?',
      'whatHappenedHint': 'O que você percebeu durante ou depois da prática?',
      'learning': 'Para a próxima vez',
      'learningHint': 'O que você quer lembrar na próxima vez que o OCD pedir?',
      'exposure': 'Exposição',
      'prediction': 'Previsão',
      'commitment': 'Compromisso',
      'saving': 'Salvando…',
      'save': 'Salvar prática',
      'other': 'Prática de ERP',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'O tempo planejado terminou.',
      'early': 'Você encerrou o cronômetro antes.',
      'other': 'O cronômetro terminou.',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'Não fiz a resposta',
      'delayed': 'Adiei a resposta',
      'performed': 'Fiz a resposta',
      'other': 'Não selecionado',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return 'Intensidade $value de 10';
  }

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'ERP guiada',
      'subtitle': 'Reutilize um plano, pratique e registre o que aconteceu.',
      'myPlans': 'Meus planos de ERP',
      'newAction': 'Novo',
      'plansError': 'Os planos de ERP não estão disponíveis agora.',
      'recentPractice': 'Práticas recentes',
      'historyError': 'O histórico de práticas não está disponível agora.',
      'archiveTitle': 'Arquivar este plano?',
      'archiveBody':
          'Ele sairá dos seus planos ativos, mas as práticas anteriores continuarão no histórico.',
      'keepAction': 'Manter',
      'archiveAction': 'Arquivar',
      'exposureValidation':
          'Quando quiser, descreva a situação com a qual deseja praticar.',
      'commitmentValidation':
          'Escolha a resposta que deseja praticar não fazer para salvar o plano.',
      'saveError': 'Não foi possível salvar seu plano de ERP. Tente novamente.',
      'updated': 'Plano de ERP atualizado.',
      'created': 'Plano de ERP criado.',
      'editTitle': 'Editar plano de ERP',
      'createTitle': 'Criar plano de ERP',
      'exerciseType': 'Tipo de exercício',
      'exposureTarget': 'Alvo da exposição',
      'ocdPrediction': 'Previsão do TOC',
      'preventionCommitment': 'Compromisso de prevenção de resposta',
      'defaultDuration': 'Duração padrão',
      'saving': 'Salvando…',
      'saveAction': 'Salvar plano',
      'createAction': 'Criar plano',
      'emptyTitle': 'Crie seu primeiro plano de ERP',
      'emptyBody':
          'Escreva uma vez a exposição, a previsão e a resposta que deseja praticar não fazer. Depois, reutilize o plano quando precisar.',
      'moreActions': 'Mais ações do plano',
      'editAction': 'Editar plano',
      'archivePlanAction': 'Arquivar plano',
      'practiceGuide': 'Guia da prática',
      'historyEmpty': 'As práticas concluídas aparecerão aqui.',
      'customDuration': 'Duração personalizada',
      'other': 'Plano de ERP',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return 'Não fazer: $response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction =>
      'O TOC diz que o desconforto não vai mudar se você não responder.';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Adiar a verificação',
      'delayReassurance': 'Adiar a busca por reafirmação',
      'delayGoogling': 'Adiar a pesquisa na internet',
      'delayRumination': 'Adiar a ruminação',
      'delayWashing': 'Adiar a lavagem',
      'other': 'ERP guiada',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Pratique deixar algo sem verificar por um curto período.',
      'delayReassurance':
          'Espere antes de pedir a alguém que elimine a incerteza.',
      'delayGoogling': 'Adie a busca por certeza ou provas.',
      'delayRumination':
          'Perceba a resolução mental de problemas sem segui-la.',
      'delayWashing': 'Espere antes de lavar, limpar ou higienizar novamente.',
      'other': 'Pratique adiar uma resposta.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Crie um plano reutilizável para quando o TOC pressionar você a verificar novamente fechaduras, interruptores, mensagens, sintomas ou erros.',
      'delayReassurance':
          'Crie um plano para a vontade de perguntar, confessar, explicar ou pedir que alguém confirme que está tudo bem.',
      'delayGoogling':
          'Crie um plano para quando o TOC quiser que você pesquise sintomas, significados, riscos, regras ou relatos até sentir certeza.',
      'delayRumination':
          'Crie um plano para compulsões mentais como repassar, provar, revisar ou resolver.',
      'delayWashing':
          'Crie um plano para a vontade de lavar, limpar, higienizar ou recomeçar porque algo parece contaminado.',
      'other': 'Crie um plano reutilizável de prática de ERP.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'A ERP permite praticar com a incerteza presente sem fazer um ritual imediatamente.',
      'delayReassurance':
          'A reafirmação pode parecer útil no momento; adiá-la permite praticar sem saber com certeza.',
      'delayGoogling':
          'Adiar a pesquisa interrompe o ciclo de certeza e permite praticar deixando uma pergunta sem resposta.',
      'delayRumination':
          'A ruminação pode parecer pensamento; a ERP permite praticar sair do ciclo sem terminar o argumento.',
      'delayWashing':
          'Esperar permite praticar com a sensação de contaminação presente sem fazer um ritual imediatamente.',
      'other': 'A ERP permite dar espaço à incerteza sem um ritual imediato.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure':
          'O que você deixará sem verificar ou verificará apenas uma vez?',
      'delayCheckingPrediction':
          'O que o TOC prevê se você não verificar novamente?',
      'delayCheckingCommitment':
          'Qual ritual de verificação você praticará não fazer?',
      'delayReassuranceExposure': 'Que reafirmação você quer pedir?',
      'delayReassurancePrediction':
          'O que o TOC diz que acontecerá se você não perguntar?',
      'delayReassuranceCommitment':
          'Que mensagem, confissão ou pergunta você evitará?',
      'delayGooglingExposure':
          'Que pesquisa ou pergunta você deixará sem resposta?',
      'delayGooglingPrediction':
          'O que o TOC diz que você precisa saber agora?',
      'delayGooglingCommitment': 'Que pesquisa, artigo ou fórum você evitará?',
      'delayRuminationExposure':
          'Que ciclo de pensamento você deixará inacabado?',
      'delayRuminationPrediction':
          'O que o TOC diz que você precisa resolver ou provar?',
      'delayRuminationCommitment':
          'Que revisão mental ou argumento você evitará?',
      'delayWashingExposure': 'Qual limite normal de higiene você seguirá?',
      'delayWashingPrediction':
          'O que o TOC prevê se você não lavar novamente?',
      'delayWashingCommitment':
          'Que lavagem, limpeza ou higienização extra você evitará?',
      'other': 'Que resposta você praticará não fazer?',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Defina uma regra de verificação antes de começar.',
      'delayChecking2':
          'Faça a verificação planejada uma vez se ela fizer parte da segurança normal.',
      'delayChecking3':
          'Evite verificar novamente enquanto o cronômetro estiver ativo.',
      'delayChecking4': 'Perceba a vontade sem negociar com ela.',
      'delayReassurance1': 'Defina o pedido de reafirmação antes de começar.',
      'delayReassurance2':
          'Não envie a mensagem nem faça a pergunta durante o cronômetro.',
      'delayReassurance3': 'Deixe o desconforto presente sem buscar certeza.',
      'delayReassurance4':
          'Volte ao que estava fazendo da forma mais gentil possível.',
      'delayGoogling1':
          'Defina a pesquisa antes de abrir qualquer outra coisa.',
      'delayGoogling2': 'Feche a caixa de pesquisa ou a aba do navegador.',
      'delayGoogling3':
          'Inicie o cronômetro antes de ler qualquer outra coisa.',
      'delayGoogling4': 'Deixe a pergunta sem resposta por enquanto.',
      'delayRumination1':
          'Nomeie o ciclo: revisar, resolver, provar ou verificar.',
      'delayRumination2': 'Deixe o pensamento inacabado.',
      'delayRumination3':
          'Leve a atenção de volta a uma tarefa ou sensação comum.',
      'delayRumination4':
          'Recomece com gentileza sempre que o ciclo puxar você de volta.',
      'delayWashing1': 'Defina o limite normal de higiene antes de começar.',
      'delayWashing2':
          'Comece com um adiamento que pareça desafiador, mas possível.',
      'delayWashing3':
          'Mantenha as mãos longe da pia ou do higienizador durante o cronômetro.',
      'delayWashing4':
          'Deixe o desconforto presente sem tentar torná-lo perfeito.',
      'other': 'Siga o plano que você escolheu.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Verificar uma vez',
      'delayChecking2': 'Não reverificar',
      'delayChecking3': 'Perceber a vontade',
      'delayReassurance1': 'Segurar a pergunta',
      'delayReassurance2': 'Deixar a incerteza',
      'delayReassurance3': 'Voltar com gentileza',
      'delayGoogling1': 'Fechar a pesquisa',
      'delayGoogling2': 'Iniciar cronômetro',
      'delayGoogling3': 'Deixar sem resposta',
      'delayRumination1': 'Nomear o ciclo',
      'delayRumination2': 'Deixar inacabado',
      'delayRumination3': 'Voltar à tarefa',
      'delayWashing1': 'Definir o limite',
      'delayWashing2': 'Adiar a lavagem',
      'delayWashing3': 'Permitir o desconforto',
      'other': 'Seguir o plano',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Programas estruturados',
      'subtitle': 'Siga um plano guiado, semana a semana, no seu ritmo.',
      'themeGroup': 'Por tema de TOC',
      'themeGroupEmpty':
          'Escolha um tema se ele combinar com o que você quer praticar.',
      'themeGroupMatched':
          'Os temas registrados na sua última autoavaliação estão sinalizados abaixo.',
      'generalGroup': 'Prática geral',
      'generalCaption': 'Habilidades que podem ser usadas em diferentes temas.',
      'enrollError': 'Não foi possível abrir este programa. Tente novamente.',
      'started': 'Iniciado',
      'notStarted': 'Não iniciado',
      'openHint': 'Abrir detalhes do programa',
      'selfCheckMatch': 'Corresponde à sua autoavaliação',
      'tapToStart': 'Toque para começar',
      'progressLoadError':
          'Não foi possível carregar a atividade do programa. Tente novamente.',
      'activityRecorded':
          'Suas escolhas de tarefas são registradas localmente.',
      'taskSaveError':
          'Não foi possível salvar esta alteração. Tente novamente.',
      'weekComplete': 'Todas as tarefas estão marcadas como concluídas',
      'weekNotComplete': 'Há tarefas restantes',
      'weekToggleHint': 'Expandir ou recolher esta semana',
      'taskToggleHint': 'Marcar ou desmarcar esta tarefa',
      'other': 'Programa',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$done de $total tarefas, $percent por cento';
  }

  @override
  String structuredProgramSummary(int count, String subtitle) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas · $subtitle',
      one: '1 semana · $subtitle',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramComplete(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'As $count tarefas estão marcadas como concluídas.',
      one: 'A tarefa está marcada como concluída.',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$done de $total tarefas marcadas como concluídas';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String exposureHierarchyText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Hierarquia de exposição',
      'newAction': 'Nova',
      'subtitle':
          'Crie uma escala de possíveis exposições e pratique um passo de cada vez.',
      'loadError':
          'Suas hierarquias não estão disponíveis agora. Tente novamente.',
      'archiveTitle': 'Arquivar esta hierarquia?',
      'archiveBody':
          'Isso remove a hierarquia da sua lista ativa. Os passos salvos permanecem neste dispositivo.',
      'keepAction': 'Manter',
      'archiveAction': 'Arquivar',
      'archiveSuccess': 'Hierarquia arquivada.',
      'archiveError':
          'Não foi possível arquivar esta hierarquia. Tente novamente.',
      'emptyTitle': 'Crie sua primeira escala',
      'emptyBody':
          'Liste possíveis exposições da mais fácil à mais difícil e escolha seu próprio ritmo.',
      'buildAction': 'Criar uma hierarquia',
      'newTitle': 'Nova hierarquia',
      'nameLabel': 'Nome',
      'nameHint': 'Por exemplo, tocar maçanetas',
      'themeLabel': 'Tema (opcional)',
      'themeHint': 'Por exemplo, contaminação',
      'generalTheme': 'Geral',
      'stepsTitle': 'Passos, os mais fáceis primeiro',
      'addAction': 'Adicionar',
      'createAction': 'Criar hierarquia',
      'saving': 'Salvando…',
      'titleValidation': 'Adicione um nome para esta escala.',
      'stepValidation': 'Adicione pelo menos um passo de exposição.',
      'createSuccess': 'Hierarquia salva.',
      'createError':
          'Não foi possível salvar esta hierarquia. Tente novamente.',
      'stepHint': 'Que exposição você poderia praticar?',
      'difficulty': 'Dificuldade',
      'anxiety': 'Ansiedade prevista',
      'materialAction': 'Material',
      'statusNotStarted': 'Não iniciado',
      'statusInProgress': 'Em andamento',
      'statusDone': 'Concluído',
      'statusError':
          'Não foi possível salvar o estado deste passo. Tente novamente.',
      'moveUp': 'Mover passo para cima',
      'moveDown': 'Mover passo para baixo',
      'removeStep': 'Remover passo',
      'openHierarchy': 'Abrir hierarquia',
      'archiveHierarchy': 'Arquivar hierarquia',
      'other': 'Hierarquia de exposição',
    });
    return '$_temp0';
  }

  @override
  String exposureHierarchySummary(int done, int count, String theme) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$done de $count passos · $theme',
      one: '$done de 1 passo · $theme',
      zero: '$theme',
    );
    return '$_temp0';
  }

  @override
  String exposureStepLabel(int number) {
    return 'Passo $number';
  }

  @override
  String exposureRating(int value) {
    return '$value de 10';
  }

  @override
  String exposureStepMetrics(int difficulty, int anxiety) {
    return 'Dificuldade $difficulty de 10 · Ansiedade prevista $anxiety de 10';
  }

  @override
  String exposureProgress(int percent) {
    return '$percent% dos passos marcados como concluídos';
  }

  @override
  String exposureMaterialsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Materiais de exposição',
      'newAction': 'Novo',
      'subtitle':
          'Mantenha roteiros, gravações em loop, imagens e links juntos para usar durante uma exposição.',
      'loadError':
          'Seus materiais não estão disponíveis agora. Tente novamente.',
      'typeScript': 'Roteiro',
      'typeLoopTape': 'Gravação em loop',
      'typeImage': 'Imagem',
      'typeLink': 'Link',
      'deleteTitle': 'Excluir este material?',
      'deleteBody':
          'Isso remove o material deste dispositivo, incluindo o arquivo armazenado, se houver.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir material',
      'deleteSuccess': 'Material excluído.',
      'deleteError': 'Não foi possível excluir este material. Tente novamente.',
      'emptyTitle': 'Reúna seus materiais',
      'emptyBody':
          'Salve um roteiro, uma gravação em loop, uma imagem ou um link para uma exposição escolhida por você.',
      'addAction': 'Adicionar material',
      'readScript': 'Ler roteiro',
      'openLink': 'Abrir link',
      'viewImage': 'Ver imagem',
      'linkError': 'Não foi possível abrir esse link.',
      'imageMissing': 'Esta imagem não está mais disponível neste dispositivo.',
      'recordingMissing':
          'Esta gravação não está mais disponível neste dispositivo.',
      'stop': 'Parar',
      'playLoop': 'Reproduzir loop',
      'microphoneNeeded':
          'O acesso ao microfone é necessário para gravar um loop. Você pode mudar isso nas configurações do dispositivo.',
      'nameValidation': 'Adicione um nome para este material.',
      'scriptValidation': 'Adicione o texto do roteiro.',
      'linkValidation': 'Cole um link.',
      'imageValidation': 'Escolha uma imagem.',
      'recordingValidation': 'Grave um loop antes de salvar.',
      'saveSuccess': 'Material salvo.',
      'saveError': 'Não foi possível salvar este material. Tente novamente.',
      'titleLabel': 'Título',
      'titleHint': 'Um nome curto que você reconhecerá',
      'saveAction': 'Salvar material',
      'scriptLabel': 'Roteiro',
      'scriptHint': 'O texto que você quer ler durante a exposição',
      'linkLabel': 'Link',
      'pickImage': 'Escolher imagem',
      'changeImage': 'Trocar imagem',
      'rerecord': 'Gravar novamente',
      'recorderHint': 'Grave um trecho curto para repetir em loop.',
      'record': 'Gravar',
      'recording': 'Gravando',
      'other': 'Material de exposição',
    });
    return '$_temp0';
  }

  @override
  String exposureMaterialEditorTitle(String type) {
    return 'Novo: $type';
  }

  @override
  String exposureRecordingSeconds(int seconds) {
    return 'Gravando · $seconds s';
  }

  @override
  String responsePreventionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Prevenção de resposta',
      'logAction': 'Registrar',
      'subtitle':
          'Registre o gatilho, a resposta que você escolheu e o desconforto naquele momento.',
      'loadError':
          'Seus registros de resposta não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este registro de resposta?',
      'deleteBody': 'Isso remove o registro permanentemente deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir registro de resposta',
      'deleteSuccess': 'Registro de resposta excluído.',
      'deleteError':
          'Não foi possível excluir este registro de resposta. Tente novamente.',
      'outcomeResisted': 'Não realizada',
      'outcomeDelayed': 'Adiada',
      'outcomePartial': 'Realizada em parte',
      'outcomePerformed': 'Realizada',
      'emptyTitle': 'Registre uma resposta',
      'emptyBody':
          'Depois de um gatilho, registre o que você escolheu e o desconforto que percebeu.',
      'emptyAction': 'Registrar uma resposta',
      'editorTitle': 'Registrar uma resposta',
      'situationLabel': 'O que desencadeou isso?',
      'situationHint': 'O gatilho e a resposta que o TOC sugeriu',
      'outcomeQuestion': 'O que você fez?',
      'distressLabel': 'Desconforto naquele momento',
      'noteLabel': 'Observação (opcional)',
      'noteHint': 'Algo que você queira lembrar',
      'saveAction': 'Salvar registro',
      'situationValidation': 'Adicione uma breve descrição do gatilho.',
      'saveSuccess': 'Registro de resposta salvo.',
      'saveError':
          'Não foi possível salvar este registro de resposta. Tente novamente.',
      'other': 'Prevenção de resposta',
    });
    return '$_temp0';
  }

  @override
  String responsePreventionDistress(int value) {
    return 'Desconforto $value de 10';
  }

  @override
  String responsePreventionLogSummary(
    String outcome,
    String date,
    int distress,
    String situation,
  ) {
    return '$outcome · $date · desconforto $distress de 10 · $situation';
  }

  @override
  String urgeSurfText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Surfar o impulso',
      'subtitle':
          'Observe um impulso pelo tempo que você escolher, sem precisar mudá-lo ou agir em resposta.',
      'startAction': 'Começar',
      'historyTitle': 'Sessões anteriores',
      'emptyHistory':
          'Ainda não há sessões salvas. Uma sessão registrada aparecerá aqui.',
      'loadError':
          'Suas sessões salvas não estão disponíveis agora. Tente novamente.',
      'triggerFallback': 'Um impulso',
      'setupTitle': 'Antes de começar',
      'triggerLabel': 'Qual é o impulso? (opcional)',
      'triggerHint': 'Por exemplo, o impulso de lavar as mãos novamente',
      'initialUrgeLabel': 'Impulso no início',
      'durationQuestion': 'Por quanto tempo você quer observá-lo?',
      'begin': 'Começar',
      'surfingTitle': 'Observe o impulso',
      'surfingBody':
          'Perceba pensamentos e sensações e escolha o que fazer a seguir. Você pode parar a qualquer momento.',
      'currentUrgeLabel': 'Impulso agora',
      'doneAction': 'Concluir por enquanto',
      'reflectionTitle': 'Registre o que percebeu',
      'waveTitle': 'Níveis de impulso registrados',
      'finalUrgeLabel': 'Impulso no fim',
      'noteLabel': 'Observação (opcional)',
      'noteHint': 'O que você percebeu?',
      'saveAction': 'Salvar sessão',
      'finishAction': 'Concluir',
      'saveSuccess': 'Sessão salva.',
      'finishSuccess': 'Prática concluída.',
      'saveError': 'Não foi possível salvar esta sessão. Tente novamente.',
      'timerComplete': 'Tempo de observação concluído.',
      'other': 'Surfar o impulso',
    });
    return '$_temp0';
  }

  @override
  String urgeSurfRating(int value) {
    return 'Impulso $value de 10';
  }

  @override
  String urgeSurfDuration(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minutos',
      one: '1 minuto',
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
    return 'Início em $initial de 10 · maior valor registrado $peak de 10 · fim em $finalLevel de 10 · $duration';
  }

  @override
  String urgeSurfSessionSemantics(String trigger, String date, String summary) {
    return '$trigger · $date · $summary';
  }

  @override
  String urgeSurfWaveSummary(int initial, int peak) {
    return 'Início em $initial de 10 · maior valor registrado $peak de 10';
  }

  @override
  String urgeSurfTimerDisplay(int minutes, String seconds) {
    return '$minutes:$seconds';
  }

  @override
  String urgeSurfTimeRemaining(int minutes, int seconds) {
    return 'Restam $minutes min e $seconds s';
  }

  @override
  String emergencyToolkitText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Apoio para este momento',
      'pauseTitle': 'Faça uma pausa antes de responder',
      'pauseBody':
          'Você não precisa responder ao impulso imediatamente. Escolha um exercício de autoajuda abaixo e vá devagar.',
      'boundary':
          'Estas ferramentas não oferecem atendimento clínico ou de emergência. Se houver perigo imediato, entre em contato com os serviços de emergência locais.',
      'breathe': 'Respirar',
      'breatheSubtitle': 'Siga um ciclo de respiração ritmada',
      'delay': 'Adiar o impulso',
      'delaySubtitle': 'Crie espaço com um temporizador',
      'surf': 'Observar o impulso',
      'surfSubtitle': 'Perceba o impulso sem agir',
      'coping': 'Técnicas de enfrentamento',
      'copingSubtitle': 'Aterramento, aceitação e mais',
      'remindersTitle': 'Alguns lembretes',
      'reminderThought':
          'Um pensamento não exige uma resposta. Posso percebê-lo sem agir.',
      'reminderUrge':
          'Um impulso pode mudar com o tempo. Posso escolher o que fazer em seguida.',
      'reminderUncertainty':
          'Posso abrir espaço para a incerteza neste momento.',
      'breatheIn': 'Inspire',
      'hold': 'Segure',
      'breatheOut': 'Expire',
      'breathingHint':
          'Siga o círculo: inspire por 4 segundos, segure, expire por 4 segundos e segure.',
      'other': 'Ferramenta de apoio',
    });
    return '$_temp0';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Autoavaliação de TOC',
      'introBody':
          'Uma autoavaliação guiada baseada na Escala Obsessivo-Compulsiva de Yale-Brown (Y-BOCS), sobre os padrões que você percebe e o quanto eles afetam você.',
      'spotTitle': 'Observe os padrões',
      'spotBody': 'Selecione obsessões e compulsões que você já vivenciou.',
      'impactTitle': 'Registre o impacto',
      'impactBody':
          'Responda a 10 perguntas sobre o quanto elas afetam o seu dia.',
      'resultIntroTitle': 'Veja o resultado',
      'resultIntroBody':
          'Confira os temas, subtotais e a faixa de gravidade registrados.',
      'begin': 'Começar',
      'retakeAction': 'Fazer novamente',
      'privacyDuration':
          'Leva cerca de 10 minutos. Suas respostas ficam neste dispositivo, a menos que você escolha exportá-las.',
      'disclaimer':
          'Esta autoavaliação pode ajudar você a descrever sua experiência. Ela não diagnostica TOC nem oferece apoio de emergência. Somente um profissional qualificado pode diagnosticar TOC.',
      'historyTitle': 'Seu histórico',
      'historyBody': 'Seus totais registrados anteriormente aparecem aqui.',
      'deleteTitle': 'Excluir avaliação?',
      'deleteBody':
          'Isso remove permanentemente esta avaliação deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir avaliação',
      'deleteSuccess': 'Avaliação excluída.',
      'deleteError':
          'Não foi possível excluir esta avaliação. Tente novamente.',
      'checklistTitle': 'O que parece familiar?',
      'checklistBody':
          'Selecione qualquer experiência atual ou passada. Ignore o que não se aplica.',
      'obsessions': 'Obsessões',
      'obsessionsDescription': 'Pensamentos, imagens ou impulsos indesejados',
      'compulsions': 'Compulsões',
      'compulsionsDescription':
          'Comportamentos ou atos mentais realizados em resposta ao sofrimento',
      'continueAction': 'Continuar',
      'seeResults': 'Ver resultado',
      'next': 'Avançar',
      'resultsTitle': 'Seu resultado',
      'retake': 'Refazer',
      'saved': 'Salvo',
      'saveHistory': 'Salvar no meu histórico',
      'saving': 'Salvando…',
      'saveSuccess': 'Salvo no seu histórico.',
      'saveError': 'Não foi possível salvar esta avaliação. Tente novamente.',
      'breakdownTitle': 'Subtotais registrados',
      'typesTitle': 'Tipos registrados',
      'typesNone':
          'Nenhum tipo de obsessão ou compulsão foi registrado nesta autoavaliação.',
      'typesBoth':
          'Obsessões e compulsões foram registradas nesta autoavaliação.',
      'typesObsessions': 'Obsessões foram registradas nesta autoavaliação.',
      'typesCompulsions': 'Compulsões foram registradas nesta autoavaliação.',
      'themesTitle': 'Temas registrados',
      'themesBody': 'As categorias da lista que contêm os itens selecionados.',
      'nextStepsTitle': 'Sobre este resultado',
      'nextStepsBody':
          'Este resultado é um retrato autorrelatado, não um diagnóstico nem apoio de emergência. Se esses padrões afetam sua vida, você pode conversar com um profissional qualificado. Se houver perigo imediato, entre em contato com os serviços de emergência locais.',
      'other': 'Autoavaliação Y-BOCS',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuar · $count selecionados',
      one: 'Continuar · 1 selecionado',
      zero: 'Continuar',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return 'Pergunta $current de $total';
  }

  @override
  String ybocsScoreOutOf(int score, int maximum) {
    return '$score de $maximum';
  }

  @override
  String ybocsHistorySummary(String severity, int score, String date) {
    return '$severity · $score de 40 · $date';
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
      other: '$count itens selecionados',
      one: '1 item selecionado',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Tarefa marcada como concluída.',
      'notCompleted': 'Tarefa marcada como não concluída.',
      'other': 'Tarefa atualizada.',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Adiamento de compulsões em 4 semanas',
      'uncertainty3wk': 'Tolerância à incerteza',
      'other': 'Programa estruturado',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Pratique adiar compulsões, uma semana de cada vez',
      'uncertainty3wk': 'Pratique viver sem ter certeza',
      'other': 'Um plano de prática guiado',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': 'Semana 1 · Perceber e nomear',
      'delayW2': 'Semana 2 · Aumentar o intervalo',
      'delayW3': 'Semana 3 · Esperar mais',
      'delayW4': 'Semana 4 · Prática diária',
      'uncertaintyW1': 'Semana 1 · Deixar em aberto',
      'uncertaintyW2': 'Semana 2 · Talvez sim, talvez não',
      'uncertaintyW3': 'Semana 3 · Deixar estar',
      'other': 'Semana do programa',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': 'Registre 3 vontades sem agir imediatamente',
      'w1b': 'Adie uma compulsão por 1 minuto, 3 vezes',
      'w2a': 'Adie compulsões por 5 minutos',
      'w2b': 'Experimente uma vez observar a vontade como uma onda',
      'w3a': 'Adie a resposta por 15 minutos',
      'w3b': 'Resista uma vez à vontade de buscar reafirmação',
      'w4a': 'Faça uma exposição por dia',
      'w4b': 'Reflita sobre o que você percebeu',
      'u1a': 'Deixe uma pergunta sem resposta',
      'u1b': 'Resista a verificar uma vez',
      'u2a': 'Use uma resposta “talvez sim, talvez não” 3 vezes',
      'u2b': 'Adie a pesquisa online sobre uma preocupação',
      'u3a': 'Passe um dia sem buscar certeza',
      'u3b': 'Reflita sobre o que você percebeu',
      'other': 'Tarefa do programa',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contaminação e lavagem',
      'checking': 'Verificação e dúvida',
      'harm': 'Dano e pensamentos tabu',
      'relationship': 'Dúvidas no relacionamento',
      'justRight': 'Sensação de exatidão e simetria',
      'other': 'Tema de TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination':
          'Para medos de que algo esteja sujo, seja contagioso ou não seja seguro tocar, e para a lavagem ou limpeza que vem depois.',
      'checking':
          'Para fechaduras, fogões, interruptores, mensagens e outras coisas que você verifica novamente porque não parecem certas o bastante.',
      'harm':
          'Para pensamentos intrusivos sobre dano ou temas que parecem violentos, sexuais ou blasfemos, e para as compulsões ou a evitação que vêm depois.',
      'relationship':
          'Para dúvidas recorrentes sobre se um relacionamento é certo, se você sente o bastante ou o que a dúvida significa.',
      'justRight':
          'Para coisas que parecem precisar estar iguais, ordenadas ou ser repetidas até parecerem certas.',
      'other': 'Uma trilha de prática organizada em torno de um tema de TOC.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contaminação',
      'checking': 'Verificação',
      'harm': 'Dano e pensamentos tabu',
      'relationship': 'Dúvidas no relacionamento',
      'justRight': 'Sensação de exatidão',
      'other': 'Tema de TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'A lista Y-BOCS é anterior às pesquisas sobre TOC de relacionamento, por isso esse tema não aparece entre as categorias. Você ainda pode usar esta trilha de prática.',
      'other': 'Este tema não aparece como uma categoria da lista Y-BOCS.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': 'Semana 1 · Tocar e esperar',
      'ct2': 'Semana 2 · Uma lavagem, não três',
      'ct3': 'Semana 3 · Levar para casa',
      'ck1': 'Semana 1 · Olhar uma vez',
      'ck2': 'Semana 2 · Sem revisão mental',
      'ck3': 'Semana 3 · Deixar sem resolver',
      'hm1': 'Semana 1 · Deixar estar',
      'hm2': 'Semana 2 · Parar de perguntar',
      'hm3': 'Semana 3 · Sem julgamento interno',
      'rl1': 'Semana 1 · Parar de testar',
      'rl2': 'Semana 2 · Sem buscar reafirmação',
      'rl3': 'Semana 3 · Viver com o talvez',
      'jr1': 'Semana 1 · Deixar torto',
      'jr2': 'Semana 2 · Sem repetir',
      'jr3': 'Semana 3 · Bom o suficiente',
      'other': 'Semana da trilha',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a':
          'Toque em algo que pareça um pouco sujo e espere cinco minutos antes de lavar as mãos',
      'ct1b': 'Registre a vontade antes e depois sem lavar',
      'ct2a': 'Lave uma vez, normalmente, e não volte para uma segunda rodada',
      'ct2b': 'Deixe uma superfície de casa sem limpar durante a semana',
      'ct3a':
          'Vá a um lugar que costuma levar você a se lavar depois e não se lave ao chegar em casa',
      'ct3b': 'Anote o que o TOC previu ao lado do que aconteceu',
      'ck1a': 'Verifique uma coisa uma vez e se afaste sem olhar de novo',
      'ck1b': 'Saia de casa uma vez sem fazer uma inspeção final dos cômodos',
      'ck2a':
          'Quando vier a vontade de rever a memória, deixe a dúvida sem resposta',
      'ck2b': 'Envie uma mensagem sem reler antes ou depois',
      'ck3a': 'Passe um dia sem voltar para verificar nada duas vezes',
      'ck3b': 'Anote o que aconteceu e o que o TOC previu',
      'hm1a':
          'Deixe um pensamento intrusivo presente por um minuto sem discutir com ele nem afastá-lo',
      'hm1b': 'Perceba a revisão mental antes de começar e deixe-a quieta',
      'hm2a':
          'Resista a perguntar se você é uma boa pessoa e também não procure uma resposta',
      'hm2b':
          'Permaneça em uma situação que você vinha evitando por causa do pensamento',
      'hm3a':
          'Passe um dia sem verificar seus sentimentos em busca de provas sobre você',
      'hm3b': 'Anote como foi a semana sem se avaliar',
      'rl1a':
          'Perceba um teste de compatibilidade que você usa e deixe de fazê-lo uma vez',
      'rl1b':
          'Deixe uma dúvida sobre o relacionamento sem resposta por dez minutos',
      'rl2a':
          'Passe um dia sem perguntar ao seu par, a uma amizade ou à internet se o relacionamento é certo',
      'rl2b':
          'Façam algo juntos sem monitorar como você se sente durante a atividade',
      'rl3a':
          'Use uma resposta “talvez sim, talvez não” quando a pergunta vier',
      'rl3b': 'Reflita sobre a semana sem tomar uma decisão sobre o futuro',
      'jr1a':
          'Deixe um objeto um pouco fora do lugar e permita que a sensação esteja presente',
      'jr1b': 'Faça algo uma vez mesmo que não pareça terminado',
      'jr2a': 'Resista a repetir uma ação para que ela pareça certa',
      'jr2b': 'Escreva algo sem voltar para deixar a redação uniforme',
      'jr3a': 'Passe um dia deixando várias coisas deliberadamente inacabadas',
      'jr3b':
          'Registre o que aconteceu com a sensação de que algo não estava certo sem mudá-la',
      'other': 'Tarefa da trilha',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time': 'Quanto do meu tempo é ocupado por pensamentos obsessivos?',
      'o_interfere': 'Quanto as obsessões interferem na minha vida?',
      'o_distress': 'Quanto sofrimento os pensamentos obsessivos me causam?',
      'o_resist': 'Quanto tento resistir aos pensamentos obsessivos?',
      'o_control': 'Quanto controle tenho sobre os pensamentos obsessivos?',
      'c_time':
          'Quanto tempo passo em compulsões, como rituais ou verificações?',
      'c_interfere': 'Quanto as compulsões interferem na minha vida?',
      'c_distress':
          'Quão ansioso ou perturbado eu me sentiria se não pudesse realizar a compulsão?',
      'c_resist': 'Quanto tento resistir às compulsões?',
      'c_control': 'Quanto controle tenho sobre as compulsões?',
      'other': 'Pergunta da autoavaliação',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'Nenhum',
      'o_time_1': 'Pouco: menos de uma hora por dia ou algumas vezes',
      'o_time_2': 'Moderado: de 1 a 3 horas por dia ou intrusões frequentes',
      'o_time_3': 'Muito: de 3 a 8 horas por dia ou intrusões muito frequentes',
      'o_time_4': 'Quase constante: mais de 8 horas por dia',
      'o_interfere_0': 'Nada',
      'o_interfere_1': 'Pouco: quase não afetam o que faço',
      'o_interfere_2': 'Um pouco: interferem, mas ainda consigo lidar',
      'o_interfere_3': 'Muito: atrapalham claramente o meu dia',
      'o_interfere_4': 'Tanto que mal consigo funcionar',
      'o_distress_0': 'Nenhum',
      'o_distress_1': 'Pouco: não muito perturbador',
      'o_distress_2': 'Moderado: perturbador, mas administrável',
      'o_distress_3': 'Muito: muito perturbador',
      'o_distress_4': 'Sofrimento quase constante e incapacitante',
      'o_resist_0': 'Sempre tento resistir, ou quase não acontecem',
      'o_resist_1': 'Tento resistir na maior parte do tempo',
      'o_resist_2': 'Faço algum esforço para resistir',
      'o_resist_3': 'Cedo a quase todos sem muita resistência',
      'o_resist_4': 'Cedo completamente e por vontade própria',
      'o_control_0': 'Controle total: consigo afastá-los facilmente',
      'o_control_1':
          'Muito controle: geralmente consigo pará-los ou redirecioná-los',
      'o_control_2': 'Algum controle: às vezes consigo, às vezes não',
      'o_control_3': 'Pouco controle: raramente consigo pará-los',
      'o_control_4': 'Nenhum controle: parecem totalmente involuntários',
      'c_time_0': 'Nenhum',
      'c_time_1': 'Pouco: menos de uma hora por dia ou algumas vezes',
      'c_time_2': 'Moderado: de 1 a 3 horas por dia ou rituais frequentes',
      'c_time_3': 'Muito: de 3 a 8 horas por dia ou rituais muito frequentes',
      'c_time_4': 'Quase constante: mais de 8 horas por dia',
      'c_interfere_0': 'Nada',
      'c_interfere_1': 'Pouco: quase não afetam o que faço',
      'c_interfere_2': 'Um pouco: interferem, mas ainda consigo lidar',
      'c_interfere_3': 'Muito: atrapalham claramente o meu dia',
      'c_interfere_4': 'Tanto que mal consigo funcionar',
      'c_distress_0': 'Nada',
      'c_distress_1': 'Um pouco inquieto',
      'c_distress_2': 'Moderadamente ansioso',
      'c_distress_3': 'Muito ansioso',
      'c_distress_4': 'Ansiedade esmagadora e incapacitante',
      'c_resist_0': 'Sempre tento resistir, ou quase não acontecem',
      'c_resist_1': 'Tento resistir na maior parte do tempo',
      'c_resist_2': 'Faço algum esforço para resistir',
      'c_resist_3': 'Cedo a quase todas sem muita resistência',
      'c_resist_4': 'Cedo completamente e por vontade própria',
      'c_control_0': 'Controle total: consigo me impedir facilmente',
      'c_control_1': 'Muito controle: geralmente consigo parar ou adiar',
      'c_control_2': 'Algum controle: às vezes consigo, às vezes não',
      'c_control_3': 'Pouco controle: raramente consigo parar ou adiar',
      'c_control_4': 'Nenhum controle: preciso concluí-las',
      'other': 'Opção de resposta',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': 'Agressividade ou dano',
      'contamination': 'Contaminação',
      'sexual': 'Sexual',
      'hoarding_obs': 'Acumulação ou guarda',
      'religious': 'Escrupulosidade religiosa ou moral',
      'symmetry_obs': 'Simetria ou exatidão',
      'somatic': 'Corpo ou doença',
      'misc_obs': 'Outras obsessões',
      'washing': 'Lavagem ou limpeza',
      'checking': 'Verificação',
      'repeating': 'Rituais de repetição',
      'counting': 'Contagem',
      'ordering': 'Ordenação ou organização',
      'misc_comp': 'Outras compulsões',
      'other': 'Outro tema',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': 'Medo de machucar a mim mesmo',
      'agg_harm_others': 'Medo de machucar outra pessoa',
      'agg_violent': 'Imagens violentas ou horríveis na minha mente',
      'agg_blurt': 'Medo de falar insultos ou obscenidades de repente',
      'agg_impulse': 'Medo de agir por um impulso indesejado',
      'agg_responsible': 'Medo de ser responsável por algo terrível',
      'con_dirt': 'Preocupação com sujeira ou germes',
      'con_bodily': 'Nojo de resíduos ou secreções corporais',
      'con_chemicals':
          'Preocupação com produtos químicos ou de limpeza doméstica',
      'con_ill': 'Medo de adoecer por contaminação',
      'con_spread': 'Medo de transmitir contaminação a outras pessoas',
      'con_sticky': 'Incômodo com substâncias ou resíduos pegajosos',
      'sex_forbidden':
          'Pensamentos ou imagens sexuais proibidos ou indesejados',
      'sex_others': 'Pensamentos sexuais sobre outras pessoas que me perturbam',
      'sex_orientation': 'Dúvidas indesejadas sobre minha orientação sexual',
      'sex_aggressive': 'Pensamentos sexuais agressivos sobre outras pessoas',
      'hoard_discard': 'Medo de jogar fora algo de que eu possa precisar',
      'hoard_value':
          'Sensação de que objetos têm um valor do qual não consigo abrir mão',
      'rel_sacrilege': 'Preocupação com sacrilégio ou blasfêmia',
      'rel_rightwrong': 'Preocupação excessiva com certo, errado ou moralidade',
      'rel_punish': 'Medo de punição por Deus ou pelo destino',
      'sym_even':
          'Necessidade de que as coisas estejam equilibradas ou “do jeito certo”',
      'sym_exact': 'Necessidade de exatidão, ordem ou precisão',
      'sym_incomplete': 'Sensação de incompletude até que tudo pareça certo',
      'som_illness': 'Preocupação excessiva com doença',
      'som_body': 'Preocupação excessiva com uma parte do corpo ou aparência',
      'misc_know': 'Necessidade de saber ou lembrar de coisas',
      'misc_saywrong': 'Medo de dizer algo errado',
      'misc_lucky': 'Números, palavras ou cores de sorte ou azar',
      'misc_sounds':
          'Sons, palavras ou músicas intrusivos que não consigo parar',
      'misc_lose': 'Medo de perder coisas',
      'wash_hands': 'Lavagem excessiva ou ritualizada das mãos',
      'wash_shower': 'Banho ou cuidados pessoais excessivos',
      'wash_clean': 'Limpeza excessiva de itens domésticos',
      'wash_avoid': 'Evitar coisas que considero contaminadas',
      'chk_locks': 'Verificar fechaduras, aparelhos, torneiras ou fogão',
      'chk_harm': 'Verificar se não machuquei ou não vou machucar alguém',
      'chk_mistake': 'Verificar se não cometi um erro',
      'chk_body': 'Verificar meu corpo em busca de sinais de doença',
      'rep_reread': 'Reler ou reescrever',
      'rep_routine':
          'Repetir ações rotineiras, como passar por portas ou subir e descer',
      'rep_untilright': 'Repetir até parecer “do jeito certo”',
      'cnt_count': 'Contar objetos, passos ou ações',
      'cnt_numbers': 'Fazer algo um determinado número de vezes',
      'ord_arrange': 'Organizar objetos até ficarem simétricos ou exatos',
      'ord_align': 'Alinhar ou endireitar objetos repetidamente',
      'mc_mental':
          'Rituais mentais, como orações silenciosas, frases ou revisões',
      'mc_reassure': 'Pedir reafirmação ou confessar repetidamente',
      'mc_touch': 'Precisar tocar, bater ou esfregar objetos',
      'mc_lists': 'Fazer listas excessivamente',
      'mc_avoid': 'Evitar situações para impedir um impulso',
      'other': 'Outro sintoma',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical':
          'Este total está na faixa subclínica da Y-BOCS. O resultado é um retrato do momento, não um diagnóstico.',
      'mild':
          'Este total está na faixa leve da Y-BOCS. O resultado é um retrato do momento, não um diagnóstico.',
      'moderate':
          'Este total está na faixa moderada da Y-BOCS. O resultado é um retrato do momento, não um diagnóstico.',
      'severe':
          'Este total está na faixa grave da Y-BOCS. Considere conversar sobre o impacto com um profissional qualificado.',
      'extreme':
          'Este total está na faixa extrema da Y-BOCS. Considere entrar em contato com um profissional qualificado. Se houver perigo imediato, contate os serviços de emergência locais.',
      'other':
          'Este total registrado é um retrato do momento, não um diagnóstico.',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Experimentos comportamentais',
      'newAction': 'Novo',
      'subtitle':
          'Compare uma previsão do OCD com o que você observa depois de uma ação planejada.',
      'loadError':
          'Seus experimentos não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este experimento?',
      'deleteBody':
          'Isso remove o experimento permanentemente deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir experimento',
      'deleteSuccess': 'Experimento excluído.',
      'deleteError':
          'Não foi possível excluir este experimento. Tente novamente.',
      'statusPlanned': 'Planejado',
      'statusCompleted': 'Concluído',
      'outcomeLabel': 'O que aconteceu',
      'learningLabel': 'O que anotei',
      'recordAction': 'Registrar o que aconteceu',
      'emptyTitle': 'Planeje um experimento comportamental',
      'emptyBody':
          'Anote a previsão do OCD, escolha uma pequena ação e depois registre o que você observou.',
      'emptyAction': 'Novo experimento',
      'outcomeEditorTitle': 'Registrar o que aconteceu',
      'newEditorTitle': 'Novo experimento',
      'predictedLabel': 'O OCD previu',
      'testActionLabel': 'Ação planejada',
      'outcomeInputLabel': 'O que realmente aconteceu?',
      'outcomeInputHint':
          'Registre o que você observou, sem avaliar o resultado',
      'learningInputLabel': 'Quer anotar algo? (opcional)',
      'learningInputHint': 'Um detalhe que você queira lembrar',
      'predictionInputLabel': 'O que o OCD prevê?',
      'predictionInputHint':
          'Por exemplo: Se eu não conferir de novo, a casa vai alagar',
      'confidenceQuestion': 'Quão certa parece a previsão?',
      'experimentInputLabel': 'Que ação vai testar a previsão?',
      'experimentInputHint':
          'Por exemplo: Sair após uma verificação normal e observar o que acontece',
      'saveOutcome': 'Salvar observação',
      'saveExperiment': 'Salvar experimento',
      'outcomeValidation': 'Adicione uma nota curta sobre o que você observou.',
      'planValidation':
          'Adicione a previsão do OCD e a ação que você planeja realizar.',
      'outcomeSaveSuccess': 'Observação salva.',
      'planSaveSuccess':
          'Experimento salvo. Registre o que aconteceu depois de realizá-lo.',
      'saveError':
          'Não foi possível salvar este experimento. Seu texto continua aqui. Tente novamente.',
      'other': 'Experimento comportamental',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentConfidence(String percent) {
    return '$percent de certeza';
  }

  @override
  String behavioralExperimentCardSummary(
    String status,
    String date,
    String confidence,
    String prediction,
    String experiment,
  ) {
    return '$status · $date · $confidence. Previsão: $prediction. Ação planejada: $experiment.';
  }

  @override
  String exposureReflectionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Reflexões sobre exposições',
      'newAction': 'Nova',
      'subtitle':
          'Registre o que você notou após uma exposição. Acrescente apenas os detalhes que parecerem úteis.',
      'loadError':
          'Suas reflexões não estão disponíveis no momento. Tente novamente.',
      'deleteTitle': 'Excluir esta reflexão?',
      'deleteBody': 'Isso exclui permanentemente a reflexão deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir reflexão',
      'deleteSuccess': 'Reflexão excluída.',
      'deleteError': 'Não foi possível excluir esta reflexão. Tente novamente.',
      'emptyTitle': 'Refletir sobre uma exposição',
      'emptyBody':
          'Registre o que aconteceu, o que o TOC previu e tudo o que você quiser lembrar. Apenas a primeira pergunta é obrigatória.',
      'emptyAction': 'Nova reflexão',
      'editorTitle': 'Nova reflexão',
      'whatHappenedLabel': 'O que aconteceu?',
      'whatHappenedHint': 'A exposição ou prática que você realizou',
      'predictionLabel': 'O que o TOC previu?',
      'predictionHint': 'O resultado que o TOC disse que poderia acontecer',
      'actualLabel': 'O que você observou?',
      'actualHint': 'O que aconteceu durante ou após a exposição',
      'learningLabel': 'Algo que você queira lembrar? (opcional)',
      'learningHint': 'Um detalhe que pode ser útil mais tarde',
      'nextTimeLabel': 'Algo que você pode mudar? (opcional)',
      'nextTimeHint': 'Deixe em branco se nada vier à mente',
      'saveAction': 'Salvar reflexão',
      'validation':
          'Comece com uma breve anotação sobre o que aconteceu. As outras perguntas são opcionais.',
      'saveSuccess': 'Reflexão salva.',
      'saveError':
          'Não foi possível salvar esta reflexão. Seu texto continua aqui. Tente novamente.',
      'other': 'Reflexão sobre uma exposição',
    });
    return '$_temp0';
  }

  @override
  String exposureReflectionCardSummary(String date, String whatHappened) {
    return '$date. O que aconteceu: $whatHappened.';
  }

  @override
  String implementationIntentionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Planos se-então',
      'newAction': 'Novo',
      'subtitle':
          'Associe uma situação a uma resposta que você queira experimentar quando ela acontecer.',
      'loadError':
          'Seus planos se-então não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este plano se-então?',
      'deleteBody': 'Isso exclui permanentemente o plano deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir plano se-então',
      'deleteSuccess': 'Plano se-então excluído.',
      'deleteError':
          'Não foi possível excluir este plano se-então. Tente novamente.',
      'emptyTitle': 'Crie um plano se-então',
      'emptyBody':
          'Escreva uma situação e a resposta que você queira experimentar quando ela acontecer.',
      'emptyAction': 'Novo plano se-então',
      'editorTitle': 'Novo plano se-então',
      'triggerLabel': 'Se…',
      'triggerHint':
          'A situação, por exemplo: noto a vontade de buscar confirmação',
      'responseLabel': 'então eu vou…',
      'responseHint':
          'A resposta que você quer experimentar, por exemplo: anotar o que estou percebendo',
      'saveAction': 'Salvar plano se-então',
      'validation':
          'Adicione a situação e a resposta que você quer experimentar.',
      'saveSuccess': 'Plano se-então salvo.',
      'saveError':
          'Não foi possível salvar este plano se-então. Seu texto continua aqui. Tente novamente.',
      'other': 'Plano se-então',
    });
    return '$_temp0';
  }

  @override
  String implementationIntentionStatement(String trigger, String response) {
    return 'Se $trigger, então $response.';
  }

  @override
  String uncertaintyTrainingText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Prática da incerteza',
      'subtitle': 'Pratique dar espaço ao não saber.',
      'loadError':
          'As contagens de práticas não estão disponíveis agora. Você ainda pode abrir os exercícios.',
      'whyLabel': 'SOBRE ESTA PRÁTICA',
      'willingnessLabel': 'Quão disposto você estava a permanecer sem saber?',
      'noteLabel': 'Nota (opcional)',
      'noteHint': 'O que você percebeu?',
      'saveAction': 'Registrar esta prática',
      'saveSuccess': 'Prática registrada.',
      'saveError':
          'Não foi possível registrar esta prática. Sua nota continua aqui. Tente novamente.',
      'other': 'Prática da incerteza',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseTitle(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': 'Talvez sim, talvez não',
      'unanswered': 'Deixe sem resposta',
      'resist': 'Pause a busca por certeza',
      'other': 'Exercício de incerteza',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseIntro(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Quando o OCD pedir certeza, experimente responder “talvez sim, talvez não” e volte a atenção ao que você estava fazendo.',
      'unanswered':
          'Deixe uma pergunta recorrente em aberto em vez de resolvê-la.',
      'resist':
          'Perceba a vontade de conferir, pesquisar ou buscar confirmação e escolha não segui-la durante esta prática.',
      'other': 'Uma prática para permitir que a incerteza continue presente.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseWhy(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Este exercício pratica deixar uma pergunta sem resposta, sem acrescentar confirmação.',
      'unanswered':
          'Este exercício pratica permitir que uma pergunta continue em aberto.',
      'resist':
          'Este exercício registra a prática deliberada de não buscar certeza.',
      'other': 'Este é um exercício de autoajuda para dar espaço à incerteza.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExercisePrompt(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Escolha uma preocupação e responda “talvez sim, talvez não”. Perceba o que está presente sem tentar resolver.',
      'unanswered':
          'Escolha uma pergunta que você normalmente resolveria e deixe-a sem resposta durante esta prática.',
      'resist':
          'Perceba uma vontade de buscar certeza e deixe-a sem resposta durante esta prática.',
      'other':
          'Escolha uma pequena forma de deixar a incerteza sem resposta durante esta prática.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyPracticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas',
      one: '1 prática',
    );
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseSummary(String title, String intro) {
    return '$title. $intro';
  }

  @override
  String uncertaintyExerciseSummaryWithCount(
    String title,
    String intro,
    int count,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas registradas.',
      one: '1 prática registrada.',
    );
    return '$title. $intro $_temp0';
  }

  @override
  String uncertaintyWillingness(int value) {
    return 'Disposição: $value de 10';
  }

  @override
  String actionPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Planejador de ações',
      'newAction': 'Novo',
      'subtitle':
          'Registre uma situação e a resposta que você quer experimentar.',
      'loadError':
          'Seus planos de ação não estão disponíveis agora. Tente novamente.',
      'deleteTitle': 'Excluir este plano de ação?',
      'deleteBody': 'Isso exclui permanentemente o plano deste dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Excluir',
      'deleteTooltip': 'Excluir plano de ação',
      'deleteSuccess': 'Plano de ação excluído.',
      'deleteError':
          'Não foi possível excluir este plano de ação. Tente novamente.',
      'statePlanned': 'Planejado',
      'stateCompleted': 'Marcado como concluído',
      'toggleMarkComplete': 'Marcar plano de ação como concluído',
      'toggleMarkIncomplete': 'Marcar plano de ação como não concluído',
      'toggleSuccessComplete': 'Plano de ação marcado como concluído.',
      'toggleSuccessIncomplete': 'Plano de ação marcado como não concluído.',
      'toggleError':
          'Não foi possível atualizar este plano de ação. O estado anterior continua sendo exibido. Tente novamente.',
      'emptyTitle': 'Crie um plano de ação',
      'emptyBody':
          'Escreva uma situação e a resposta que você quer experimentar quando ela acontecer.',
      'emptyAction': 'Novo plano de ação',
      'editorTitle': 'Novo plano de ação',
      'situationLabel': 'Quando o OCD aparecer',
      'situationHint': 'Por exemplo: percebo a vontade de pesquisar um sintoma',
      'actionLabel': 'Resposta que quero experimentar',
      'actionHint':
          'Por exemplo: esperar 15 minutos antes de decidir se pesquiso',
      'dateLabel': 'Data (opcional)',
      'pickDate': 'Escolher uma data',
      'clearDate': 'Remover data',
      'notesLabel': 'Notas (opcional)',
      'notesHint': 'Qualquer coisa que você queira lembrar',
      'saveAction': 'Salvar plano de ação',
      'validation':
          'Adicione a situação e a resposta que você quer experimentar.',
      'saveSuccess': 'Plano de ação salvo.',
      'saveError':
          'Não foi possível salvar este plano de ação. Seu texto continua aqui. Tente novamente.',
      'other': 'Plano de ação',
    });
    return '$_temp0';
  }

  @override
  String actionPlanCardSummary(String status, String situation, String action) {
    return '$status. Situação: $situation. Resposta planejada: $action.';
  }

  @override
  String actionPlanDateSummary(String date) {
    return 'Data planejada: $date.';
  }

  @override
  String settingsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'proActiveMessage': 'O Patterns Pro está ativo neste dispositivo.',
      'welcomeScheduled':
          'As telas de boas-vindas aparecerão na próxima vez que você abrir o Patterns.',
      'exportPromptTitle': 'Exportar dados?',
      'exportPromptBody':
          'O Patterns cria um backup ZIP não criptografado dos seus registros locais. Salve-o em um local privado.',
      'exportBackupAction': 'Exportar backup ZIP',
      'exportDialogTitle': 'Exportar dados do Patterns',
      'exportSucceeded': 'Dados exportados.',
      'exportFailed':
          'A exportação falhou. Seus dados não foram alterados. Tente novamente.',
      'importPromptTitle': 'Importar dados?',
      'importPromptBody':
          'Escolha um backup do Patterns em ZIP ou JSON. Você poderá revisar o conteúdo antes de substituir seus registros atuais.',
      'chooseBackupAction': 'Escolher backup',
      'importDialogTitle': 'Selecionar backup do Patterns',
      'backupUnreadable':
          'O Patterns não conseguiu ler este arquivo de backup. Escolha outro arquivo.',
      'backupInvalid':
          'Este não é um backup válido do Patterns. Seus dados atuais não foram alterados.',
      'importFailed':
          'A importação falhou. Seus dados atuais não foram alterados. Tente novamente.',
      'importPreviewTitle': 'Substituir os dados atuais?',
      'importPreviewIntro':
          'Este backup contém os seguintes registros locais. A importação substituirá seus registros atuais.',
      'replaceAction': 'Substituir dados',
      'importSucceeded': 'Dados importados.',
      'wipePromptTitle': 'Apagar todos os dados locais?',
      'wipePromptBody':
          'Isso exclui permanentemente deste dispositivo as entradas do diário, os registros de OCD, o histórico de práticas de recuperação, os materiais salvos localmente e as preferências do aplicativo. Não é possível desfazer. Sua compra do Patterns Pro continua vinculada à conta da loja, mas este dispositivo esquecerá o desbloqueio local. Você poderá restaurá-lo depois.',
      'wipeAction': 'Apagar dados',
      'wipeSucceeded': 'Dados locais apagados.',
      'wipeFailed':
          'O Patterns não conseguiu terminar de apagar os dados locais. Tente novamente.',
      'appLockDisabled': 'Bloqueio do aplicativo desativado.',
      'deviceLockUnavailable':
          'O bloqueio do dispositivo não está disponível. Configure um código ou biometria e tente novamente.',
      'appLockReason':
          'Desbloqueie o Patterns para ativar o bloqueio do aplicativo.',
      'appLockEnabled': 'Bloqueio do aplicativo ativado.',
      'appLockTemporaryLockout':
          'Muitas tentativas. Tente novamente em instantes.',
      'appLockBiometricLockout':
          'A autenticação biométrica está bloqueada. Primeiro desbloqueie o dispositivo com o código.',
      'appLockEnableFailed':
          'O Patterns não conseguiu alterar o bloqueio do aplicativo. Tente novamente.',
      'reminderOff': 'Lembrete diário desativado.',
      'notificationsUnavailable':
          'As notificações do Patterns estão desativadas. Ative-as nas configurações do dispositivo para receber lembretes.',
      'reminderOn': 'Lembrete diário ativado.',
      'reminderChangeFailed':
          'O Patterns não conseguiu alterar o lembrete. A configuração anterior continua em vigor.',
      'analyticsChangeFailed':
          'O Patterns não conseguiu alterar o compartilhamento anônimo. A configuração anterior continua em vigor.',
      'privacyPolicyFailed':
          'O Patterns não conseguiu abrir a política de privacidade. Tente novamente.',
      'other': 'Configurações',
    });
    return '$_temp0';
  }

  @override
  String settingsBackupJournalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas no diário',
      one: '1 entrada no diário',
      zero: 'Nenhuma entrada no diário',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupOcdCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos de OCD',
      one: '1 evento de OCD',
      zero: 'Nenhum evento de OCD',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupDelayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessões de adiamento',
      one: '1 sessão de adiamento',
      zero: 'Nenhuma sessão de adiamento',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupErpPlanCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count planos de ERP',
      one: '1 plano de ERP',
      zero: 'Nenhum plano de ERP',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupErpPracticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count práticas de ERP',
      one: '1 prática de ERP',
      zero: 'Nenhuma prática de ERP',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupRecoveryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count outros registros de ferramentas de recuperação',
      one: '1 outro registro de ferramenta de recuperação',
      zero: 'Nenhum outro registro de ferramentas de recuperação',
    );
    return '$_temp0';
  }

  @override
  String settingsBackupSelfCheckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count autoquestionários Y-BOCS',
      one: '1 autoquestionário Y-BOCS',
      zero: 'Nenhum autoquestionário Y-BOCS',
    );
    return '$_temp0';
  }

  @override
  String settingsReminderSetFor(String time) {
    return 'Lembrete definido para $time.';
  }

  @override
  String get appUnlockReason => 'Desbloqueie o Patterns para continuar.';

  @override
  String get appLockUnavailableDisabled =>
      'A autenticação biométrica não está disponível. O bloqueio do aplicativo foi desativado.';

  @override
  String get appUnlockFailed =>
      'Não foi possível desbloquear o Patterns. Tente novamente.';

  @override
  String get privacyScreenLabel => 'Tela de privacidade do Patterns';

  @override
  String get unlockingAction => 'Desbloqueando…';

  @override
  String get unlockAction => 'Desbloquear';

  @override
  String get analyticsPromptTitle => 'Ajudar a melhorar o Patterns?';

  @override
  String get analyticsPromptBody =>
      'Compartilhe eventos anônimos de uso de recursos para ajudar a melhorar o Patterns. Entradas do diário, conteúdo de OCD, avaliações, notas, resumos gerados, região e idioma escolhido nunca são incluídos. O compartilhamento permanece desativado até você escolher ativá-lo.';

  @override
  String get notNowAction => 'Agora não';

  @override
  String get shareAnonymousUsageAction => 'Compartilhar uso anônimo';
}
