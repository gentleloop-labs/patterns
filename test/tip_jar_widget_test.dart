import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/widgets/tip_jar_sheet.dart';

void main() {
  Widget appFor(Locale locale, {double textScale = 1}) => MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: const Scaffold(body: TipJarSheet()),
    ),
  );

  testWidgets('tip jar follows the active locale', (tester) async {
    await tester.binding.setSurfaceSize(const Size(600, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(appFor(const Locale('ja')));
    await tester.pump();

    expect(find.text('Patternsを支援'), findsOneWidget);
    expect(find.textContaining('チップは任意'), findsOneWidget);
  });

  testWidgets('tip jar reflows at 200% text size', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(appFor(const Locale('de'), textScale: 2));
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('Patterns unterstützen'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
