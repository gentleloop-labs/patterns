import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/action_planner_screen.dart';
import 'package:patterns/mobile/screens/uncertainty_training_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Calm extends CalmInsightsNotifier {
  _Calm(this.enabled);
  final bool enabled;

  @override
  bool build() => enabled;
}

class _UncertaintyLogs extends UncertaintyLogNotifier {
  _UncertaintyLogs(this.items, {this.addResult = true});

  final List<UncertaintyLog> items;
  final bool addResult;
  UncertaintyLog? addedLog;

  @override
  Future<List<UncertaintyLog>> build() async => items;

  @override
  Future<bool> add(UncertaintyLog log) async {
    addedLog = log;
    if (addResult) state = AsyncData([log, ...items]);
    return addResult;
  }
}

class _ActionPlans extends ActionPlanNotifier {
  _ActionPlans(
    this.items, {
    this.addResult = true,
    this.toggleResult = true,
    this.deleteResult = true,
  });

  final List<ActionPlan> items;
  final bool addResult;
  final bool toggleResult;
  final bool deleteResult;
  ActionPlan? addedPlan;
  bool toggleCalled = false;
  bool deleteCalled = false;

  @override
  Future<List<ActionPlan>> build() async => items;

  @override
  Future<bool> add(ActionPlan plan) async {
    addedPlan = plan;
    if (addResult) state = AsyncData([plan, ...items]);
    return addResult;
  }

  @override
  Future<bool> setCompleted(ActionPlan plan, bool completed) async {
    toggleCalled = true;
    if (toggleResult) {
      state = AsyncData([
        plan.copyWith(completed: completed),
        ...items.where((item) => item.id != plan.id),
      ]);
    }
    return toggleResult;
  }

  @override
  Future<bool> delete(int id) async {
    deleteCalled = true;
    if (deleteResult) {
      state = AsyncData(items.where((item) => item.id != id).toList());
    }
    return deleteResult;
  }
}

Widget _uncertaintyHost({
  required Widget home,
  required _UncertaintyLogs Function() logs,
  bool calm = true,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [
      calmInsightsProvider.overrideWith(() => _Calm(calm)),
      uncertaintyLogProvider.overrideWith(logs),
    ],
    child: _materialHost(
      home: home,
      locale: locale,
      textScaler: textScaler,
      disableAnimations: disableAnimations,
    ),
  );
}

Widget _actionHost({
  required Widget home,
  required _ActionPlans Function() plans,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [actionPlanProvider.overrideWith(plans)],
    child: _materialHost(
      home: home,
      locale: locale,
      textScaler: textScaler,
      disableAnimations: disableAnimations,
    ),
  );
}

Widget _materialHost({
  required Widget home,
  required Locale locale,
  required TextScaler textScaler,
  required bool disableAnimations,
}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: AppTheme.mobileDarkTheme,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: textScaler, disableAnimations: disableAnimations),
      child: child!,
    ),
    home: home,
  );
}

UncertaintyLog _uncertaintyLog() {
  return UncertaintyLog(
    id: 3,
    datetime: DateTime(2026, 9, 12),
    exerciseId: 'maybe',
    willingness: 6,
    note: '自分で書いたメモ',
    createdAt: DateTime(2026, 9, 12),
  );
}

ActionPlan _actionPlan({bool completed = false}) {
  return ActionPlan(
    id: 9,
    situation: '自分で書いた状況',
    plannedAction: '自分で書いた対応',
    date: '2026-09-12',
    notes: '自分で書いたメモ',
    completed: completed,
    createdAt: DateTime(2026, 9, 12),
  );
}

