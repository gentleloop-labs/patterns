import 'dart:async';
import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../content/ybocs_content.dart';
import '../../app_preferences.dart';
import '../../l10n/l10n.dart';
import '../../models/export_report_options.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../services/analytics_service.dart';
import '../../services/review_prompt.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/export_report_sheet.dart';
import '../../widgets/platform.dart';
import 'recovery_metrics_screen.dart';

enum _InsightTab { overview, thoughts, urges, erp }

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  AnalyticsDateRange _range = AnalyticsDateRange.thirty;
  AnalyticsDateRange _previousRange = AnalyticsDateRange.thirty;
  _InsightTab _tab = _InsightTab.overview;
  Timer? _lingerTimer;

  @override
  void initState() {
    super.initState();
    _lingerTimer = Timer(const Duration(seconds: 20), () {
      if (!mounted) return;
      ReviewPromptService.maybeRequestReview(
        context,
        trigger: ReviewTrigger.analyticsLinger,
      );
    });
  }

  @override
  void dispose() {
    _lingerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final journalAsync = ref.watch(journalProvider);
    final ocdAsync = ref.watch(ocdProvider);
    final delays = ref.watch(delaySessionProvider).asData?.value ?? const [];
    final erp = ref.watch(erpExerciseSessionProvider).asData?.value ?? const [];
    final steps = ref.watch(exposureStepProvider).asData?.value ?? const [];
    final responses =
        ref.watch(responsePreventionProvider).asData?.value ?? const [];
    final surfs = ref.watch(urgeSurfProvider).asData?.value ?? const [];
    final ybocs = ref.watch(ybocsAssessmentProvider).asData?.value ?? const [];
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.scaffoldBackgroundColor, context.appColors.surface],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 116),
            children: [
              FadeSlideIn(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 12,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        strings.insightsTitle,
                        style: _screenTitle(theme),
                      ),
                    ),
                    if (isPdfExportSupported)
                      _IconGlassButton(
                        tooltip: strings.insightsExportReport,
                        icon: LineIcons.fileExport,
                        onTap: () => ExportReportSheet.show(
                          context,
                          initialOptions: ExportReportOptions(range: _range),
                        ),
                      ),
                    const SizedBox(width: 10),
                    _RangeMenu(
                      range: _range,
                      onChanged: (range) {
                        if (range == _range) return;
                        setState(() {
                          _previousRange = _range;
                          _range = range;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              FadeSlideIn(
                delay: const Duration(milliseconds: 50),
                child: _InsightSegmentedControl(
                  tab: _tab,
                  onChanged: (tab) => setState(() => _tab = tab),
                ),
              ),
              const SizedBox(height: 14),
              journalAsync.when(
                data: (journals) => ocdAsync.when(
                  data: (ocds) {
                    final dashboard = AnalyticsService.buildRecoveryDashboard(
                      journals: journals,
                      ocds: ocds,
                      delaySessions: delays,
                      erpSessions: erp,
                      exposureSteps: steps,
                      responsePreventionLogs: responses,
                      urgeSurfSessions: surfs,
                      ybocsAssessments: ybocs,
                      range: _range,
                    );
                    // Gate the practice-progress score on all-time activity
                    // (same rule as the Today home) so a single session doesn't
                    // read as a precise, potentially discouraging number.
                    final enoughForScore =
                        AnalyticsService.hasEnoughForProgress(
                          journals: journals,
                          ocds: ocds,
                          delaySessions: delays,
                          erpSessions: erp,
                        );
                    final calmSummary = AnalyticsService.buildCalmInsights(
                      journals: journals,
                      ocds: ocds,
                      delaySessions: delays,
                      erpSessions: erp,
                      exposureSteps: steps,
                    );
                    final goingForward = _range.index >= _previousRange.index;
                    return PageTransitionSwitcher(
                      duration: AppMotion.medium,
                      reverse: !goingForward,
                      transitionBuilder: (child, primary, secondary) {
                        if (motionDisabled(context)) return child;
                        return SharedAxisTransition(
                          animation: primary,
                          secondaryAnimation: secondary,
                          transitionType: SharedAxisTransitionType.horizontal,
                          fillColor: Colors.transparent,
                          child: child,
                        );
                      },
                      child: _DashboardTabBody(
                        key: ValueKey('${_range.name}-${_tab.name}'),
                        tab: _tab,
                        summary: dashboard,
                        enoughForScore: enoughForScore,
                        calmInsightsEnabled: calmInsightsEnabled,
                        calmSummary: calmSummary,
                      ),
                    );
                  },
                  loading: () => const _InsightsLoading(),
                  error: (error, _) => const _InsightsError(),
                ),
                loading: () => const _InsightsLoading(),
                error: (error, _) => const _InsightsError(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardTabBody extends StatelessWidget {
  final _InsightTab tab;
  final RecoveryDashboardSummary summary;
  final bool enoughForScore;
  final bool calmInsightsEnabled;
  final CalmInsightsSummary calmSummary;

  const _DashboardTabBody({
    super.key,
    required this.tab,
    required this.summary,
    required this.enoughForScore,
    required this.calmInsightsEnabled,
    required this.calmSummary,
  });

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case _InsightTab.overview:
        return _OverviewDashboard(
          summary: summary,
          enoughForScore: enoughForScore,
          calmInsightsEnabled: calmInsightsEnabled,
          calmSummary: calmSummary,
        );
      case _InsightTab.thoughts:
        return _ThoughtsDashboard(
          summary: summary,
          calmInsightsEnabled: calmInsightsEnabled,
        );
      case _InsightTab.urges:
        return _UrgesDashboard(
          summary: summary,
          calmInsightsEnabled: calmInsightsEnabled,
        );
      case _InsightTab.erp:
        return _ErpDashboard(
          summary: summary,
          calmInsightsEnabled: calmInsightsEnabled,
        );
    }
  }
}

class _OverviewDashboard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool enoughForScore;
  final bool calmInsightsEnabled;
  final CalmInsightsSummary calmSummary;

  const _OverviewDashboard({
    required this.summary,
    required this.enoughForScore,
    required this.calmInsightsEnabled,
    required this.calmSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (calmInsightsEnabled) ...[
          _CalmInsightsCard(summary: calmSummary),
          const SizedBox(height: 12),
        ],
        if (!calmInsightsEnabled) ...[
          _RecoveryScoreCard(summary: summary, enoughData: enoughForScore),
          const SizedBox(height: 12),
        ],
        _MoodCard(summary: summary),
        const SizedBox(height: 12),
        _YbocsCard(summary: summary, calmInsightsEnabled: calmInsightsEnabled),
        const SizedBox(height: 12),
        _ResponsiveCardPair(
          first: _UrgeIntensityCard(
            summary: summary,
            calmInsightsEnabled: calmInsightsEnabled,
          ),
          second: _ErpPracticeCard(
            summary: summary,
            calmInsightsEnabled: calmInsightsEnabled,
          ),
        ),
        const SizedBox(height: 12),
        if (!calmInsightsEnabled) ...[
          _ConsistencyCard(summary: summary),
          const SizedBox(height: 12),
        ],
        _TopThemesCard(summary: summary),
        const SizedBox(height: 24),
        const RecoveryMetricsSection(),
      ],
    );
  }
}

class _ResponsiveCardPair extends StatelessWidget {
  final Widget first;
  final Widget second;

  const _ResponsiveCardPair({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.textScalerOf(context).scale(1) > 1.3) {
      return Column(children: [first, const SizedBox(height: 12), second]);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(width: 12),
        Expanded(child: second),
      ],
    );
  }
}

class _CalmInsightsCard extends StatelessWidget {
  final CalmInsightsSummary summary;

  const _CalmInsightsCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final facts = <String>[
      if (summary.journalCount > 0)
        strings.calmJournalActivity(summary.journalCount),
      if (summary.trackedMomentCount > 0)
        strings.calmTrackedActivity(summary.trackedMomentCount),
      if (summary.delayCount > 0) strings.calmDelayActivity(summary.delayCount),
      if (summary.erpPracticeCount > 0)
        strings.calmErpActivity(summary.erpPracticeCount),
      if (summary.exposureCount > 0)
        strings.calmExposureActivity(summary.exposureCount),
    ];
    final body = facts.isEmpty
        ? strings.calmNoRecentActivity
        : facts.join(', ');
    return Semantics(
      container: true,
      label: strings.calmRecentActivityTitle,
      value: body,
      child: _GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardTitle(strings.calmRecentActivityTitle),
            const SizedBox(height: 10),
            Text(body, style: _mutedStyle.copyWith(height: 1.45)),
          ],
        ),
      ),
    );
  }
}

