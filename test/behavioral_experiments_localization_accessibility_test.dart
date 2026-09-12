import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/behavioral_experiments_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Experiments extends BehavioralExperimentNotifier {
  _Experiments(
    this.items, {
    this.addResult = true,
    this.editResult = true,
    this.deleteResult = true,
  });

  final List<BehavioralExperiment> items;
  final bool addResult;
  final bool editResult;
  final bool deleteResult;
  bool addCalled = false;
  bool editCalled = false;
  bool deleteCalled = false;

  @override
  Future<List<BehavioralExperiment>> build() async => items;

  @override
  Future<bool> add(BehavioralExperiment experiment) async {
    addCalled = true;
    if (addResult) state = AsyncData([experiment, ...items]);
    return addResult;
  }

  @override
  Future<bool> edit(BehavioralExperiment experiment) async {
    editCalled = true;
    if (editResult) {
      state = AsyncData([
        experiment,
        ...items.where((item) => item.id != experiment.id),
      ]);
    }
    return editResult;
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

Widget _host({
  required Widget home,
  required _Experiments Function() experiments,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [behavioralExperimentProvider.overrideWith(experiments)],
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
      home: home,
    ),
  );
}

BehavioralExperiment _experiment({
  ExperimentStatus status = ExperimentStatus.planned,
}) {
  return BehavioralExperiment(
    id: 7,
    datetime: DateTime(2026, 9, 12),
    fearPrediction: '自分で書いた予測',
    confidence: 70,
    experiment: '自分で決めた行動',
    outcome: status == ExperimentStatus.completed ? '自分の観察' : '',
    learning: status == ExperimentStatus.completed ? '自分のメモ' : '',
    status: status,
    createdAt: DateTime(2026, 9, 12),
  );
}

void main() {
  testWidgets('empty behavioral experiments follow the Japanese locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const BehavioralExperimentsScreen(),
        experiments: () => _Experiments(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('行動実験'), findsOneWidget);
    expect(find.text('行動実験を計画する'), findsOneWidget);
    expect(find.text('新しい行動実験'), findsOneWidget);
    expect(find.text('Behavioral Experiments'), findsNothing);
  });

  testWidgets('experiment cards preserve user text and expose factual state', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const BehavioralExperimentsScreen(),
        experiments: () =>
            _Experiments([_experiment(status: ExperimentStatus.completed)]),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('完了'), findsOneWidget);
    expect(find.textContaining('確信度70'), findsOneWidget);
    expect(find.text('自分で書いた予測'), findsOneWidget);
    expect(find.text('自分で決めた行動'), findsOneWidget);
    expect(find.text('自分の観察'), findsOneWidget);
    expect(find.text('自分のメモ'), findsNWidgets(2));
    expect(
      find.bySemanticsLabel(RegExp('完了.*自分で書いた予測.*自分で決めた行動')),
      findsOneWidget,
    );
  });

  testWidgets('plan validation is warm and localized', (tester) async {
    await tester.pumpWidget(
      _host(
        home: const BehavioralExperimentEditScreen(),
        experiments: () => _Experiments(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    final save = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, '行動実験を保存'),
    );
    save.onPressed!();
    await tester.pumpAndSettle();

    expect(find.text('OCDの予測と、予定している行動の両方を入力してください。'), findsOneWidget);
  });

  testWidgets('failed plan save retains both user-authored fields', (
    tester,
  ) async {
    late _Experiments notifier;
    await tester.pumpWidget(
      _host(
        home: const BehavioralExperimentEditScreen(),
        experiments: () => notifier = _Experiments(const [], addResult: false),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Meine Vorhersage');
    await tester.enterText(find.byType(TextField).last, 'Meine Handlung');
    tester
        .widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Experiment speichern'),
        )
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.addCalled, isTrue);
    expect(find.byType(BehavioralExperimentEditScreen), findsOneWidget);
    expect(find.text('Meine Vorhersage'), findsOneWidget);
    expect(find.text('Meine Handlung'), findsOneWidget);
    expect(
      find.text(
        'Dieses Experiment konnte nicht gespeichert werden. Ihr Text ist noch vorhanden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('failed observation save retains optional reflection', (
    tester,
  ) async {
    late _Experiments notifier;
    await tester.pumpWidget(
      _host(
        home: BehavioralExperimentEditScreen(existing: _experiment()),
        experiments: () =>
            notifier = _Experiments([_experiment()], editResult: false),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '自分の観察');
    await tester.enterText(find.byType(TextField).last, '自分の振り返り');
    tester
        .widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '観察を保存'))
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.editCalled, isTrue);
    expect(find.byType(BehavioralExperimentEditScreen), findsOneWidget);
    expect(find.text('自分の観察'), findsOneWidget);
    expect(find.text('自分の振り返り'), findsOneWidget);
    expect(
      find.text('この行動実験を保存できませんでした。入力した内容は残っています。もう一度お試しください。'),
      findsOneWidget,
    );
  });

  testWidgets('failed deletion keeps the experiment and reports the error', (
    tester,
  ) async {
    late _Experiments notifier;
    await tester.pumpWidget(
      _host(
        home: const BehavioralExperimentsScreen(),
        experiments: () =>
            notifier = _Experiments([_experiment()], deleteResult: false),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('行動実験を削除'));
    await tester.pumpAndSettle();
    expect(find.text('この行動実験を削除しますか？'), findsOneWidget);
    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(notifier.deleteCalled, isTrue);
    expect(find.text('自分で書いた予測'), findsOneWidget);
    expect(find.text('この行動実験を削除できませんでした。もう一度お試しください。'), findsOneWidget);
  });

  testWidgets('editor reflows at 200 percent and exposes slider value', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: const BehavioralExperimentEditScreen(),
        experiments: () => _Experiments(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Neue Experiment'), findsNothing);
    expect(find.text('Neues Experiment'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byType(Slider),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    final slider = tester.getSemantics(
      find
          .bySemanticsLabel(RegExp('Wie sicher fühlt sich die Vorhersage an'))
          .last,
    );
    expect(slider.getSemanticsData().value, contains('sicher'));
    expect(tester.takeException(), isNull);
  });
}
