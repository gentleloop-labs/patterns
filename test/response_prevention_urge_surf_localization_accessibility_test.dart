import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/response_prevention_screen.dart';
import 'package:patterns/mobile/screens/urge_surf_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Responses extends ResponsePreventionNotifier {
  _Responses(this.items, {this.saveResult = true, this.deleteResult = true});

  final List<ResponsePreventionLog> items;
  final bool saveResult;
  final bool deleteResult;
  bool saveCalled = false;
  bool deleteCalled = false;

  @override
  Future<List<ResponsePreventionLog>> build() async => items;

  @override
  Future<bool> addLog(ResponsePreventionLog log) async {
    saveCalled = true;
    if (saveResult) state = AsyncData([log, ...items]);
    return saveResult;
  }

  @override
  Future<bool> deleteLog(int id) async {
    deleteCalled = true;
    if (deleteResult) {
      state = AsyncData(items.where((item) => item.id != id).toList());
    }
    return deleteResult;
  }
}

class _Surfs extends UrgeSurfNotifier {
  _Surfs(this.items, {this.saveResult = true});

  final List<UrgeSurfSession> items;
  final bool saveResult;
  bool saveCalled = false;

  @override
  Future<List<UrgeSurfSession>> build() async => items;

  @override
  Future<bool> addSession(UrgeSurfSession session) async {
    saveCalled = true;
    if (saveResult) state = AsyncData([session, ...items]);
    return saveResult;
  }
}

Widget _host({
  required Widget home,
  required _Responses Function() responses,
  required _Surfs Function() surfs,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [
      responsePreventionProvider.overrideWith(responses),
      urgeSurfProvider.overrideWith(surfs),
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
      home: home,
    ),
  );
}

void main() {
  testWidgets('response prevention keeps user text and localizes its summary', (
    tester,
  ) async {
    final log = ResponsePreventionLog(
      id: 7,
      datetime: DateTime(2026, 9, 12),
      situation: '自分で書いたきっかけ',
      outcome: ResponseOutcome.delayed,
      anxietyLevel: 6,
      note: '自分のメモ',
      createdAt: DateTime(2026, 9, 12),
    );

    await tester.pumpWidget(
      _host(
        home: const ResponsePreventionScreen(),
        responses: () => _Responses([log]),
        surfs: () => _Surfs(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('反応妨害'), findsOneWidget);
    expect(find.text('遅らせた'), findsOneWidget);
    expect(find.text('苦痛度6/10'), findsOneWidget);
    expect(find.text('自分で書いたきっかけ'), findsOneWidget);
    expect(find.text('自分のメモ'), findsOneWidget);
    expect(find.text('Response Prevention'), findsNothing);

    final semantics = tester.getSemantics(
      find.bySemanticsLabel(RegExp('遅らせた.*自分で書いたきっかけ')),
    );
    expect(semantics.getSemanticsData().label, contains('苦痛度6/10'));
  });

  testWidgets('response save failure keeps the editor and explains the error', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    late _Responses notifier;
    await tester.pumpWidget(
      _host(
        home: const ResponsePreventionLogScreen(),
        responses: () => notifier = _Responses(const [], saveResult: false),
        surfs: () => _Surfs(const []),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Türgriff');
    final save = find.text('Protokoll speichern');
    await tester.scrollUntilVisible(
      save,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    tester
        .widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Protokoll speichern'),
        )
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.saveCalled, isTrue);
    expect(find.byType(ResponsePreventionLogScreen), findsOneWidget);
    expect(
      find.text(
        'Dieses Reaktionsprotokoll konnte nicht gespeichert werden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
    expect(find.text('Türgriff'), findsOneWidget);
  });

  testWidgets('response choices reflow at 200 percent with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: const ResponsePreventionLogScreen(),
        responses: () => _Responses(const []),
        surfs: () => _Surfs(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Nicht ausgeführt'), findsOneWidget);
    expect(find.text('Teilweise ausgeführt'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed response deletion keeps the saved log', (tester) async {
    final log = ResponsePreventionLog(
      id: 9,
      datetime: DateTime(2026, 9, 12),
      situation: '保存したきっかけ',
      outcome: ResponseOutcome.resisted,
      anxietyLevel: 4,
      createdAt: DateTime(2026, 9, 12),
    );
    late _Responses notifier;

    await tester.pumpWidget(
      _host(
        home: const ResponsePreventionScreen(),
        responses: () => notifier = _Responses([log], deleteResult: false),
        surfs: () => _Surfs(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('反応の記録を削除'));
    await tester.pumpAndSettle();
    expect(find.text('この反応の記録を削除しますか？'), findsOneWidget);
    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(notifier.deleteCalled, isTrue);
    expect(find.text('保存したきっかけ'), findsOneWidget);
    expect(find.text('反応の記録を削除できませんでした。もう一度お試しください。'), findsOneWidget);
  });

  testWidgets('urge history is factual, localized, and preserves user text', (
    tester,
  ) async {
    final session = UrgeSurfSession(
      id: 4,
      datetime: DateTime(2026, 9, 12),
      trigger: '自分で書いた衝動',
      initialUrge: 7,
      peakUrge: 8,
      finalUrge: 5,
      durationSeconds: 92,
      note: '保存したメモ',
      createdAt: DateTime(2026, 9, 12),
    );

    await tester.pumpWidget(
      _host(
        home: const UrgeSurfScreen(),
        responses: () => _Responses(const []),
        surfs: () => _Surfs([session]),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('衝動の波に乗る'), findsOneWidget);
    expect(find.text('自分で書いた衝動'), findsOneWidget);
    expect(find.textContaining('開始時7/10'), findsOneWidget);
    expect(find.text('Urge Surfing'), findsNothing);
    expect(find.bySemanticsLabel(RegExp('自分で書いた衝動.*開始時7/10')), findsOneWidget);
  });

  testWidgets('urge flow reflows and removes decorative timer motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: const UrgeSurfFlow(record: false),
        responses: () => _Responses(const []),
        surfs: () => _Surfs(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Vor dem Surf'), findsOneWidget);
    final begin = find.text('Beginnen');
    await tester.scrollUntilVisible(
      begin,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(begin);
    await tester.pump();

    expect(find.text('Den Drang beobachten'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(
      find.bySemanticsLabel(RegExp(r'Noch 3 Min\..*0 Sek\.')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);

    final done = find.text('Für jetzt fertig');
    await tester.scrollUntilVisible(
      done,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(done);
    await tester.pumpAndSettle();
    expect(find.text('Festhalten, was Sie bemerkt haben'), findsOneWidget);
  });

  testWidgets('urge save failure retains optional reflection', (tester) async {
    late _Surfs notifier;
    await tester.pumpWidget(
      _host(
        home: const UrgeSurfFlow(),
        responses: () => _Responses(const []),
        surfs: () => notifier = _Surfs(const [], saveResult: false),
        locale: const Locale('ja'),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('開始'));
    await tester.pump();
    await tester.tap(find.text('今はここまで'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '自分の振り返り');
    await tester.tap(find.text('記録を保存'));
    await tester.pumpAndSettle();

    expect(notifier.saveCalled, isTrue);
    expect(find.text('気づいたことを記録'), findsOneWidget);
    expect(find.text('自分の振り返り'), findsOneWidget);
    expect(find.text('記録を保存できませんでした。もう一度お試しください。'), findsOneWidget);
  });
}