class _ThoughtsDashboard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool calmInsightsEnabled;

  const _ThoughtsDashboard({
    required this.summary,
    required this.calmInsightsEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ResponsiveCardPair(
          first: _KpiCard(
            label: context.l10n.insightsObsessionsLogged,
            value: context.formatInteger(summary.thoughts),
            icon: LineIcons.brain,
          ),
          second: _KpiCard(
            label: context.l10n.insightsThemesFound,
            value: context.formatInteger(summary.topThemes.length),
            icon: LineIcons.tags,
          ),
        ),
        const SizedBox(height: 12),
        _YbocsCard(summary: summary, calmInsightsEnabled: calmInsightsEnabled),
        const SizedBox(height: 12),
        _TopThemesCard(summary: summary),
        const SizedBox(height: 12),
        _MoodCard(summary: summary),
      ],
    );
  }
}

class _UrgesDashboard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool calmInsightsEnabled;

  const _UrgesDashboard({
    required this.summary,
    required this.calmInsightsEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ResponsiveCardPair(
          first: _KpiCard(
            label: context.l10n.insightsCompulsions,
            value: context.formatInteger(summary.compulsions),
            icon: LineIcons.bullseye,
          ),
          second: _KpiCard(
            label: context.l10n.insightsAverageIntensityShort,
            value: context.formatOneDecimal(summary.averageUrge),
            suffix: context.l10n.insightsOutOfTenShort,
            icon: LineIcons.lineChart,
            delta: calmInsightsEnabled ? null : summary.urgeDelta,
          ),
        ),
        const SizedBox(height: 12),
        _UrgeIntensityCard(
          summary: summary,
          wide: true,
          calmInsightsEnabled: calmInsightsEnabled,
        ),
        if (!calmInsightsEnabled) ...[
          const SizedBox(height: 12),
          _ConsistencyCard(summary: summary),
        ],
      ],
    );
  }
}

