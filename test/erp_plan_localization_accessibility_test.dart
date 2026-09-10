import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/l10n/app_localizations_ja.dart';
import 'package:patterns/mobile/screens/erp_exercises_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Plans extends ErpExercisePlanNotifier {
  _Plans({this.saveSucceeds = true});

  final bool saveSucceeds;

  @override
  Future<List<ErpExercisePlan>> build() async => const [];

  @override
  Future<bool> addPlan(ErpExercisePlan plan) async => saveSucceeds;
}

class _Sessions extends ErpExerciseSessionNotifier {
  @override
  Future<List<ErpExerciseSession>> build() async => const [];
}

Widget _host({
  required Locale locale,
  bool saveSucceeds = true,
  TextScaler textScaler = TextScaler.noScaling,
}) {
  return ProviderScope(
    overrides: [
      erpExercisePlanProvider.overrideWith(
        () => _Plans(saveSucceeds: saveSucceeds),
      ),
      erpExerciseSessionProvider.overrideWith(_Sessions.new),
    ],
    child: MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mobileDarkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: textScaler, disableAnimations: true),
        child: child!,
      ),
      home: const ErpExercisesScreen(showBack: true),
    ),
  );
}

void _usePhoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  test('ERP templates keep stable IDs while presentation is localized', () {
    final strings = AppLocalizationsJa();
    expect(erpExerciseTemplates.map((template) => template.id), [
      'delay_checking',
      'delay_reassurance',
      'delay_googling',
      'delay_rumination',
      'delay_washing',
    ]);

    final checking = erpExerciseTemplates.first;
    expect(checking.canonicalTitle, 'Delay Checking');
    expect(checking.localizedTitle(strings), '確認を遅らせる');
    expect(checking.localizedInstructions(strings), hasLength(4));
    expect(checking.localizedQuickCues(strings), hasLength(3));
  });

  testWidgets('ERP plan shell is localized and reflows at 200 percent', (
    tester,
  ) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(
      _host(locale: const Locale('ja'), textScaler: const TextScaler.linear(2)),
    );
    await tester.pumpAndSettle();

    expect(find.text('ガイド付きERP'), findsOneWidget);
    expect(find.text('計画を再利用して練習し、起きたことを記録します。'), findsOneWidget);
    expect(find.bySemanticsLabel('戻る'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed plan save stays in the localized editor', (tester) async {
    _usePhoneViewport(tester);
    await tester.pumpWidget(
      _host(locale: const Locale('de'), saveSucceeds: false),
    );
    await tester.pump();

    await tester.tap(find.text('Neu'));
    await tester.pumpAndSettle();
    expect(find.text('ERP-Plan erstellen'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Eine Situation');
    await tester.drag(find.byType(ListView).first, const Offset(0, -520));
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(2), 'Nicht nachfragen');
    await tester.drag(find.byType(ListView).first, const Offset(0, -700));
    await tester.pump();
    await tester.tap(find.text('Plan erstellen').hitTestable());
    await tester.pump();

    expect(find.text('ERP-Plan erstellen'), findsOneWidget);
    expect(
      find.text(
        'Dein ERP-Plan konnte nicht gespeichert werden. Bitte versuche es erneut.',
      ),
      findsOneWidget,
    );
  });
}
