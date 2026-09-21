import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/app_preferences.dart';
import 'package:patterns/content/ybocs_content.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/first_run.dart';
import 'package:patterns/mobile/screens/action_planner_screen.dart';
import 'package:patterns/mobile/screens/analytics_screen.dart';
import 'package:patterns/mobile/screens/behavioral_experiments_screen.dart';
import 'package:patterns/mobile/screens/compulsion_delay_screen.dart';
import 'package:patterns/mobile/screens/emergency_toolkit_screen.dart';
import 'package:patterns/mobile/screens/erp_exercises_screen.dart';
import 'package:patterns/mobile/screens/exposure_hierarchy_screen.dart';
import 'package:patterns/mobile/screens/exposure_materials_screen.dart';
import 'package:patterns/mobile/screens/exposure_reflection_screen.dart';
import 'package:patterns/mobile/screens/first_run_result_screen.dart';
import 'package:patterns/mobile/screens/implementation_intentions_screen.dart';
import 'package:patterns/mobile/screens/journal_screen.dart';
import 'package:patterns/mobile/screens/ocd_tracker_screen.dart';
import 'package:patterns/mobile/screens/onboarding_screen.dart';
import 'package:patterns/mobile/screens/recovery_hub_screen.dart';
import 'package:patterns/mobile/screens/recovery_metrics_screen.dart';
import 'package:patterns/mobile/screens/response_prevention_screen.dart';
import 'package:patterns/mobile/screens/settings_screen.dart';
import 'package:patterns/mobile/screens/structured_programs_screen.dart';
import 'package:patterns/mobile/screens/uncertainty_training_screen.dart';
import 'package:patterns/mobile/screens/urge_surf_screen.dart';
import 'package:patterns/mobile/screens/ybocs_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/services/pro_entry_point.dart';
import 'package:patterns/theme/app_theme.dart';
import 'package:patterns/widgets/paywall_sheet.dart';
import 'package:patterns/widgets/tip_jar_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Journals extends JournalNotifier {
  @override
  Future<List<JournalEntry>> build() async => const [];
}

class _Ocds extends OcdNotifier {
  @override
  Future<List<OcdEntry>> build() async => const [];
}

class _Delays extends DelaySessionNotifier {
  @override
  Future<List<DelaySession>> build() async => const [];
}

class _ErpSessions extends ErpExerciseSessionNotifier {
  @override
  Future<List<ErpExerciseSession>> build() async => const [];
}

class _ErpPlans extends ErpExercisePlanNotifier {
  @override
  Future<List<ErpExercisePlan>> build() async => const [];
}

class _Steps extends ExposureStepNotifier {
  @override
  Future<List<ExposureStep>> build() async => const [];
}

class _Responses extends ResponsePreventionNotifier {
  @override
  Future<List<ResponsePreventionLog>> build() async => const [];
}

class _Surfs extends UrgeSurfNotifier {
  @override
  Future<List<UrgeSurfSession>> build() async => const [];
}

class _Ybocs extends YbocsAssessmentNotifier {
  @override
  Future<List<YbocsAssessment>> build() async => const [];
}

class _Hierarchies extends ExposureHierarchyNotifier {
  @override
  Future<List<ExposureHierarchy>> build() async => const [];
}

class _Enrollments extends ProgramEnrollmentNotifier {
  @override
  Future<List<ProgramEnrollment>> build() async => const [];
}

class _TaskProgress extends ProgramTaskProgressNotifier {
  @override
  Future<List<ProgramTaskProgress>> build() async => const [];
}

class _Experiments extends BehavioralExperimentNotifier {
  @override
  Future<List<BehavioralExperiment>> build() async => const [];
}

class _Reflections extends ExposureReflectionNotifier {
  @override
  Future<List<ExposureReflection>> build() async => const [];
}

class _ActionPlans extends ActionPlanNotifier {
  @override
  Future<List<ActionPlan>> build() async => const [];
}

class _Intentions extends ImplementationIntentionNotifier {
  @override
  Future<List<ImplementationIntention>> build() async => const [];
}

class _UncertaintyLogs extends UncertaintyLogNotifier {
  @override
  Future<List<UncertaintyLog>> build() async => const [];
}

