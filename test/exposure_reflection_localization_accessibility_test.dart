import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/exposure_reflection_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Reflections extends ExposureReflectionNotifier {
  _Reflections(this.items, {this.addResult = true, this.deleteResult = true});

  final List<ExposureReflection> items;
  final bool addResult;
  final bool deleteResult;
  ExposureReflection? addedReflection;
  bool deleteCalled = false;

  @override
  Future<List<ExposureReflection>> build() async => items;

  @override
  Future<bool> add(ExposureReflection reflection) async {
    addedReflection = reflection;
    if (addResult) state = AsyncData([reflection, ...items]);
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
  required _Reflections Function() reflections,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [exposureReflectionProvider.overrideWith(reflections)],
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

ExposureReflection _reflection() {
  return ExposureReflection(
    id: 11,
    datetime: DateTime(2026, 9, 12),
    whatHappened: '自分で書いた出来事',
    ocdPredicted: '自分で書いた予測',
    actuallyHappened: '自分で書いた観察',
    whatILearned: '自分で書いたメモ',
    doDifferently: '自分で書いた次の案',
    createdAt: DateTime(2026, 9, 12),
  );
}

void main() {
  testWidgets('empty Exposure Reflections follow the Japanese locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const ExposureReflectionScreen(),
        reflections: () => _Reflections(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('曝露の振り返り'), findsOneWidget);
    expect(find.text('曝露を振り返る'), findsOneWidget);
    expect(find.text('新しい振り返り'), findsOneWidget);
    expect(find.text('Exposure Reflections'), findsNothing);
  });

  testWidgets(
    'reflection cards preserve user text and expose a factual label',
    (tester) async {
      await tester.pumpWidget(
        _host(
          home: const ExposureReflectionScreen(),
          reflections: () => _Reflections([_reflection()]),
          locale: const Locale('ja'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('自分で書いた出来事'), findsOneWidget);
      expect(find.text('自分で書いたメモ'), findsOneWidget);
      expect(find.byTooltip('振り返りを削除'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('9月12日.*自分で書いた出来事')), findsOneWidget);
    },
  );

  testWidgets('required-field validation is specific and localized', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const ExposureReflectionEditScreen(),
        reflections: () => _Reflections(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    tester
        .widget<ElevatedButton>(
          find.byType(ElevatedButton, skipOffstage: false).last,
        )
        .onPressed!();
    await tester.pumpAndSettle();

    expect(find.text('まず、何が起きたかを短く入力してください。その他の質問は任意です。'), findsOneWidget);
  });

  testWidgets('saving preserves every user-authored reflection field', (
    tester,
  ) async {
    late _Reflections notifier;
    await tester.pumpWidget(
      _host(
        home: const ExposureReflectionEditScreen(),
        reflections: () => notifier = _Reflections(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    const values = ['出来事', '予測', '観察', 'メモ', '次の案'];
    final fields = find.byType(TextField);
    for (var index = 0; index < values.length; index++) {
      await tester.enterText(fields.at(index), values[index]);
    }
    tester
        .widget<ElevatedButton>(
          find.byType(ElevatedButton, skipOffstage: false).last,
        )
        .onPressed!();
    await tester.pumpAndSettle();

    final saved = notifier.addedReflection;
    expect(saved, isNotNull);
    expect(saved!.whatHappened, '出来事');
    expect(saved.ocdPredicted, '予測');
    expect(saved.actuallyHappened, '観察');
    expect(saved.whatILearned, 'メモ');
    expect(saved.doDifferently, '次の案');
  });

  testWidgets('failed save retains every user-authored field', (tester) async {
    late _Reflections notifier;
    await tester.pumpWidget(
      _host(
        home: const ExposureReflectionEditScreen(),
        reflections: () => notifier = _Reflections(const [], addResult: false),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    const values = ['Ereignis', 'Vorhersage', 'Beobachtung', 'Notiz', 'Idee'];
    final fields = find.byType(TextField);
    for (var index = 0; index < values.length; index++) {
      await tester.enterText(fields.at(index), values[index]);
    }
    tester
        .widget<ElevatedButton>(
          find.byType(ElevatedButton, skipOffstage: false).last,
        )
        .onPressed!();
    await tester.pumpAndSettle();

    expect(notifier.addedReflection, isNotNull);
    expect(find.byType(ExposureReflectionEditScreen), findsOneWidget);
    for (final value in values) {
      expect(find.text(value), findsOneWidget);
    }
    expect(
      find.text(
        'Diese Reflexion konnte nicht gespeichert werden. Ihr Text ist noch vorhanden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('failed deletion keeps the reflection and reports the error', (
    tester,
  ) async {
    late _Reflections notifier;
    await tester.pumpWidget(
      _host(
        home: const ExposureReflectionScreen(),
        reflections: () =>
            notifier = _Reflections([_reflection()], deleteResult: false),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('振り返りを削除'));
    await tester.pumpAndSettle();
    expect(find.text('この振り返りを削除しますか？'), findsOneWidget);
    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(notifier.deleteCalled, isTrue);
    expect(find.text('自分で書いた出来事'), findsOneWidget);
    expect(find.text('この振り返りを削除できませんでした。もう一度お試しください。'), findsOneWidget);
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
        home: const ExposureReflectionEditScreen(),
        reflections: () => _Reflections(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Neue Reflexion'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.widgetWithText(ElevatedButton, 'Reflexion speichern'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(ElevatedButton, 'Reflexion speichern'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
