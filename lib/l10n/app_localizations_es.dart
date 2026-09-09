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
}