class _ErpDashboard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool calmInsightsEnabled;

  const _ErpDashboard({
    required this.summary,
    required this.calmInsightsEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ErpPracticeCard(
          summary: summary,
          wide: true,
          calmInsightsEnabled: calmInsightsEnabled,
        ),
        if (!calmInsightsEnabled) ...[
          const SizedBox(height: 12),
          _ConsistencyCard(summary: summary),
        ],
        const SizedBox(height: 24),
        const RecoveryMetricsSection(),
      ],
    );
  }
}

class _RecoveryScoreCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;

  /// Whether there's enough all-time activity for the score to be meaningful.
  /// Matches the Today home so the two screens never disagree.
  final bool enoughData;

  const _RecoveryScoreCard({required this.summary, this.enoughData = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (!enoughData) {
      // Deliberately no number yet — say so plainly so it doesn't look broken,
      // and reassure that the sessions below are already being counted.
      return _GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardTitle(context.l10n.insightsPracticeProgress),
            const SizedBox(height: 10),
            Text(
              summary.hasAnyData
                  ? context.l10n.insightsScoreNeedsMoreActivity
                  : context.l10n.insightsScoreEmpty,
              style: TextStyle(
                color: context.appColors.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }
    return _GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(context.l10n.insightsPracticeProgress),
                    const SizedBox(height: 12),
                    Text(
                      context.formatWholePercent(summary.recoveryScore),
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontFamily: AppTheme.sansFamily,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _DeltaLabel(
                      delta: summary.scoreDelta,
                      comparison: context.l10n.insightsComparedPreviousDays(
                        summary.rangeDays,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: _MiniLineChart(
                        semanticTitle: context.l10n.insightsPracticeProgress,
                        points: summary.scoreTrend,
                        minY: 0,
                        maxY: 100,
                        color: context.appColors.accent,
                        showDots: false,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _ScoreRing(score: summary.recoveryScore),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.insightsPracticeProgressBoundary,
            style: TextStyle(
              color: context.appColors.textSecondary.withValues(alpha: 0.85),
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;

  const _MoodCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _CardTitle(context.l10n.insightsMoodOverTime, info: true),
              _LegendDot(
                color: context.appColors.positive,
                label: context.l10n.insightsMoodGood,
              ),
              _LegendDot(
                color: context.appColors.accent,
                label: context.l10n.insightsMoodOkay,
              ),
              _LegendDot(
                color: context.appColors.negative,
                label: context.l10n.insightsMoodLow,
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 132,
            child: _MiniLineChart(
              semanticTitle: context.l10n.insightsMoodOverTime,
              points: summary.moodTrend,
              minY: 0,
              maxY: 10,
              color: context.appColors.positive,
              moodColors: true,
              bottomLabels: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// The Y-BOCS total over time. The app has always told people that retaking the
/// self-check every few weeks shows whether things are shifting; this is where
/// that promise is actually kept.
///
/// Severity colour, band name, and standard range all come from
/// [YbocsSeverityDisplay] so there is exactly one place that decides how a band
/// is presented.
class _YbocsCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool calmInsightsEnabled;

  const _YbocsCard({required this.summary, required this.calmInsightsEnabled});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final latest = summary.latestYbocs;

    // One point is not a trend, and a line through a single dot reads as a flat
    // result rather than as "not enough yet". Invite a retake instead.
    if (!summary.hasYbocsTrend) {
      return _GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardTitle(context.l10n.insightsYbocsOverTime, info: true),
            const SizedBox(height: 10),
            if (latest == null)
              Text(context.l10n.insightsYbocsEmpty, style: _mutedStyle)
            else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.formatInteger(latest.totalScore),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: latest.severity.color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Text(
                      context.l10n.insightsOutOfFortyShort,
                      style: _mutedStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.insightsYbocsSingleResult(
                  _ybocsSeverityLabel(context, latest.severity),
                ),
                style: _mutedStyle,
              ),
            ],
          ],
        ),
      );
    }

    final severity = latest!.severity;
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(context.l10n.insightsYbocsOverTime, info: true),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                context.formatInteger(latest.totalScore),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: severity.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 4),
                child: Text(
                  context.l10n.insightsOutOfFortyShort,
                  style: _mutedStyle,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  context.l10n.insightsYbocsSeverityRange(
                    _ybocsSeverityLabel(context, severity),
                    severity.range,
                  ),
                  style: _mutedStyle.copyWith(color: severity.color),
                ),
              ),
            ],
          ),
          if (!calmInsightsEnabled) ...[
            const SizedBox(height: 4),
            _DeltaLabel(
              delta: summary.ybocsDelta,
              comparison: context.l10n.insightsAcrossSelfChecks(
                summary.ybocsTrend.length,
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            height: 132,
            child: _MiniLineChart(
              semanticTitle: context.l10n.insightsYbocsOverTime,
              points: summary.ybocsTrend,
              minY: 0,
              maxY: 40,
              color: severity.color,
              bottomLabels: true,
            ),
          ),
          const SizedBox(height: 10),
          Text(context.l10n.insightsYbocsBoundary, style: _mutedStyle),
        ],
      ),
    );
  }
}

