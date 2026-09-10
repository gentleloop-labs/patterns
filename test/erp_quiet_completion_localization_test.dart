import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/erp_exercises_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _SavedSession {
  ErpExerciseSession? value;
}

class _Sessions extends ErpExerciseSessionNotifier {
  _Sessions(this.output, this.succeeds);

  final _SavedSession output;
  final bool succeeds;

  @override
  Future<List<ErpExerciseSession>> build() async => const [];

  @override
  Future<bool> addSession(ErpExerciseSession session) async {
    if (succeeds) output.value = session;
    return succeeds;
  }
}

ErpExercisePlan _plan() {
  final now = DateTime(2026, 9, 10);
  return ErpExercisePlan(
    id: 7,
    exerciseId: 'delay_checking',
    exerciseTitle: 'Saved plan title',
    triggerOrExposure: 'Leave the door after one normal check',
    fearPrediction: 'I may feel uncertain',
    preventionCommitment: 'Do not check again',
    defaultSeconds: 60,
    createdAt: now,
    updatedAt: now,
  );
}

Widget _host({
  required Locale locale,
  required _SavedSession output,
  bool saveSucceeds = true,
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [
      erpExerciseSessionProvider.overrideWith(
        () => _Sessions(output, saveSucceeds),
      ),
    ],
    child: MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mobileDarkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: textScaler,
          disableAnimations: disableAnimations,
        ),
        child: child!,
      ),
      home: ErpPlanPracticeFlow(plan: _plan()),
    ),
  );
}

void _usePhoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _reachReflection(
  WidgetTester tester, {
  required String start,
  required String stopEarly,
  required String stop,
}) async {
  await tester.scrollUntilVisible(
    find.text(start),
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.tap(find.text(start));
  await tester.pump();
  await tester.tap(
    find.widgetWithText(OutlinedButton, stopEarly).hitTestable(),
  );
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.widgetWithText(ElevatedButton, stop).hitTestable());
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets('ERP saves before Japanese quiet completion', (tester) async {
    _usePhoneViewport(tester);
    final saved = _SavedSession();
    await tester.pumpWidget(_host(locale: const Locale('ja'), output: saved));
    await tester.pump();

    await _reachReflection(
      tester,
      start: '練習を始める',
      stopEarly: '早めに終了',
      stop: '終了する',
    );
    expect(find.text('振り返る'), findsOneWidget);
    expect(find.text('タイマーを早めに終了しました。'), findsOneWidget);

    await tester.tap(find.text('反応を先延ばしにした'));
    await tester.scrollUntilVisible(
      find.text('練習を保存'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('練習を保存'));
    await tester.pump();

    expect(saved.value, isNotNull);
    expect(saved.value!.exerciseId, 'delay_checking');
    expect(saved.value!.triggerOrExposure, _plan().triggerOrExposure);
    expect(saved.value!.outcome, DelayOutcome.delayed);
    expect(find.text('練習を記録しました'), findsOneWidget);
    expect(find.text('今はここまで'), findsOneWidget);
    expect(find.textContaining('Patterns Pro'), findsNothing);
  });

  testWidgets('failed ERP save never presents completion', (tester) async {
    _usePhoneViewport(tester);
    final saved = _SavedSession();
    await tester.pumpWidget(
      _host(locale: const Locale('de'), output: saved, saveSucceeds: false),
    );
    await tester.pump();

    await _reachReflection(
      tester,
      start: 'Übung starten',
      stopEarly: 'Früher aufhören',
      stop: 'Aufhören',
    );
    await tester.tap(find.text('Reaktion aufgeschoben'));
    await tester.scrollUntilVisible(
      find.text('Übung speichern'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Übung speichern'));
    await tester.pump();

    expect(saved.value, isNull);
    expect(
      find.text(
        'Deine ERP-Übung konnte nicht gespeichert werden. Bitte versuche es erneut.',
      ),
      findsOneWidget,
    );
    expect(find.text('Jetzt fertig'), findsNothing);
  });

  testWidgets('ERP setup supports 200 percent text and localized semantics', (
    tester,
  ) async {
    _usePhoneViewport(tester);
    final saved = _SavedSession();
    await tester.pumpWidget(
      _host(
        locale: const Locale('fr'),
        output: saved,
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text(
        'Quelle est l’intensité de l’envie ou de l’anxiété maintenant ?',
      ),
      140,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.value == 'Intensité 5 sur 10',
      ),
      findsOneWidget,
    );
  });
}
