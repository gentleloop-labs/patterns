import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_language.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  tearDown(() {
    appPreferences = null;
  });

  test('new installations follow the system language', () async {
    SharedPreferences.setMockInitialValues({});

    await initAppPreferences();

    expect(
      appPreferences?.getString(languagePreferenceKey),
      AppLanguage.system.preferenceValue,
    );
    expect(appPreferences?.getBool(calmInsightsPreferenceKey), isTrue);
  });

  test('established installations remain in English', () async {
    SharedPreferences.setMockInitialValues({hasStartedKey: true});

    await initAppPreferences();

    expect(
      appPreferences?.getString(languagePreferenceKey),
      AppLanguage.english.preferenceValue,
    );
    expect(appPreferences?.getBool(calmInsightsPreferenceKey), isFalse);
    expect(
      appPreferences?.getString(analyticsConsentDecisionKey),
      AnalyticsConsentDecision.declined.name,
    );
  });

  test('new installs leave analytics undecided and disabled', () async {
    SharedPreferences.setMockInitialValues({});

    await initAppPreferences();

    expect(appPreferences?.getBool(usageAnalyticsEnabledKey), isNot(true));
    expect(
      appPreferences?.getString(analyticsConsentDecisionKey),
      AnalyticsConsentDecision.undecided.name,
    );
  });

  test('an established analytics opt-in is preserved', () async {
    SharedPreferences.setMockInitialValues({
      hasStartedKey: true,
      usageAnalyticsEnabledKey: true,
    });

    await initAppPreferences();

    expect(
      appPreferences?.getString(analyticsConsentDecisionKey),
      AnalyticsConsentDecision.granted.name,
    );
  });

  test('established Calm Insights choice is preserved', () async {
    SharedPreferences.setMockInitialValues({
      hasStartedKey: true,
      calmInsightsPreferenceKey: true,
    });

    await initAppPreferences();

    expect(appPreferences?.getBool(calmInsightsPreferenceKey), isTrue);
  });

  test('a corrupt Calm Insights preference is repaired safely', () async {
    SharedPreferences.setMockInitialValues({
      hasStartedKey: true,
      calmInsightsPreferenceKey: 'invalid',
    });

    await initAppPreferences();

    expect(appPreferences?.getBool(calmInsightsPreferenceKey), isFalse);
  });

  test('a valid language preference is preserved', () async {
    SharedPreferences.setMockInitialValues({
      languagePreferenceKey: AppLanguage.french.preferenceValue,
    });

    await initAppPreferences();

    expect(
      appPreferences?.getString(languagePreferenceKey),
      AppLanguage.french.preferenceValue,
    );
  });

  test('an invalid language preference is repaired to English', () async {
    SharedPreferences.setMockInitialValues({languagePreferenceKey: 'xx'});

    await initAppPreferences();

    expect(
      appPreferences?.getString(languagePreferenceKey),
      AppLanguage.english.preferenceValue,
    );
  });

  test('a corrupt language preference type is repaired to English', () async {
    SharedPreferences.setMockInitialValues({languagePreferenceKey: 42});

    await initAppPreferences();

    expect(
      appPreferences?.getString(languagePreferenceKey),
      AppLanguage.english.preferenceValue,
    );
  });

  group('system locale resolution', () {
    test('release gating forces English throughout locale resolution', () {
      expect(
        resolveSystemLocale(const [Locale('ja')], multilingualEnabled: false),
        const Locale('en'),
      );
      expect(
        resolveEffectiveLocale(AppLanguage.french, const [
          Locale('fr'),
        ], multilingualEnabled: false),
        const Locale('en'),
      );
      expect(
        localeOverrideForBuild(AppLanguage.system, multilingualEnabled: false),
        const Locale('en'),
      );
      expect(availableAppLanguagesFor(multilingualEnabled: false), const [
        AppLanguage.system,
        AppLanguage.english,
      ]);
      expect(enabledAppLocalesFor(multilingualEnabled: false), const [
        Locale('en'),
      ]);
    });

    test('uses Brazilian Portuguese only for Brazil', () {
      expect(
        resolveSystemLocale(const [Locale('pt', 'BR')]),
        const Locale('pt', 'BR'),
      );
      expect(
        resolveSystemLocale(const [Locale('pt', 'PT')]),
        const Locale('en'),
      );
      expect(resolveSystemLocale(const [Locale('pt')]), const Locale('en'));
    });

    test('maps regional Spanish to neutral Spanish', () {
      expect(
        resolveSystemLocale(const [Locale('es', 'MX')]),
        const Locale('es'),
      );
      expect(
        resolveSystemLocale(const [Locale('es', 'ES')]),
        const Locale('es'),
      );
    });

    test('uses the first supported platform language', () {
      expect(
        resolveSystemLocale(const [Locale('it'), Locale('ja', 'JP')]),
        const Locale('ja'),
      );
      expect(
        resolveSystemLocale(const [Locale('it'), Locale('nl')]),
        const Locale('en'),
      );
    });
  });

  testWidgets('changing the provider updates localized UI without restart', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      languagePreferenceKey: AppLanguage.english.preferenceValue,
    });
    await initAppPreferences();

    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (context, ref, child) {
            final language = ref.watch(languageProvider);
            return MaterialApp(
              locale: language.localeOverride,
              supportedLocales: supportedAppLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: Builder(
                builder: (context) => Scaffold(
                  body: Column(
                    children: [
                      Text(AppLocalizations.of(context).settingsTitle),
                      TextButton(
                        onPressed: () => ref
                            .read(languageProvider.notifier)
                            .setLanguage(AppLanguage.japanese),
                        child: const Text('switch'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    await tester.tap(find.text('switch'));
    await tester.pumpAndSettle();

    expect(find.text('設定'), findsOneWidget);
    expect(
      appPreferences?.getString(languagePreferenceKey),
      AppLanguage.japanese.preferenceValue,
    );
  });
}