class _UrgeIntensityCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool wide;
  final bool calmInsightsEnabled;

  const _UrgeIntensityCard({
    required this.summary,
    required this.calmInsightsEnabled,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _GlassCard(
      minHeight: wide ? null : 176,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(context.l10n.insightsAverageUrgeIntensity, info: true),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                context.formatOneDecimal(summary.averageUrge),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 4),
                child: Text(
                  context.l10n.insightsOutOfTenShort,
                  style: _mutedStyle,
                ),
              ),
            ],
          ),
          if (!calmInsightsEnabled) ...[
            const SizedBox(height: 4),
            _DeltaLabel(
              delta: summary.urgeDelta,
              comparison: context.l10n.insightsComparedPreviousDays(
                summary.rangeDays,
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            height: wide ? 132 : 64,
            child: _MiniLineChart(
              semanticTitle: context.l10n.insightsAverageUrgeIntensity,
              points: summary.urgeTrend,
              minY: 0,
              maxY: 10,
              color: context.appColors.accent,
              bottomLabels: wide,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErpPracticeCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final bool wide;
  final bool calmInsightsEnabled;

  const _ErpPracticeCard({
    required this.summary,
    required this.calmInsightsEnabled,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _GlassCard(
      minHeight: wide ? null : 176,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(context.l10n.insightsErpPractice, info: true),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                context.formatInteger(summary.erpPracticeCount),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 4),
                child: Text(
                  context.l10n.insightsSessions(summary.erpPracticeCount),
                  style: _mutedStyle,
                ),
              ),
            ],
          ),
          if (!calmInsightsEnabled) ...[
            const SizedBox(height: 4),
            _DeltaLabel(
              delta: summary.erpDelta,
              comparison: context.l10n.insightsComparedPreviousDays(
                summary.rangeDays,
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            height: wide ? 150 : 64,
            child: _MiniBarChart(
              semanticTitle: context.l10n.insightsErpPractice,
              points: summary.erpTrend,
              bottomLabels: wide,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsistencyCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;

  const _ConsistencyCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    return _GlassCard(
      child: Flex(
        direction: stacked ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: stacked ? null : 126,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardTitle(context.l10n.insightsConsistency, info: true),
                const SizedBox(height: 12),
                Text(
                  context.formatWholePercent(summary.consistencyPercent),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.l10n.insightsActiveDays(
                    summary.activeDays,
                    summary.rangeDays,
                  ),
                  style: _mutedStyle,
                ),
              ],
            ),
          ),
          SizedBox(width: stacked ? 0 : 12, height: stacked ? 12 : 0),
          if (stacked)
            _DotHeatmap(
              semanticLabel: context.l10n.insightsActivityMapSummary(
                summary.activeDays,
                summary.rangeDays,
              ),
              values: summary.consistencyHeatmap,
              active: context.appColors.accent,
            )
          else
            Expanded(
              child: _DotHeatmap(
                semanticLabel: context.l10n.insightsActivityMapSummary(
                  summary.activeDays,
                  summary.rangeDays,
                ),
                values: summary.consistencyHeatmap,
                active: context.appColors.accent,
              ),
            ),
        ],
      ),
    );
  }
}

class _TopThemesCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;

  const _TopThemesCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final themes = summary.topThemes;
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(context.l10n.insightsTopThemes, info: true),
          const SizedBox(height: 14),
          if (themes.isEmpty)
            Text(context.l10n.insightsThemesEmpty, style: _mutedStyle)
          else
            for (var i = 0; i < themes.length; i++) ...[
              _ThemeRow(
                theme: themes[i],
                color: _themeColors[i % _themeColors.length],
              ),
              if (i != themes.length - 1) const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}

class _ThemeRow extends StatelessWidget {
  final ThemeInsight theme;
  final Color color;

  const _ThemeRow({required this.theme, required this.color});

  @override
  Widget build(BuildContext context) {
    final percent = (theme.percent * 100).round();
    final localizedLabel = _localizedThemeLabel(context, theme.label);
    return Semantics(
      container: true,
      label: context.l10n.insightsThemeShare(localizedLabel, percent),
      excludeSemantics: true,
      child: Column(
        children: [
          Row(
            children: [
              Icon(_themeIcon(theme.label), color: color, size: 19),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  localizedLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(context.formatWholePercent(percent), style: _mutedStyle),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: theme.percent.clamp(0, 1),
              minHeight: 6,
              backgroundColor: const Color(0xFF292927),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;
  final IconData icon;
  final InsightDelta? delta;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    this.suffix,
    this.delta,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.appColors.accent, size: 22),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 3, bottom: 4),
                  child: Text(suffix!, style: _mutedStyle),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: _mutedStyle),
          if (delta != null) ...[
            const SizedBox(height: 8),
            _DeltaLabel(
              delta: delta!,
              comparison: context.l10n.insightsComparedPreviousRange,
            ),
          ],
        ],
      ),
    );
  }
}

