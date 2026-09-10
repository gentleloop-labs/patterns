import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('mobile Settings uses the active locale for its main sections', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'legacy_install_marker': true});
    await initAppPreferences();

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('ja'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: SettingsScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('データ'), findsOneWidget);
    expect(find.text('データを書き出す'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('プライバシー'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('プライバシー'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('匿名の利用状況を共有'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('匿名の利用状況を共有'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('ヘルプ'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('ヘルプ'), findsOneWidget);
  });
}