void main() {
  testWidgets('uncertainty exercises use stable IDs and Japanese copy', (
    tester,
  ) async {
    await tester.pumpWidget(
      _uncertaintyHost(
        home: const UncertaintyTrainingScreen(),
        logs: () => _UncertaintyLogs([_uncertaintyLog(), _uncertaintyLog()]),
        calm: true,
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('不確かさの練習'), findsOneWidget);
    expect(find.text('そうかもしれないし、違うかもしれない'), findsOneWidget);
    expect(find.text('答えを出さない'), findsOneWidget);
    expect(find.text('確かさ探しをいったん止める'), findsOneWidget);
    expect(find.text('2回の練習'), findsNothing);
  });

  testWidgets('factual practice count appears only outside Calm Insights', (
    tester,
  ) async {
    await tester.pumpWidget(
      _uncertaintyHost(
        home: const UncertaintyTrainingScreen(),
        logs: () => _UncertaintyLogs([_uncertaintyLog(), _uncertaintyLog()]),
        calm: false,
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('2回の練習'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('そうかもしれないし.*記録した練習は2回')),
      findsOneWidget,
    );
  });

  testWidgets('uncertainty practice is localized and keeps its measurement', (
    tester,
  ) async {
    await tester.pumpWidget(
      _uncertaintyHost(
        home: const UncertaintyPracticeScreen(
          exercise: UncertaintyExercise(id: 'maybe'),
        ),
        logs: () => _UncertaintyLogs(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('この練習について'), findsOneWidget);
    expect(find.textContaining('安心材料を付け加えず'), findsOneWidget);
    expect(find.text('意思の度合い：10段階中5'), findsOneWidget);
    expect(
      tester
          .getSemantics(find.bySemanticsLabel(RegExp('分からないままにしておく意思')).last)
          .getSemanticsData()
          .value,
      '意思の度合い：10段階中5',
    );
  });

  testWidgets('failed uncertainty save retains the user note', (tester) async {
    late _UncertaintyLogs notifier;
    await tester.pumpWidget(
      _uncertaintyHost(
        home: const UncertaintyPracticeScreen(
          exercise: UncertaintyExercise(id: 'unanswered'),
        ),
        logs: () => notifier = _UncertaintyLogs(const [], addResult: false),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Meine eigene Notiz');
    tester
        .widget<ElevatedButton>(
          find.byType(ElevatedButton, skipOffstage: false).last,
        )
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.addedLog?.exerciseId, 'unanswered');
    expect(notifier.addedLog?.note, 'Meine eigene Notiz');
    expect(find.text('Meine eigene Notiz'), findsOneWidget);
    expect(
      find.text(
        'Diese Übung konnte nicht festgehalten werden. Ihre Notiz ist noch vorhanden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('uncertainty editor reflows at 200 percent with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _uncertaintyHost(
        home: const UncertaintyPracticeScreen(
          exercise: UncertaintyExercise(id: 'resist'),
        ),
        logs: () => _UncertaintyLogs(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Gewissheitssuche pausieren'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.widgetWithText(ElevatedButton, 'Übung festhalten'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('action-plan card preserves text, date, notes, and state', (
    tester,
  ) async {
    await tester.pumpWidget(
      _actionHost(
        home: const ActionPlannerScreen(),
        plans: () => _ActionPlans([_actionPlan()]),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('自分で書いた状況'), findsOneWidget);
    expect(find.text('自分で書いた対応'), findsOneWidget);
    expect(find.text('自分で書いたメモ'), findsOneWidget);
    expect(find.textContaining('2026'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('予定.*自分で書いた状況.*自分で書いた対応')),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel(RegExp('行動プランを完了として記録')), findsOneWidget);
    final delete = find.byTooltip('行動プランを削除');
    expect(tester.getSize(delete).width, greaterThanOrEqualTo(44));
  });

  testWidgets('failed state change keeps the previous action-plan state', (
    tester,
  ) async {
    late _ActionPlans notifier;
    await tester.pumpWidget(
      _actionHost(
        home: const ActionPlannerScreen(),
        plans: () =>
            notifier = _ActionPlans([_actionPlan()], toggleResult: false),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('行動プランを完了として記録'));
    await tester.pumpAndSettle();

    expect(notifier.toggleCalled, isTrue);
    expect(find.bySemanticsLabel(RegExp('行動プランを完了として記録')), findsOneWidget);
    expect(
      find.text('この行動プランを更新できませんでした。以前の状態を表示しています。もう一度お試しください。'),
      findsOneWidget,
    );
  });

  testWidgets('failed action-plan deletion keeps user-authored content', (
    tester,
  ) async {
    late _ActionPlans notifier;
    await tester.pumpWidget(
      _actionHost(
        home: const ActionPlannerScreen(),
        plans: () =>
            notifier = _ActionPlans([_actionPlan()], deleteResult: false),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('行動プランを削除'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(notifier.deleteCalled, isTrue);
    expect(find.text('自分で書いた状況'), findsOneWidget);
    expect(find.text('この行動プランを削除できませんでした。もう一度お試しください。'), findsOneWidget);
  });

  testWidgets('failed action-plan save retains every user field', (
    tester,
  ) async {
    late _ActionPlans notifier;
    await tester.pumpWidget(
      _actionHost(
        home: const ActionPlanEditScreen(),
        plans: () => notifier = _ActionPlans(const [], addResult: false),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    const values = ['Meine Situation', 'Meine Reaktion', 'Meine Notiz'];
    final fields = find.byType(TextField);
    for (var index = 0; index < values.length; index++) {
      await tester.enterText(fields.at(index), values[index]);
    }
    await tester.tap(find.bySemanticsLabel('Datum auswählen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    tester
        .widget<ElevatedButton>(
          find.byType(ElevatedButton, skipOffstage: false).last,
        )
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.addedPlan, isNotNull);
    expect(notifier.addedPlan!.situation, values[0]);
    expect(notifier.addedPlan!.plannedAction, values[1]);
    expect(notifier.addedPlan!.notes, values[2]);
    expect(notifier.addedPlan!.date, matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
    for (final value in values) {
      expect(find.text(value), findsOneWidget);
    }
    expect(
      find.text(
        'Dieser Handlungsplan konnte nicht gespeichert werden. Ihr Text ist noch vorhanden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('action-plan editor reflows at 200 percent with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _actionHost(
        home: const ActionPlanEditScreen(),
        plans: () => _ActionPlans(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Neuer Handlungsplan'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.widgetWithText(ElevatedButton, 'Handlungsplan speichern'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
