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
}