class _RangeMenu extends StatelessWidget {
  final AnalyticsDateRange range;
  final ValueChanged<AnalyticsDateRange> onChanged;

  const _RangeMenu({required this.range, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<AnalyticsDateRange>(
      tooltip: context.l10n.insightsChangeRange,
      onSelected: onChanged,
      color: context.appColors.card,
      itemBuilder: (_) => [
        PopupMenuItem(
          value: AnalyticsDateRange.seven,
          child: Text(context.l10n.rangeLastSevenDays),
        ),
        PopupMenuItem(
          value: AnalyticsDateRange.thirty,
          child: Text(context.l10n.rangeLastThirtyDays),
        ),
        PopupMenuItem(
          value: AnalyticsDateRange.ninety,
          child: Text(context.l10n.rangeLastNinetyDays),
        ),
        PopupMenuItem(
          value: AnalyticsDateRange.year,
          child: Text(context.l10n.rangeLastYear),
        ),
      ],
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: _premiumDecoration(theme, radius: 18),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _rangeLabel(context, range),
                style: TextStyle(
                  color: context.appColors.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              LineIcons.angleDown,
              size: 14,
              color: context.appColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightSegmentedControl extends StatelessWidget {
  final _InsightTab tab;
  final ValueChanged<_InsightTab> onChanged;

  const _InsightSegmentedControl({required this.tab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    final buttons = [
      _SegmentButton(
        label: context.l10n.insightsOverviewTab,
        selected: tab == _InsightTab.overview,
        onTap: () => onChanged(_InsightTab.overview),
      ),
      _SegmentButton(
        label: context.l10n.insightsObsessionsTab,
        selected: tab == _InsightTab.thoughts,
        onTap: () => onChanged(_InsightTab.thoughts),
      ),
      _SegmentButton(
        label: context.l10n.insightsCompulsionsTab,
        selected: tab == _InsightTab.urges,
        onTap: () => onChanged(_InsightTab.urges),
      ),
      _SegmentButton(
        label: context.l10n.insightsErpTab,
        selected: tab == _InsightTab.erp,
        onTap: () => onChanged(_InsightTab.erp),
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: _premiumDecoration(theme, radius: 18),
      child: stacked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buttons,
            )
          : Row(
              children: [for (final button in buttons) Expanded(child: button)],
            ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final segmentColors = insightSegmentColors(theme, selected: selected);

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: ExcludeSemantics(
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: AnimatedContainer(
              duration: motionDisabled(context)
                  ? Duration.zero
                  : AppMotion.fast,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              decoration: BoxDecoration(
                color: segmentColors.background,
                borderRadius: BorderRadius.circular(14),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: context.appColors.accent.withValues(
                            alpha: 0.16,
                          ),
                          blurRadius: 18,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: segmentColors.foreground,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
({Color background, Color foreground}) insightSegmentColors(
  ThemeData theme, {
  required bool selected,
}) {
  if (!selected) {
    return (
      background: Colors.transparent,
      foreground: theme.appColors.textSecondary,
    );
  }

  if (theme.brightness == Brightness.light) {
    return (
      background: theme.colorScheme.primary,
      foreground: theme.colorScheme.onPrimary,
    );
  }

  return (
    background: const Color(0xFF27251C),
    foreground: theme.appColors.accent,
  );
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double? minHeight;

  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      width: double.infinity,
      padding: padding,
      decoration: _premiumDecoration(theme),
      child: child,
    );
  }
}

class _IconGlassButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  const _IconGlassButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: ExcludeSemantics(
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: _premiumDecoration(theme, radius: 14),
              child: Icon(
                icon,
                size: 18,
                color: context.appColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String text;
  final bool info;

  const _CardTitle(this.text, {this.info = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
        ),
        if (info) ...[
          const SizedBox(width: 4),
          Icon(
            LineIcons.infoCircle,
            size: 13,
            color: context.appColors.textSecondary,
          ),
        ],
      ],
    );
  }
}

class _DeltaLabel extends StatelessWidget {
  final InsightDelta delta;
  final String comparison;

  const _DeltaLabel({required this.delta, required this.comparison});

  @override
  Widget build(BuildContext context) {
    final color = switch (delta.tone) {
      InsightTone.positive => context.appColors.positive,
      InsightTone.negative => context.appColors.negative,
      InsightTone.neutral => context.appColors.textSecondary,
    };
    final value = context.formatOneDecimal(delta.value.abs());
    final label = delta.value > 0
        ? context.l10n.insightsDeltaIncrease(value, comparison)
        : delta.value < 0
        ? context.l10n.insightsDeltaDecrease(value, comparison)
        : context.l10n.insightsDeltaUnchanged(comparison);
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: _mutedStyle.copyWith(fontSize: 10.5)),
      ],
    );
  }
}

class _ScoreRing extends StatelessWidget {
  final int score;

  const _ScoreRing({required this.score});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.recoveryScoreSemantics(score),
      excludeSemantics: true,
      child: SizedBox(
        width: 96,
        height: 96,
        child: CustomPaint(
          painter: _ScoreRingPainter(
            score: score,
            accent: context.appColors.accent,
            track: context.appColors.border,
          ),
          child: Center(
            child: Icon(
              LineIcons.lineChart,
              color: context.appColors.textSecondary,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  final int score;
  final Color accent;
  final Color track;

  _ScoreRingPainter({
    required this.score,
    required this.accent,
    required this.track,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 7;
    final trackPaint = Paint()
      ..color = track
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final progress = Paint()
      ..shader = SweepGradient(
        colors: [accent, const Color(0xFFFFE28A), accent],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      (score.clamp(0, 100) / 100) * math.pi * 2,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.accent != accent ||
        oldDelegate.track != track;
  }
}

class _MiniLineChart extends StatelessWidget {
  final String semanticTitle;
  final List<DashboardPoint> points;
  final double minY;
  final double maxY;
  final Color color;
  final bool showDots;
  final bool bottomLabels;
  final bool moodColors;

  const _MiniLineChart({
    required this.semanticTitle,
    required this.points,
    required this.minY,
    required this.maxY,
    required this.color,
    this.showDots = true,
    this.bottomLabels = false,
    this.moodColors = false,
  });

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Center(
        child: Text(context.l10n.insightsNoData, style: _mutedStyle),
      );
    }
    final spots = [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].value),
    ];
    return Semantics(
      image: true,
      label: _chartSummary(context, semanticTitle, points),
      child: ExcludeSemantics(
        child: LineChart(
          LineChartData(
            minY: minY,
            maxY: maxY,
            gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => const FlLine(
                color: Color(0xFF33322F),
                strokeWidth: 0.8,
                dashArray: [4, 4],
              ),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: bottomLabels,
                  reservedSize: 20,
                  interval: math.max(1, (points.length - 1).toDouble()),
                  getTitlesWidget: (value, meta) {
                    final i = value.round();
                    if (i < 0 || i >= points.length)
                      return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        context.formatMonthDay(points[i].date),
                        style: _mutedStyle.copyWith(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 2.6,
                color: color,
                gradient: moodColors
                    ? LinearGradient(
                        colors: [
                          context.appColors.negative,
                          context.appColors.accent,
                          context.appColors.positive,
                        ],
                      )
                    : null,
                dotData: FlDotData(show: showDots),
                belowBarData: BarAreaData(
                  show: true,
                  color: color.withValues(alpha: 0.08),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  final String semanticTitle;
  final List<DashboardPoint> points;
  final bool bottomLabels;

  const _MiniBarChart({
    required this.semanticTitle,
    required this.points,
    this.bottomLabels = false,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = points.fold<double>(1, (max, p) => math.max(max, p.value));
    if (points.isEmpty) {
      return Center(
        child: Text(context.l10n.insightsNoData, style: _mutedStyle),
      );
    }
    return Semantics(
      image: true,
      label: _chartSummary(context, semanticTitle, points),
      child: ExcludeSemantics(
        child: BarChart(
          BarChartData(
            minY: 0,
            maxY: maxValue + 1,
            gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => const FlLine(
                color: Color(0xFF33322F),
                strokeWidth: 0.8,
                dashArray: [4, 4],
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: bottomLabels,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    final i = value.round();
                    if (i < 0 || i >= points.length)
                      return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        context.formatMonthDay(points[i].date),
                        style: _mutedStyle.copyWith(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: [
              for (var i = 0; i < points.length; i++)
                BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: points[i].value,
                      width: 7,
                      borderRadius: BorderRadius.circular(6),
                      color: context.appColors.accent,
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxValue + 1,
                        color: const Color(0xFF292927),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotHeatmap extends StatelessWidget {
  final String semanticLabel;
  final List<bool> values;
  final Color active;

  const _DotHeatmap({
    required this.semanticLabel,
    required this.values,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox.shrink();
    return Semantics(
      image: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const columns = 10;
          final rows = (values.length / columns).ceil();
          final gap = constraints.maxWidth < 190 ? 5.0 : 7.0;
          final size = ((constraints.maxWidth - gap * (columns - 1)) / columns)
              .clamp(7.0, 12.0);
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (var i = 0; i < rows * columns; i++)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: i < values.length && values[i]
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    borderRadius: i < values.length && values[i]
                        ? null
                        : BorderRadius.circular(2),
                    border: Border.all(
                      color: i < values.length && values[i]
                          ? active
                          : context.appColors.textSecondary,
                    ),
                    color: i < values.length && values[i]
                        ? active
                        : const Color(0xFF31302D),
                    boxShadow: i < values.length && values[i]
                        ? [
                            BoxShadow(
                              color: active.withValues(alpha: 0.25),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _InsightsLoading extends StatelessWidget {
  const _InsightsLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Center(
        child: Semantics(
          liveRegion: true,
          label: context.l10n.insightsLoading,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _InsightsError extends StatelessWidget {
  const _InsightsError();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Semantics(
        liveRegion: true,
        child: Text(context.l10n.insightsLoadError, style: _mutedStyle),
      ),
    );
  }
}

BoxDecoration _premiumDecoration(ThemeData theme, {double radius = 20}) {
  final colors = theme.appColors;
  return BoxDecoration(
    color: colors.card,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: colors.border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.28 : 0.08,
        ),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
      BoxShadow(color: colors.accent.withValues(alpha: 0.035), blurRadius: 28),
    ],
  );
}

TextStyle _screenTitle(ThemeData theme) {
  return TextStyle(
    fontFamily: AppTheme.sansFamily,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -0.2,
    color: theme.colorScheme.onSurface,
  );
}

String _rangeLabel(BuildContext context, AnalyticsDateRange range) {
  return switch (range) {
    AnalyticsDateRange.seven => context.l10n.rangeLastSevenDays,
    AnalyticsDateRange.thirty => context.l10n.rangeLastThirtyDays,
    AnalyticsDateRange.ninety => context.l10n.rangeLastNinetyDays,
    AnalyticsDateRange.year => context.l10n.rangeLastYear,
    AnalyticsDateRange.allTime => context.l10n.rangeAllTime,
    AnalyticsDateRange.custom => context.l10n.rangeCustom,
  };
}

String _chartSummary(
  BuildContext context,
  String title,
  List<DashboardPoint> points,
) {
  final values = points
      .map(
        (point) => context.l10n.insightsChartPoint(
          context.formatMonthDay(point.date),
          context.formatOneDecimal(point.value),
        ),
      )
      .join(', ');
  return context.l10n.insightsChartSummary(title, values);
}

String _ybocsSeverityLabel(BuildContext context, YbocsSeverity severity) {
  return switch (severity) {
    YbocsSeverity.subclinical => context.l10n.ybocsSeveritySubclinical,
    YbocsSeverity.mild => context.l10n.ybocsSeverityMild,
    YbocsSeverity.moderate => context.l10n.ybocsSeverityModerate,
    YbocsSeverity.severe => context.l10n.ybocsSeveritySevere,
    YbocsSeverity.extreme => context.l10n.ybocsSeverityExtreme,
  };
}

String _localizedThemeLabel(BuildContext context, String label) {
  return switch (label) {
    'Contamination' => context.l10n.insightsThemeContamination,
    'Harm' => context.l10n.insightsThemeHarm,
    'Checking' => context.l10n.insightsThemeChecking,
    'Reassurance' => context.l10n.insightsThemeReassurance,
    'Health' => context.l10n.insightsThemeHealth,
    'Relationship' => context.l10n.insightsThemeRelationship,
    'Symmetry' => context.l10n.insightsThemeSymmetry,
    'Moral' => context.l10n.insightsThemeMoral,
    'Rumination' => context.l10n.insightsThemeRumination,
    'Uncertainty' => context.l10n.insightsThemeUncertainty,
    _ => context.l10n.insightsThemeOther,
  };
}

IconData _themeIcon(String label) {
  return switch (label) {
    'Contamination' => LineIcons.flask,
    'Harm' => LineIcons.exclamationTriangle,
    'Checking' => LineIcons.checkCircle,
    'Reassurance' => LineIcons.comments,
    'Health' => LineIcons.heartbeat,
    'Relationship' => LineIcons.heart,
    'Symmetry' => LineIcons.objectGroup,
    'Moral' => LineIcons.balanceScale,
    'Rumination' => LineIcons.syncIcon,
    'Uncertainty' => LineIcons.questionCircle,
    _ => LineIcons.tag,
  };
}

const _themeColors = [
  Color(0xFFA13F3F),
  Color(0xFFFF9F43),
  Color(0xFF5CA7FF),
  Color(0xFF407A52),
];

const _mutedStyle = TextStyle(fontSize: 12, height: 1.25);
