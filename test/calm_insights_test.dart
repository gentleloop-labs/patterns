import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/services/analytics_service.dart';

void main() {
  test('Calm Insights reports recent activity without a score', () {
    final now = DateTime(2026, 9, 9, 12);
    final recent = now.subtract(const Duration(days: 2));
    final old = now.subtract(const Duration(days: 10));

    final summary = AnalyticsService.buildCalmInsights(
      now: now,
      journals: [
        JournalEntry(
          date: '2026-09-07',
          content: 'private journal text',
          createdAt: recent,
          updatedAt: recent,
        ),
        JournalEntry(
          date: '2026-08-30',
          content: 'older private journal text',
          createdAt: old,
          updatedAt: old,
        ),
      ],
      ocds: [
        OcdEntry(
          type: OcdType.obsession,
          datetime: recent,
          content: 'private tracked text',
          distressLevel: 6,
          response: '',
          createdAt: recent,
        ),
      ],
      delaySessions: [
        DelaySession(
          compulsion: 'private compulsion text',
          plannedSeconds: 60,
          actualSeconds: 60,
          completed: true,
          urgeBefore: 7,
          urgeAfter: 5,
          outcome: DelayOutcome.delayed,
          createdAt: recent,
        ),
      ],
      erpSessions: [
        ErpExerciseSession(
          exerciseId: 'stable-id',
          exerciseTitle: 'private title',
          triggerOrExposure: 'private exposure',
          fearPrediction: 'private prediction',
          preventionCommitment: 'private commitment',
          plannedSeconds: 60,
          actualSeconds: 60,
          completed: true,
          anxietyBefore: 7,
          anxietyAfter: 6,
          outcome: DelayOutcome.resisted,
          whatHappened: 'private result',
          learning: 'private learning',
          createdAt: recent,
        ),
      ],
      exposureSteps: [
        ExposureStep(
          orderIndex: 0,
          description: 'private exposure step',
          difficulty: 5,
          anxietyRating: 6,
          status: ExposureStepStatus.completed,
          completedAt: recent,
        ),
      ],
    );

    expect(summary.journalCount, 1);
    expect(summary.trackedMomentCount, 1);
    expect(summary.delayCount, 1);
    expect(summary.erpPracticeCount, 1);
    expect(summary.exposureCount, 1);
    expect(summary.totalCount, 5);
    expect(summary.hasAnyData, isTrue);
  });

  test('Calm Insights has an honest empty state', () {
    final summary = AnalyticsService.buildCalmInsights(
      journals: const [],
      ocds: const [],
      delaySessions: const [],
      erpSessions: const [],
      exposureSteps: const [],
    );

    expect(summary.totalCount, 0);
    expect(summary.hasAnyData, isFalse);
  });
}
