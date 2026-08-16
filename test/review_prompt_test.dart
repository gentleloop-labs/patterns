import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/services/app_events.dart';
import 'package:patterns/services/review_prompt.dart';
import 'package:patterns/services/telemetry.dart';

class _FakeReviewGateway implements ReviewGateway {
  bool available;
  bool throwOnRequest;
  int requestCount = 0;
  int storeOpenCount = 0;

  _FakeReviewGateway({this.available = true, this.throwOnRequest = false});

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<void> requestReview() async {
    requestCount += 1;
    if (throwOnRequest) throw StateError('request failed');
  }

  @override
  Future<void> openStoreListing({required String appStoreId}) async {
    storeOpenCount += 1;
  }
}

void main() {
  Future<void> initializePrefs() async {
    SharedPreferences.setMockInitialValues({});
    await initAppPreferences();
    await Telemetry.reset();
  }

  DateTime oldEnoughInstallDate() => DateTime.now().subtract(
    Duration(hours: ReviewPromptService.minHoursInstalled + 1),
  );

  Future<void> setEligibleState({
    List<DateTime> attempts = const [],
    DateTime? lastFailure,
  }) => ReviewPromptService.setTestingState(
    firstSeen: oldEnoughInstallDate(),
    meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
    distinctDays: ReviewPromptService.minDistinctDays,
    attempts: attempts,
    lastFailure: lastFailure,
  );

  setUp(() {
    ReviewPromptService.setMobileOverrideForTesting(true);
  });

  tearDown(() {
    ReviewPromptService.setGatewayForTesting(null);
    ReviewPromptService.setMobileOverrideForTesting(null);
    appPreferences = null;
  });

  test('diagnostics reports missing preferences as ineligible', () {
    appPreferences = null;

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.eligible, isFalse);
    expect(
      diagnostics.reason,
      RatingPromptIneligibility.preferencesUnavailable,
    );
  });

  test('new installs remain ineligible until 24 elapsed hours', () async {
    await initializePrefs();
    await ReviewPromptService.setTestingState(
      firstSeen: DateTime.now().subtract(
        Duration(hours: ReviewPromptService.minHoursInstalled - 1),
      ),
      meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
      distinctDays: ReviewPromptService.minDistinctDays,
    );

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.eligible, isFalse);
    expect(diagnostics.reason, RatingPromptIneligibility.tooRecentlyInstalled);
  });

  test('eligible after age, action, and active-day thresholds', () async {
    await initializePrefs();
    await setEligibleState();

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.eligible, isTrue);
    expect(diagnostics.reason, isNull);
  });

  test('meaningful actions and distinct days remain required', () async {
    await initializePrefs();
    await ReviewPromptService.setTestingState(
      firstSeen: oldEnoughInstallDate(),
      meaningfulActionCount: ReviewPromptService.minMeaningfulActions - 1,
      distinctDays: ReviewPromptService.minDistinctDays,
    );
    expect(
      ReviewPromptService.diagnostics().reason,
      RatingPromptIneligibility.notEnoughMeaningfulActions,
    );

    await ReviewPromptService.setTestingState(
      firstSeen: oldEnoughInstallDate(),
      meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
      distinctDays: ReviewPromptService.minDistinctDays - 1,
    );
    expect(
      ReviewPromptService.diagnostics().reason,
      RatingPromptIneligibility.notEnoughDistinctDays,
    );
  });

  test('recent attempt starts the 30-day cooldown', () async {
    await initializePrefs();
    await setEligibleState(attempts: [DateTime.now()]);

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.eligible, isFalse);
    expect(diagnostics.reason, RatingPromptIneligibility.promptCooldown);
  });

  test('three attempts inside 365 days enforce the annual cap', () async {
    await initializePrefs();
    await setEligibleState(
      attempts: [
        DateTime.now().subtract(const Duration(days: 300)),
        DateTime.now().subtract(const Duration(days: 200)),
        DateTime.now().subtract(const Duration(days: 40)),
      ],
    );

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.attemptsInLast365Days, 3);
    expect(diagnostics.reason, RatingPromptIneligibility.annualAttemptLimit);
  });

  test('attempts older than 365 days roll out of the window', () async {
    await initializePrefs();
    await setEligibleState(
      attempts: [
        DateTime.now().subtract(
          Duration(days: ReviewPromptService.attemptWindowDays + 1),
        ),
      ],
    );

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.attemptsInLast365Days, 0);
    expect(diagnostics.eligible, isTrue);
  });

  test('native failure starts a seven-day backoff', () async {
    await initializePrefs();
    await setEligibleState(lastFailure: DateTime.now());

    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.reason, RatingPromptIneligibility.failureBackoff);
  });

  test(
    'legacy decline, opt-out, and completed choices remain honored',
    () async {
      await initializePrefs();
      await ReviewPromptService.setTestingState(
        firstSeen: oldEnoughInstallDate(),
        meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
        distinctDays: ReviewPromptService.minDistinctDays,
        lastDecline: DateTime.now(),
      );
      expect(
        ReviewPromptService.diagnostics().reason,
        RatingPromptIneligibility.declineCooldown,
      );

      await ReviewPromptService.setTestingState(
        firstSeen: oldEnoughInstallDate(),
        meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
        distinctDays: ReviewPromptService.minDistinctDays,
        optedOut: true,
      );
      expect(
        ReviewPromptService.diagnostics().reason,
        RatingPromptIneligibility.optedOut,
      );

      await ReviewPromptService.setTestingState(
        firstSeen: oldEnoughInstallDate(),
        meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
        distinctDays: ReviewPromptService.minDistinctDays,
        completed: true,
      );
      expect(
        ReviewPromptService.diagnostics().reason,
        RatingPromptIneligibility.completed,
      );
    },
  );

  test('recordSessionStart migrates the legacy last prompt', () async {
    await initializePrefs();
    final legacyAttempt = DateTime.now().subtract(const Duration(days: 45));
    await ReviewPromptService.setTestingState(
      firstSeen: oldEnoughInstallDate(),
      meaningfulActionCount: ReviewPromptService.minMeaningfulActions,
      distinctDays: ReviewPromptService.minDistinctDays,
      lastPrompt: legacyAttempt,
    );

    await ReviewPromptService.recordSessionStart();
    final diagnostics = ReviewPromptService.diagnostics();

    expect(diagnostics.attemptsInLast365Days, 1);
    expect(
      diagnostics.lastAttempt!.difference(legacyAttempt).inSeconds.abs(),
      lessThan(1),
    );
  });

  testWidgets(
    'automatic flow calls the native gateway without a custom dialog',
    (tester) async {
      await initializePrefs();
      await setEligibleState();
      final gateway = _FakeReviewGateway();
      ReviewPromptService.setGatewayForTesting(gateway);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => ReviewPromptService.maybeRequestReview(
                  context,
                  trigger: ReviewTrigger.journalSaved,
                ),
                child: const Text('Trigger'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Trigger'));
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pump();

      expect(gateway.requestCount, 1);
      expect(find.byType(Dialog), findsNothing);
      expect(ReviewPromptService.diagnostics().attemptsInLast365Days, 1);
      expect(Telemetry.counters()[AppEvents.reviewRequestAttempted], 1);
    },
  );

  testWidgets('unavailable native flow records failure but no attempt', (
    tester,
  ) async {
    await initializePrefs();
    await setEligibleState();
    final gateway = _FakeReviewGateway(available: false);
    ReviewPromptService.setGatewayForTesting(gateway);

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => ReviewPromptService.maybeRequestReview(
                context,
                trigger: ReviewTrigger.analyticsLinger,
              ),
              child: const Text('Trigger'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Trigger'));
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump();

    final diagnostics = ReviewPromptService.diagnostics();
    expect(gateway.requestCount, 0);
    expect(diagnostics.attemptsInLast365Days, 0);
    expect(diagnostics.reason, RatingPromptIneligibility.failureBackoff);
    expect(Telemetry.counters()[AppEvents.reviewRequestUnavailable], 1);
  });

  testWidgets('throwing native flow records failure but no attempt', (
    tester,
  ) async {
    await initializePrefs();
    await setEligibleState();
    final gateway = _FakeReviewGateway(throwOnRequest: true);
    ReviewPromptService.setGatewayForTesting(gateway);

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => ReviewPromptService.maybeRequestReview(
                context,
                trigger: ReviewTrigger.erpCompleted,
              ),
              child: const Text('Trigger'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Trigger'));
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump();

    final diagnostics = ReviewPromptService.diagnostics();
    expect(gateway.requestCount, 1);
    expect(diagnostics.attemptsInLast365Days, 0);
    expect(diagnostics.reason, RatingPromptIneligibility.failureBackoff);
    expect(Telemetry.counters()[AppEvents.reviewRequestFailed], 1);
  });

  testWidgets('manual Rate opens the store and does not change cadence', (
    tester,
  ) async {
    await initializePrefs();
    await setEligibleState();
    final gateway = _FakeReviewGateway();
    ReviewPromptService.setGatewayForTesting(gateway);

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () =>
                  ReviewPromptService.requestReviewManually(context),
              child: const Text('Rate'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Rate'));
    await tester.pump();

    expect(gateway.storeOpenCount, 1);
    expect(gateway.requestCount, 0);
    expect(ReviewPromptService.diagnostics().attemptsInLast365Days, 0);
    expect(ReviewPromptService.diagnostics().eligible, isTrue);
    expect(Telemetry.counters()[AppEvents.reviewManualStoreOpened], 1);
  });
}
