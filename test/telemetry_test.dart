import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/services/telemetry.dart';

void main() {
  Future<void> initPrefs() async {
    SharedPreferences.setMockInitialValues({});
    await initAppPreferences();
    await Telemetry.reset();
  }

  test('log increments a base counter and categorical sub-counters', () async {
    await initPrefs();

    Telemetry.log('onboarding.path_chosen', {'path': 'urge'});
    Telemetry.log('onboarding.path_chosen', {'path': 'urge'});
    Telemetry.log('onboarding.path_chosen', {'path': 'journal'});

    final counters = Telemetry.counters();
    expect(counters['onboarding.path_chosen'], 3);
    expect(counters['onboarding.path_chosen.path:urge'], 2);
    expect(counters['onboarding.path_chosen.path:journal'], 1);
  });

  test('numeric metrics do not explode the counter keyspace', () async {
    await initPrefs();

    Telemetry.log('activity.completed', {'kind': 'urge', 'durationSec': 12345});

    final counters = Telemetry.counters();
    expect(counters['activity.completed'], 1);
    expect(counters['activity.completed.kind:urge'], 1);
    // Large numeric prop is recorded in the ring buffer, not as a counter.
    expect(
      counters.keys.any((k) => k.contains('durationSec')),
      isFalse,
    );
  });

  test('recent events are returned most-recent first', () async {
    await initPrefs();

    Telemetry.log('a');
    Telemetry.log('b');

    final events = Telemetry.recentEvents();
    expect(events.first['e'], 'b');
    expect(events.last['e'], 'a');
  });

  test('logOnce fires exactly once across calls', () async {
    await initPrefs();

    Telemetry.logOnce('score.first_shown');
    Telemetry.logOnce('score.first_shown');
    Telemetry.logOnce('score.first_shown');

    expect(Telemetry.counters()['score.first_shown'], 1);
  });

  test('recordSessionStart anchors install day and logs day 0', () async {
    await initPrefs();

    await Telemetry.recordSessionStart();

    final counters = Telemetry.counters();
    expect(counters['session.start'], 1);
    expect(counters['session.start.day:0'], 1);
    // No retention event on the very first session.
    expect(counters['retention.day'], isNull);
  });

  test('log is a safe no-op when preferences are unavailable', () {
    appPreferences = null;
    // Should not throw.
    Telemetry.log('anything', {'x': 1});
    expect(Telemetry.counters(), isEmpty);
  });
}
