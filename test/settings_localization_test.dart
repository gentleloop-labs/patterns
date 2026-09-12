import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/biometric_auth.dart';
import 'package:patterns/mobile/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'legacy_install_marker': true});
    await initAppPreferences();
  });

  testWidgets('mobile Settings uses the active locale for its main sections', (
    tester,
  ) async {
    await _pumpSettings(tester, locale: const Locale('ja'));
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

  testWidgets('backup actions and warnings are localized and accessible', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await _pumpSettings(tester, locale: const Locale('ja'));

    final export = find.bySemanticsLabel('データを書き出す');
    expect(export, findsOneWidget);
    final exportData = tester.getSemantics(export).getSemanticsData();
    expect(exportData.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(exportData.hasAction(SemanticsAction.tap), isTrue);

    await tester.tap(find.text('データを書き出す'));
    await tester.pumpAndSettle();

    expect(find.text('データを書き出しますか？'), findsOneWidget);
    expect(find.text('ZIPバックアップを書き出す'), findsOneWidget);
    expect(find.textContaining('暗号化されていないZIP'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('destructive copy reflows at 200 percent German text', (
    tester,
  ) async {
    await _pumpSettings(tester, locale: const Locale('de'), textScale: 2);

    await tester.scrollUntilVisible(
      find.text('Alle Daten löschen'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Alle Daten löschen'));
    await tester.pumpAndSettle();

    expect(find.text('Alle lokalen Daten löschen?'), findsOneWidget);
    expect(find.text('Daten löschen'), findsOneWidget);
    expect(find.text('Abbrechen'), findsOneWidget);
    expect(find.textContaining('App-Store-Konto'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cancelled biometric authentication leaves app lock disabled', (
    tester,
  ) async {
    final auth = _RejectingAuthenticator();
    await _pumpSettings(
      tester,
      locale: const Locale('ja'),
      authenticator: auth,
    );

    await tester.scrollUntilVisible(
      find.text('アプリロック'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(_switchBeside(tester, 'アプリロック'));
    await tester.pumpAndSettle();

    expect(auth.calls, 1);
    expect(auth.reason, 'アプリロックを有効にするためにPatternsのロックを解除してください。');
    expect(
      ProviderScope.containerOf(
        tester.element(find.byType(SettingsScreen)),
      ).read(appLockEnabledProvider),
      isFalse,
    );
  });

  test('backup preview counts use locale-aware plural forms', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final japanese = await AppLocalizations.delegate.load(const Locale('ja'));

    expect(english.settingsBackupJournalCount(0), 'No journal entries');
    expect(english.settingsBackupJournalCount(1), '1 journal entry');
    expect(english.settingsBackupJournalCount(2), '2 journal entries');
    expect(japanese.settingsBackupRecoveryCount(12), 'その他の回復ツールの記録：12件');
  });
}

Future<void> _pumpSettings(
  WidgetTester tester, {
  required Locale locale,
  double textScale = 1,
  BiometricAuthenticator? authenticator,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        if (authenticator != null)
          biometricAuthenticatorProvider.overrideWithValue(authenticator),
      ],
      child: MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: MediaQuery(
          data: MediaQueryData(
            disableAnimations: true,
            textScaler: TextScaler.linear(textScale),
          ),
          child: const SettingsScreen(),
        ),
      ),
    ),
  );
}

Finder _switchBeside(WidgetTester tester, String label) {
  final targetY = tester.getCenter(find.text(label)).dy;
  for (final element in find.byType(Switch).evaluate()) {
    final candidate = find.byWidget(element.widget);
    if ((tester.getCenter(candidate).dy - targetY).abs() < 60) return candidate;
  }
  throw TestFailure('No switch found beside $label');
}

class _RejectingAuthenticator extends BiometricAuthenticator {
  int calls = 0;
  String? reason;

  @override
  Future<bool> isDeviceSupported() async => true;

  @override
  Future<bool> authenticate({required String reason}) async {
    calls += 1;
    this.reason = reason;
    return false;
  }
}
