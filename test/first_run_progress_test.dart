import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/services/analytics_service.dart';

DelaySession _delay(DateTime when) => DelaySession(
  compulsion: 'c',
  plannedSeconds: 120,
  actualSeconds: 120,
  completed: true,
  urgeBefore: 7,
  urgeAfter: 4,
  outcome: DelayOutcome.resisted,
  createdAt: when,
);

void main() {
  final day1 = DateTime(2026, 7, 20, 9);
  final day2 = DateTime(2026, 7, 21, 9);
  final day3 = DateTime(2026, 7, 22, 9);

  bool enough(List<DelaySession> delays) => AnalyticsService.hasEnoughForProgress(
    journals: const [],
    ocds: const [],
    delaySessions: delays,
    erpSessions: const [],
  );

  test('a single first activity is not enough to reveal the score', () {
    expect(enough([_delay(day1)]), isFalse);
  });

  test('three activities on the same day is still not enough (needs 2 days)', () {
    expect(
      enough([_delay(day1), _delay(day1), _delay(day1)]),
      isFalse,
    );
  });

  test('two activities across two days is not enough (needs 3 activities)', () {
    expect(enough([_delay(day1), _delay(day2)]), isFalse);
  });

  test('three activities across two+ distinct days reveals the score', () {
    expect(
      enough([_delay(day1), _delay(day2), _delay(day3)]),
      isTrue,
    );
  });
}
