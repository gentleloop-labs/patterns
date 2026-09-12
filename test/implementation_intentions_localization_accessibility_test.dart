import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/implementation_intentions_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Intentions extends ImplementationIntentionNotifier {
  _Intentions(this.items, {this.addResult = true, this.deleteResult = true});

  final List<ImplementationIntention> items;
  final bool addResult;
  final bool deleteResult;
  ImplementationIntention? addedIntention;
  bool deleteCalled = false;

  @override
  Future<List<ImplementationIntention>> build() async => items;

  @override
  Future<bool> add(ImplementationIntention intention) async {
    addedIntention = intention;
    if (addResult) state = AsyncData([intention, ...items]);
    return addResult;
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
  required _Intentions Function() intentions,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [implementationIntentionProvider.overrideWith(intentions)],
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

ImplementationIntention _intention() {
  return ImplementationIntention(
    id: 13,
    trigger: '自分で書いた状況',
    response: '自分で書いた対応',
    createdAt: DateTime(2026, 9, 12),
  );
}

void main() {
  testWidgets('empty if-then plans follow the Japanese locale', (tester) async {
    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionsScreen(),
        intentions: () => _Intentions(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('もし〜ならプラン'), findsOneWidget);
    expect(find.text('もし〜ならプランを作る'), findsOneWidget);
    expect(find.text('新しいもし〜ならプラン'), findsOneWidget);
    expect(find.text('If–Then Plans'), findsNothing);
  });

  testWidgets('cards preserve user text and expose a factual statement', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionsScreen(),
        intentions: () => _Intentions([_intention()]),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    const statement = 'もし自分で書いた状況なら、自分で書いた対応。';
    expect(find.text(statement), findsOneWidget);
    expect(find.bySemanticsLabel(statement), findsOneWidget);
    final delete = find.byTooltip('もし〜ならプランを削除');
    expect(delete, findsOneWidget);
    final size = tester.getSize(delete);
    expect(size.width, greaterThanOrEqualTo(44));
    expect(size.height, greaterThanOrEqualTo(44));
  });

  testWidgets('required-field validation is specific and localized', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionEditScreen(),
        intentions: () => _Intentions(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    tester
        .widget<ElevatedButton>(find.byType(ElevatedButton).last)
        .onPressed!();
    await tester.pumpAndSettle();

    expect(find.text('状況と、試したい対応の両方を入力してください。'), findsOneWidget);
  });

  testWidgets('saving preserves both user-authored fields', (tester) async {
    late _Intentions notifier;
    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionEditScreen(),
        intentions: () => notifier = _Intentions(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '自分の状況');
    await tester.enterText(find.byType(TextField).last, '自分の対応');
    tester
        .widget<ElevatedButton>(find.byType(ElevatedButton).last)
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.addedIntention, isNotNull);
    expect(notifier.addedIntention!.trigger, '自分の状況');
    expect(notifier.addedIntention!.response, '自分の対応');
  });

  testWidgets('failed save retains both user-authored fields', (tester) async {
    late _Intentions notifier;
    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionEditScreen(),
        intentions: () => notifier = _Intentions(const [], addResult: false),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Meine Situation');
    await tester.enterText(find.byType(TextField).last, 'Meine Reaktion');
    tester
        .widget<ElevatedButton>(find.byType(ElevatedButton).last)
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.addedIntention, isNotNull);
    expect(find.byType(ImplementationIntentionEditScreen), findsOneWidget);
    expect(find.text('Meine Situation'), findsOneWidget);
    expect(find.text('Meine Reaktion'), findsOneWidget);
    expect(
      find.text(
        'Dieser Wenn-dann-Plan konnte nicht gespeichert werden. Ihr Text ist noch vorhanden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('failed deletion keeps the plan and reports the error', (
    tester,
  ) async {
    late _Intentions notifier;
    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionsScreen(),
        intentions: () =>
            notifier = _Intentions([_intention()], deleteResult: false),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('もし〜ならプランを削除'));
    await tester.pumpAndSettle();
    expect(find.text('このもし〜ならプランを削除しますか？'), findsOneWidget);
    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(notifier.deleteCalled, isTrue);
    expect(find.textContaining('自分で書いた状況'), findsOneWidget);
    expect(find.text('このもし〜ならプランを削除できませんでした。もう一度お試しください。'), findsOneWidget);
  });

  testWidgets('editor reflows at 200 percent with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: const ImplementationIntentionEditScreen(),
        intentions: () => _Intentions(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Neuer Wenn-dann-Plan'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.widgetWithText(ElevatedButton, 'Wenn-dann-Plan speichern'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(ElevatedButton, 'Wenn-dann-Plan speichern'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