class _Materials extends ExposureMaterialNotifier {
  @override
  Future<List<ExposureMaterial>> build() async => const [];
}

class _Pro extends ProNotifier {
  @override
  bool build() => true;
}

class _Calm extends CalmInsightsNotifier {
  @override
  bool build() => true;
}

typedef _SurfaceBuilder = Widget Function();
typedef _SurfaceAdvance =
    Future<void> Function(WidgetTester tester, AppLocalizations strings);

class _ReviewSurface {
  final String name;
  final _SurfaceBuilder build;
  final _SurfaceAdvance? advance;
  final bool normalTextOnlyAdvance;

  const _ReviewSurface(
    this.name,
    this.build, {
    this.advance,
    this.normalTextOnlyAdvance = false,
  });
}

const _locales = <Locale>[
  Locale('en'),
  Locale('pt', 'BR'),
  Locale('de'),
  Locale('ja'),
  Locale('es'),
  Locale('fr'),
];

const _scales = <String, double>{'normal': 1, '200-percent': 2, 'maximum': 3.2};
final _surfaces = <_ReviewSurface>[
  _ReviewSurface(
    'onboarding-promise',
    () => WelcomeScreen(onChoosePath: (FirstRunPath _) {}, onImport: () {}),
  ),
  _ReviewSurface(
    'onboarding-choices',
    () => WelcomeScreen(onChoosePath: (FirstRunPath _) {}, onImport: () {}),
    advance: _tapFirstElevatedButton,
  ),
  _ReviewSurface(
    'today',
    () => TodayScreen(
      onJournal: () {},
      onTrack: () {},
      onDelay: () {},
      onErp: () {},
      onInsights: () {},
      onSettings: () {},
      onNextStep: (_) {},
    ),
  ),
  _ReviewSurface('journal', JournalScreen.new),
  _ReviewSurface(
    'journal-editor',
    () => JournalEntryEditor(date: DateTime(2026, 9, 17)),
  ),
  _ReviewSurface(
    'tracker',
    () => OcdTrackerScreen(onAdd: () {}, onDelay: () {}),
  ),
  _ReviewSurface(
    'tracker-editor',
    () => const OcdEventFlow(initialType: OcdType.obsession),
  ),
  _ReviewSurface(
    'compulsion-delay',
    () => const CompulsionDelayFlow(initialCompulsion: 'checking'),
  ),
  _ReviewSurface(
    'compulsion-delay-stop-dialog',
    () => const CompulsionDelayFlow(initialCompulsion: 'checking'),
    advance: _showDelayStopDialog,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface(
    'compulsion-delay-reflection',
    () => const CompulsionDelayFlow(initialCompulsion: 'checking'),
    advance: _showDelayReflection,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface('insights', AnalyticsScreen.new),
  _ReviewSurface('recovery', RecoveryHubScreen.new),
  _ReviewSurface('recovery-metrics', RecoveryMetricsScreen.new),
  _ReviewSurface('immediate-support', EmergencyToolkitScreen.new),
  _ReviewSurface('breathing', BreathingScreen.new),
  _ReviewSurface('urge-surf', UrgeSurfScreen.new),
  _ReviewSurface('urge-surf-flow', UrgeSurfFlow.new),
  _ReviewSurface('response-prevention', ResponsePreventionScreen.new),
  _ReviewSurface('response-prevention-editor', ResponsePreventionLogScreen.new),
  _ReviewSurface('erp-plan-editor', ErpPlanEditorScreen.new),
  _ReviewSurface('erp-plans', () => const ErpExercisesScreen(showBack: true)),
  _ReviewSurface(
    'erp-practice-stop-dialog',
    () => ErpPlanPracticeFlow(plan: _sampleErpPlan()),
    advance: _showErpStopDialog,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface(
    'erp-practice-reflection',
    () => ErpPlanPracticeFlow(plan: _sampleErpPlan()),
    advance: _showErpReflection,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface('exposure-hierarchies', ExposureHierarchyScreen.new),
  _ReviewSurface(
    'exposure-hierarchy-editor',
    ExposureHierarchyBuilderScreen.new,
  ),
  _ReviewSurface('exposure-materials', ExposureMaterialsScreen.new),
  _ReviewSurface(
    'exposure-material-editor',
    () => const ExposureMaterialEditScreen(type: MaterialType.script),
  ),
  _ReviewSurface('behavioral-experiments', BehavioralExperimentsScreen.new),
  _ReviewSurface(
    'behavioral-experiment-editor',
    BehavioralExperimentEditScreen.new,
  ),
  _ReviewSurface('exposure-reflections', ExposureReflectionScreen.new),
  _ReviewSurface(
    'exposure-reflection-editor',
    ExposureReflectionEditScreen.new,
  ),
  _ReviewSurface('action-plans', ActionPlannerScreen.new),
  _ReviewSurface('action-plan-editor', ActionPlanEditScreen.new),
  _ReviewSurface(
    'implementation-intentions',
    ImplementationIntentionsScreen.new,
  ),
  _ReviewSurface(
    'implementation-intention-editor',
    ImplementationIntentionEditScreen.new,
  ),
  _ReviewSurface('uncertainty-training', UncertaintyTrainingScreen.new),
  _ReviewSurface(
    'uncertainty-practice',
    () => UncertaintyPracticeScreen(exercise: uncertaintyExercises.first),
  ),
  _ReviewSurface('structured-programs', StructuredProgramsScreen.new),
  _ReviewSurface('ybocs-intro', YbocsScreen.new),
  _ReviewSurface(
    'ybocs-checklist',
    YbocsScreen.new,
    advance: _showYbocsChecklist,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface(
    'ybocs-questions',
    YbocsScreen.new,
    advance: _showYbocsQuestions,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface(
    'ybocs-results',
    YbocsScreen.new,
    advance: _showYbocsResults,
    normalTextOnlyAdvance: true,
  ),
  _ReviewSurface(
    'first-run-result',
    () => FirstRunResultScreen(
      kind: FirstRunPath.explore,
      result: const FirstRunActivityResult(),
      onDone: () {},
    ),
  ),
  _ReviewSurface('settings', SettingsScreen.new),
  _ReviewSurface(
    'pro',
    () =>
        const Scaffold(body: PaywallSheet(entryPoint: ProEntryPoint.settings)),
  ),
  _ReviewSurface('tips', () => const Scaffold(body: TipJarSheet())),
];

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final manrope = FontLoader(AppTheme.sansFamily)
      ..addFont(rootBundle.load('assets/fonts/Manrope-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Manrope-Medium.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Manrope-Semibold.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Manrope-Bold.ttf'));
    final fraunces = FontLoader(AppTheme.displayFamily)
      ..addFont(rootBundle.load('assets/fonts/Fraunces-Variable.ttf'));
    await Future.wait([manrope.load(), fraunces.load()]);
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({'legacy_install_marker': true});
    await initAppPreferences();
  });

  for (final locale in _locales) {
    for (final scale in _scales.entries) {
      testWidgets(
        '${_localeTag(locale)} renders representative mobile surfaces at ${scale.key}',
        (tester) async {
          final screenSize = scale.value == 1
              ? const Size(320, 568)
              : const Size(390, 844);
          await tester.binding.setSurfaceSize(screenSize);
          addTearDown(() => tester.binding.setSurfaceSize(null));
          final multilineButtonLabels = <String>{};

          for (final surface in _surfaces) {
            await tester.pumpWidget(
              _host(
                locale: locale,
                textScale: scale.value,
                screenSize: screenSize,
                home: surface.build(),
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));
            if (surface.advance != null &&
                (!surface.normalTextOnlyAdvance || scale.value == 1)) {
              await surface.advance!(tester, lookupAppLocalizations(locale));
            }
            _expectNoRenderException(
              tester,
              '${_localeTag(locale)} / ${scale.key} / ${surface.name} / initial',
            );
            if (scale.value == 1) {
              multilineButtonLabels.addAll(
                _multilineButtonLabels(
                  tester,
                  '${_localeTag(locale)} / ${surface.name} / initial',
                ),
              );
            }

            await _exerciseVerticalContent(
              tester,
              context: '${_localeTag(locale)} / ${scale.key} / ${surface.name}',
              multilineButtonLabels: scale.value == 1
                  ? multilineButtonLabels
                  : null,
            );

            await tester.pumpWidget(const SizedBox.shrink());
            await tester.pump();
          }

          expect(
            multilineButtonLabels,
            isEmpty,
            reason:
                '${_localeTag(locale)} has button labels that wrap at normal text size',
          );
        },
      );
    }
  }
}

Future<void> _tapFirstElevatedButton(
  WidgetTester tester,
  AppLocalizations _,
) async {
  final button = find.byType(ElevatedButton).first;
  await tester.ensureVisible(button);
  await tester.pump();
  await tester.tap(button);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

ErpExercisePlan _sampleErpPlan() {
  final now = DateTime(2026, 9, 22);
  return ErpExercisePlan(
    id: 7,
    exerciseId: 'delay_checking',
    exerciseTitle: 'Saved plan title',
    triggerOrExposure: 'Leave after one normal check',
    fearPrediction: 'I may feel uncertain',
    preventionCommitment: 'Do not check again',
    defaultSeconds: 60,
    createdAt: now,
    updatedAt: now,
  );
}

Future<void> _showDelayStopDialog(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _scrollUntilTextVisible(tester, strings.delayBeginAction);
  final begin = find.widgetWithText(ElevatedButton, strings.delayBeginAction);
  await tester.tap(begin);
  await tester.pump();

  final stop = find.widgetWithText(OutlinedButton, strings.delayStopAction);
  await tester.tap(stop);
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _showDelayReflection(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _showDelayStopDialog(tester, strings);
  await tester.tap(
    find.widgetWithText(ElevatedButton, strings.delayStopAction).hitTestable(),
  );
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _showErpStopDialog(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _scrollUntilTextVisible(tester, strings.erpFlowText('start'));
  final start = find.widgetWithText(
    ElevatedButton,
    strings.erpFlowText('start'),
  );
  await tester.tap(start);
  await tester.pump();

  final stop = find.widgetWithText(
    OutlinedButton,
    strings.erpFlowText('stopEarly'),
  );
  await tester.tap(stop);
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _showErpReflection(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _showErpStopDialog(tester, strings);
  await tester.tap(
    find
        .widgetWithText(ElevatedButton, strings.erpFlowText('stop'))
        .hitTestable(),
  );
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _showYbocsChecklist(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _scrollUntilTextVisible(tester, strings.ybocsText('begin'));
  final begin = find.widgetWithText(ElevatedButton, strings.ybocsText('begin'));
  await tester.tap(begin);
  await tester.pump();
}

Future<void> _showYbocsQuestions(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _showYbocsChecklist(tester, strings);
  final continueLabel = strings.ybocsSelectedCount(0);
  final continueButton = find.widgetWithText(ElevatedButton, continueLabel);
  await tester.tap(continueButton);
  await tester.pump();
}

Future<void> _showYbocsResults(
  WidgetTester tester,
  AppLocalizations strings,
) async {
  await _showYbocsQuestions(tester, strings);
  for (var index = 0; index < ybocsSeverityQuestions.length; index++) {
    final question = ybocsSeverityQuestions[index];
    final optionText = question.localizedOption(strings, 0);
    final option = find.text(optionText);
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pump();

    final action = find.widgetWithText(
      ElevatedButton,
      strings.ybocsText(
        index == ybocsSeverityQuestions.length - 1 ? 'seeResults' : 'next',
      ),
    );
    await tester.ensureVisible(action);
    await tester.tap(action);
    await tester.pump();
  }
}

Future<void> _scrollUntilTextVisible(WidgetTester tester, String text) async {
  await tester.scrollUntilVisible(
    find.text(text),
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pump();
}

Widget _host({
  required Locale locale,
  required double textScale,
  required Size screenSize,
  required Widget home,
}) {
  return ProviderScope(
    overrides: [
      journalProvider.overrideWith(_Journals.new),
      ocdProvider.overrideWith(_Ocds.new),
      delaySessionProvider.overrideWith(_Delays.new),
      erpExerciseSessionProvider.overrideWith(_ErpSessions.new),
      erpExercisePlanProvider.overrideWith(_ErpPlans.new),
      exposureStepProvider.overrideWith(_Steps.new),
      responsePreventionProvider.overrideWith(_Responses.new),
      urgeSurfProvider.overrideWith(_Surfs.new),
      exposureHierarchyProvider.overrideWith(_Hierarchies.new),
      programEnrollmentProvider.overrideWith(_Enrollments.new),
      programTaskProgressProvider.overrideWith(_TaskProgress.new),
      behavioralExperimentProvider.overrideWith(_Experiments.new),
      exposureReflectionProvider.overrideWith(_Reflections.new),
      actionPlanProvider.overrideWith(_ActionPlans.new),
      implementationIntentionProvider.overrideWith(_Intentions.new),
      uncertaintyLogProvider.overrideWith(_UncertaintyLogs.new),
      exposureMaterialProvider.overrideWith(_Materials.new),
      ybocsAssessmentProvider.overrideWith(_Ybocs.new),
      proProvider.overrideWith(_Pro.new),
      calmInsightsProvider.overrideWith(_Calm.new),
    ],
    child: MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mobileDarkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          size: screenSize,
          textScaler: TextScaler.linear(textScale),
          disableAnimations: true,
        ),
        child: child!,
      ),
      home: home,
    ),
  );
}

Future<void> _exerciseVerticalContent(
  WidgetTester tester, {
  required String context,
  required Set<String>? multilineButtonLabels,
}) async {
  for (var step = 0; step < 10; step++) {
    final vertical = find.byType(Scrollable).evaluate().where((element) {
      final widget = element.widget as Scrollable;
      return widget.axisDirection == AxisDirection.down ||
          widget.axisDirection == AxisDirection.up;
    }).toList();
    if (vertical.isEmpty) return;

    final finder = find.byWidget(vertical.first.widget);
    await tester.drag(finder, const Offset(0, -520), warnIfMissed: false);
    await tester.pump();
    _expectNoRenderException(tester, '$context / scroll $step');
    if (multilineButtonLabels != null) {
      multilineButtonLabels.addAll(
        _multilineButtonLabels(tester, '$context / scroll $step'),
      );
    }
  }
}

Iterable<String> _multilineButtonLabels(
  WidgetTester tester,
  String context,
) sync* {
  final richTextElements = find.byType(RichText).evaluate();

  for (final element in richTextElements) {
    var belongsToButton = false;
    var belongsToSegmentedButton = false;
    element.visitAncestorElements((ancestor) {
      if (ancestor.widget is ButtonStyleButton) {
        belongsToButton = true;
      }
      if (ancestor.widget is SegmentedButton) belongsToSegmentedButton = true;
      return true;
    });
    if (!belongsToButton || belongsToSegmentedButton) continue;

    final renderObject = element.renderObject;
    if (renderObject is! RenderParagraph ||
        !renderObject.attached ||
        !renderObject.hasSize) {
      continue;
    }

    final painter = TextPainter(
      text: renderObject.text,
      textAlign: renderObject.textAlign,
      textDirection: renderObject.textDirection,
      textScaler: renderObject.textScaler,
      maxLines: renderObject.maxLines,
      locale: renderObject.locale,
      strutStyle: renderObject.strutStyle,
      textWidthBasis: renderObject.textWidthBasis,
      textHeightBehavior: renderObject.textHeightBehavior,
    )..layout(maxWidth: renderObject.size.width);
    final metrics = painter.computeLineMetrics();
    if (metrics.length > 1) {
      final surface = context
          .replaceAll(' / normal', '')
          .replaceFirst(RegExp(r' / (initial|scroll \d+)$'), '');
      yield '$surface: "${renderObject.text.toPlainText()}" '
          '[size=${renderObject.size}, constraints=${renderObject.constraints}, '
          'lines=${metrics.map((line) => line.width.toStringAsFixed(1)).toList()}]';
    }
  }
}

void _expectNoRenderException(WidgetTester tester, String context) {
  final exceptions = <Object>[];
  Object? exception;
  while ((exception = tester.takeException()) != null) {
    if (exception is FlutterError) {
      debugPrint(exception.toString());
    }
    exceptions.add(exception!);
  }
  expect(exceptions, isEmpty, reason: context);
}

String _localeTag(Locale locale) => locale.countryCode == null
    ? locale.languageCode
    : '${locale.languageCode}-${locale.countryCode}';
