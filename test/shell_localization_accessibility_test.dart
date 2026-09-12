import 'dart:ui' show SemanticsFlag;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/l10n/app_language.dart';
import 'package:patterns/mobile/first_run.dart';
import 'package:patterns/mobile/preferences.dart';
import 'package:patterns/mobile/screens/first_run_result_screen.dart';
import 'package:patterns/mobile/widgets/spotlight_tour.dart';
import 'package:patterns/theme/app_theme.dart';
import 'package:patterns/widgets/section_intro.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await initMobilePreferences();
  });

  test('every section intro resolves in every supported language', () {
    for (final locale in supportedAppLocales) {
      final strings = lookupAppLocalizations(locale);
      for (final id in sectionIntroIds) {
        final intro = localizedSectionIntro(strings, id);
        expect(intro, isNotNull, reason: '$id in $locale');
        expect(intro!.title.trim(), isNotEmpty, reason: '$id title in $locale');
        expect(
          intro.points.every((point) => point.trim().isNotEmpty),
          isTrue,
          reason: '$id body in $locale',
        );
      }
    }
  });

  testWidgets('first-run result is factual and localized in Japanese', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        locale: const Locale('ja'),
        child: FirstRunResultScreen(
          kind: FirstRunPath.selfcheck,
          result: const FirstRunActivityResult(),
          onDone: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('保存しました'), findsOneWidget);
    expect(
      find.text('セルフチェックはこの端末に保存されました。結果は現時点の記録であり、診断ではありません。'),
      findsOneWidget,
    );
    expect(find.text('やさしいリマインダーを設定'), findsOneWidget);
    expect(find.text('自分のスペースへ'), findsOneWidget);
    expect(find.textContaining('proved'), findsNothing);
  });

  testWidgets('German first-run result reflows at 200 percent text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        child: FirstRunResultScreen(
          kind: FirstRunPath.erp,
          result: const FirstRunActivityResult(),
          onDone: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Übung erfasst'), findsOneWidget);
    expect(find.text('Sanfte Erinnerung einstellen'), findsOneWidget);
  });

  testWidgets('spotlight tour localizes controls and blocks background copy', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      _host(locale: const Locale('ja'), child: const _TourHarness()),
    );
    await tester.tap(find.text('show'));
    await tester.pumpAndSettle();

    expect(find.text('2ステップ中1ステップ目'), findsOneWidget);
    expect(find.text('スキップ'), findsOneWidget);
    expect(find.text('次へ'), findsOneWidget);
    final tourScope = tester.getSemantics(
      find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.scopesRoute == true &&
            widget.properties.label == 'first',
      ),
    );
    expect(tourScope.hasFlag(SemanticsFlag.scopesRoute), isTrue);
    expect(tourScope.hasFlag(SemanticsFlag.namesRoute), isTrue);
    expect(tester.getSize(find.text('スキップ')).height, greaterThan(0));
    expect(
      tester.getSize(find.widgetWithText(TextButton, 'スキップ')).height,
      greaterThanOrEqualTo(44),
    );
    semantics.dispose();
  });
}

Widget _host({
  required Locale locale,
  required Widget child,
  TextScaler textScaler = TextScaler.noScaling,
}) {
  return ProviderScope(
    child: MaterialApp(
      locale: locale,
      theme: AppTheme.mobileDarkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: supportedAppLocales,
      builder: (context, appChild) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: appChild!,
      ),
      home: child,
    ),
  );
}

class _TourHarness extends StatelessWidget {
  const _TourHarness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Semantics(
        label: 'private content',
        child: Center(
          child: ElevatedButton(
            onPressed: () => showSpotlightTour(
              context,
              steps: const [
                TourStep(title: 'first'),
                TourStep(title: 'second'),
              ],
              onFinish: () {},
            ),
            child: const Text('show'),
          ),
        ),
      ),
    );
  }
}
