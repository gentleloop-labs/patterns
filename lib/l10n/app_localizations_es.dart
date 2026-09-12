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

  @override
  String get journalWorkspaceTitle => 'Espacio del diario';

  @override
  String get journalSubtitle => 'Tu espacio para reflexionar y soltar.';

  @override
  String get journalNewEntryAction => 'Nueva entrada';

  @override
  String get journalEarlierSection => 'Anteriores';

  @override
  String get journalNoEntryForDate => 'No hay ninguna entrada para esta fecha.';

  @override
  String get journalCreateEntryAction => 'Crear entrada';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date a las $time';
  }

  @override
  String get journalDeleteEntryAction => 'Eliminar entrada';

  @override
  String get journalDeleteEntryTitle => '¿Eliminar entrada?';

  @override
  String get journalDeleteEntryBody =>
      'Esta entrada del diario se eliminará permanentemente.';

  @override
  String get journalDeletedMessage => 'Se eliminó la entrada del diario.';

  @override
  String get journalEditAction => 'Editar';

  @override
  String journalEditingDate(String date) {
    return 'Editando: $date';
  }

  @override
  String get journalUnsavedChangesStatus => 'Cambios sin guardar';

  @override
  String get journalEntrySavedMessage => 'Entrada del diario guardada';

  @override
  String journalReadOnlyLabel(String date) {
    return 'Entrada del diario de solo lectura del $date';
  }

  @override
  String get journalThemeContamination => 'Contaminación';

  @override
  String get journalThemeUncertainty => 'Incertidumbre';

  @override
  String get journalThemeChecking => 'Comprobación';

  @override
  String get journalThemeRelationship => 'Relación';

  @override
  String get journalThemeHealth => 'Salud';

  @override
  String get todayGreetingMorning => 'Buenos días';

  @override
  String get todayGreetingAfternoon => 'Buenas tardes';

  @override
  String get todayGreetingEvening => 'Buenas noches';

  @override
  String get todayEncouragement => 'Puedes hacerlo. Una decisión a la vez.';

  @override
  String get todayContinuePractice => 'Continúa tu práctica';

  @override
  String get todaySeeAllAction => 'Ver todo';

  @override
  String get todayQuickActions => 'Acciones rápidas';

  @override
  String get todayChooseActivity => '¿Qué te gustaría hacer?';

  @override
  String get todayWriteSomethingTitle => 'Anotar algo';

  @override
  String get todayWriteSomethingBody =>
      'Saca un pensamiento de tu cabeza y ponlo por escrito.';

  @override
  String get todayDelayUrgeTitle => 'Retrasar un impulso';

  @override
  String get todayDelayUrgeBody => 'Crea un espacio antes de responder.';

  @override
  String get todayPracticeErpTitle => 'Practicar (ERP)';

  @override
  String get todayPracticeErpBody => 'Un ejercicio breve y guiado.';

  @override
  String get todayFirstJournalTitle => 'Anota otro momento';

  @override
  String get todayFirstJournalBody =>
      'Nombrar un pensamiento puede facilitar observarlo.';

  @override
  String get todayFirstErpTitle => 'Practica de nuevo';

  @override
  String get todayFirstErpBody => 'Prueba otra práctica de ERP breve y guiada.';

  @override
  String get todayFirstDelayTitle => 'Prueba un retraso de dos minutos';

  @override
  String get todayFirstDelayBody =>
      'Cuando el impulso sea fuerte, deja un pequeño espacio antes de actuar.';

  @override
  String get todayStartPracticeAction => 'Iniciar práctica';

  @override
  String get todayStartDelayAction => 'Iniciar retraso';

  @override
  String get todayProTitle => 'Continúa con Patterns Pro';

  @override
  String get todayProBody =>
      'Crea un plan, practica y revisa tu actividad con el tiempo.';

  @override
  String get todayHideSevenDays => 'Ocultar por 7 días';

  @override
  String get todayPracticeProgress => 'Progreso de la práctica';

  @override
  String get todaySteadyPractice => 'Práctica constante';

  @override
  String get todayStartGently => 'Empieza con calma';

  @override
  String get todayPracticeActiveBody =>
      'Tus actividades registradas están formando una visión a más largo plazo.';

  @override
  String get todayPracticeEmptyBody =>
      'Esto cambia a medida que escribes, registras y practicas.';

  @override
  String get todayProgressDisclaimer =>
      'Esto refleja la frecuencia de las prácticas registradas, no un diagnóstico ni una evaluación clínica. El valor puede ser menor durante una semana difícil.';

  @override
  String get todayProgressStartedTitle => 'Tu actividad está tomando forma';

  @override
  String get todayProgressPendingBody =>
      'Aparecerá un valor de progreso después de registrar actividades en más de un día.';

  @override
  String get todayScoreNew => 'Nuevo';

  @override
  String get todayScoreStrong => 'Fuerte';

  @override
  String get todayScoreSteady => 'Constante';

  @override
  String get todayScoreBuilding => 'En desarrollo';

  @override
  String get todayScoreStarting => 'Comenzando';

  @override
  String get todayBeginCheckIn => 'Empieza con un breve registro';

  @override
  String get todayNoChange => 'Sin cambios respecto al período anterior';

  @override
  String todayPointsUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points puntos más',
      one: '1 punto más',
    );
    return '$_temp0 que en el período anterior';
  }

  @override
  String todayPointsDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points puntos menos',
      one: '1 punto menos',
    );
    return '$_temp0 que en el período anterior';
  }

  @override
  String get todayNextStep => 'Tu siguiente paso';

  @override
  String get todayNextSelfCheckTitle => 'Observa cómo estás';

  @override
  String get todayNextSelfCheckBody =>
      'Una autoevaluación puede registrar una referencia para compararla más adelante.';

  @override
  String get todayNextSelfCheckAction => 'Hacer autoevaluación';

  @override
  String get todayNextHierarchyTitle => 'Prepara tu práctica';

  @override
  String get todayNextHierarchyBody =>
      'Crea una jerarquía de exposición, de pasos más fáciles a más difíciles.';

  @override
  String get todayNextHierarchyAction => 'Crear jerarquía';

  @override
  String get todayNextPracticeTitle => 'Elige la práctica de hoy';

  @override
  String get todayNextPracticeBody =>
      'Elige un ejercicio de ERP manejable para hoy.';

  @override
  String get todayNextPracticeAction => 'Iniciar práctica';

  @override
  String get todayNextReflectTitle => 'Reflexiona sobre la práctica';

  @override
  String get todayNextReflectBody =>
      'Registra lo que notaste durante la práctica de hoy.';

  @override
  String get todayNextReflectAction => 'Reflexionar';

  @override
  String get todayNextJournalTitle => 'Reflexiona sobre hoy';

  @override
  String get todayNextJournalBody =>
      'Escribe una línea sobre lo que notaste en tu práctica.';

  @override
  String get todayNextJournalAction => 'Abrir diario';

  @override
  String get todayCompulsionDelay => 'Retraso de compulsión';

  @override
  String get todayStartErp => 'Iniciar práctica de ERP';

  @override
  String get todayResistUrgeBody =>
      'Permanece con el impulso antes de decidir qué hacer.';

  @override
  String get todayBuildToleranceBody =>
      'Practica un paso manejable a tu ritmo.';

  @override
  String get todayResumeAction => 'Continuar';

  @override
  String get todayStartAction => 'Iniciar';

  @override
  String get todayJournalBody => 'Escribe y reflexiona en tu diario privado.';

  @override
  String get todayExposureTools => 'Herramientas de exposición';

  @override
  String get todayExposureToolsBody =>
      'Jerarquía, materiales y práctica con la incertidumbre.';

  @override
  String get todayInsightsBody => 'Revisa tu actividad registrada.';

  @override
  String get todaySelfCheckTitle => 'Comprende tus patrones';

  @override
  String get todaySelfCheckDuration => 'Opcional · unos 10 min';

  @override
  String get todayInsightsPlaceholder =>
      'Tus datos aparecerán aquí a medida que registres actividades.';

  @override
  String get todayDailyCheckInComplete => 'Registro diario guardado';

  @override
  String get todayDailyCheckIn => 'Registro diario';

  @override
  String get todayDailyCompleteBody =>
      'Hay una entrada de diario registrada para hoy.';

  @override
  String get todayDailyBody => 'Escribe una entrada breve cuando estés listo.';

  @override
  String get todayOpenAction => 'Abrir';

  @override
  String get todayCheckInAction => 'Registrar';

  @override
  String get todayRecoveryScore => 'Puntuación de recuperación';

  @override
  String todayActivitiesLastSevenDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actividades en los últimos 7 días',
      one: '1 actividad en los últimos 7 días',
    );
    return '$_temp0';
  }

  @override
  String get todayActivityRecorded =>
      'Calculado a partir de la actividad registrada';

  @override
  String get todayPracticesRecorded => 'Prácticas registradas';

  @override
  String get todayPracticeStreak => 'Racha de práctica';

  @override
  String todaySessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sesiones',
      one: '1 sesión',
    );
    return '$_temp0';
  }

  @override
  String todayDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String get todayPickUpBody =>
      'Continúa desde el tiempo registrado anteriormente.';

  @override
  String get todayPracticeUrgesBody =>
      'Practica esperar antes de responder a un impulso.';

  @override
  String get todayReadCheckIn => 'Leer el registro de hoy';

  @override
  String get todayOpenJournalMore => 'Abre el Diario para leer o añadir más';

  @override
  String get todayShortJournal => 'Escribe una entrada breve en el diario';

  @override
  String get todayExplore => 'Explorar';

  @override
  String get todayReflectProcess => 'Reflexiona y procesa';

  @override
  String get todayRecoveryTools => 'Herramientas de recuperación';

  @override
  String get todaySupportPractice => 'Apoya tu práctica';

  @override
  String get todayTrackBody => 'Registra pensamientos e impulsos';

  @override
  String get todaySeePatterns => 'Revisa tus patrones registrados';

  @override
  String todayScoreA11y(int score, String label) {
    return 'Progreso de la práctica: $score de 100, $label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return 'Temporizador de práctica: $elapsed transcurridos de $planned';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day: actividad registrada';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day: no hay actividad registrada';
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
  String get trackerFilterObsessions => 'Obsesiones';

  @override
  String get trackerFilterCompulsions => 'Compulsiones';

  @override
  String get trackerLoadingLabel => 'Cargando momentos registrados';

  @override
  String get trackerLoadError =>
      'No se pudieron cargar sus momentos registrados. Inténtelo de nuevo.';

  @override
  String get trackerEditTitle => 'Editar evento';

  @override
  String get trackerAddTitle => 'Registrar evento';

  @override
  String get trackerTypeGroupLabel => 'Tipo de evento';

  @override
  String get trackerTypeObsession => 'Obsesión';

  @override
  String get trackerTypeCompulsion => 'Compulsión';

  @override
  String get trackerThoughtLabel => '¿Qué decía el pensamiento?';

  @override
  String get trackerUrgeLabel => '¿Cuál era el impulso?';

  @override
  String get trackerThoughtHint => 'Describa el pensamiento o la imagen.';

  @override
  String get trackerUrgeHint => 'Describa el impulso o la compulsión.';

  @override
  String get trackerActionLabel => '¿Qué le llevó a hacer el TOC?';

  @override
  String get trackerActionHint => 'Una nota breve es suficiente.';

  @override
  String get trackerResponseLabel => 'Lo que hizo en su lugar';

  @override
  String get trackerResponseHint =>
      'Registre cualquier respuesta que eligió, incluso un retraso parcial.';

  @override
  String get trackerSavingAction => 'Guardando…';

  @override
  String get trackerUpdateAction => 'Actualizar evento';

  @override
  String get trackerSaveAction => 'Guardar evento';

  @override
  String get trackerContentRequired =>
      'Cuando esté listo, añada unas palabras sobre lo que ocurrió.';

  @override
  String get trackerSaveError =>
      'No se pudo guardar su evento. Inténtelo de nuevo.';

  @override
  String get trackerUpdateError =>
      'No se pudo actualizar su evento. Inténtelo de nuevo.';

  @override
  String get trackerEditTooltip => 'Editar evento';

  @override
  String get trackerDeleteTooltip => 'Eliminar evento';

  @override
  String trackerDistressValue(int value) {
    return 'Malestar $value de 10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => 'No se registró una respuesta';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type. $date. Malestar $distress de 10. $content. Respuesta: $response';
  }

  @override
  String get trackerDeleteTitle => '¿Eliminar evento?';

  @override
  String get trackerDeleteBody =>
      'Esto elimina el evento de su historial local en este dispositivo.';

  @override
  String get trackerDeleteAction => 'Eliminar';

  @override
  String get trackerDeletedMessage => 'Evento eliminado';

  @override
  String get trackerDeleteError =>
      'No se pudo eliminar su evento. Inténtelo de nuevo.';

  @override
  String get trackerDistressLabel => 'Malestar, de 0 a 10';

  @override
  String get trackerEmptyTitle => 'Aún no hay eventos';

  @override
  String get trackerEmptyBody =>
      'Registre solo lo que le resulte útil. Una nota breve es suficiente.';

  @override
  String get trackerEmptyAction => 'Registrar evento de TOC';

  @override
  String get insightsTitle => 'Información';

  @override
  String get insightsExportReport => 'Exportar informe';

  @override
  String get insightsObsessionsLogged => 'Obsesiones registradas';

  @override
  String get insightsThemesFound => 'Temas encontrados';

  @override
  String get insightsCompulsions => 'Compulsiones';

  @override
  String get insightsAverageIntensityShort => 'Intensidad media';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => 'Progreso de la práctica';

  @override
  String get insightsScoreNeedsMoreActivity =>
      'La puntuación aparece después de practicar varias veces en distintos días, para mostrar una tendencia y no un solo momento. Las sesiones siguientes ya se están contando.';

  @override
  String get insightsScoreEmpty =>
      'La puntuación aparecerá aquí después de practicar varias veces. Aún no hay nada que medir.';

  @override
  String insightsComparedPreviousDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'los $count días anteriores',
      one: 'el día anterior',
    );
    return 'en comparación con $_temp0';
  }

  @override
  String get insightsComparedPreviousRange =>
      'en comparación con el periodo anterior';

  @override
  String get insightsPracticeProgressBoundary =>
      'Refleja la frecuencia de práctica, no un diagnóstico ni su estado clínico. En una semana difícil, la cifra puede ser menor.';

  @override
  String get insightsMoodOverTime => 'Estado de ánimo a lo largo del tiempo';

  @override
  String get insightsMoodGood => 'Bueno';

  @override
  String get insightsMoodOkay => 'Regular';

  @override
  String get insightsMoodLow => 'Bajo';

  @override
  String get insightsYbocsOverTime => 'Y-BOCS a lo largo del tiempo';

  @override
  String get insightsYbocsEmpty =>
      'Realice la autoevaluación y el total registrado iniciará una línea aquí.';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return 'Rango $severity. Repita la autoevaluación en unas semanas para añadir otro punto registrado.';
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
      other: '$count autoevaluaciones',
      one: '1 autoevaluación',
    );
    return 'en $_temp0';
  }

  @override
  String get insightsYbocsBoundary =>
      'Es una instantánea, no un diagnóstico. Los totales registrados pueden variar y un total más alto no define su progreso.';

  @override
  String get insightsAverageUrgeIntensity => 'Intensidad media del impulso';

  @override
  String get insightsErpPractice => 'Práctica de ERP';

  @override
  String insightsSessions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sesiones',
      one: 'sesión',
    );
    return '$_temp0';
  }

  @override
  String get insightsConsistency => 'Constancia';

  @override
  String insightsActiveDays(int active, int total) {
    return '$active de $total días';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return 'Actividad registrada en $active de $total días';
  }

  @override
  String get insightsTopThemes => 'Temas principales';

  @override
  String get insightsThemesEmpty =>
      'Los temas aparecerán a medida que registre en qué se centra el TOC.';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme, $percent por ciento de los temas registrados';
  }

  @override
  String get insightsChangeRange => 'Cambiar intervalo de fechas';

  @override
  String get insightsOverviewTab => 'Resumen';

  @override
  String get insightsObsessionsTab => 'Obsesiones';

  @override
  String get insightsCompulsionsTab => 'Compulsiones';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ aumento de $value, $comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ descenso de $value, $comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ Sin cambios, $comparison';
  }

  @override
  String get insightsNoData => 'Aún no hay datos';

  @override
  String get insightsLoading => 'Cargando información';

  @override
  String get insightsLoadError =>
      'No se pudo cargar su información. Inténtelo de nuevo.';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date: $value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title. Puntos registrados: $values';
  }

  @override
  String get ybocsSeveritySubclinical => 'Subclínico';

  @override
  String get ybocsSeverityMild => 'Leve';

  @override
  String get ybocsSeverityModerate => 'Moderado';

  @override
  String get ybocsSeveritySevere => 'Grave';

  @override
  String get ybocsSeverityExtreme => 'Extremo';

  @override
  String get insightsThemeContamination => 'Contaminación';

  @override
  String get insightsThemeHarm => 'Daño';

  @override
  String get insightsThemeChecking => 'Comprobación';

  @override
  String get insightsThemeReassurance => 'Búsqueda de confirmación';

  @override
  String get insightsThemeHealth => 'Salud';

  @override
  String get insightsThemeRelationship => 'Relaciones';

  @override
  String get insightsThemeSymmetry => 'Simetría';

  @override
  String get insightsThemeMoral => 'Moralidad';

  @override
  String get insightsThemeRumination => 'Rumiación';

  @override
  String get insightsThemeUncertainty => 'Incertidumbre';

  @override
  String get insightsThemeOther => 'Otro';

  @override
  String get recoveryTitle => 'Recuperación';

  @override
  String get recoverySubtitle =>
      'Herramientas y prácticas agrupadas según el punto en el que estés.';

  @override
  String get recoveryImmediateHelpTitle => 'Apoyo para un momento difícil';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Kit para momentos difíciles',
      'copingLibrary': 'Biblioteca de afrontamiento',
      'compulsionDelay': 'Pausar la compulsión',
      'ybocsSelfCheck': 'Autoevaluación de OCD',
      'recoveryMetrics': 'Actividad de recuperación',
      'exposureHierarchy': 'Jerarquía de exposición',
      'exposureMaterials': 'Materiales de exposición',
      'structuredPrograms': 'Programas estructurados',
      'actionPlanner': 'Plan de acción',
      'implementationIntentions': 'Planes si-entonces',
      'guidedErp': 'ERP guiada',
      'urgeSurfing': 'Surfear el impulso',
      'responsePrevention': 'Prevención de respuesta',
      'uncertaintyTraining': 'Práctica de incertidumbre',
      'behavioralExperiments': 'Experimentos conductuales',
      'reflectionJournal': 'Diario de reflexión',
      'other': 'Herramienta de recuperación',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'Apoyo rápido para volver al presente.',
      'copingLibrary': 'Conecta con el presente y vuelve a empezar.',
      'compulsionDelay': 'Crea espacio antes de responder.',
      'ybocsSelfCheck': 'Un registro Y-BOCS.',
      'recoveryMetrics': 'Revisa la actividad registrada.',
      'exposureHierarchy': 'Crea tu escalera.',
      'exposureMaterials': 'Guarda guiones y enlaces.',
      'structuredPrograms': 'Sigue semanas guiadas.',
      'actionPlanner': 'Planifica tus respuestas.',
      'implementationIntentions': 'Crea planes si-entonces.',
      'guidedErp': 'Practica un plan.',
      'urgeSurfing': 'Acompaña la ola.',
      'responsePrevention': 'Registra lo que hiciste en su lugar.',
      'uncertaintyTraining': 'Practica dar espacio al quizá.',
      'behavioralExperiments': 'Pon a prueba la predicción de OCD.',
      'reflectionJournal': 'Anota lo que observaste.',
      'other': 'Abre una herramienta de recuperación.',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Evaluar',
      'plan': 'Planificar',
      'practice': 'Practicar',
      'review': 'Revisar',
      'other': 'Herramientas',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': 'Observa dónde estás.',
      'plan': 'Prepara tu práctica.',
      'practice': 'Haz una práctica.',
      'review': 'Reflexiona y aprende.',
      'other': 'Elige lo que te resulte útil.',
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
    return '$title requiere Patterns Pro';
  }

  @override
  String get delayNameUrgeValidation =>
      'Cuando quieras, nombra el impulso con el que quieres quedarte.';

  @override
  String get delayOutcomeValidation =>
      'Cuando quieras, elige lo que terminaste haciendo.';

  @override
  String get delaySaveError =>
      'No se pudo guardar tu práctica. Inténtalo de nuevo.';

  @override
  String get delayStopEarlyTitle => '¿Terminar antes?';

  @override
  String get delayStopEarlyBody =>
      'Está bien parar. El tiempo que esperaste todavía se puede registrar.';

  @override
  String get delayKeepGoingAction => 'Seguir';

  @override
  String get delayStopAction => 'Necesito parar';

  @override
  String get delaySetupTitle => 'Pausar el impulso';

  @override
  String get delayUrgeQuestion => '¿Con qué impulso te estás quedando?';

  @override
  String get delayUrgeHint =>
      'Por ejemplo: revisar la cerradura, lavarte o buscar en internet';

  @override
  String get delayUrgeBeforeLabel => '¿Qué intensidad tiene el impulso ahora?';

  @override
  String get delayDurationQuestion => '¿Cuánto tiempo vas a esperar?';

  @override
  String get delayDurationGroupLabel => 'Duración de la pausa';

  @override
  String get delayBeginAction => 'Empezar';

  @override
  String get delayCountdownTitle => 'Estás dejando espacio';

  @override
  String get delayCountdownBody =>
      'Observa el impulso sin actuar. Tú puedes elegir qué ocurre después.';

  @override
  String get delayReflectionTitle => '¿Qué ocurrió?';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed':
          'Terminó el tiempo previsto. Los detalles siguientes son opcionales.',
      'early':
          'Terminaste el temporizador antes. Los detalles siguientes son opcionales.',
      'other':
          'Terminó el temporizador. Los detalles siguientes son opcionales.',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel => '¿Qué intensidad tiene el impulso ahora?';

  @override
  String get delayOutcomeQuestion => '¿Qué hiciste con el impulso?';

  @override
  String get delayOutcomeGroupLabel => 'Resultado registrado';

  @override
  String get delayNoteLabel => '¿Notaste algo? (opcional)';

  @override
  String get delayNoteHint => 'Una nota breve es suficiente.';

  @override
  String get delaySavingAction => 'Guardando…';

  @override
  String get delaySaveAction => 'Guardar práctica';

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
  String get delayCustomTitle => 'Pausa personalizada';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'No lo hice',
      'delayed': 'Lo retrasé',
      'performed': 'Lo hice',
      'other': 'Sin seleccionar',
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
    return 'Pausa personalizada: $_temp0';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation':
          'Cuando quieras, elige lo que ocurrió durante la práctica.',
      'saveError': 'No se pudo guardar tu práctica de ERP. Inténtalo de nuevo.',
      'stopTitle': '¿Terminar antes?',
      'stopBody':
          'Está bien parar. El tiempo que practicaste todavía se puede registrar.',
      'keepGoing': 'Seguir',
      'stop': 'Parar',
      'anxietyBefore': '¿Qué intensidad tiene ahora el impulso o la ansiedad?',
      'duration': 'Duración',
      'start': 'Empezar práctica',
      'countdownCue': 'Practica sin',
      'resisting': 'Respuesta que no estás haciendo',
      'countdownBody':
          'No necesitas demostrar que la predicción es falsa antes de que termine el temporizador.',
      'stopEarly': 'Terminar antes',
      'reflectionTitle': 'Reflexionar',
      'reflectionBody':
          'Los detalles siguientes son opcionales. Registra solo lo que te resulte útil.',
      'anxietyAfter': '¿Qué intensidad tiene ahora?',
      'outcomeQuestion': '¿Qué hiciste?',
      'whatHappened': '¿Qué ocurrió realmente?',
      'whatHappenedHint': '¿Qué notaste durante o después de la práctica?',
      'learning': 'Para la próxima vez',
      'learningHint': '¿Qué quieres recordar la próxima vez que OCD pregunte?',
      'exposure': 'Exposición',
      'prediction': 'Predicción',
      'commitment': 'Compromiso',
      'saving': 'Guardando…',
      'save': 'Guardar práctica',
      'other': 'Práctica de ERP',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Terminó el tiempo previsto.',
      'early': 'Terminaste el temporizador antes.',
      'other': 'Terminó el temporizador.',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'No hice la respuesta',
      'delayed': 'Retrasé la respuesta',
      'performed': 'Hice la respuesta',
      'other': 'Sin seleccionar',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return 'Intensidad $value de 10';
  }

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'ERP guiada',
      'subtitle': 'Reutiliza un plan, practica y registra lo que ocurrió.',
      'myPlans': 'Mis planes de ERP',
      'newAction': 'Nuevo',
      'plansError': 'Los planes de ERP no están disponibles ahora.',
      'recentPractice': 'Práctica reciente',
      'historyError': 'El historial de prácticas no está disponible ahora.',
      'archiveTitle': '¿Archivar este plan?',
      'archiveBody':
          'Saldrá de tus planes activos, pero las prácticas anteriores seguirán en tu historial.',
      'keepAction': 'Conservar',
      'archiveAction': 'Archivar',
      'exposureValidation':
          'Cuando quieras, describe la situación con la que quieres practicar.',
      'commitmentValidation':
          'Elige la respuesta que quieres practicar sin realizar para poder guardar el plan.',
      'saveError': 'No se pudo guardar tu plan de ERP. Inténtalo de nuevo.',
      'updated': 'Plan de ERP actualizado.',
      'created': 'Plan de ERP creado.',
      'editTitle': 'Editar plan de ERP',
      'createTitle': 'Crear plan de ERP',
      'exerciseType': 'Tipo de ejercicio',
      'exposureTarget': 'Objetivo de exposición',
      'ocdPrediction': 'Predicción del TOC',
      'preventionCommitment': 'Compromiso de prevención de respuesta',
      'defaultDuration': 'Duración predeterminada',
      'saving': 'Guardando…',
      'saveAction': 'Guardar plan',
      'createAction': 'Crear plan',
      'emptyTitle': 'Crea tu primer plan de ERP',
      'emptyBody':
          'Escribe una vez la exposición, la predicción y la respuesta que quieres practicar sin realizar. Después podrás reutilizar el plan.',
      'moreActions': 'Más acciones del plan',
      'editAction': 'Editar plan',
      'archivePlanAction': 'Archivar plan',
      'practiceGuide': 'Guía de práctica',
      'historyEmpty': 'Las prácticas completadas aparecerán aquí.',
      'customDuration': 'Duración personalizada',
      'other': 'Plan de ERP',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return 'Evitar: $response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction =>
      'El TOC dice que el malestar no cambiará a menos que respondas.';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'Retrasar la comprobación',
      'delayReassurance': 'Retrasar la búsqueda de tranquilidad',
      'delayGoogling': 'Retrasar la búsqueda en internet',
      'delayRumination': 'Retrasar la rumiación',
      'delayWashing': 'Retrasar el lavado',
      'other': 'ERP guiada',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Practica dejar algo sin comprobar durante un breve periodo.',
      'delayReassurance':
          'Espera antes de pedir a alguien que elimine la incertidumbre.',
      'delayGoogling': 'Pospón la búsqueda de certeza o pruebas.',
      'delayRumination':
          'Observa la resolución mental de problemas sin seguirla.',
      'delayWashing': 'Espera antes de volver a lavar, limpiar o desinfectar.',
      'other': 'Practica retrasar una respuesta.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'Crea un plan reutilizable para cuando el TOC te empuje a volver a comprobar cerraduras, interruptores, mensajes, síntomas o errores.',
      'delayReassurance':
          'Crea un plan para el impulso de preguntar, confesar, explicar o pedir a alguien que confirme que todo está bien.',
      'delayGoogling':
          'Crea un plan para cuando el TOC quiera que busques síntomas, significados, riesgos, reglas o historias hasta sentir certeza.',
      'delayRumination':
          'Crea un plan para compulsiones mentales como repasar, demostrar, revisar o resolver.',
      'delayWashing':
          'Crea un plan para el impulso de lavar, limpiar, desinfectar o empezar de nuevo porque algo parece contaminado.',
      'other': 'Crea un plan de práctica de ERP reutilizable.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          'La ERP te permite practicar con la incertidumbre presente sin hacer un ritual de inmediato.',
      'delayReassurance':
          'La tranquilidad puede parecer útil en el momento; retrasarla te permite practicar sin saber con certeza.',
      'delayGoogling':
          'Posponer la búsqueda interrumpe el ciclo de certeza y te permite practicar dejando una pregunta sin responder.',
      'delayRumination':
          'La rumiación puede parecer pensamiento; la ERP te permite practicar salir del ciclo sin terminar el argumento.',
      'delayWashing':
          'Esperar te permite practicar con la sensación de contaminación presente sin hacer un ritual de inmediato.',
      'other':
          'La ERP permite practicar con la incertidumbre sin hacer un ritual de inmediato.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure':
          '¿Qué dejarás sin comprobar o comprobarás solo una vez?',
      'delayCheckingPrediction':
          '¿Qué predice el TOC si no vuelves a comprobar?',
      'delayCheckingCommitment':
          '¿Qué ritual de comprobación practicarás sin realizar?',
      'delayReassuranceExposure': '¿Qué tranquilidad quieres pedir?',
      'delayReassurancePrediction':
          '¿Qué dice el TOC que ocurrirá si no preguntas?',
      'delayReassuranceCommitment':
          '¿Qué mensaje, confesión o pregunta evitarás?',
      'delayGooglingExposure':
          '¿Qué búsqueda o pregunta dejarás sin responder?',
      'delayGooglingPrediction': '¿Qué dice el TOC que necesitas saber ahora?',
      'delayGooglingCommitment': '¿Qué búsqueda, artículo o foro evitarás?',
      'delayRuminationExposure':
          '¿Qué ciclo de pensamiento dejarás sin terminar?',
      'delayRuminationPrediction':
          '¿Qué dice el TOC que debes resolver o demostrar?',
      'delayRuminationCommitment': '¿Qué revisión mental o argumento evitarás?',
      'delayWashingExposure': '¿Qué límite de higiene normal seguirás?',
      'delayWashingPrediction': '¿Qué predice el TOC si no vuelves a lavarte?',
      'delayWashingCommitment':
          '¿Qué lavado, limpieza o desinfección adicional evitarás?',
      'other': '¿Qué respuesta practicarás sin realizar?',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Define una regla de comprobación antes de empezar.',
      'delayChecking2':
          'Haz la comprobación prevista una vez si forma parte de la seguridad normal.',
      'delayChecking3':
          'Evita volver a comprobar mientras corre el temporizador.',
      'delayChecking4': 'Observa el impulso sin negociar con él.',
      'delayReassurance1':
          'Define la petición de tranquilidad antes de empezar.',
      'delayReassurance2':
          'No envíes el mensaje ni hagas la pregunta durante el temporizador.',
      'delayReassurance3':
          'Deja que el malestar esté presente sin buscar certeza.',
      'delayReassurance4':
          'Vuelve a lo que estabas haciendo con toda la suavidad posible.',
      'delayGoogling1':
          'Define la búsqueda antes de abrir cualquier otra cosa.',
      'delayGoogling2':
          'Cierra el cuadro de búsqueda o la pestaña del navegador.',
      'delayGoogling3': 'Inicia el temporizador antes de leer nada más.',
      'delayGoogling4': 'Deja la pregunta sin responder por ahora.',
      'delayRumination1':
          'Pon nombre al ciclo: repasar, resolver, demostrar o comprobar.',
      'delayRumination2': 'Deja el pensamiento sin terminar.',
      'delayRumination3':
          'Devuelve la atención a una tarea o sensación cotidiana.',
      'delayRumination4':
          'Vuelve a empezar con suavidad cada vez que el ciclo te atraiga.',
      'delayWashing1': 'Define el límite de higiene normal antes de empezar.',
      'delayWashing2':
          'Empieza con una demora que resulte difícil pero posible.',
      'delayWashing3':
          'Mantén las manos lejos del lavabo o del desinfectante durante el temporizador.',
      'delayWashing4':
          'Deja que el malestar esté presente sin intentar hacerlo perfecto.',
      'other': 'Sigue el plan que elegiste.',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': 'Comprobar una vez',
      'delayChecking2': 'No repetir',
      'delayChecking3': 'Observar el impulso',
      'delayReassurance1': 'No preguntar aún',
      'delayReassurance2': 'Dejar la incertidumbre',
      'delayReassurance3': 'Volver con suavidad',
      'delayGoogling1': 'Cerrar la búsqueda',
      'delayGoogling2': 'Iniciar temporizador',
      'delayGoogling3': 'Dejar sin responder',
      'delayRumination1': 'Nombrar el ciclo',
      'delayRumination2': 'Dejar sin terminar',
      'delayRumination3': 'Volver a la tarea',
      'delayWashing1': 'Definir el límite',
      'delayWashing2': 'Retrasar el lavado',
      'delayWashing3': 'Permitir el malestar',
      'other': 'Seguir el plan',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Programas estructurados',
      'subtitle': 'Sigue un plan guiado semana a semana, a tu propio ritmo.',
      'themeGroup': 'Por tema del TOC',
      'themeGroupEmpty':
          'Elige un tema si encaja con lo que quieres practicar.',
      'themeGroupMatched':
          'Los temas registrados en tu última autoevaluación aparecen señalados abajo.',
      'generalGroup': 'Práctica general',
      'generalCaption': 'Habilidades que pueden usarse con distintos temas.',
      'enrollError': 'No se pudo abrir este programa. Inténtalo de nuevo.',
      'started': 'Iniciado',
      'notStarted': 'No iniciado',
      'openHint': 'Abrir los detalles del programa',
      'selfCheckMatch': 'Coincide con tu autoevaluación',
      'tapToStart': 'Toca para empezar',
      'progressLoadError':
          'No se pudo cargar la actividad del programa. Inténtalo de nuevo.',
      'activityRecorded':
          'Tus selecciones de tareas se guardan de forma local.',
      'taskSaveError':
          'No se pudo guardar este cambio en la tarea. Inténtalo de nuevo.',
      'weekComplete': 'Todas las tareas están marcadas como completadas',
      'weekNotComplete': 'Quedan tareas',
      'weekToggleHint': 'Expandir o contraer esta semana',
      'taskToggleHint': 'Marcar o desmarcar esta tarea',
      'other': 'Programa',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$done de $total tareas, $percent por ciento';
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
      other: 'Las $count tareas están marcadas como completadas.',
      one: 'La tarea está marcada como completada.',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$done de $total tareas marcadas como completadas';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String exposureHierarchyText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Jerarquía de exposición',
      'newAction': 'Nueva',
      'subtitle':
          'Crea una escala de posibles exposiciones y practica un paso cada vez.',
      'loadError':
          'Tus jerarquías no están disponibles ahora. Inténtalo de nuevo.',
      'archiveTitle': '¿Archivar esta jerarquía?',
      'archiveBody':
          'Esto quita la jerarquía de tu lista activa. Los pasos guardados permanecen en este dispositivo.',
      'keepAction': 'Conservar',
      'archiveAction': 'Archivar',
      'archiveSuccess': 'Jerarquía archivada.',
      'archiveError': 'No se pudo archivar esta jerarquía. Inténtalo de nuevo.',
      'emptyTitle': 'Crea tu primera escala',
      'emptyBody':
          'Enumera posibles exposiciones de menor a mayor dificultad y elige tu propio ritmo.',
      'buildAction': 'Crear una jerarquía',
      'newTitle': 'Nueva jerarquía',
      'nameLabel': 'Nombre',
      'nameHint': 'Por ejemplo, tocar manijas de puertas',
      'themeLabel': 'Tema (opcional)',
      'themeHint': 'Por ejemplo, contaminación',
      'generalTheme': 'General',
      'stepsTitle': 'Pasos, primero los más fáciles',
      'addAction': 'Añadir',
      'createAction': 'Crear jerarquía',
      'saving': 'Guardando…',
      'titleValidation': 'Añade un nombre para esta escala.',
      'stepValidation': 'Añade al menos un paso de exposición.',
      'createSuccess': 'Jerarquía guardada.',
      'createError': 'No se pudo guardar esta jerarquía. Inténtalo de nuevo.',
      'stepHint': '¿Qué exposición podrías practicar?',
      'difficulty': 'Dificultad',
      'anxiety': 'Ansiedad prevista',
      'materialAction': 'Material',
      'statusNotStarted': 'Sin empezar',
      'statusInProgress': 'En curso',
      'statusDone': 'Hecho',
      'statusError':
          'No se pudo guardar el estado de este paso. Inténtalo de nuevo.',
      'moveUp': 'Subir el paso',
      'moveDown': 'Bajar el paso',
      'removeStep': 'Eliminar el paso',
      'openHierarchy': 'Abrir jerarquía',
      'archiveHierarchy': 'Archivar jerarquía',
      'other': 'Jerarquía de exposición',
    });
    return '$_temp0';
  }

  @override
  String exposureHierarchySummary(int done, int count, String theme) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$done de $count pasos · $theme',
      one: '$done de 1 paso · $theme',
      zero: '$theme',
    );
    return '$_temp0';
  }

  @override
  String exposureStepLabel(int number) {
    return 'Paso $number';
  }

  @override
  String exposureRating(int value) {
    return '$value de 10';
  }

  @override
  String exposureStepMetrics(int difficulty, int anxiety) {
    return 'Dificultad $difficulty de 10 · Ansiedad prevista $anxiety de 10';
  }

  @override
  String exposureProgress(int percent) {
    return '$percent % de pasos marcados como hechos';
  }

  @override
  String exposureMaterialsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Materiales de exposición',
      'newAction': 'Nuevo',
      'subtitle':
          'Guarda juntos tus guiones, grabaciones en bucle, imágenes y enlaces para usarlos durante una exposición.',
      'loadError':
          'Tus materiales no están disponibles ahora. Inténtalo de nuevo.',
      'typeScript': 'Guion',
      'typeLoopTape': 'Grabación en bucle',
      'typeImage': 'Imagen',
      'typeLink': 'Enlace',
      'deleteTitle': '¿Eliminar este material?',
      'deleteBody':
          'Esto elimina el material de este dispositivo, incluido su archivo guardado si existe.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar material',
      'deleteSuccess': 'Material eliminado.',
      'deleteError': 'No se pudo eliminar este material. Inténtalo de nuevo.',
      'emptyTitle': 'Reúne tus materiales',
      'emptyBody':
          'Guarda un guion, una grabación en bucle, una imagen o un enlace para una exposición que elijas.',
      'addAction': 'Añadir material',
      'readScript': 'Leer guion',
      'openLink': 'Abrir enlace',
      'viewImage': 'Ver imagen',
      'linkError': 'No se pudo abrir ese enlace.',
      'imageMissing': 'Esta imagen ya no está disponible en este dispositivo.',
      'recordingMissing':
          'Esta grabación ya no está disponible en este dispositivo.',
      'stop': 'Detener',
      'playLoop': 'Reproducir bucle',
      'microphoneNeeded':
          'Se necesita acceso al micrófono para grabar un bucle. Puedes cambiarlo en los ajustes del dispositivo.',
      'nameValidation': 'Añade un nombre para este material.',
      'scriptValidation': 'Añade el texto del guion.',
      'linkValidation': 'Pega un enlace.',
      'imageValidation': 'Elige una imagen.',
      'recordingValidation': 'Graba un bucle antes de guardar.',
      'saveSuccess': 'Material guardado.',
      'saveError': 'No se pudo guardar este material. Inténtalo de nuevo.',
      'titleLabel': 'Título',
      'titleHint': 'Un nombre corto que reconocerás',
      'saveAction': 'Guardar material',
      'scriptLabel': 'Guion',
      'scriptHint': 'El texto que quieres leer durante la exposición',
      'linkLabel': 'Enlace',
      'pickImage': 'Elegir imagen',
      'changeImage': 'Cambiar imagen',
      'rerecord': 'Volver a grabar',
      'recorderHint': 'Graba un clip corto para reproducirlo en bucle.',
      'record': 'Grabar',
      'recording': 'Grabando',
      'other': 'Material de exposición',
    });
    return '$_temp0';
  }

  @override
  String exposureMaterialEditorTitle(String type) {
    return 'Nuevo: $type';
  }

  @override
  String exposureRecordingSeconds(int seconds) {
    return 'Grabando · $seconds s';
  }

  @override
  String responsePreventionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Prevención de respuesta',
      'logAction': 'Registrar',
      'subtitle':
          'Registra el desencadenante, la respuesta que elegiste y el malestar de ese momento.',
      'loadError':
          'Tus registros de respuesta no están disponibles ahora. Inténtalo de nuevo.',
      'deleteTitle': '¿Eliminar este registro de respuesta?',
      'deleteBody':
          'Esto elimina el registro de forma permanente de este dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar registro de respuesta',
      'deleteSuccess': 'Registro de respuesta eliminado.',
      'deleteError':
          'No se pudo eliminar este registro de respuesta. Inténtalo de nuevo.',
      'outcomeResisted': 'No realizada',
      'outcomeDelayed': 'Retrasada',
      'outcomePartial': 'Realizada en parte',
      'outcomePerformed': 'Realizada',
      'emptyTitle': 'Registra una respuesta',
      'emptyBody':
          'Después de un desencadenante, registra lo que elegiste y el malestar que notaste.',
      'emptyAction': 'Registrar una respuesta',
      'editorTitle': 'Registrar una respuesta',
      'situationLabel': '¿Qué lo desencadenó?',
      'situationHint': 'El desencadenante y la respuesta que impulsó el TOC',
      'outcomeQuestion': '¿Qué hiciste?',
      'distressLabel': 'Malestar en ese momento',
      'noteLabel': 'Nota (opcional)',
      'noteHint': 'Algo que quieras recordar',
      'saveAction': 'Guardar registro',
      'situationValidation': 'Añade una descripción breve del desencadenante.',
      'saveSuccess': 'Registro de respuesta guardado.',
      'saveError':
          'No se pudo guardar este registro de respuesta. Inténtalo de nuevo.',
      'other': 'Prevención de respuesta',
    });
    return '$_temp0';
  }

  @override
  String responsePreventionDistress(int value) {
    return 'Malestar $value de 10';
  }

  @override
  String responsePreventionLogSummary(
    String outcome,
    String date,
    int distress,
    String situation,
  ) {
    return '$outcome · $date · malestar $distress de 10 · $situation';
  }

  @override
  String urgeSurfText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Surfear el impulso',
      'subtitle':
          'Observa un impulso durante el tiempo que elijas, sin tener que cambiarlo ni actuar en respuesta.',
      'startAction': 'Empezar',
      'historyTitle': 'Sesiones anteriores',
      'emptyHistory':
          'Aún no hay sesiones guardadas. Una sesión registrada aparecerá aquí.',
      'loadError':
          'Tus sesiones guardadas no están disponibles ahora. Inténtalo de nuevo.',
      'triggerFallback': 'Un impulso',
      'setupTitle': 'Antes de empezar',
      'triggerLabel': '¿Cuál es el impulso? (opcional)',
      'triggerHint': 'Por ejemplo, el impulso de volver a lavarme las manos',
      'initialUrgeLabel': 'Impulso al comenzar',
      'durationQuestion': '¿Durante cuánto tiempo quieres observarlo?',
      'begin': 'Comenzar',
      'surfingTitle': 'Observa el impulso',
      'surfingBody':
          'Observa los pensamientos y las sensaciones, y elige qué hacer después. Puedes parar en cualquier momento.',
      'currentUrgeLabel': 'Impulso ahora',
      'doneAction': 'Terminar por ahora',
      'reflectionTitle': 'Registra lo que notaste',
      'waveTitle': 'Niveles de impulso registrados',
      'finalUrgeLabel': 'Impulso al terminar',
      'noteLabel': 'Nota (opcional)',
      'noteHint': '¿Qué notaste?',
      'saveAction': 'Guardar sesión',
      'finishAction': 'Finalizar',
      'saveSuccess': 'Sesión guardada.',
      'finishSuccess': 'Práctica finalizada.',
      'saveError': 'No se pudo guardar esta sesión. Inténtalo de nuevo.',
      'timerComplete': 'Tiempo de observación terminado.',
      'other': 'Surfear el impulso',
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
    return 'Comenzó en $initial de 10 · valor más alto registrado $peak de 10 · terminó en $finalLevel de 10 · $duration';
  }

  @override
  String urgeSurfSessionSemantics(String trigger, String date, String summary) {
    return '$trigger · $date · $summary';
  }

  @override
  String urgeSurfWaveSummary(int initial, int peak) {
    return 'Comenzó en $initial de 10 · valor más alto registrado $peak de 10';
  }

  @override
  String urgeSurfTimerDisplay(int minutes, String seconds) {
    return '$minutes:$seconds';
  }

  @override
  String urgeSurfTimeRemaining(int minutes, int seconds) {
    return 'Quedan $minutes min y $seconds s';
  }

  @override
  String emergencyToolkitText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Apoyo para este momento',
      'pauseTitle': 'Haz una pausa antes de responder',
      'pauseBody':
          'No tienes que responder al impulso de inmediato. Elige un ejercicio de autoayuda y hazlo despacio.',
      'boundary':
          'Estas herramientas no ofrecen atención clínica ni de emergencia. Si corres peligro inmediato, contacta con los servicios de emergencia locales.',
      'breathe': 'Respirar',
      'breatheSubtitle': 'Sigue un ciclo de respiración pautada',
      'delay': 'Retrasar el impulso',
      'delaySubtitle': 'Crea espacio con un temporizador',
      'surf': 'Observar el impulso',
      'surfSubtitle': 'Nota el impulso sin actuar',
      'coping': 'Técnicas de afrontamiento',
      'copingSubtitle': 'Anclaje, aceptación y más',
      'remindersTitle': 'Algunos recordatorios',
      'reminderThought':
          'Un pensamiento no exige una respuesta. Puedo notarlo sin actuar.',
      'reminderUrge':
          'Un impulso puede cambiar con el tiempo. Puedo elegir qué hacer después.',
      'reminderUncertainty':
          'Puedo dar espacio a la incertidumbre en este momento.',
      'breatheIn': 'Inspira',
      'hold': 'Mantén',
      'breatheOut': 'Espira',
      'breathingHint':
          'Sigue el círculo: inspira durante 4 segundos, mantén, espira durante 4 segundos y mantén.',
      'other': 'Herramienta de apoyo',
    });
    return '$_temp0';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Autoevaluación de TOC',
      'introBody':
          'Una autoevaluación guiada basada en la Escala Obsesivo-Compulsiva de Yale-Brown (Y-BOCS), sobre los patrones que notas y cuánto te afectan.',
      'spotTitle': 'Identifica los patrones',
      'spotBody':
          'Selecciona las obsesiones y compulsiones que hayas experimentado.',
      'impactTitle': 'Registra el impacto',
      'impactBody': 'Responde 10 preguntas sobre cuánto afectan tu día.',
      'resultIntroTitle': 'Revisa el resultado',
      'resultIntroBody':
          'Consulta los temas, subtotales y el rango de gravedad registrados.',
      'begin': 'Comenzar',
      'retakeAction': 'Hacerla de nuevo',
      'privacyDuration':
          'Tarda unos 10 minutos. Tus respuestas permanecen en este dispositivo, salvo que decidas exportarlas.',
      'disclaimer':
          'Esta autoevaluación puede ayudarte a describir tu experiencia. No diagnostica el TOC ni ofrece ayuda de emergencia. Solo un profesional cualificado puede diagnosticar el TOC.',
      'historyTitle': 'Tu historial',
      'historyBody': 'Aquí aparecen tus totales registrados anteriormente.',
      'deleteTitle': '¿Eliminar la evaluación?',
      'deleteBody':
          'Esto elimina permanentemente esta evaluación de este dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar evaluación',
      'deleteSuccess': 'Evaluación eliminada.',
      'deleteError': 'No se pudo eliminar esta evaluación. Inténtalo de nuevo.',
      'checklistTitle': '¿Qué te resulta familiar?',
      'checklistBody':
          'Selecciona cualquier experiencia actual o pasada. Omite lo que no encaje.',
      'obsessions': 'Obsesiones',
      'obsessionsDescription': 'Pensamientos, imágenes o impulsos no deseados',
      'compulsions': 'Compulsiones',
      'compulsionsDescription':
          'Conductas o actos mentales realizados en respuesta al malestar',
      'continueAction': 'Continuar',
      'seeResults': 'Ver resultado',
      'next': 'Siguiente',
      'resultsTitle': 'Tu resultado',
      'retake': 'Repetir',
      'saved': 'Guardado',
      'saveHistory': 'Guardar en mi historial',
      'saving': 'Guardando…',
      'saveSuccess': 'Guardado en tu historial.',
      'saveError': 'No se pudo guardar esta evaluación. Inténtalo de nuevo.',
      'breakdownTitle': 'Subtotales registrados',
      'typesTitle': 'Tipos registrados',
      'typesNone':
          'En esta autoevaluación no se registró ningún tipo de obsesión o compulsión.',
      'typesBoth':
          'En esta autoevaluación se registraron obsesiones y compulsiones.',
      'typesObsessions': 'En esta autoevaluación se registraron obsesiones.',
      'typesCompulsions': 'En esta autoevaluación se registraron compulsiones.',
      'themesTitle': 'Temas registrados',
      'themesBody':
          'Las categorías de la lista que contienen los elementos seleccionados.',
      'nextStepsTitle': 'Sobre este resultado',
      'nextStepsBody':
          'Este resultado es una instantánea autoinformada, no un diagnóstico ni ayuda de emergencia. Si estos patrones afectan tu vida, puedes comentarlos con un profesional cualificado. Si corres peligro inmediato, contacta con los servicios de emergencia locales.',
      'other': 'Autoevaluación Y-BOCS',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuar · $count seleccionados',
      one: 'Continuar · 1 seleccionado',
      zero: 'Continuar',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return 'Pregunta $current de $total';
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
      other: '$count elementos seleccionados',
      one: '1 elemento seleccionado',
    );
    return '$_temp0';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'Tarea marcada como completada.',
      'notCompleted': 'Tarea marcada como no completada.',
      'other': 'Tarea actualizada.',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Retraso de compulsiones en 4 semanas',
      'uncertainty3wk': 'Tolerancia a la incertidumbre',
      'other': 'Programa estructurado',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': 'Practica retrasar las compulsiones, semana a semana',
      'uncertainty3wk': 'Practica vivir sin saber con certeza',
      'other': 'Un plan de práctica guiado',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': 'Semana 1 · Observar y nombrar',
      'delayW2': 'Semana 2 · Ampliar el intervalo',
      'delayW3': 'Semana 3 · Esperar más',
      'delayW4': 'Semana 4 · Práctica diaria',
      'uncertaintyW1': 'Semana 1 · Dejarlo abierto',
      'uncertaintyW2': 'Semana 2 · Quizá sí, quizá no',
      'uncertaintyW3': 'Semana 3 · Dejarlo estar',
      'other': 'Semana del programa',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': 'Registra 3 impulsos sin actuar de inmediato',
      'w1b': 'Retrasa una compulsión 1 minuto, 3 veces',
      'w2a': 'Retrasa las compulsiones 5 minutos',
      'w2b': 'Prueba una vez a observar el impulso como una ola',
      'w3a': 'Retrasa la respuesta 15 minutos',
      'w3b': 'No respondas una vez a un impulso de buscar tranquilidad',
      'w4a': 'Completa una exposición cada día',
      'w4b': 'Reflexiona sobre lo que observaste',
      'u1a': 'Deja una pregunta sin responder',
      'u1b': 'No compruebes una vez',
      'u2a': 'Usa una respuesta de «quizá sí, quizá no» 3 veces',
      'u2b': 'Retrasa la búsqueda en internet sobre una preocupación',
      'u3a': 'Pasa un día sin buscar certeza',
      'u3b': 'Reflexiona sobre lo que observaste',
      'other': 'Tarea del programa',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contaminación y lavado',
      'checking': 'Comprobación y duda',
      'harm': 'Daño y pensamientos tabú',
      'relationship': 'Dudas sobre la relación',
      'justRight': 'Sensación de exactitud y simetría',
      'other': 'Tema del TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination':
          'Para temores de que algo esté sucio, sea contagioso o no sea seguro tocarlo, y para el lavado o la limpieza que siguen.',
      'checking':
          'Para cerraduras, fogones, interruptores, mensajes y otras cosas que vuelves a revisar porque no parecen lo bastante seguras.',
      'harm':
          'Para pensamientos intrusivos sobre daño o temas que se sienten violentos, sexuales o blasfemos, y para las compulsiones o la evitación que siguen.',
      'relationship':
          'Para dudas recurrentes sobre si una relación es la adecuada, si sientes lo suficiente o qué significa la duda.',
      'justRight':
          'Para cosas que parecen tener que estar uniformes, ordenadas o repetirse hasta sentirse correctas.',
      'other':
          'Un itinerario de práctica organizado en torno a un tema del TOC.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': 'Contaminación',
      'checking': 'Comprobación',
      'harm': 'Daño y pensamientos tabú',
      'relationship': 'Dudas sobre la relación',
      'justRight': 'Sensación de exactitud',
      'other': 'Tema del TOC',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'La lista Y-BOCS es anterior a la investigación sobre el TOC de relaciones, por lo que este tema no figura entre sus categorías. Aun así, puedes usar este itinerario de práctica.',
      'other': 'Este tema no aparece como categoría en la lista Y-BOCS.',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': 'Semana 1 · Tocar y esperar',
      'ct2': 'Semana 2 · Un lavado, no tres',
      'ct3': 'Semana 3 · Llevarlo a casa',
      'ck1': 'Semana 1 · Mirar una vez',
      'ck2': 'Semana 2 · Sin repaso mental',
      'ck3': 'Semana 3 · Dejarlo sin resolver',
      'hm1': 'Semana 1 · Dejarlo estar',
      'hm2': 'Semana 2 · Dejar de preguntar',
      'hm3': 'Semana 3 · Sin juicio interior',
      'rl1': 'Semana 1 · Dejar de poner a prueba',
      'rl2': 'Semana 2 · Sin buscar tranquilidad',
      'rl3': 'Semana 3 · Vivir con el quizá',
      'jr1': 'Semana 1 · Dejarlo torcido',
      'jr2': 'Semana 2 · Sin repetir',
      'jr3': 'Semana 3 · Suficientemente bien',
      'other': 'Semana del itinerario',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a':
          'Toca algo que parezca un poco sucio y espera cinco minutos antes de lavarte las manos',
      'ct1b': 'Registra el impulso antes y después sin lavarte',
      'ct2a':
          'Lávate una vez, de forma normal, y no vuelvas para una segunda ronda',
      'ct2b': 'Deja una superficie de casa sin limpiar durante la semana',
      'ct3a':
          'Ve a un lugar que suele llevarte a lavarte después y no te laves al llegar a casa',
      'ct3b': 'Anota lo que predijo el TOC junto a lo que ocurrió',
      'ck1a': 'Comprueba algo una vez y aléjate sin volver a mirar',
      'ck1b':
          'Sal de casa una vez sin hacer una revisión final de las habitaciones',
      'ck2a':
          'Cuando aparezca el impulso de repasar el recuerdo, deja la duda sin resolver',
      'ck2b': 'Envía un mensaje sin releerlo antes ni después',
      'ck3a': 'Pasa un día sin volver a comprobar nada dos veces',
      'ck3b': 'Anota lo que ocurrió y lo que predijo el TOC',
      'hm1a':
          'Deja que un pensamiento intrusivo permanezca un minuto sin discutir con él ni apartarlo',
      'hm1b': 'Observa el repaso mental antes de que empiece y déjalo estar',
      'hm2a':
          'Evita preguntar si eres una buena persona y tampoco busques una respuesta',
      'hm2b':
          'Permanece en una situación que has estado evitando por el pensamiento',
      'hm3a':
          'Pasa un día sin comprobar tus sentimientos para buscar pruebas sobre ti',
      'hm3b': 'Anota cómo fue la semana sin calificarte',
      'rl1a':
          'Observa una prueba de compatibilidad que utilices y sáltatela una vez',
      'rl1b':
          'Deja una duda sobre la relación sin responder durante diez minutos',
      'rl2a':
          'Pasa un día sin preguntar a tu pareja, a una amistad o en internet si la relación es la adecuada',
      'rl2b': 'Haced algo juntos sin vigilar cómo te sientes mientras ocurre',
      'rl3a':
          'Usa una respuesta de «quizá sí, quizá no» cuando aparezca la pregunta',
      'rl3b':
          'Reflexiona sobre la semana sin tomar una decisión sobre el futuro',
      'jr1a':
          'Deja un objeto ligeramente fuera de lugar y permite que la sensación esté presente',
      'jr1b': 'Haz algo una sola vez aunque no parezca terminado',
      'jr2a': 'Evita repetir una acción para que se sienta correcta',
      'jr2b':
          'Escribe algo sin volver para que la redacción se sienta uniforme',
      'jr3a':
          'Pasa un día dejando varias cosas sin terminar de forma deliberada',
      'jr3b':
          'Registra qué ocurrió con la sensación de que algo no estaba bien sin cambiarlo',
      'other': 'Tarea del itinerario',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time': '¿Cuánto tiempo ocupan mis pensamientos obsesivos?',
      'o_interfere': '¿Cuánto interfieren las obsesiones en mi vida?',
      'o_distress': '¿Cuánto malestar me causan los pensamientos obsesivos?',
      'o_resist': '¿Cuánto intento resistirme a los pensamientos obsesivos?',
      'o_control': '¿Cuánto control tengo sobre los pensamientos obsesivos?',
      'c_time':
          '¿Cuánto tiempo dedico a compulsiones, como rituales o comprobaciones?',
      'c_interfere': '¿Cuánto interfieren las compulsiones en mi vida?',
      'c_distress':
          '¿Cuánta ansiedad o malestar sentiría si no pudiera realizar la compulsión?',
      'c_resist': '¿Cuánto intento resistirme a las compulsiones?',
      'c_control': '¿Cuánto control tengo sobre las compulsiones?',
      'other': 'Pregunta de autoevaluación',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'Nada',
      'o_time_1': 'Un poco: menos de una hora al día o de vez en cuando',
      'o_time_2':
          'Una cantidad moderada: de 1 a 3 horas al día o intrusiones frecuentes',
      'o_time_3': 'Mucho: de 3 a 8 horas al día o intrusiones muy frecuentes',
      'o_time_4': 'Casi constante: más de 8 horas al día',
      'o_interfere_0': 'Nada',
      'o_interfere_1': 'Un poco: apenas afectan lo que hago',
      'o_interfere_2': 'Algo: interfieren, pero aún puedo manejarlo',
      'o_interfere_3': 'Mucho: obstaculizan claramente mi día',
      'o_interfere_4': 'Tanto que apenas puedo funcionar',
      'o_distress_0': 'Ninguno',
      'o_distress_1': 'Un poco: no demasiado perturbador',
      'o_distress_2': 'Moderado: perturbador, pero manejable',
      'o_distress_3': 'Mucho: muy perturbador',
      'o_distress_4': 'Malestar casi constante e incapacitante',
      'o_resist_0': 'Siempre intento resistirme, o casi no aparecen',
      'o_resist_1': 'Intento resistirme la mayor parte del tiempo',
      'o_resist_2': 'Hago algún esfuerzo por resistirme',
      'o_resist_3': 'Cedo a casi todos sin oponer mucha resistencia',
      'o_resist_4': 'Cedo por completo y voluntariamente',
      'o_control_0': 'Control total: puedo apartarlos fácilmente',
      'o_control_1': 'Mucho control: normalmente puedo detenerlos o desviarlos',
      'o_control_2': 'Algo de control: a veces puedo y a veces no',
      'o_control_3': 'Poco control: rara vez logro detenerlos',
      'o_control_4': 'Ningún control: se sienten completamente involuntarios',
      'c_time_0': 'Nada',
      'c_time_1': 'Un poco: menos de una hora al día o de vez en cuando',
      'c_time_2':
          'Una cantidad moderada: de 1 a 3 horas al día o rituales frecuentes',
      'c_time_3': 'Mucho: de 3 a 8 horas al día o rituales muy frecuentes',
      'c_time_4': 'Casi constante: más de 8 horas al día',
      'c_interfere_0': 'Nada',
      'c_interfere_1': 'Un poco: apenas afectan lo que hago',
      'c_interfere_2': 'Algo: interfieren, pero aún puedo manejarlo',
      'c_interfere_3': 'Mucho: obstaculizan claramente mi día',
      'c_interfere_4': 'Tanto que apenas puedo funcionar',
      'c_distress_0': 'Nada',
      'c_distress_1': 'Un poco de inquietud',
      'c_distress_2': 'Ansiedad moderada',
      'c_distress_3': 'Mucha ansiedad',
      'c_distress_4': 'Ansiedad abrumadora e incapacitante',
      'c_resist_0': 'Siempre intento resistirme, o casi no aparecen',
      'c_resist_1': 'Intento resistirme la mayor parte del tiempo',
      'c_resist_2': 'Hago algún esfuerzo por resistirme',
      'c_resist_3': 'Cedo a casi todas sin oponer mucha resistencia',
      'c_resist_4': 'Cedo por completo y voluntariamente',
      'c_control_0': 'Control total: puedo detenerme fácilmente',
      'c_control_1': 'Mucho control: normalmente puedo detenerme o retrasarlas',
      'c_control_2': 'Algo de control: a veces puedo y a veces no',
      'c_control_3': 'Poco control: rara vez puedo detenerme o retrasarlas',
      'c_control_4': 'Ningún control: tengo que completarlas',
      'other': 'Opción de respuesta',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': 'Agresividad o daño',
      'contamination': 'Contaminación',
      'sexual': 'Sexual',
      'hoarding_obs': 'Acumulación o conservación',
      'religious': 'Escrupulosidad religiosa o moral',
      'symmetry_obs': 'Simetría o exactitud',
      'somatic': 'Cuerpo o enfermedad',
      'misc_obs': 'Otras obsesiones',
      'washing': 'Lavado o limpieza',
      'checking': 'Comprobación',
      'repeating': 'Rituales de repetición',
      'counting': 'Conteo',
      'ordering': 'Orden o colocación',
      'misc_comp': 'Otras compulsiones',
      'other': 'Otro tema',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': 'Miedo a hacerme daño',
      'agg_harm_others': 'Miedo a hacer daño a otra persona',
      'agg_violent': 'Imágenes violentas u horribles en mi mente',
      'agg_blurt': 'Miedo a soltar insultos u obscenidades',
      'agg_impulse': 'Miedo a actuar siguiendo un impulso no deseado',
      'agg_responsible': 'Miedo a ser responsable de que ocurra algo terrible',
      'con_dirt': 'Preocupación por la suciedad o los gérmenes',
      'con_bodily': 'Asco por residuos o secreciones corporales',
      'con_chemicals':
          'Preocupación por productos químicos o limpiadores domésticos',
      'con_ill': 'Miedo a enfermar por contaminación',
      'con_spread': 'Miedo a transmitir contaminación a otras personas',
      'con_sticky': 'Me molestan las sustancias o residuos pegajosos',
      'sex_forbidden':
          'Pensamientos o imágenes sexuales prohibidos o no deseados',
      'sex_others':
          'Pensamientos sexuales sobre otras personas que me perturban',
      'sex_orientation': 'Dudas no deseadas sobre mi orientación sexual',
      'sex_aggressive': 'Pensamientos sexuales agresivos hacia otras personas',
      'hoard_discard': 'Miedo a tirar algo que podría necesitar',
      'hoard_value':
          'Sensación de que los objetos tienen un valor del que no puedo desprenderme',
      'rel_sacrilege': 'Preocupación por el sacrilegio o la blasfemia',
      'rel_rightwrong':
          'Preocupación excesiva por lo correcto, lo incorrecto o la moralidad',
      'rel_punish': 'Miedo al castigo de Dios o del destino',
      'sym_even':
          'Necesidad de que las cosas estén equilibradas o “justo bien”',
      'sym_exact': 'Necesidad de exactitud, orden o precisión',
      'sym_incomplete':
          'Sensación de estar incompleto hasta que todo se siente bien',
      'som_illness': 'Preocupación excesiva por una enfermedad',
      'som_body':
          'Preocupación excesiva por una parte del cuerpo o la apariencia',
      'misc_know': 'Necesidad de saber o recordar cosas',
      'misc_saywrong': 'Miedo a decir algo incorrecto',
      'misc_lucky': 'Números, palabras o colores de buena o mala suerte',
      'misc_sounds':
          'Sonidos, palabras o música intrusivos que no puedo detener',
      'misc_lose': 'Miedo a perder cosas',
      'wash_hands': 'Lavado de manos excesivo o ritualizado',
      'wash_shower': 'Ducha, baño o aseo excesivos',
      'wash_clean': 'Limpieza excesiva de objetos domésticos',
      'wash_avoid': 'Evitar cosas que considero contaminadas',
      'chk_locks': 'Comprobar cerraduras, aparatos, grifos o la cocina',
      'chk_harm': 'Comprobar que no hice ni haré daño a alguien',
      'chk_mistake': 'Comprobar que no cometí un error',
      'chk_body': 'Comprobar mi cuerpo en busca de señales de enfermedad',
      'rep_reread': 'Volver a leer o escribir',
      'rep_routine':
          'Repetir acciones rutinarias, como pasar por puertas o subir y bajar',
      'rep_untilright': 'Repetir hasta que se sienta “justo bien”',
      'cnt_count': 'Contar objetos, pasos o acciones',
      'cnt_numbers': 'Hacer algo un número determinado de veces',
      'ord_arrange': 'Ordenar cosas hasta que estén simétricas o exactas',
      'ord_align': 'Alinear o enderezar objetos repetidamente',
      'mc_mental':
          'Rituales mentales, como oraciones silenciosas, frases o repasos',
      'mc_reassure': 'Pedir tranquilidad o confesar repetidamente',
      'mc_touch': 'Necesidad de tocar, dar golpecitos o frotar cosas',
      'mc_lists': 'Hacer listas en exceso',
      'mc_avoid': 'Evitar situaciones para impedir un impulso',
      'other': 'Otro síntoma',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical':
          'Este total está en el rango subclínico de la Y-BOCS. El resultado es una instantánea, no un diagnóstico.',
      'mild':
          'Este total está en el rango leve de la Y-BOCS. El resultado es una instantánea, no un diagnóstico.',
      'moderate':
          'Este total está en el rango moderado de la Y-BOCS. El resultado es una instantánea, no un diagnóstico.',
      'severe':
          'Este total está en el rango grave de la Y-BOCS. Considera comentar el impacto con un profesional cualificado.',
      'extreme':
          'Este total está en el rango extremo de la Y-BOCS. Considera contactar con un profesional cualificado. Si corres peligro inmediato, contacta con los servicios de emergencia locales.',
      'other': 'Este total registrado es una instantánea, no un diagnóstico.',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Experimentos conductuales',
      'newAction': 'Nuevo',
      'subtitle':
          'Compara una predicción del OCD con lo que observas después de una acción planificada.',
      'loadError':
          'Tus experimentos no están disponibles en este momento. Inténtalo de nuevo.',
      'deleteTitle': '¿Eliminar este experimento?',
      'deleteBody':
          'Esto elimina permanentemente el experimento de este dispositivo.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar experimento',
      'deleteSuccess': 'Experimento eliminado.',
      'deleteError':
          'No se pudo eliminar este experimento. Inténtalo de nuevo.',
      'statusPlanned': 'Planificado',
      'statusCompleted': 'Completado',
      'outcomeLabel': 'Qué ocurrió',
      'learningLabel': 'Lo que anoté',
      'recordAction': 'Anotar lo ocurrido',
      'emptyTitle': 'Planifica un experimento conductual',
      'emptyBody':
          'Escribe la predicción del OCD, elige una acción pequeña y después anota lo que observaste.',
      'emptyAction': 'Nuevo experimento',
      'outcomeEditorTitle': 'Anotar lo ocurrido',
      'newEditorTitle': 'Nuevo experimento',
      'predictedLabel': 'El OCD predijo',
      'testActionLabel': 'Acción planificada',
      'outcomeInputLabel': '¿Qué ocurrió realmente?',
      'outcomeInputHint': 'Anota lo que observaste, sin calificar el resultado',
      'learningInputLabel': '¿Quieres anotar algo? (opcional)',
      'learningInputHint': 'Un detalle que quieras recordar',
      'predictionInputLabel': '¿Qué predice el OCD?',
      'predictionInputHint':
          'Por ejemplo: Si no vuelvo a comprobar, la casa se inundará',
      'confidenceQuestion': '¿Qué tan segura parece la predicción?',
      'experimentInputLabel': '¿Qué acción pondrá a prueba la predicción?',
      'experimentInputHint':
          'Por ejemplo: Irte después de una comprobación normal y observar qué ocurre',
      'saveOutcome': 'Guardar observación',
      'saveExperiment': 'Guardar experimento',
      'outcomeValidation': 'Añade una nota breve sobre lo que observaste.',
      'planValidation':
          'Añade tanto la predicción del OCD como la acción que planeas realizar.',
      'outcomeSaveSuccess': 'Observación guardada.',
      'planSaveSuccess':
          'Experimento guardado. Anota lo ocurrido después de realizarlo.',
      'saveError':
          'No se pudo guardar este experimento. Tu texto sigue aquí. Inténtalo de nuevo.',
      'other': 'Experimento conductual',
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
    return '$status · $date · $confidence. Predicción: $prediction. Acción planificada: $experiment.';
  }

  @override
  String exposureReflectionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Reflexiones sobre exposiciones',
      'newAction': 'Nueva',
      'subtitle':
          'Registra lo que notaste después de una exposición. Añade solo los detalles que te resulten útiles.',
      'loadError':
          'Tus reflexiones no están disponibles en este momento. Inténtalo de nuevo.',
      'deleteTitle': '¿Eliminar esta reflexión?',
      'deleteBody':
          'Esto elimina la reflexión de este dispositivo de forma permanente.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar reflexión',
      'deleteSuccess': 'Reflexión eliminada.',
      'deleteError': 'No se pudo eliminar esta reflexión. Inténtalo de nuevo.',
      'emptyTitle': 'Reflexiona sobre una exposición',
      'emptyBody':
          'Registra qué ocurrió, qué predijo el OCD y cualquier cosa que quieras recordar. Solo se requiere la primera pregunta.',
      'emptyAction': 'Nueva reflexión',
      'editorTitle': 'Nueva reflexión',
      'whatHappenedLabel': '¿Qué ocurrió?',
      'whatHappenedHint': 'La exposición o práctica que realizaste',
      'predictionLabel': '¿Qué predijo el OCD?',
      'predictionHint': 'El resultado que el OCD dijo que podría ocurrir',
      'actualLabel': '¿Qué observaste?',
      'actualHint': 'Lo que ocurrió durante o después de la exposición',
      'learningLabel': '¿Hay algo que quieras recordar? (opcional)',
      'learningHint': 'Un detalle que podría ser útil más adelante',
      'nextTimeLabel': '¿Hay algo que podrías cambiar? (opcional)',
      'nextTimeHint': 'Déjalo en blanco si no se te ocurre nada',
      'saveAction': 'Guardar reflexión',
      'validation':
          'Empieza con una breve nota sobre lo que ocurrió. Las demás preguntas son opcionales.',
      'saveSuccess': 'Reflexión guardada.',
      'saveError':
          'No se pudo guardar esta reflexión. Tu texto sigue aquí. Inténtalo de nuevo.',
      'other': 'Reflexión sobre una exposición',
    });
    return '$_temp0';
  }

  @override
  String exposureReflectionCardSummary(String date, String whatHappened) {
    return '$date. Qué ocurrió: $whatHappened.';
  }

  @override
  String implementationIntentionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Planes si-entonces',
      'newAction': 'Nuevo',
      'subtitle':
          'Relaciona una situación con una respuesta que quieras probar cuando ocurra.',
      'loadError':
          'Tus planes si-entonces no están disponibles en este momento. Inténtalo de nuevo.',
      'deleteTitle': '¿Eliminar este plan si-entonces?',
      'deleteBody':
          'Esto elimina el plan de este dispositivo de forma permanente.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar plan si-entonces',
      'deleteSuccess': 'Plan si-entonces eliminado.',
      'deleteError':
          'No se pudo eliminar este plan si-entonces. Inténtalo de nuevo.',
      'emptyTitle': 'Crea un plan si-entonces',
      'emptyBody':
          'Escribe una situación y la respuesta que quieras probar cuando ocurra.',
      'emptyAction': 'Nuevo plan si-entonces',
      'editorTitle': 'Nuevo plan si-entonces',
      'triggerLabel': 'Si…',
      'triggerHint':
          'La situación, por ejemplo: noto la necesidad de buscar tranquilidad',
      'responseLabel': 'entonces…',
      'responseHint':
          'La respuesta que quieres probar, por ejemplo: escribir lo que estoy notando',
      'saveAction': 'Guardar plan si-entonces',
      'validation': 'Añade la situación y la respuesta que quieras probar.',
      'saveSuccess': 'Plan si-entonces guardado.',
      'saveError':
          'No se pudo guardar este plan si-entonces. Tu texto sigue aquí. Inténtalo de nuevo.',
      'other': 'Plan si-entonces',
    });
    return '$_temp0';
  }

  @override
  String implementationIntentionStatement(String trigger, String response) {
    return 'Si $trigger, entonces $response.';
  }

  @override
  String uncertaintyTrainingText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Práctica de la incertidumbre',
      'subtitle': 'Practica dar espacio a no saber.',
      'loadError':
          'Los recuentos de prácticas no están disponibles en este momento. Puedes abrir los ejercicios de todos modos.',
      'whyLabel': 'SOBRE ESTA PRÁCTICA',
      'willingnessLabel': '¿Qué tan dispuesto estabas a permanecer sin saber?',
      'noteLabel': 'Nota (opcional)',
      'noteHint': '¿Qué notaste?',
      'saveAction': 'Registrar esta práctica',
      'saveSuccess': 'Práctica registrada.',
      'saveError':
          'No se pudo registrar esta práctica. Tu nota sigue aquí. Inténtalo de nuevo.',
      'other': 'Práctica de la incertidumbre',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseTitle(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': 'Quizá sí, quizá no',
      'unanswered': 'Déjalo sin respuesta',
      'resist': 'Pausa la búsqueda de certeza',
      'other': 'Ejercicio de incertidumbre',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseIntro(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Cuando el OCD pida certeza, prueba a responder “quizá sí, quizá no” y vuelve a prestar atención a lo que estabas haciendo.',
      'unanswered':
          'Deja abierta una pregunta recurrente en vez de resolverla.',
      'resist':
          'Nota el impulso de comprobar, buscar o pedir tranquilidad y elige no seguirlo durante esta práctica.',
      'other': 'Una práctica para permitir que la incertidumbre siga presente.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseWhy(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Este ejercicio practica dejar una pregunta sin resolver, sin añadir tranquilidad.',
      'unanswered':
          'Este ejercicio practica permitir que una pregunta siga abierta.',
      'resist':
          'Este ejercicio registra la práctica deliberada de no buscar certeza.',
      'other':
          'Este es un ejercicio de autoayuda para dar espacio a la incertidumbre.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExercisePrompt(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe':
          'Elige una preocupación y responde “quizá sí, quizá no”. Nota lo que está presente sin intentar resolverlo.',
      'unanswered':
          'Elige una pregunta que normalmente resolverías y déjala sin respuesta durante esta práctica.',
      'resist':
          'Nota un impulso de buscar certeza y déjalo sin respuesta durante esta práctica.',
      'other':
          'Elige una pequeña forma de dejar la incertidumbre sin resolver durante esta práctica.',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyPracticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prácticas',
      one: '1 práctica',
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
      other: '$count prácticas registradas.',
      one: '1 práctica registrada.',
    );
    return '$title. $intro $_temp0';
  }

  @override
  String uncertaintyWillingness(int value) {
    return 'Disposición: $value de 10';
  }

  @override
  String actionPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'Planificador de acciones',
      'newAction': 'Nuevo',
      'subtitle': 'Registra una situación y la respuesta que quieras probar.',
      'loadError':
          'Tus planes de acción no están disponibles en este momento. Inténtalo de nuevo.',
      'deleteTitle': '¿Eliminar este plan de acción?',
      'deleteBody':
          'Esto elimina el plan de este dispositivo de forma permanente.',
      'cancel': 'Cancelar',
      'deleteAction': 'Eliminar',
      'deleteTooltip': 'Eliminar plan de acción',
      'deleteSuccess': 'Plan de acción eliminado.',
      'deleteError':
          'No se pudo eliminar este plan de acción. Inténtalo de nuevo.',
      'statePlanned': 'Planificado',
      'stateCompleted': 'Marcado como completado',
      'toggleMarkComplete': 'Marcar el plan de acción como completado',
      'toggleMarkIncomplete': 'Marcar el plan de acción como no completado',
      'toggleSuccessComplete': 'Plan de acción marcado como completado.',
      'toggleSuccessIncomplete': 'Plan de acción marcado como no completado.',
      'toggleError':
          'No se pudo actualizar este plan de acción. Se sigue mostrando su estado anterior. Inténtalo de nuevo.',
      'emptyTitle': 'Crea un plan de acción',
      'emptyBody':
          'Escribe una situación y la respuesta que quieras probar cuando ocurra.',
      'emptyAction': 'Nuevo plan de acción',
      'editorTitle': 'Nuevo plan de acción',
      'situationLabel': 'Cuando aparezca el OCD',
      'situationHint':
          'Por ejemplo: noto el impulso de buscar información sobre un síntoma',
      'actionLabel': 'Respuesta que quiero probar',
      'actionHint': 'Por ejemplo: esperar 15 minutos antes de decidir si busco',
      'dateLabel': 'Fecha (opcional)',
      'pickDate': 'Elegir una fecha',
      'clearDate': 'Quitar fecha',
      'notesLabel': 'Notas (opcional)',
      'notesHint': 'Cualquier cosa que quieras recordar',
      'saveAction': 'Guardar plan de acción',
      'validation': 'Añade la situación y la respuesta que quieras probar.',
      'saveSuccess': 'Plan de acción guardado.',
      'saveError':
          'No se pudo guardar este plan de acción. Tu texto sigue aquí. Inténtalo de nuevo.',
      'other': 'Plan de acción',
    });
    return '$_temp0';
  }

  @override
  String actionPlanCardSummary(String status, String situation, String action) {
    return '$status. Situación: $situation. Respuesta planificada: $action.';
  }

  @override
  String actionPlanDateSummary(String date) {
    return 'Fecha planificada: $date.';
  }
}
