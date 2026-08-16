import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/content/ybocs_content.dart';
import 'package:patterns/models/export_report_options.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/services/analytics_service.dart';
import 'package:patterns/services/pdf_report_service.dart';

YbocsAssessment _assessment({
  required DateTime at,
  required int obsessions,
  required int compulsions,
  List<String> themes = const [],
}) {
  final total = obsessions + compulsions;
  return YbocsAssessment(
    datetime: at,
    obsessionScore: obsessions,
    compulsionScore: compulsions,
    totalScore: total,
    severity: ybocsSeverityForScore(total),
    itemScores: const [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
    themes: themes,
    symptoms: const [],
    createdAt: at,
  );
}

void main() {
  group('filterYbocs', () {
    test('keeps only assessments in range and sorts them oldest first', () {
      final filter = DateRangeFilter.custom(
        start: DateTime(2026, 3, 1),
        end: DateTime(2026, 3, 31),
      );
      // Deliberately newest-first, which is how the database returns them.
      final assessments = [
        _assessment(at: DateTime(2026, 3, 20), obsessions: 8, compulsions: 8),
        _assessment(at: DateTime(2026, 3, 5), obsessions: 10, compulsions: 10),
        _assessment(at: DateTime(2026, 2, 20), obsessions: 12, compulsions: 12),
      ];

      final kept = AnalyticsService.filterYbocs(assessments, filter);

      expect(kept.length, 2);
      expect(kept.first.datetime, DateTime(2026, 3, 5));
      expect(kept.last.datetime, DateTime(2026, 3, 20));
    });

    test('does not mutate the caller list order', () {
      final first = _assessment(
        at: DateTime(2026, 3, 20),
        obsessions: 8,
        compulsions: 8,
      );
      final second = _assessment(
        at: DateTime(2026, 3, 5),
        obsessions: 10,
        compulsions: 10,
      );
      final source = [first, second];

      AnalyticsService.filterYbocs(
        source,
        DateRangeFilter.fromPreset(AnalyticsDateRange.allTime),
      );

      expect(source.first, same(first));
    });
  });

  group('dashboard Y-BOCS trend', () {
    RecoveryDashboardSummary build(List<YbocsAssessment> ybocs) {
      return AnalyticsService.buildRecoveryDashboard(
        journals: const [],
        ocds: const [],
        delaySessions: const [],
        erpSessions: const [],
        exposureSteps: const [],
        ybocsAssessments: ybocs,
        range: AnalyticsDateRange.ninety,
        now: DateTime(2026, 3, 31),
      );
    }

    test('is empty when the self-check has never been taken', () {
      final summary = build(const []);

      expect(summary.ybocsTrend, isEmpty);
      expect(summary.latestYbocs, isNull);
      expect(summary.hasYbocsTrend, isFalse);
    });

    test('a single self-check is not yet a trend', () {
      final summary = build([
        _assessment(at: DateTime(2026, 3, 10), obsessions: 9, compulsions: 9),
      ]);

      expect(summary.ybocsTrend.length, 1);
      expect(summary.latestYbocs?.totalScore, 18);
      expect(summary.hasYbocsTrend, isFalse);
      // No direction can be claimed from one point.
      expect(summary.ybocsDelta.value, 0);
    });

    test('orders points oldest first and reports the newest as latest', () {
      final summary = build([
        _assessment(at: DateTime(2026, 3, 20), obsessions: 6, compulsions: 6),
        _assessment(at: DateTime(2026, 2, 10), obsessions: 12, compulsions: 12),
        _assessment(at: DateTime(2026, 3, 1), obsessions: 9, compulsions: 9),
      ]);

      expect(summary.ybocsTrend.map((p) => p.value).toList(), [24, 18, 12]);
      expect(summary.latestYbocs?.totalScore, 12);
      expect(summary.hasYbocsTrend, isTrue);
    });

    test('a falling score reads as an improvement', () {
      final summary = build([
        _assessment(at: DateTime(2026, 2, 10), obsessions: 12, compulsions: 12),
        _assessment(at: DateTime(2026, 3, 20), obsessions: 6, compulsions: 6),
      ]);

      expect(summary.ybocsDelta.value, -12);
      expect(summary.ybocsDelta.lowerIsBetter, isTrue);
      expect(summary.ybocsDelta.tone, InsightTone.positive);
    });

    test('a rising score reads as a setback, not as progress', () {
      final summary = build([
        _assessment(at: DateTime(2026, 2, 10), obsessions: 6, compulsions: 6),
        _assessment(at: DateTime(2026, 3, 20), obsessions: 12, compulsions: 12),
      ]);

      expect(summary.ybocsDelta.value, 12);
      expect(summary.ybocsDelta.tone, InsightTone.negative);
    });

    test('excludes assessments outside the window', () {
      final summary = build([
        _assessment(at: DateTime(2025, 6, 1), obsessions: 15, compulsions: 15),
        _assessment(at: DateTime(2026, 3, 20), obsessions: 6, compulsions: 6),
      ]);

      expect(summary.ybocsTrend.length, 1);
      expect(summary.ybocsTrend.single.value, 12);
    });
  });

  group('export gating', () {
    test('self-checks alone are enough to export a report', () {
      const options = ExportReportOptions(
        sections: ExportSections(journal: false, ocd: false, analytics: false),
      );

      expect(
        options.hasExportableContent(
          journalCount: 0,
          ocdCount: 0,
          ybocsCount: 2,
        ),
        isTrue,
      );
    });

    test('an unticked Y-BOCS section does not unblock an empty report', () {
      const options = ExportReportOptions(
        sections: ExportSections(
          journal: false,
          ocd: false,
          analytics: false,
          ybocs: false,
        ),
      );

      expect(
        options.hasExportableContent(
          journalCount: 0,
          ocdCount: 0,
          ybocsCount: 5,
        ),
        isFalse,
      );
    });
  });

  group('category lookup', () {
    test('resolves a known theme id to its title', () {
      expect(ybocsCategoryTitleFor('contamination'), isNotNull);
    });

    test('returns null for an unknown id rather than leaking it', () {
      expect(ybocsCategoryTitleFor('not_a_real_category'), isNull);
    });
  });

  group('PDF report', () {
    // The pdf package needs no platform channels for generation, but the fonts
    // are loaded from the asset bundle, so this needs the binding.
    setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

    test('generates a report from self-checks with no journals or OCD logs', () async {
      const options = ExportReportOptions(
        range: AnalyticsDateRange.allTime,
        sections: ExportSections(journal: false, ocd: false, analytics: false),
      );

      final bytes = await PdfReportService.generate(
        options: options,
        journals: const [],
        ocds: const [],
        ybocs: [
          _assessment(
            at: DateTime(2026, 2, 10),
            obsessions: 12,
            compulsions: 12,
            themes: const ['contamination'],
          ),
          _assessment(at: DateTime(2026, 3, 20), obsessions: 6, compulsions: 6),
        ],
      );

      expect(bytes, isNotEmpty);
    });
  });

  group('InsightDelta.arrow', () {
    test('a falling lower-is-better score shows a down arrow', () {
      const delta = InsightDelta(value: -16, lowerIsBetter: true);

      // Green (positive tone) but pointing DOWN. This is the pairing that
      // regressed: the arrow used to follow the tone, so a 16-point Y-BOCS
      // improvement rendered as "↑ 16" over a chart that visibly fell.
      expect(delta.tone, InsightTone.positive);
      expect(delta.arrow, '↓');
    });

    test('a rising lower-is-better score shows an up arrow', () {
      const delta = InsightDelta(value: 16, lowerIsBetter: true);

      expect(delta.tone, InsightTone.negative);
      expect(delta.arrow, '↑');
    });

    test('a rising higher-is-better score shows an up arrow', () {
      const delta = InsightDelta(value: 5);

      expect(delta.tone, InsightTone.positive);
      expect(delta.arrow, '↑');
    });

    test('a falling higher-is-better score shows a down arrow', () {
      const delta = InsightDelta(value: -5);

      expect(delta.tone, InsightTone.negative);
      expect(delta.arrow, '↓');
    });

    test('no meaningful change shows a level arrow either way round', () {
      expect(const InsightDelta(value: 0).arrow, '→');
      expect(const InsightDelta(value: 0.01, lowerIsBetter: true).arrow, '→');
      expect(const InsightDelta(value: -0.01).arrow, '→');
    });
  });
}
