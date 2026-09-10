import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/recovery_hub_screen.dart';
import 'package:patterns/theme/app_theme.dart';
import 'package:patterns/widgets/animations.dart';

class _Pro extends ProNotifier {
  _Pro(this.enabled);

  final bool enabled;

  @override
  bool build() => enabled;
}

Widget _host({
  required Locale locale,
  bool pro = false,
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [proProvider.overrideWith(() => _Pro(pro))],
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
      home: const RecoveryHubScreen(),
    ),
  );
}

void main() {
  testWidgets('Recovery Hub resolves stable tool IDs in Japanese', (
    tester,
  ) async {
    await tester.pumpWidget(_host(locale: const Locale('ja'), pro: true));
    await tester.pumpAndSettle();

    expect(find.text('回復'), findsOneWidget);
    expect(find.text('つらい時のサポート'), findsOneWidget);
    expect(find.bySemanticsLabel('つらい時のツールキット'), findsOneWidget);
    expect(find.bySemanticsLabel('対処法ライブラリ'), findsOneWidget);
    expect(find.bySemanticsLabel('強迫行為を待つ'), findsWidgets);
    expect(find.text('Recovery'), findsNothing);
  });

  testWidgets('locked tools expose a visible and semantic Pro state', (
    tester,
  ) async {
    await tester.pumpWidget(_host(locale: const Locale('de')));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Recovery-Aktivität'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Patterns Pro'), findsWidgets);
    final semantics = tester.getSemantics(
      find.bySemanticsLabel('Recovery-Aktivität'),
    );
    expect(semantics.hint, contains('erfordert Patterns Pro'));
    expect(semantics.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
  });

  testWidgets('quick tools reflow at 200 percent text with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        locale: const Locale('fr'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pump();

    expect(find.text('Rétablissement'), findsOneWidget);
    expect(find.byType(AnimatedScale), findsNothing);
    expect(tester.takeException(), isNull);

    final quickTool = find.bySemanticsLabel('Kit pour les moments difficiles');
    expect(quickTool, findsOneWidget);
    expect(tester.getSize(quickTool).height, greaterThanOrEqualTo(72));
  });
}
