import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/first_run.dart';
import 'package:patterns/mobile/screens/analytics_screen.dart';
import 'package:patterns/mobile/screens/compulsion_delay_screen.dart';
import 'package:patterns/mobile/screens/emergency_toolkit_screen.dart';
import 'package:patterns/mobile/screens/erp_exercises_screen.dart';
import 'package:patterns/mobile/screens/journal_screen.dart';
import 'package:patterns/mobile/screens/ocd_tracker_screen.dart';
import 'package:patterns/mobile/screens/onboarding_screen.dart';
import 'package:patterns/mobile/screens/recovery_hub_screen.dart';
import 'package:patterns/mobile/screens/settings_screen.dart';
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

class _Pro extends ProNotifier {
  @override
  bool build() => true;
}

class _Calm extends CalmInsightsNotifier {
  @override
  bool build() => true;
}

typedef _SurfaceBuilder = Widget Function();
typedef _SurfaceAdvance = Future<void> Function(WidgetTester tester);

class _ReviewSurface {
  final String name;
  final _SurfaceBuilder build;
  final _SurfaceAdvance? advance;

  const _ReviewSurface(this.name, this.build, {this.advance});
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
  _ReviewSurface('insights', AnalyticsScreen.new),
  _ReviewSurface('recovery', RecoveryHubScreen.new),
  _ReviewSurface('immediate-support', EmergencyToolkitScreen.new),
  _ReviewSurface('erp-plan-editor', ErpPlanEditorScreen.new),
  _ReviewSurface('ybocs-intro', YbocsScreen.new),
  _ReviewSurface('settings', SettingsScreen.new),
  _ReviewSurface(
    'pro',
    () =>
        const Scaffold(body: PaywallSheet(entryPoint: ProEntryPoint.settings)),
  ),
  _ReviewSurface('tips', () => const Scaffold(body: TipJarSheet())),
];

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'legacy_install_marker': true});
    await initAppPreferences();
  });

  for (final locale in _locales) {
    for (final scale in _scales.entries) {
      testWidgets(
        '${_localeTag(locale)} renders representative mobile surfaces at ${scale.key}',
        (tester) async {
          await tester.binding.setSurfaceSize(const Size(390, 844));
          addTearDown(() => tester.binding.setSurfaceSize(null));

          for (final surface in _surfaces) {
            await tester.pumpWidget(
              _host(
                locale: locale,
                textScale: scale.value,
                home: surface.build(),
              ),
            );
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));
            if (surface.advance != null) {
              await surface.advance!(tester);
            }
            _expectNoRenderException(
              tester,
              '${_localeTag(locale)} / ${scale.key} / ${surface.name} / initial',
            );

            await _exerciseVerticalContent(
              tester,
              context: '${_localeTag(locale)} / ${scale.key} / ${surface.name}',
            );

            await tester.pumpWidget(const SizedBox.shrink());
            await tester.pump();
          }
        },
      );
    }
  }
}

Future<void> _tapFirstElevatedButton(WidgetTester tester) async {
  final button = find.byType(ElevatedButton).first;
  await tester.ensureVisible(button);
  await tester.pump();
  await tester.tap(button);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

Widget _host({
  required Locale locale,
  required double textScale,
  required Widget home,
}) {
  return ProviderScope(
    overrides: [
      journalProvider.overrideWith(_Journals.new),
      ocdProvider.overrideWith(_Ocds.new),
      delaySessionProvider.overrideWith(_Delays.new),
      erpExerciseSessionProvider.overrideWith(_ErpSessions.new),
      exposureStepProvider.overrideWith(_Steps.new),
      responsePreventionProvider.overrideWith(_Responses.new),
      urgeSurfProvider.overrideWith(_Surfs.new),
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
          size: const Size(390, 844),
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
