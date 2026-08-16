import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/services/app_events.dart';
import 'package:patterns/services/telemetry.dart';

void main() {
  Future<void> initPrefs() async {
    SharedPreferences.setMockInitialValues({});
    await initAppPreferences();
    await Telemetry.reset();
    // logOnce markers survive Telemetry.reset (they are not counters), so clear
    // them explicitly to simulate a fresh installation.
    for (final key in appPreferences!.getKeys().toList()) {
      if (key.startsWith('tel_once_')) await appPreferences!.remove(key);
    }
  }

  group('funnel milestones fire once per installation', () {
    test('first_open', () async {
      await initPrefs();

      AppEvents.logFirstOpen();
      AppEvents.logFirstOpen();
      AppEvents.logFirstOpen();

      expect(Telemetry.counters()[AppEvents.firstOpen], 1);
    });

    test('onboarding_started and onboarding_completed', () async {
      await initPrefs();

      AppEvents.logOnboardingStarted();
      AppEvents.logOnboardingStarted();
      AppEvents.logOnboardingCompleted(path: 'urge');
      AppEvents.logOnboardingCompleted(path: 'journal');

      final counters = Telemetry.counters();
      expect(counters[AppEvents.onboardingStarted], 1);
      expect(counters[AppEvents.onboardingCompleted], 1);
      // The first completion wins, so the path recorded is the real one.
      expect(counters['${AppEvents.onboardingCompleted}.path:urge'], 1);
      expect(counters['${AppEvents.onboardingCompleted}.path:journal'], isNull);
    });

    test('each first_* activity milestone', () async {
      await initPrefs();

      AppEvents.logFirstJournalEntryCreated();
      AppEvents.logFirstJournalEntryCreated();
      AppEvents.logFirstCompulsionDelayStarted();
      AppEvents.logFirstCompulsionDelayStarted();
      AppEvents.logFirstCompulsionDelayCompleted(ranToCompletion: true);
      AppEvents.logFirstCompulsionDelayCompleted(ranToCompletion: false);
      AppEvents.logFirstExposureCreated(stepCount: 5);
      AppEvents.logFirstExposureCreated(stepCount: 9);
      AppEvents.logFirstExposureCompleted(ranToCompletion: true);
      AppEvents.logFirstExposureCompleted(ranToCompletion: true);

      final counters = Telemetry.counters();
      expect(counters[AppEvents.firstJournalEntryCreated], 1);
      expect(counters[AppEvents.firstCompulsionDelayStarted], 1);
      expect(counters[AppEvents.firstCompulsionDelayCompleted], 1);
      expect(counters[AppEvents.firstExposureCreated], 1);
      expect(counters[AppEvents.firstExposureCompleted], 1);
    });
  });

  group('first_meaningful_action', () {
    test('fires once, on whichever primary action lands first', () async {
      await initPrefs();

      AppEvents.logFirstCompulsionDelayCompleted(ranToCompletion: true);
      AppEvents.logFirstJournalEntryCreated();
      AppEvents.logFirstExposureCompleted(ranToCompletion: true);
      AppEvents.logFirstSelfCheckCompleted();

      final counters = Telemetry.counters();
      expect(counters[AppEvents.firstMeaningfulAction], 1);
      expect(
        counters['${AppEvents.firstMeaningfulAction}.kind:compulsion_delay'],
        1,
      );
      expect(counters['${AppEvents.firstMeaningfulAction}.kind:journal'], isNull);
    });

    test('a journal-first user is attributed to journal', () async {
      await initPrefs();

      AppEvents.logFirstJournalEntryCreated();
      AppEvents.logFirstCompulsionDelayCompleted(ranToCompletion: true);

      expect(
        Telemetry.counters()['${AppEvents.firstMeaningfulAction}.kind:journal'],
        1,
      );
    });

    test('a self-check alone counts as meaningful', () async {
      await initPrefs();

      AppEvents.logFirstSelfCheckCompleted();

      expect(
        Telemetry.counters()['${AppEvents.firstMeaningfulAction}.kind:self_check'],
        1,
      );
    });
  });

  group('supporter events repeat (they are not milestones)', () {
    test('screen views and purchases accumulate', () async {
      await initPrefs();

      AppEvents.logSupporterScreenViewed(source: 'settings');
      AppEvents.logSupporterScreenViewed(source: 'settings');
      AppEvents.logSupporterPurchaseStarted();
      AppEvents.logSupporterPurchaseCompleted(restored: false);
      AppEvents.logSupporterPurchaseCompleted(restored: true);

      final counters = Telemetry.counters();
      expect(counters[AppEvents.supporterScreenViewed], 2);
      expect(counters['${AppEvents.supporterScreenViewed}.source:settings'], 2);
      expect(counters[AppEvents.supporterPurchaseStarted], 1);
      expect(counters[AppEvents.supporterPurchaseCompleted], 2);
      expect(counters['${AppEvents.supporterPurchaseCompleted}.restored:true'], 1);
      expect(counters['${AppEvents.supporterPurchaseCompleted}.restored:false'], 1);
    });
  });

  group('privacy contract', () {
    test('no event carries free text, even if a call site passes prose', () async {
      await initPrefs();

      // A future call site mistakenly passing user-entered content.
      AppEvents.logSupporterScreenViewed(
        source: 'I keep checking the stove because I am afraid of a fire',
      );
      AppEvents.logOnboardingCompleted(
        path: 'my trigger is touching door handles in public',
      );

      for (final event in Telemetry.recentEvents()) {
        final props = event['p'] as Map<String, Object?>?;
        if (props == null) continue;
        for (final value in props.values) {
          if (value is! String) continue;
          expect(value.length, lessThanOrEqualTo(24));
          expect(RegExp(r'^[a-z0-9_]+$').hasMatch(value), isTrue,
              reason: 'prop "$value" is not a slug');
        }
      }
    });

    test('slugging strips punctuation and spaces', () async {
      await initPrefs();

      AppEvents.logSupporterScreenViewed(source: 'Settings / Pro Row!');

      expect(
        Telemetry.counters()['${AppEvents.supporterScreenViewed}.source:settings_pro_row'],
        1,
      );
    });

    test('event names are GA4-compatible lowercase snake_case', () {
      for (final name in AppEvents.all) {
        expect(RegExp(r'^[a-z][a-z0-9_]{0,39}$').hasMatch(name), isTrue,
            reason: '"$name" is not a valid GA4 event name');
      }
    });
  });
}
