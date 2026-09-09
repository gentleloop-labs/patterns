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
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Configurações';

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
}
