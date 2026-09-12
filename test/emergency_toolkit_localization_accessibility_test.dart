import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/emergency_toolkit_screen.dart';
import 'package:patterns/theme/app_theme.dart';

Widget _host({
  required Locale locale,
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
  Widget home = const EmergencyToolkitScreen(),
}) => MaterialApp(
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

void main() {
  testWidgets('immediate-support copy is factual and localized in Japanese', (
    tester,
  ) async {
    await tester.pumpWidget(_host(locale: const Locale('ja')));
    await tester.pumpAndSettle();

    expect(find.text('今この時のサポート'), findsOneWidget);
    expect(find.textContaining('緊急支援や医療ではありません'), findsOneWidget);
    expect(find.bySemanticsLabel('呼吸する'), findsOneWidget);
    expect(find.textContaining("You're safe"), findsNothing);
    expect(find.textContaining('Urges always pass'), findsNothing);
  });

  testWidgets('breathing view reflows at 200 percent with motion disabled', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
        home: const BreathingScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Einatmen'), findsOneWidget);
    expect(
      tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .any((widget) => widget.duration == Duration.zero),
      isTrue,
    );
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
