// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsDataSection => 'Datos';

  @override
  String get settingsExportDataTitle => 'Exportar datos';

  @override
  String get settingsExportDataSubtitle =>
      'Guarda tus registros en una copia JSON local';

  @override
  String get settingsImportDataTitle => 'Importar datos';

  @override
  String get settingsImportDataSubtitle =>
      'Restaura entradas desde una copia ZIP o JSON';

  @override
  String get settingsRemindersSection => 'Recordatorios';

  @override
  String get settingsDailyReminderTitle => 'Recordatorio diario';

  @override
  String settingsDailyReminderAt(String time) {
    return 'Un recordatorio amable a las $time';
  }

  @override
  String get settingsDailyReminderOff =>
      'Un recordatorio amable para registrarte cada día';

  @override
  String get settingsReminderTimeTitle => 'Hora del recordatorio';

  @override
  String get settingsPrivacySection => 'Privacidad';

  @override
  String get settingsPrivacySafetySubtitle =>
      'Cómo se gestionan tus datos locales';

  @override
  String get settingsAnalyticsTitle => 'Compartir análisis de uso anónimos';

  @override
  String get settingsAnalyticsSubtitle =>
      'Comparte solo eventos de uso de funciones. Nunca incluye datos personales sobre el OCD.';

  @override
  String get settingsAppLockTitle => 'Bloqueo de la aplicación';

  @override
  String get settingsAppLockSubtitle =>
      'Solicita desbloquear el dispositivo al volver a abrir Patterns';

  @override
  String get settingsWipeTitle => 'Borrar todos los datos';

  @override
  String get settingsWipeSubtitle =>
      'Elimina entradas locales y restablece las preferencias';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Pro está activo';

  @override
  String get settingsProActiveSubtitle =>
      'Todas las herramientas de recuperación están desbloqueadas. Gracias.';

  @override
  String get settingsUnlockProTitle => 'Desbloquear Patterns Pro';

  @override
  String get settingsUnlockProSubtitle =>
      'Pago único para todas las herramientas de recuperación';

  @override
  String get settingsRestorePurchasesTitle => 'Restaurar compras';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Restaura un desbloqueo anterior de Patterns Pro';

  @override
  String get settingsHelpSection => 'Ayuda';

  @override
  String get settingsReplayTourTitle => 'Repetir el recorrido';

  @override
  String get settingsReplayTourSubtitle =>
      'Vuelve a ver para qué sirve cada pestaña';

  @override
  String get settingsShowWelcomeTitle => 'Mostrar las pantallas de bienvenida';

  @override
  String get settingsShowWelcomeSubtitle =>
      'Muestra la introducción la próxima vez que abras Patterns';

  @override
  String get settingsFeedbackSection => 'Comentarios';

  @override
  String get settingsRateTitle => 'Calificar Patterns';

  @override
  String get settingsRateSubtitle => 'Comparte tu opinión en la tienda';

  @override
  String get settingsSendFeedbackTitle => 'Enviar comentarios';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Comparte una idea o cuéntanos qué salió mal';

  @override
  String get settingsSupportTitle => 'Apoyar Patterns';

  @override
  String get settingsSupportSubtitle =>
      'Deja una propina opcional para apoyar el desarrollo';

  @override
  String get appearanceTitle => 'Apariencia';

  @override
  String get appearanceSystem => 'Sistema';

  @override
  String get appearanceLight => 'Claro';

  @override
  String get appearanceDark => 'Oscuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSubtitle => 'Elija el idioma que usa Patterns';

  @override
  String get calmInsightsTitle => 'Información sin presión';

  @override
  String get calmInsightsSubtitle =>
      'Oculta las rachas y las puntuaciones calculadas. Sus datos registrados siguen disponibles.';

  @override
  String get calmRecentActivityTitle => 'Su actividad reciente';

  @override
  String get calmNoRecentActivity =>
      'No hay registros en los últimos 7 días. Este espacio estará listo cuando lo necesite.';

  @override
  String calmJournalActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas de diario',
      one: '1 entrada de diario',
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
      other: '$count aplazamientos de compulsión',
      one: '1 aplazamiento de compulsión',
    );
    return '$_temp0';
  }

  @override
  String calmErpActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prácticas de ERP',
      one: '1 práctica de ERP',
    );
    return '$_temp0';
  }

  @override
  String calmExposureActivity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count exposiciones completadas',
      one: '1 exposición completada',
    );
    return '$_temp0';
  }

  @override
  String get recoveryMetricsTitle => 'Actividad de recuperación';

  @override
  String get recoveryMetricsTeaserTitle => 'Reúne tu actividad de recuperación';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'Consulta exposiciones, sesiones de práctica y cambios registrados en la urgencia en tus herramientas de ERP. Desbloquéalo con Patterns Pro.';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'Consulta rachas de práctica, exposiciones completadas y cambios registrados en la urgencia en tus herramientas de ERP. Desbloquéalo con Patterns Pro.';

  @override
  String get recoveryMetricsUnlockPro => 'Desbloquear Patterns Pro';

  @override
  String get recoveryMetricsEmptyTitle =>
      'Tu actividad de recuperación aparecerá aquí';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      'Practica un retraso, una sesión de ERP o un paso de exposición para ver aquí recuentos objetivos de actividad.';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      'Practica un retraso, una sesión de ERP o un paso de exposición para empezar tu historial de actividad y tu racha de práctica.';

  @override
  String get recoveryMetricsExposuresDone => 'Exposiciones completadas';

  @override
  String get recoveryMetricsSessionsPracticed => 'Sesiones practicadas';

  @override
  String get recoveryMetricsAverageUrgeDrop =>
      'Cambio medio registrado en la urgencia';

  @override
  String get recoveryMetricsThisWeek => 'Esta semana';

  @override
  String recoveryMetricsDayStreak(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Racha de $days días',
      one: 'Racha de 1 día',
    );
    return '$_temp0';
  }

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get doneAction => 'Listo';

  @override
  String get doneForNowAction => 'Terminar por ahora';

  @override
  String get completionSavedTitle => 'Guardado';

  @override
  String get completionPracticeTitle => 'Práctica registrada';

  @override
  String get completionJournalBody =>
      'La entrada del diario se guardó en este dispositivo.';

  @override
  String get completionTrackedBody =>
      'El momento registrado se guardó en este dispositivo.';

  @override
  String get completionTrackedUpdatedBody =>
      'El momento registrado se actualizó.';

  @override
  String get completionDelayBody =>
      'La práctica de aplazamiento de la compulsión se registró.';

  @override
  String get completionErpBody => 'La práctica de ERP se registró.';

  @override
  String get notificationOpenAction => 'Abrir notificación';

  @override
  String get dailyReminderChannelName => 'Recordatorio diario';

  @override
  String get dailyReminderChannelDescription =>
      'Un recordatorio diario amable para dedicar un momento a Patterns.';

  @override
  String get dailyReminderTitle => 'Un momento de calma';

  @override
  String get dailyReminderBody =>
      'Tómese un momento tranquilo con Patterns cuando esté preparado.';

  @override
  String get practiceTimerChannelName => 'Temporizador de práctica';

  @override
  String get practiceTimerChannelDescription =>
      'Un aviso amable cuando finalice el tiempo de práctica.';

  @override
  String get appUpdatesChannelName => 'Actualizaciones de la aplicación';

  @override
  String get appUpdatesChannelDescription =>
      'Avisos ocasionales cuando Patterns incorpore herramientas de recuperación importantes.';

  @override
  String get updateAnnouncementTitle => 'Patterns ha mejorado';

  @override
  String get updateAnnouncementBody =>
      'Ya están disponibles nuevas herramientas de recuperación, información sobre el progreso y un inicio más tranquilo.';

  @override
  String get practiceWindowCompleteTitle => 'Tiempo de práctica finalizado';

  @override
  String get practiceWindowCompleteBody =>
      'Tómese un momento para observar lo que ocurrió.';

  @override
  String get erpWindowCompleteTitle => 'Tiempo de práctica de ERP finalizado';

  @override
  String get erpWindowCompleteBody =>
      'Tómese un momento para reflexionar sobre lo ocurrido.';

  @override
  String get navToday => 'Hoy';

  @override
  String get navHome => 'Inicio';

  @override
  String get navJournal => 'Diario';

  @override
  String get navTrack => 'Registrar';

  @override
  String get navTracker => 'Registro';

  @override
  String get navRecovery => 'Recuperación';

  @override
  String get navInsights => 'Análisis';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get exportReportTitle => 'Exportar informe';

  @override
  String get exportReportDescription =>
      'Guarda un PDF combinado de tu diario, registro de OCD y análisis. Tú eliges dónde guardarlo y si quieres compartirlo.';

  @override
  String get exportTimeWindow => 'Periodo';

  @override
  String get exportStart => 'Inicio';

  @override
  String get exportEnd => 'Fin';

  @override
  String get exportIncludeSections => 'Incluir secciones';

  @override
  String get exportAnalyticsSummary => 'Resumen de análisis';

  @override
  String get exportJournalEntries => 'Entradas del diario';

  @override
  String get exportOcdEvents => 'Eventos de OCD';

  @override
  String get exportYbocsSelfChecks => 'Autoevaluaciones Y-BOCS';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total entradas',
      one: '1 entrada',
      zero: 'No hay entradas',
    );
    return '$_temp0 en este periodo ($journal diario, $ocd OCD, $selfChecks autoevaluaciones)';
  }

  @override
  String get exportLargeReport =>
      'Este informe es grande y puede tardar un momento en generarse.';

  @override
  String get exportPrivacyWarning =>
      'Esto crea un PDF sin cifrar. Guárdalo en un lugar privado.';

  @override
  String get exportSavePdf => 'Guardar PDF';

  @override
  String get exportSelectSectionError =>
      'Selecciona al menos una sección para exportar.';

  @override
  String get exportNoEntriesError =>
      'No hay entradas que coincidan con este periodo y selección.';

  @override
  String get exportReportSaved => 'Informe guardado';

  @override
  String get exportReportFailed => 'No se pudo crear el informe';

  @override
  String get rangeSevenDays => '7 d';

  @override
  String get rangeThirtyDays => '30 d';

  @override
  String get rangeNinetyDays => '90 d';

  @override
  String get rangeYear => 'Año';

  @override
  String get rangeAll => 'Todo';

  @override
  String get rangeCustom => 'Personalizado';

  @override
  String get rangeLastSevenDays => 'Últimos 7 días';

  @override
  String get rangeLastThirtyDays => 'Últimos 30 días';

  @override
  String get rangeLastNinetyDays => 'Últimos 90 días';

  @override
  String get rangeLastYear => 'Último año';

  @override
  String get rangeAllTime => 'Todo el tiempo';

  @override
  String get pdfPersonalReport => 'Informe personal';

  @override
  String pdfGenerated(String date) {
    return 'Generado el $date';
  }

  @override
  String get pdfDisclaimer =>
      'Este informe contiene notas personales creadas en Patterns para la autorreflexión. No es asesoramiento médico ni sustituye la atención de un profesional cualificado.';

  @override
  String get pdfJournalCount => 'Entradas del diario';

  @override
  String get pdfOcdCount => 'Eventos de OCD';

  @override
  String get pdfAverageDistress => 'Malestar promedio';

  @override
  String get pdfObsessions => 'Obsesiones';

  @override
  String get pdfCompulsions => 'Compulsiones';

  @override
  String get pdfNoJournalEntries =>
      'No hay entradas del diario en este periodo.';

  @override
  String get pdfNoOcdEvents => 'No hay eventos de OCD en este periodo.';

  @override
  String get pdfObsession => 'Obsesión';

  @override
  String get pdfCompulsion => 'Compulsión';

  @override
  String pdfDistressScore(int score) {
    return 'Malestar $score/10';
  }

  @override
  String get pdfThought => 'Pensamiento';

  @override
  String get pdfUrge => 'Impulso';

  @override
  String pdfResponse(String text) {
    return 'Respuesta: $text';
  }

  @override
  String pdfActionTaken(String text) {
    return 'Acción realizada: $text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scale, autoevaluada en la app. El total es de 40, con 20 para obsesiones y 20 para compulsiones.';

  @override
  String get pdfMostRecentTotal => 'Total más reciente';

  @override
  String get pdfTakenOn => 'Realizada el';

  @override
  String get pdfObsessionsSubtotal => 'Subtotal de obsesiones';

  @override
  String get pdfCompulsionsSubtotal => 'Subtotal de compulsiones';

  @override
  String get pdfChangeAcrossRange => 'Cambio en el periodo';

  @override
  String get pdfSelfChecksInRange => 'Autoevaluaciones en el periodo';

  @override
  String get pdfThemesFlagged => 'Temas marcados';

  @override
  String get pdfSingleSelfCheck => 'Una autoevaluación en este periodo';

  @override
  String pdfChangeSince(String change, String date) {
    return '$change desde el $date';
  }

  @override
  String get pdfDate => 'Fecha';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfBand => 'Nivel';

  @override
  String get severitySubclinical => 'Subclínico';

  @override
  String get severityMild => 'Leve';

  @override
  String get severityModerate => 'Moderado';

  @override
  String get severitySevere => 'Severo';

  @override
  String get severityExtreme => 'Extremo';

  @override
  String get backAction => 'Atrás';

  @override
  String get onboardingSafetyFootnote =>
      'Privado por diseño. No es un diagnóstico ni sustituye la atención profesional.';

  @override
  String get onboardingHeadline =>
      'Un lugar tranquilo para practicar con el OCD.';

  @override
  String get onboardingIntroduction =>
      'Registre el pensamiento intrusivo, retrase la compulsión y practique una respuesta diferente, paso a paso.';

  @override
  String get onboardingPrivacy =>
      'Sus datos de OCD permanecen en este dispositivo. Sin cuenta. Sin sincronización en la nube.';

  @override
  String get getStartedAction => 'Comenzar';

  @override
  String get importExistingDataAction => 'Importar datos existentes';

  @override
  String get onboardingQuestion => '¿Qué le ayudaría ahora?';

  @override
  String get onboardingPickOne =>
      'Elija una opción. Podrá hacer el resto cuando quiera.';

  @override
  String get onboardingUrgeTitle => 'Estoy luchando contra un impulso';

  @override
  String get onboardingUrgeSubtitle =>
      'Ponga algo de tiempo entre el impulso y el ritual.';

  @override
  String get onboardingJournalTitle => 'Quiero escribir algo';

  @override
  String get onboardingJournalSubtitle =>
      'Saque el pensamiento de su mente y póngalo en una página.';

  @override
  String get onboardingErpTitle => 'Quiero practicar no hacer una compulsión';

  @override
  String get onboardingErpSubtitle => 'Una exposición breve y guiada.';

  @override
  String get onboardingSelfCheckTitle => 'Quiero saber cómo está mi OCD ahora';

  @override
  String get onboardingSelfCheckSubtitle =>
      'La autoevaluación Y-BOCS. Unos 10 minutos.';

  @override
  String get onboardingExploreTitle => 'Solo estoy explorando';

  @override
  String get onboardingExploreSubtitle => 'Primero eche un vistazo.';

  @override
  String get whatsNewTitle => 'Practique sin presión';

  @override
  String get whatsNewBody =>
      'Patterns 1.10 incorpora Insights tranquilos, finales de sesión más sencillos, mejoras de accesibilidad y selección opcional de idioma.';

  @override
  String get whatsNewLanguagesTitle => 'Insights tranquilos';

  @override
  String get whatsNewLanguagesBody =>
      'Elija resúmenes objetivos de actividad en lugar de puntuaciones, rachas y porcentajes de constancia calculados.';

  @override
  String get whatsNewPrivateTitle => 'Un final claro';

  @override
  String get whatsNewPrivateBody =>
      'El diario, el seguimiento, el aplazamiento de compulsiones y las sesiones de ERP terminan con una confirmación objetiva y Terminar por ahora.';

  @override
  String get whatsNewReportsTitle => 'Más accesible, en su idioma';

  @override
  String get whatsNewReportsBody =>
      'Las etiquetas mejoradas y la reducción de movimiento se unen al inglés, portugués de Brasil, alemán, japonés, español y francés.';

  @override
  String get whatsNewExploreAction => 'Explorar Patterns 1.10';

  @override
  String get continueToPatternsAction => 'Continuar a Patterns';

  @override
  String get whatsNewNotificationNote =>
      'Sus entradas se conservan tal como las escribió. El idioma e Insights tranquilos permanecen en este dispositivo y no se incluyen en analíticas ni copias de seguridad.';

  @override
  String get formatBold => 'Negrita';

  @override
  String get formatItalic => 'Cursiva';

  @override
  String get formatBulletedList => 'Lista con viñetas';

  @override
  String get formatToggleHint =>
      'Toque dos veces para activar o desactivar este formato.';

  @override
  String get journalEditorLabel => 'Editor del diario';

  @override
  String get journalEditorHint =>
      'Introduzca el texto del diario. Los controles de formato aparecen después del editor.';

  @override
  String timerRemaining(String time) {
    return 'Tiempo restante: $time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return 'Puntuación de recuperación: $score de 100.';
  }

  @override
  String get privacySafetyTitle => 'Privacidad y seguridad';

  @override
  String get privacyLocalContent =>
      'Las entradas del diario, eventos de OCD, niveles de malestar, reflexiones y preferencias se guardan localmente en este dispositivo.';

  @override
  String get privacyPurchases =>
      'Patterns Pro y las propinas se procesan en la tienda de apps. Patterns no recibe los datos de su tarjeta de pago.';

  @override
  String get privacyExports =>
      'Una exportación manual crea una copia JSON o un informe PDF sin cifrar solo donde usted decide guardarlo o compartirlo.';

  @override
  String get privacyAnalytics =>
      'Las analíticas anónimas están desactivadas salvo que usted las active. Si lo hace, Patterns envía eventos de uso con nombre, un identificador aleatorio de instalación, plataforma, versión y hora al servicio propio. Nunca incluye entradas, datos de OCD, resúmenes generados, configuración regional ni idioma elegido. Al desactivarlas se borran los eventos pendientes y el identificador local.';

  @override
  String get privacyClinicalBoundary =>
      'Patterns es una herramienta de autoayuda para la reflexión personal y la práctica de ERP. No diagnostica ni trata el OCD, no sustituye la atención de un profesional cualificado y no ofrece asistencia de emergencia.';

  @override
  String get viewPrivacyPolicyAction => 'Ver la Política de Privacidad';

  @override
  String get closeAction => 'Cerrar';

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools =>
      'También incluye todas las herramientas Pro de planificación, práctica, métricas y reflexión.';

  @override
  String get proPaywallAlreadyPurchased =>
      '¿Ya compraste Pro? No se te volverá a cobrar.';

  @override
  String get proPaywallTryAgainAction => 'Volver a intentar';

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
      'Las compras dentro de la app no están disponibles en este dispositivo.';

  @override
  String get proPaywallProductUnavailable =>
      'Patterns Pro no está disponible en este momento. Inténtalo de nuevo más tarde.';

  @override
  String get proPaywallProductLoadFailed =>
      'No se pudo cargar Patterns Pro. Inténtalo de nuevo más tarde.';

  @override
  String get proPaywallPurchaseStartFailed => 'No se pudo iniciar la compra.';

  @override
  String get proPaywallPurchaseFailed =>
      'No se pudo completar la compra. Inténtalo de nuevo.';

  @override
  String get proPaywallRestoreNotFound =>
      'No se encontró ninguna compra anterior en esta cuenta. Si compraste Pro con otra cuenta, inicia sesión con ella e inténtalo de nuevo.';

  @override
  String get proPaywallRestoreFailed =>
      'No se pudieron restaurar las compras. Inténtalo de nuevo.';

  @override
  String get proPaywallWelcomeBack => 'Te damos la bienvenida de nuevo';

  @override
  String get proPaywallAllSet => 'Todo listo';

  @override
  String get proPaywallRestoredBody =>
      'Patterns Pro se restauró en este dispositivo.';

  @override
  String get proPaywallUnlockedBody =>
      'Patterns Pro está desbloqueado. Todas las herramientas de recuperación ya están disponibles.';

  @override
  String get proPaywallContinueAction => 'Continuar';

  @override
  String get proPaywallLoadingLabel => 'Cargando Patterns Pro';

  @override
  String get proHeadlineSettings =>
      'Pasar del registro a la práctica de recuperación';

  @override
  String get proHeadlineTodayNextStep => 'Continuar con la práctica de hoy';

  @override
  String get proHeadlineRecoveryMetrics =>
      'Revisar la actividad de recuperación';

  @override
  String get proHeadlineExposureHierarchy =>
      'Crear una jerarquía clara de exposición';

  @override
  String get proHeadlineExposureMaterials =>
      'Mantener juntos los materiales de práctica';

  @override
  String get proHeadlineStructuredPrograms =>
      'Convertir la recuperación en una rutina';

  @override
  String get proHeadlineActionPlanner =>
      'Planificar una respuesta antes de que aparezca el TOC';

  @override
  String get proHeadlineImplementationIntentions =>
      'Facilitar la siguiente elección';

  @override
  String get proHeadlineUrgeSurfing => 'Practicar cómo dejar pasar el impulso';

  @override
  String get proHeadlineResponsePrevention => 'Registrar la respuesta elegida';

  @override
  String get proHeadlineUncertaintyTraining =>
      'Practicar cómo dejar espacio al quizás';

  @override
  String get proHeadlineBehavioralExperiments =>
      'Poner a prueba las predicciones del TOC';

  @override
  String get proHeadlineReflectionJournal =>
      'Registrar lo aprendido en cada práctica';

  @override
  String get proBenefitGeneralPlans =>
      'Crear jerarquías de exposición y planes de práctica';

  @override
  String get proBenefitGeneralResponsePrevention =>
      'Usar herramientas específicas de prevención de respuesta';

  @override
  String get proBenefitGeneralReview =>
      'Revisar la actividad de recuperación y las reflexiones';

  @override
  String get proBenefitMetricsActivity =>
      'Revisar la actividad de práctica a lo largo del tiempo';

  @override
  String get proBenefitMetricsNonjudgmental =>
      'Ver la actividad registrada sin juzgar días concretos';

  @override
  String get proBenefitMetricsPatterns =>
      'Explorar patrones objetivos de recuperación';

  @override
  String get proBenefitExposureLadder =>
      'Ordenar los pasos de más suaves a más difíciles';

  @override
  String get proBenefitExposureMaterials =>
      'Tener cerca guiones, audios en bucle, imágenes y enlaces';

  @override
  String get proBenefitExposureRepeatable =>
      'Convertir un plan en una práctica repetible';

  @override
  String get proBenefitProgramsStructure =>
      'Seguir una estructura semanal tranquila';

  @override
  String get proBenefitProgramsTasks =>
      'Mantener las tareas de práctica en un solo lugar';

  @override
  String get proBenefitProgramsReview => 'Revisar qué ayudó al continuar';

  @override
  String get proBenefitPlanningAhead =>
      'Elegir una respuesta antes del momento difícil';

  @override
  String get proBenefitPlanningIfThen => 'Crear planes prácticos si-entonces';

  @override
  String get proBenefitPlanningReturn =>
      'Volver al plan cuando aumente la incertidumbre';

  @override
  String get proBenefitInMomentTools =>
      'Usar herramientas de práctica en el momento';

  @override
  String get proBenefitInMomentPrivacy =>
      'Registrar elecciones sin escribir detalles sensibles';

  @override
  String get proBenefitInMomentRepetition =>
      'Aumentar la tolerancia con prácticas repetibles';

  @override
  String get proBenefitReflectionCompare =>
      'Comparar las predicciones con lo que ocurrió';

  @override
  String get proBenefitReflectionCapture =>
      'Registrar lo aprendido después de practicar';

  @override
  String get proBenefitReflectionPatterns =>
      'Observar patrones útiles a lo largo del tiempo';

  @override
  String get proRestoreChecking => 'Comprobando tus compras…';

  @override
  String get proRestoreSucceeded =>
      'Patterns Pro se restauró. Todas las herramientas de recuperación vuelven a estar desbloqueadas.';

  @override
  String get tipJarTitle => 'Apoyar a Patterns';

  @override
  String get tipJarBody =>
      'Patterns es independiente y no tiene anuncios. Si te ha ayudado, una pequeña propina significa mucho. Las propinas son opcionales y no desbloquean nada.';

  @override
  String get tipJarLoadingLabel => 'Cargando opciones de propina';

  @override
  String get tipJarPurchasesUnavailable =>
      'Las compras dentro de la app no están disponibles en este dispositivo.';

  @override
  String get tipJarOptionsUnavailable =>
      'No se encontraron opciones de propina. Inténtalo de nuevo más tarde.';

  @override
  String get tipJarLoadFailed =>
      'No se pudieron cargar las opciones de propina. Inténtalo de nuevo más tarde.';

  @override
  String get tipJarPurchaseFailed =>
      'No se pudo completar la propina. Inténtalo de nuevo.';

  @override
  String get tipJarTryAgainAction => 'Volver a intentar';

  @override
  String get tipSmallTitle => 'Propina pequeña';

  @override
  String get tipSmallDescription =>
      'Una propina pequeña y opcional para apoyar el desarrollo de Patterns. No desbloquea funciones.';

  @override
  String get tipMediumTitle => 'Propina mediana';

  @override
  String get tipMediumDescription =>
      'Una propina mediana y opcional para apoyar el desarrollo de Patterns. No desbloquea funciones.';

  @override
  String get tipLargeTitle => 'Propina grande';

  @override
  String get tipLargeDescription =>
      'Una propina grande y opcional para apoyar el desarrollo de Patterns. No desbloquea funciones.';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title, $price. $description';
  }

  @override
  String get tipChoiceHint => 'Envía esta propina opcional';

  @override
  String get tipThanksTitle => 'Gracias';

  @override
  String get tipThanksBody =>
      'Tu apoyo significa mucho. Patterns sigue sin anuncios e independiente gracias a personas como tú.';

  @override
  String get tipThanksAction => 'Con gusto';

  @override
  String get desktopProTitle => 'Desbloquear Patterns Desktop Pro';

  @override
  String get desktopProSubtitle =>
      'Una licencia de pago único para herramientas de recuperación sin conexión y optimizadas para escritorio.';

  @override
  String get desktopFeatureHierarchyTitle => 'Creador de jerarquías';

  @override
  String get desktopFeatureHierarchyDescription =>
      'Crear y registrar pasos y jerarquías de exposición.';

  @override
  String get desktopFeatureErpTitle => 'Registros de ejercicios ERP';

  @override
  String get desktopFeatureErpDescription =>
      'Registrar prevención de respuesta y ejercicios con tiempo.';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription =>
      'Registrar los cambios del impulso con un temporizador en vivo.';

  @override
  String get desktopFeatureActivityTitle => 'Actividad de recuperación';

  @override
  String get desktopFeatureActivityDescription =>
      'Revisar actividad objetiva y patrones semanales.';

  @override
  String get desktopOneTimeLicense => 'Licencia de pago único';

  @override
  String desktopOneTimePrice(String price) {
    return '$price, compra única';
  }

  @override
  String get desktopPurchaseLicenseAction => 'Comprar licencia';

  @override
  String get desktopCheckoutUnavailable =>
      'La página de compra no está disponible en esta compilación.';

  @override
  String get desktopAlreadyPurchased =>
      '¿Ya la compraste? Introduce tu clave de licencia';

  @override
  String get desktopLicensePrompt =>
      'Introduce tu clave de licencia de Lemon Squeezy:';

  @override
  String get desktopLicenseLabel => 'Clave de licencia';

  @override
  String get desktopLicenseHint => 'Pega la clave de licencia de tu recibo';

  @override
  String get desktopLicenseActivating => 'Activando la licencia…';

  @override
  String get desktopActivateLicenseAction => 'Activar licencia';

  @override
  String get desktopLicenseBackAction => 'Volver';

  @override
  String get desktopLicenseInvalid =>
      'Introduce la clave de licencia completa que aparece en tu recibo.';

  @override
  String get desktopLicenseRejected =>
      'No se pudo verificar esta licencia para Patterns Desktop Pro. Revisa la clave e inténtalo de nuevo.';

  @override
  String get desktopLicenseUnavailable =>
      'No se pudo conectar con el servicio de licencias. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get desktopLicenseNotConfigured =>
      'La activación de licencias no está disponible en esta compilación.';

  @override
  String get journalTitle => 'Diario';

  @override
  String get journalSearchAction => 'Buscar en el diario';

  @override
  String get journalChooseDateAction => 'Elegir fecha';

  @override
  String get journalSearchHint => 'Buscar entradas';

  @override
  String get journalClearSearchAction => 'Borrar búsqueda';

  @override
  String get journalNoMatchesTitle => 'Sin resultados';

  @override
  String journalNoMatchesBody(String query) {
    return 'No hay ninguna entrada que coincida con «$query».';
  }

  @override
  String get journalEmptyTitle => 'Aún no hay entradas en el diario';

  @override
  String get journalEmptyBody => 'Unas pocas líneas bastan para empezar.';

  @override
  String get journalLoadError =>
      'No se pudieron cargar las entradas del diario. Inténtalo de nuevo.';

  @override
  String get journalLoadingLabel => 'Cargando entradas del diario';

  @override
  String get journalSavingStatus => 'Guardando…';

  @override
  String get journalSavedStatus => 'Guardado';

  @override
  String get journalUnsavedStatus => 'Sin guardar';

  @override
  String get journalClearDayAction => 'Borrar este día';

  @override
  String get journalSaveAction => 'Guardar';

  @override
  String get journalStartWritingPlaceholder => 'Empieza a escribir…';

  @override
  String get journalFormatSelectionHint =>
      'Selecciona texto para darle formato';

  @override
  String get journalClearedMessage => 'Se borró la entrada de ese día.';

  @override
  String get journalNothingToSaveMessage =>
      'Todavía no hay nada que guardar. Añade una línea cuando te apetezca.';

  @override
  String get journalClearDayTitle => '¿Borrar este día?';

  @override
  String journalClearDayBody(String date) {
    return 'Esto borra todo lo guardado el $date. Podrás volver a escribir para ese día cuando quieras.';
  }

  @override
  String get journalKeepEntryAction => 'Conservar';

  @override
  String get journalTodayEntry => 'Entrada de hoy';

  @override
  String get journalOpenEntryAction => 'Abrir entrada';

  @override
  String journalOpenEntryHint(String date) {
    return 'Abre la entrada del diario del $date.';
  }
}
