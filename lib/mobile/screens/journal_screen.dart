import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../models/models.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/l10n.dart';
import '../../providers/providers.dart';
import '../../services/analytics_service.dart';
import '../../services/review_prompt.dart';
import '../../services/app_events.dart';
import '../../services/telemetry.dart';
import '../../services/pro_entry_point.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/activity_completion.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/rich_journal.dart';
import '../../widgets/paywall_sheet.dart';
import '../first_run.dart';
import '../preferences.dart';

class TodayScreen extends ConsumerStatefulWidget {
  final VoidCallback onJournal;
  final VoidCallback onTrack;
  final VoidCallback onDelay;
  final VoidCallback onErp;
  final VoidCallback onInsights;
  final VoidCallback onSettings;
  final ValueChanged<RecoveryStep> onNextStep;

  const TodayScreen({
    super.key,
    required this.onJournal,
    required this.onTrack,
    required this.onDelay,
    required this.onErp,
    required this.onInsights,
    required this.onSettings,
    required this.onNextStep,
  });

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    final journalAsync = ref.watch(journalProvider);
    final ocdAsync = ref.watch(ocdProvider);
    final delays = ref.watch(delaySessionProvider).asData?.value ?? const [];
    final erp = ref.watch(erpExerciseSessionProvider).asData?.value ?? const [];
    final steps = ref.watch(exposureStepProvider).asData?.value ?? const [];
    final responses =
        ref.watch(responsePreventionProvider).asData?.value ?? const [];
    final surfs = ref.watch(urgeSurfProvider).asData?.value ?? const [];
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);

    final journals = journalAsync.asData?.value ?? const <JournalEntry>[];
    final ocds = ocdAsync.asData?.value ?? const <OcdEntry>[];
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final hasCheckedIn = journals.any((entry) => entry.date == todayKey);
    final metrics = AnalyticsService.buildRecoveryMetrics(
      delaySessions: delays,
      erpSessions: erp,
      exposureSteps: steps,
      responsePreventionLogs: responses,
      urgeSurfSessions: surfs,
    );
    final dashboard = AnalyticsService.buildRecoveryDashboard(
      journals: journals,
      ocds: ocds,
      delaySessions: delays,
      erpSessions: erp,
      exposureSteps: steps,
      responsePreventionLogs: responses,
      urgeSurfSessions: surfs,
    );
    final recentDelay = _latestDelay(delays);
    final calmSummary = AnalyticsService.buildCalmInsights(
      journals: journals,
      ocds: ocds,
      delaySessions: delays,
      erpSessions: erp,
      exposureSteps: steps,
    );

    // The single recommended next action, mirroring the ERP journey stages so
    // Today always shows one clear thing to do instead of a wall of tools.
    final isPro = ref.watch(proProvider);
    final meaningfulActionCount = ref.watch(meaningfulActionCountProvider);
    final ybocs = ref.watch(ybocsAssessmentProvider).asData?.value ?? const [];
    final hierarchySteps =
        ref.watch(exposureStepProvider).asData?.value ?? const [];
    final now = DateTime.now();
    bool isToday(DateTime d) =>
        d.year == now.year && d.month == now.month && d.day == now.day;
    final practicedToday =
        erp.any((e) => isToday(e.createdAt)) ||
        delays.any((d) => isToday(d.createdAt));
    final nextStep = AnalyticsService.chooseNextStep(
      isPro: isPro,
      hasYbocs: ybocs.isNotEmpty,
      hasHierarchy: hierarchySteps.isNotEmpty,
      practicedToday: practicedToday,
    );
    final localizedNextStep = _localizedNextStep(context, nextStep);
    final dismissedUntilMillis =
        mobilePreferences?.getInt(proCardDismissedUntilKey) ?? 0;
    final showProCard =
        !isPro &&
        meaningfulActionCount >= 2 &&
        DateTime.now().millisecondsSinceEpoch >= dismissedUntilMillis;

    // As soon as the user has done anything real, the home becomes the full,
    // responsive cockpit so their work is reflected back to them. The truly
    // empty state (no practice yet) keeps the calmer first-run Today.
    final hasActivity =
        journals.isNotEmpty ||
        ocds.isNotEmpty ||
        delays.isNotEmpty ||
        erp.isNotEmpty;

    // The numeric practice-progress score stays hidden until there's enough
    // data to be meaningful (a single session would read as a noisy, possibly
    // discouraging number). Until then the card shows a gentle placeholder.
    final enoughForScore = AnalyticsService.hasEnoughForProgress(
      journals: journals,
      ocds: ocds,
      delaySessions: delays,
      erpSessions: erp,
    );

    final children = hasActivity
        ? _establishedChildren(
            metrics: metrics,
            dashboard: dashboard,
            nextStep: localizedNextStep,
            recentDelay: recentDelay,
            hasCheckedIn: hasCheckedIn,
            enoughForScore: enoughForScore,
            showProCard: showProCard,
            calmInsightsEnabled: calmInsightsEnabled,
            calmSummary: calmSummary,
          )
        : _firstRunChildren(hasYbocs: ybocs.isNotEmpty);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              context.appColors.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
            children: staggered(children),
          ),
        ),
      ),
    );
  }

  List<Widget> _establishedChildren({
    required RecoveryMetrics metrics,
    required RecoveryDashboardSummary dashboard,
    required RecoveryNextStep nextStep,
    required DelaySession? recentDelay,
    required bool hasCheckedIn,
    required bool enoughForScore,
    required bool showProCard,
    required bool calmInsightsEnabled,
    required CalmInsightsSummary calmSummary,
  }) {
    final strings = context.l10n;
    return [
      _HomeHeader(
        streak: metrics.practiceStreakDays,
        showStreak: !calmInsightsEnabled && metrics.practiceStreakDays > 0,
        onSettings: widget.onSettings,
      ),
      const SizedBox(height: 18),
      if (calmInsightsEnabled)
        _CalmActivityCard(summary: calmSummary, onTap: widget.onInsights)
      else
        _HomeScoreCard(
          summary: dashboard,
          enoughData: enoughForScore,
          onTap: widget.onInsights,
        ),
      const SizedBox(height: 16),
      _NextStepCard(
        step: nextStep,
        onTap: () => widget.onNextStep(nextStep.step),
      ),
      if (showProCard) ...[
        const SizedBox(height: 12),
        _ProProgressionCard(
          onTap: () => PaywallSheet.show(
            context,
            entryPoint: ProEntryPoint.todayNextStep,
          ),
          onDismiss: () async {
            final until = DateTime.now()
                .add(const Duration(days: 7))
                .millisecondsSinceEpoch;
            await mobilePreferences?.setInt(proCardDismissedUntilKey, until);
            if (mounted) setState(() {});
          },
        ),
      ],
      const SizedBox(height: 20),
      _HomeSectionHeader(
        title: strings.todayContinuePractice,
        actionLabel: strings.todaySeeAllAction,
        onAction: widget.onErp,
      ),
      const SizedBox(height: 10),
      _ContinuePracticeCard(
        recentDelay: recentDelay,
        onResume: recentDelay == null ? widget.onErp : widget.onDelay,
      ),
      const SizedBox(height: 22),
      _HomeSectionHeader(title: strings.todayQuickActions),
      const SizedBox(height: 10),
      _QuickActionGrid(
        onJournal: widget.onJournal,
        onErp: widget.onErp,
        onExposureTools: widget.onErp,
        onInsights: widget.onInsights,
      ),
      const SizedBox(height: 14),
      _DailyCheckInCard(checkedIn: hasCheckedIn, onTap: widget.onJournal),
    ];
  }

  /// The simplified first-run Today: one recommended action echoing what the
  /// user said they needed, three immediate choices, an optional self-check
  /// row, and a calm placeholder where analytics will grow — no score, no
  /// streak, no dense cockpit until there's real data.
  List<Widget> _firstRunChildren({required bool hasYbocs}) {
    final strings = context.l10n;
    final primary = _firstRunPrimary(readFirstRunPath());
    return [
      _HomeHeader(streak: 0, showStreak: false, onSettings: widget.onSettings),
      const SizedBox(height: 18),
      _NextStepCard(step: primary.step, onTap: primary.onTap),
      const SizedBox(height: 22),
      _HomeSectionHeader(title: strings.todayChooseActivity),
      const SizedBox(height: 10),
      _QuickActionTile(
        icon: LineIcons.edit,
        title: strings.todayWriteSomethingTitle,
        subtitle: strings.todayWriteSomethingBody,
        onTap: widget.onTrack,
      ),
      const SizedBox(height: 10),
      _QuickActionTile(
        icon: LineIcons.hourglassHalf,
        title: strings.todayDelayUrgeTitle,
        subtitle: strings.todayDelayUrgeBody,
        onTap: widget.onDelay,
      ),
      const SizedBox(height: 10),
      _QuickActionTile(
        icon: LineIcons.seedling,
        title: strings.todayPracticeErpTitle,
        subtitle: strings.todayPracticeErpBody,
        onTap: widget.onErp,
      ),
      if (!hasYbocs) ...[
        const SizedBox(height: 18),
        _SelfCheckRow(onTap: () => widget.onNextStep(RecoveryStep.selfCheck)),
      ],
      const SizedBox(height: 18),
      const _InsightsPlaceholder(),
    ];
  }

  ({RecoveryNextStep step, VoidCallback onTap}) _firstRunPrimary(
    FirstRunPath? path,
  ) {
    final strings = context.l10n;
    switch (path) {
      case FirstRunPath.journal:
        return (
          step: RecoveryNextStep(
            step: RecoveryStep.journal,
            title: strings.todayFirstJournalTitle,
            subtitle: strings.todayFirstJournalBody,
            ctaLabel: strings.journalNewEntryAction,
          ),
          onTap: widget.onTrack,
        );
      case FirstRunPath.erp:
        return (
          step: RecoveryNextStep(
            step: RecoveryStep.dailyPractice,
            title: strings.todayFirstErpTitle,
            subtitle: strings.todayFirstErpBody,
            ctaLabel: strings.todayStartPracticeAction,
          ),
          onTap: widget.onErp,
        );
      case FirstRunPath.urge:
      case FirstRunPath.selfcheck:
      case FirstRunPath.explore:
      case null:
        return (
          step: RecoveryNextStep(
            step: RecoveryStep.dailyPractice,
            title: strings.todayFirstDelayTitle,
            subtitle: strings.todayFirstDelayBody,
            ctaLabel: strings.todayStartDelayAction,
          ),
          onTap: widget.onDelay,
        );
    }
  }

  RecoveryNextStep _localizedNextStep(BuildContext context, RecoveryStep step) {
    final strings = context.l10n;
    return switch (step) {
      RecoveryStep.selfCheck => RecoveryNextStep(
        step: step,
        title: strings.todayNextSelfCheckTitle,
        subtitle: strings.todayNextSelfCheckBody,
        ctaLabel: strings.todayNextSelfCheckAction,
      ),
      RecoveryStep.buildHierarchy => RecoveryNextStep(
        step: step,
        title: strings.todayNextHierarchyTitle,
        subtitle: strings.todayNextHierarchyBody,
        ctaLabel: strings.todayNextHierarchyAction,
      ),
      RecoveryStep.dailyPractice => RecoveryNextStep(
        step: step,
        title: strings.todayNextPracticeTitle,
        subtitle: strings.todayNextPracticeBody,
        ctaLabel: strings.todayNextPracticeAction,
      ),
      RecoveryStep.reflect => RecoveryNextStep(
        step: step,
        title: strings.todayNextReflectTitle,
        subtitle: strings.todayNextReflectBody,
        ctaLabel: strings.todayNextReflectAction,
      ),
      RecoveryStep.journal => RecoveryNextStep(
        step: step,
        title: strings.todayNextJournalTitle,
        subtitle: strings.todayNextJournalBody,
        ctaLabel: strings.todayNextJournalAction,
      ),
    };
  }

  DelaySession? _latestDelay(List<DelaySession> sessions) {
    DelaySession? latest;
    for (final session in sessions) {
      if (latest == null || session.createdAt.isAfter(latest.createdAt)) {
        latest = session;
      }
    }
    return latest;
  }
}

class _ProProgressionCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _ProProgressionCard({required this.onTap, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      decoration: _homeCardDecoration(Theme.of(context), radius: 18).copyWith(
        border: Border.all(
          color: context.appColors.accent.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.appColors.accent.withValues(alpha: 0.14),
            ),
            child: Icon(
              LineIcons.seedling,
              color: context.appColors.accent,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.todayProTitle,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    strings.todayProBody,
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 12.5,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: strings.todayHideSevenDays,
            onPressed: onDismiss,
            icon: const Icon(Icons.close_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final int streak;
  final VoidCallback onSettings;
  final bool showStreak;

  const _HomeHeader({
    required this.streak,
    required this.onSettings,
    this.showStreak = true,
  });

  @override
  Widget build(BuildContext context) {
    final greeting = _greetingFor(context, DateTime.now());
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            greeting,
            style: TextStyle(
              fontFamily: AppTheme.sansFamily,
              fontSize: 23,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
              color: context.appColors.accent,
              height: 1.12,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.todayEncouragement,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 14,
            height: 1.25,
          ),
        ),
      ],
    );
    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showStreak) ...[
          Semantics(
            label: context.l10n.recoveryMetricsDayStreak(streak),
            excludeSemantics: true,
            child: Container(
              constraints: const BoxConstraints(minHeight: 44),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: _homeCardDecoration(Theme.of(context), radius: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: context.appColors.accent,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$streak',
                    style: TextStyle(
                      color: context.appColors.accent,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        PressScale(
          onTap: onSettings,
          child: Semantics(
            button: true,
            label: context.l10n.settingsTitle,
            excludeSemantics: true,
            child: Container(
              key: const ValueKey('today-settings-action'),
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              alignment: Alignment.center,
              decoration: _homeCardDecoration(Theme.of(context), radius: 16),
              child: Icon(
                LineIcons.cog,
                color: context.appColors.textSecondary,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );

    if (_usesLargeText(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: actions),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: heading),
        const SizedBox(width: 12),
        actions,
      ],
    );
  }

  String _greetingFor(BuildContext context, DateTime now) {
    final strings = context.l10n;
    if (now.hour < 12) return strings.todayGreetingMorning;
    if (now.hour < 17) return strings.todayGreetingAfternoon;
    return strings.todayGreetingEvening;
  }
}

class _CalmActivityCard extends StatelessWidget {
  final CalmInsightsSummary summary;
  final VoidCallback onTap;

  const _CalmActivityCard({required this.summary, required this.onTap});

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
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: strings.calmRecentActivityTitle,
      value: facts.isEmpty ? strings.calmNoRecentActivity : facts.join(', '),
      child: Material(
        color: context.appColors.card,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LineIcons.leaf,
                      color: context.appColors.accent,
                      semanticLabel: null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        strings.calmRecentActivityTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const ExcludeSemantics(child: Icon(LineIcons.angleRight)),
                  ],
                ),
                const SizedBox(height: 12),
                if (facts.isEmpty)
                  Text(
                    strings.calmNoRecentActivity,
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  for (final fact in facts)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 7, right: 8),
                            child: ExcludeSemantics(
                              child: Icon(Icons.circle, size: 5),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              fact,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeScoreCard extends StatelessWidget {
  final RecoveryDashboardSummary summary;
  final VoidCallback onTap;

  /// Whether there's enough real data for the number to be meaningful. Until
  /// then we show a gentle placeholder instead of a noisy single-session score.
  final bool enoughData;

  const _HomeScoreCard({
    required this.summary,
    required this.onTap,
    this.enoughData = true,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    if (!enoughData) return _buildPlaceholder(context);
    Telemetry.logOnce('score.first_shown');
    final score = summary.recoveryScore;
    final label = _scoreLabel(strings, score, summary.hasAnyData);
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.todayPracticeProgress.toUpperCase(),
          style: TextStyle(
            color: context.appColors.accent,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          summary.hasAnyData
              ? strings.todaySteadyPractice
              : strings.todayStartGently,
          style: TextStyle(
            color: context.appColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          summary.hasAnyData
              ? strings.todayPracticeActiveBody
              : strings.todayPracticeEmptyBody,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 13,
            height: 1.34,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          _deltaText(strings, summary.scoreDelta.value, summary.hasAnyData),
          style: TextStyle(
            color: context.appColors.accent,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
    final ring = _HomeScoreRing(score: score, label: label);
    final summaryLayout = _usesLargeText(context)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ring, const SizedBox(height: 16), details],
          )
        : Row(
            children: [
              ring,
              const SizedBox(width: 18),
              Expanded(child: details),
              const SizedBox(width: 8),
              ExcludeSemantics(
                child: Icon(
                  LineIcons.angleRight,
                  color: context.appColors.textSecondary,
                ),
              ),
            ],
          );
    return Semantics(
      button: true,
      label: strings.todayScoreA11y(score, label),
      hint: strings.todayInsightsBody,
      child: PressScale(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: _homeCardDecoration(Theme.of(context), radius: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              summaryLayout,
              const SizedBox(height: 14),
              Text(
                strings.todayProgressDisclaimer,
                style: TextStyle(
                  color: context.appColors.textSecondary.withValues(alpha: 0.8),
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final strings = context.l10n;
    return Semantics(
      button: true,
      label: strings.todayPracticeProgress,
      hint: strings.todayInsightsBody,
      child: PressScale(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: _homeCardDecoration(Theme.of(context), radius: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.todayPracticeProgress.toUpperCase(),
                style: TextStyle(
                  color: context.appColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                strings.todayProgressStartedTitle,
                style: TextStyle(
                  color: context.appColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  height: 1.18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                strings.todayProgressPendingBody,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontSize: 13,
                  height: 1.34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _scoreLabel(AppLocalizations strings, int score, bool hasData) {
    if (!hasData) return strings.todayScoreNew;
    if (score >= 80) return strings.todayScoreStrong;
    if (score >= 60) return strings.todayScoreSteady;
    if (score >= 40) return strings.todayScoreBuilding;
    return strings.todayScoreStarting;
  }

  String _deltaText(AppLocalizations strings, double delta, bool hasData) {
    if (!hasData) return strings.todayBeginCheckIn;
    final rounded = delta.round();
    if (rounded == 0) return strings.todayNoChange;
    return rounded > 0
        ? strings.todayPointsUp(rounded.abs())
        : strings.todayPointsDown(rounded.abs());
  }
}

class _HomeScoreRing extends StatelessWidget {
  final int score;
  final String label;

  const _HomeScoreRing({required this.score, required this.label});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.todayScoreA11y(score, label),
      excludeSemantics: true,
      child: SizedBox(
        width: 108,
        height: 108,
        child: CustomPaint(
          painter: _HomeScoreRingPainter(
            score,
            accent: context.appColors.accent,
            trackColor: context.appColors.border,
          ),
          child: MediaQuery.withClampedTextScaling(
            maxScaleFactor: 1.2,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$score',
                    style: TextStyle(
                      color: context.appColors.textPrimary,
                      fontSize: 31,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: context.appColors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeScoreRingPainter extends CustomPainter {
  final int score;
  final Color accent;
  final Color trackColor;

  _HomeScoreRingPainter(
    this.score, {
    required this.accent,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 8;
    final track = Paint()
      ..color = trackColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final progress = Paint()
      ..shader = SweepGradient(
        colors: [accent, const Color(0xFFFFE994), accent],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      (score.clamp(0, 100) / 100) * math.pi * 2,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(covariant _HomeScoreRingPainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.accent != accent ||
        oldDelegate.trackColor != trackColor;
  }
}

class _NextStepCard extends StatelessWidget {
  final RecoveryNextStep step;
  final VoidCallback onTap;

  const _NextStepCard({required this.step, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: step.title,
      hint: step.subtitle,
      child: PressScale(
        onTap: onTap,
        child: Container(
          key: const ValueKey('today-next-step-card'),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: nextStepCardGradientColors(theme),
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: context.appColors.accent.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.todayNextStep.toUpperCase(),
                style: TextStyle(
                  color: context.appColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                step.title,
                style: TextStyle(
                  color: context.appColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                step.subtitle,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontSize: 13,
                  height: 1.34,
                ),
              ),
              const SizedBox(height: 14),
              if (_usesLargeText(context))
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(44, 44),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(step.ctaLabel, textAlign: TextAlign.center),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(44, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(step.ctaLabel),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
List<Color> nextStepCardGradientColors(ThemeData theme) {
  if (theme.brightness == Brightness.dark) {
    return const [Color(0xFF23200F), Color(0xFF15140F)];
  }

  final colors = theme.appColors;
  return [
    Color.alphaBlend(colors.accent.withValues(alpha: 0.12), colors.card),
    colors.card,
  ];
}

class _HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _HomeSectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: context.appColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (actionLabel != null && onAction != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              minimumSize: const Size(44, 44),
              foregroundColor: context.appColors.accent,
            ),
            child: Text(
              actionLabel!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ),
      ],
    );
  }
}

class _ContinuePracticeCard extends StatelessWidget {
  final DelaySession? recentDelay;
  final VoidCallback onResume;

  const _ContinuePracticeCard({
    required this.recentDelay,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final session = recentDelay;
    final hasSession = session != null;
    final progress = hasSession && session.plannedSeconds > 0
        ? (session.actualSeconds / session.plannedSeconds).clamp(0.0, 1.0)
        : 0.58;
    final elapsed = hasSession ? _formatSeconds(session.actualSeconds) : '2:30';
    final planned = hasSession
        ? _formatSeconds(session.plannedSeconds)
        : '5:00';

    final timerLabel = strings.todayTimerA11y(elapsed, planned);
    final progressGraphic = Semantics(
      label: timerLabel,
      excludeSemantics: true,
      child: SizedBox(
        width: 60,
        height: 60,
        child: CustomPaint(
          painter: _MiniProgressPainter(
            progress,
            accent: context.appColors.accent,
            trackColor: context.appColors.border,
          ),
          child: Center(
            child: Icon(
              LineIcons.clock,
              color: context.appColors.accent,
              size: 22,
            ),
          ),
        ),
      ),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasSession ? strings.todayCompulsionDelay : strings.todayStartErp,
          style: TextStyle(
            color: context.appColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hasSession
              ? strings.todayResistUrgeBody
              : strings.todayBuildToleranceBody,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 12,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        Semantics(
          label: timerLabel,
          excludeSemantics: true,
          child: _usesLargeText(context)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: context.appColors.border,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.appColors.accent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$elapsed / $planned',
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: context.appColors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.appColors.accent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$elapsed / $planned',
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
    final action = ElevatedButton(
      onPressed: onResume,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        hasSession ? strings.todayResumeAction : strings.todayStartAction,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _homeCardDecoration(Theme.of(context), radius: 18),
      child: _usesLargeText(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    progressGraphic,
                    const SizedBox(width: 16),
                    Expanded(child: details),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(width: double.infinity, child: action),
              ],
            )
          : Row(
              children: [
                progressGraphic,
                const SizedBox(width: 16),
                Expanded(child: details),
                const SizedBox(width: 12),
                action,
              ],
            ),
    );
  }

  String _formatSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainder = seconds % 60;
    return '$minutes:${remainder.toString().padLeft(2, '0')}';
  }
}

class _MiniProgressPainter extends CustomPainter {
  final double progress;
  final Color accent;
  final Color trackColor;

  _MiniProgressPainter(
    this.progress, {
    required this.accent,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 5;
    final track = Paint()
      ..color = trackColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final active = Paint()
      ..color = accent
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      progress.clamp(0.0, 1.0) * math.pi * 2,
      false,
      active,
    );
  }

  @override
  bool shouldRepaint(covariant _MiniProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.accent != accent ||
        oldDelegate.trackColor != trackColor;
  }
}

class _QuickActionGrid extends StatelessWidget {
  final VoidCallback onJournal;
  final VoidCallback onErp;
  final VoidCallback onExposureTools;
  final VoidCallback onInsights;

  const _QuickActionGrid({
    required this.onJournal,
    required this.onErp,
    required this.onExposureTools,
    required this.onInsights,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final journal = _QuickActionTile(
      icon: LineIcons.edit,
      title: strings.navJournal,
      subtitle: strings.todayJournalBody,
      onTap: onJournal,
    );
    final erp = _QuickActionTile(
      icon: LineIcons.bullseye,
      title: strings.todayStartErp,
      subtitle: strings.todayBuildToleranceBody,
      onTap: onErp,
    );
    final exposure = _QuickActionTile(
      icon: LineIcons.layerGroup,
      title: strings.todayExposureTools,
      subtitle: strings.todayExposureToolsBody,
      onTap: onExposureTools,
    );
    final insights = _QuickActionTile(
      icon: LineIcons.barChart,
      title: strings.navInsights,
      subtitle: strings.todayInsightsBody,
      onTap: onInsights,
    );
    if (_usesLargeText(context)) {
      return Column(
        children: [
          journal,
          const SizedBox(height: 10),
          erp,
          const SizedBox(height: 10),
          exposure,
          const SizedBox(height: 10),
          insights,
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: journal),
            const SizedBox(width: 10),
            Expanded(child: erp),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: exposure),
            const SizedBox(width: 10),
            Expanded(child: insights),
          ],
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: title,
      hint: subtitle,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 98),
          padding: const EdgeInsets.all(14),
          decoration: _homeCardDecoration(Theme.of(context), radius: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: context.appColors.accent, size: 27),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: context.appColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 11.5,
                        height: 1.18,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                LineIcons.angleRight,
                color: context.appColors.textSecondary,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Quiet, optional entry to the self-check on the first-run Today — never a
/// forced first action, and clearly labelled optional.
class _SelfCheckRow extends StatelessWidget {
  final VoidCallback onTap;

  const _SelfCheckRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Semantics(
      button: true,
      label: strings.todaySelfCheckTitle,
      hint: strings.todaySelfCheckDuration,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: _homeCardDecoration(Theme.of(context), radius: 16),
          child: Row(
            children: [
              Icon(
                LineIcons.clipboardList,
                color: context.appColors.textSecondary,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.todaySelfCheckTitle,
                      style: TextStyle(
                        color: context.appColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      strings.todaySelfCheckDuration,
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                LineIcons.angleRight,
                color: context.appColors.textSecondary,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Calm placeholder shown where analytics live, before there is any data to
/// summarise. Keeps the honesty promise: no fabricated numbers up front.
class _InsightsPlaceholder extends StatelessWidget {
  const _InsightsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _homeCardDecoration(Theme.of(context), radius: 16),
      child: Row(
        children: [
          Icon(
            LineIcons.lineChart,
            color: context.appColors.textSecondary.withValues(alpha: 0.8),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.todayInsightsPlaceholder,
              style: TextStyle(
                color: context.appColors.textSecondary,
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyCheckInCard extends StatelessWidget {
  final bool checkedIn;
  final VoidCallback onTap;

  const _DailyCheckInCard({required this.checkedIn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          checkedIn
              ? strings.todayDailyCheckInComplete
              : strings.todayDailyCheckIn,
          style: TextStyle(
            color: context.appColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          checkedIn ? strings.todayDailyCompleteBody : strings.todayDailyBody,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 12,
            height: 1.25,
          ),
        ),
      ],
    );
    final action = ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        checkedIn ? strings.todayOpenAction : strings.todayCheckInAction,
      ),
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _homeCardDecoration(Theme.of(context), radius: 18),
      child: _usesLargeText(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                details,
                const SizedBox(height: 14),
                SizedBox(width: double.infinity, child: action),
              ],
            )
          : Row(
              children: [
                ExcludeSemantics(
                  child: Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.appColors.positive.withValues(alpha: 0.12),
                    ),
                    child: Icon(
                      Icons.eco_rounded,
                      color: context.appColors.positive,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(child: details),
                const SizedBox(width: 12),
                action,
              ],
            ),
    );
  }
}

BoxDecoration _homeCardDecoration(ThemeData theme, {double radius = 20}) {
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
        blurRadius: 24,
        offset: const Offset(0, 12),
      ),
      BoxShadow(color: colors.accent.withValues(alpha: 0.035), blurRadius: 30),
    ],
  );
}

bool _usesLargeText(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(1) >= 1.5;

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(journalSearchQueryProvider);
    if (_searchController.text.isNotEmpty) _isSearching = true;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _enterSearch() {
    setState(() => _isSearching = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  void _exitSearch() {
    _searchFocus.unfocus();
    _searchController.clear();
    ref.read(journalSearchQueryProvider.notifier).query = '';
    setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final entriesAsync = ref.watch(filteredJournalProvider);
    final reduceMotion = motionDisabled(context);
    final textScale = MediaQuery.textScalerOf(context).scale(1);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: AnimatedSwitcher(
                duration: reduceMotion ? Duration.zero : AppMotion.fast,
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: _isSearching
                    ? _InlineSearchBar(
                        key: const ValueKey('search'),
                        controller: _searchController,
                        focusNode: _searchFocus,
                        onChanged: (value) =>
                            ref
                                    .read(journalSearchQueryProvider.notifier)
                                    .query =
                                value,
                        onCancel: _exitSearch,
                      )
                    : Row(
                        key: const ValueKey('header'),
                        children: [
                          Expanded(
                            child: Text(
                              strings.journalTitle,
                              style: _screenTitle(theme),
                            ),
                          ),
                          _RoundIconButton(
                            icon: LineIcons.search,
                            semanticLabel: strings.journalSearchAction,
                            onTap: _enterSearch,
                          ),
                          const SizedBox(width: 10),
                          _RoundIconButton(
                            icon: LineIcons.calendar,
                            semanticLabel: strings.journalChooseDateAction,
                            onTap: () => _pickDate(context),
                          ),
                        ],
                      ),
              ),
            ),
            AnimatedSize(
              duration: reduceMotion ? Duration.zero : AppMotion.fast,
              curve: Curves.easeOutCubic,
              child: _isSearching
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 64 + ((textScale - 1).clamp(0, 1) * 32),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final date = DateTime.now().subtract(
                            Duration(days: index),
                          );
                          return _DatePill(
                            date: date,
                            isToday: index == 0,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => JournalEntryEditor(date: date),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemCount: 10,
                      ),
                    ),
            ),
            Expanded(
              child: entriesAsync.when(
                data: (entries) {
                  final sorted = List<JournalEntry>.from(entries)
                    ..sort((a, b) => b.date.compareTo(a.date));
                  final query = ref.watch(journalSearchQueryProvider);
                  final todayKey = DateFormat(
                    'yyyy-MM-dd',
                  ).format(DateTime.now());
                  final hasTodayEntry = entries.any(
                    (entry) => entry.date == todayKey,
                  );
                  final children = <Widget>[
                    // The shortcut card is only useful before today's entry
                    // exists - once saved, it sits at the top of the list.
                    if (!_isSearching && !hasTodayEntry) ...[
                      _TodayEntryCard(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                JournalEntryEditor(date: DateTime.now()),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (sorted.isEmpty)
                      _EmptyState(
                        icon: _isSearching && query.isNotEmpty
                            ? LineIcons.search
                            : LineIcons.penNib,
                        title: _isSearching && query.isNotEmpty
                            ? strings.journalNoMatchesTitle
                            : strings.journalEmptyTitle,
                        body: _isSearching && query.isNotEmpty
                            ? strings.journalNoMatchesBody(query)
                            : strings.journalEmptyBody,
                      )
                    else
                      ...sorted.map((entry) => _JournalListCard(entry: entry)),
                  ];
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 116),
                    children: staggered(children),
                  );
                },
                loading: () => Center(
                  child: Semantics(
                    liveRegion: true,
                    label: strings.journalLoadingLabel,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) => Center(
                  child: Semantics(
                    liveRegion: true,
                    child: Text(strings.journalLoadError),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _DatePickerSheet(initialDate: DateTime.now()),
    );
    if (picked == null || !context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => JournalEntryEditor(date: picked)),
    );
  }
}

class _InlineSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onCancel;

  const _InlineSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onCancel,
  });

  @override
  State<_InlineSearchBar> createState() => _InlineSearchBarState();
}

class _InlineSearchBarState extends State<_InlineSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChange);
    super.dispose();
  }

  void _onControllerChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 44),
            decoration: _softDecoration(theme, radius: 18),
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              children: [
                Icon(
                  LineIcons.search,
                  size: 18,
                  color: context.appColors.textSecondary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    onChanged: widget.onChanged,
                    textInputAction: TextInputAction.search,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: context.l10n.journalSearchHint,
                      hintStyle: TextStyle(
                        color: context.appColors.textSecondary.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (widget.controller.text.isNotEmpty)
                  IconButton(
                    tooltip: context.l10n.journalClearSearchAction,
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged('');
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: context.appColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: widget.onCancel,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: const Size(44, 44),
            foregroundColor: theme.colorScheme.primary,
          ),
          child: Text(
            context.l10n.cancelAction,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class JournalEntryEditor extends ConsumerStatefulWidget {
  final DateTime date;

  const JournalEntryEditor({super.key, required this.date});

  @override
  ConsumerState<JournalEntryEditor> createState() => _JournalEntryEditorState();
}

class _JournalEntryEditorState extends ConsumerState<JournalEntryEditor> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  bool _loaded = false;
  bool _saving = false;
  bool _saved = true;
  String _savedSnapshot = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onDocumentChanged);
  }

  void _onDocumentChanged() {
    // Compare against the last-saved snapshot so cursor/selection moves don't
    // flip the indicator to "Unsaved" - only real content edits do.
    if (!_loaded) return;
    final saved = storedFromDocument(_controller.document) == _savedSnapshot;
    if (saved != _saved) setState(() => _saved = saved);
  }

  @override
  void dispose() {
    _controller.removeListener(_onDocumentChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(journalProvider);
    final theme = Theme.of(context);
    final strings = context.l10n;
    final reduceMotion = motionDisabled(context);
    final dateKey = DateFormat('yyyy-MM-dd').format(widget.date);
    final hasExistingEntry =
        entriesAsync.asData?.value.any((entry) => entry.date == dateKey) ??
        false;

    entriesAsync.whenData((entries) {
      if (_loaded) return;
      final existing = entries
          .where((entry) => entry.date == dateKey)
          .firstOrNull;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _controller.document = documentFromStored(existing?.content ?? '');
        _controller.moveCursorToEnd();
        _savedSnapshot = storedFromDocument(_controller.document);
        setState(() {
          _loaded = true;
          _saved = true;
        });
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final largeText =
                      MediaQuery.textScalerOf(context).scale(1) > 1.3;
                  final backButton = IconButton(
                    tooltip: strings.backAction,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(LineIcons.angleLeft),
                  );
                  final title = Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.formatFullDate(widget.date),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Semantics(
                          liveRegion: true,
                          child: AnimatedSwitcher(
                            duration: reduceMotion
                                ? Duration.zero
                                : AppMotion.fast,
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: SizeTransition(
                                    sizeFactor: animation,
                                    axisAlignment: -1,
                                    child: child,
                                  ),
                                ),
                            child: Text(
                              _saving
                                  ? strings.journalSavingStatus
                                  : (_saved
                                        ? strings.journalSavedStatus
                                        : strings.journalUnsavedStatus),
                              key: ValueKey(
                                _saving
                                    ? 'saving'
                                    : (_saved ? 'saved' : 'unsaved'),
                              ),
                              style: _muted(theme, 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  final actions = <Widget>[
                    if (hasExistingEntry)
                      IconButton(
                        tooltip: strings.journalClearDayAction,
                        onPressed: _saving ? null : _confirmReset,
                        icon: const Icon(LineIcons.trash),
                        color: context.appColors.textSecondary,
                      ),
                    TextButton(
                      onPressed: (_saving || _saved) ? null : _save,
                      child: Text(strings.journalSaveAction),
                    ),
                  ];
                  if (largeText || constraints.maxWidth < 360) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [backButton, title]),
                        Padding(
                          padding: const EdgeInsets.only(left: 48),
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            spacing: 8,
                            runSpacing: 4,
                            children: actions,
                          ),
                        ),
                      ],
                    );
                  }
                  return Row(children: [backButton, title, ...actions]);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                child: Semantics(
                  container: true,
                  textField: true,
                  label: strings.journalEditorLabel,
                  hint: strings.journalEditorHint,
                  child: QuillEditor.basic(
                    controller: _controller,
                    focusNode: _focusNode,
                    config: QuillEditorConfig(
                      autoFocus: true,
                      expands: true,
                      placeholder: strings.journalStartWritingPlaceholder,
                      customStyles: _editorStyles(theme),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor.withValues(alpha: 0.6),
                  ),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final stacked =
                      MediaQuery.textScalerOf(context).scale(1) > 1.3 ||
                      constraints.maxWidth < 340;
                  final toolbar = JournalFormatToolbar(controller: _controller);
                  final guidance = Text(
                    strings.journalFormatSelectionHint,
                    style: _muted(theme, 11),
                  );
                  if (stacked) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [toolbar, const SizedBox(height: 4), guidance],
                    );
                  }
                  return Row(
                    children: [
                      toolbar,
                      const Spacer(),
                      Flexible(child: guidance),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DefaultStyles _editorStyles(ThemeData theme) {
    final base = TextStyle(
      fontFamily: AppTheme.sansFamily,
      fontSize: 19,
      height: 1.65,
      letterSpacing: -0.1,
      color: theme.colorScheme.onSurface,
    );
    return DefaultStyles(
      paragraph: DefaultTextBlockStyle(
        base,
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(0, 0),
        const VerticalSpacing(0, 0),
        null,
      ),
      placeHolder: DefaultTextBlockStyle(
        base.copyWith(
          color: context.appColors.textSecondary.withValues(alpha: 0.5),
        ),
        const HorizontalSpacing(0, 0),
        const VerticalSpacing(0, 0),
        const VerticalSpacing(0, 0),
        null,
      ),
    );
  }

  Future<void> _confirmReset() async {
    final cleared = await confirmClearJournalDay(context, ref, widget.date);
    if (!cleared || !mounted) return;
    // The editor is still open on a day that no longer has an entry, so reset
    // the document before leaving or the unsaved-changes guard will fire.
    _controller.document = Document();
    _savedSnapshot = storedFromDocument(_controller.document);
    setState(() => _saved = true);
    final message = context.l10n.journalClearedMessage;
    Navigator.pop(context);
    showAppSnackBar(context, message, type: ToastType.success);
  }

  Future<void> _save() async {
    if (_controller.document.toPlainText().trim().isEmpty) {
      showAppSnackBar(
        context,
        context.l10n.journalNothingToSaveMessage,
        type: ToastType.info,
      );
      return;
    }
    final dateKey = DateFormat('yyyy-MM-dd').format(widget.date);
    final isNew =
        !(ref.read(journalProvider).asData?.value ?? const <JournalEntry>[])
            .any((entry) => entry.date == dateKey);
    setState(() => _saving = true);
    await ref
        .read(journalProvider.notifier)
        .saveEntry(dateKey, storedFromDocument(_controller.document));
    if (!mounted) return;
    _savedSnapshot = storedFromDocument(_controller.document);
    setState(() {
      _saving = false;
      _saved = true;
    });
    // Milestone only — the entry itself never leaves the device or the DB.
    if (isNew) AppEvents.logFirstJournalEntryCreated();
    await ReviewPromptService.recordJournalSaved();
    if (!mounted) return;
    await showQuietCompletion(
      context,
      const ActivityCompletionResult(ActivityCompletionKind.journal),
    );
    if (mounted) returnToNeutralHome(context);
  }
}

/// Confirms and then clears everything saved for [date].
///
/// Shared by the editor's bin button and a long press on a list card, so an
/// entry that landed on the wrong date can be cleared without opening it, and
/// both routes use one wording and one confirmation.
///
/// Returns true only when the day was actually deleted. Callers own their own
/// feedback, because the editor also has to reset its document and pop.
Future<bool> confirmClearJournalDay(
  BuildContext context,
  WidgetRef ref,
  DateTime date,
) async {
  final formattedDate = context.formatFullDate(date);
  final confirmed =
      await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) => _BottomPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sheetContext.l10n.journalClearDayTitle,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Text(
                sheetContext.l10n.journalClearDayBody(formattedDate),
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final stacked =
                      MediaQuery.textScalerOf(context).scale(1) > 1.3 ||
                      constraints.maxWidth < 320;
                  final buttonWidth = stacked
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 12) / 2;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: buttonWidth,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(sheetContext, false),
                          child: Text(sheetContext.l10n.journalKeepEntryAction),
                        ),
                      ),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(sheetContext, true),
                          child: Text(sheetContext.l10n.journalClearDayAction),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ) ??
      false;

  if (!confirmed) return false;
  final dateKey = DateFormat('yyyy-MM-dd').format(date);
  await ref.read(journalProvider.notifier).deleteEntry(dateKey);
  return true;
}

class _JournalListCard extends ConsumerWidget {
  final JournalEntry entry;

  const _JournalListCard({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final date = DateTime.parse(entry.date);
    final formattedDate = context.formatFullDate(date);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _Card(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => JournalEntryEditor(date: date),
          ),
        ),
        onLongPress: () async {
          final cleared = await confirmClearJournalDay(context, ref, date);
          if (!cleared || !context.mounted) return;
          showAppSnackBar(
            context,
            context.l10n.journalClearedMessage,
            type: ToastType.success,
          );
        },
        semanticHint: context.l10n.journalOpenEntryHint(formattedDate),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.formatMonthDay(date),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              richPreviewSpan(
                entry.content,
                _muted(theme, 14).copyWith(height: 1.45),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayEntryCard extends StatelessWidget {
  final VoidCallback onTap;

  const _TodayEntryCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _Card(
      onTap: onTap,
      semanticHint: context.l10n.journalOpenEntryHint(
        context.formatFullDate(DateTime.now()),
      ),
      child: Row(
        children: [
          Icon(LineIcons.penNib, color: theme.colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              context.l10n.journalTodayEntry,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Icon(LineIcons.angleRight, color: context.appColors.textSecondary),
        ],
      ),
    );
  }
}

class _DatePill extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final VoidCallback onTap;

  const _DatePill({
    required this.date,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    final weekday = context.formatShortWeekday(date);
    final monthDay = context.formatMonthDay(date);
    final formattedDate = context.formatFullDate(date);
    final textScale = MediaQuery.textScalerOf(context).scale(1);

    final fillColor = isToday
        ? accent.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.04);
    final borderColor = isToday
        ? accent.withValues(alpha: 0.55)
        : theme.dividerColor.withValues(alpha: 0.6);
    final topColor = isToday
        ? accent.withValues(alpha: 0.85)
        : theme.colorScheme.onSurface.withValues(alpha: 0.55);
    final bottomColor = isToday ? accent : theme.colorScheme.onSurface;

    return Semantics(
      button: true,
      label: isToday ? context.l10n.journalTodayEntry : formattedDate,
      hint: context.l10n.journalOpenEntryHint(formattedDate),
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: Container(
          width: 88 + ((textScale - 1).clamp(0, 1) * 32),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isToday ? context.l10n.navToday : weekday,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontFamily: AppTheme.sansFamily,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  height: 1.1,
                  color: topColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                monthDay,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontFamily: AppTheme.sansFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                  height: 1.1,
                  color: bottomColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DatePickerSheet extends StatefulWidget {
  final DateTime initialDate;

  const _DatePickerSheet({required this.initialDate});

  @override
  State<_DatePickerSheet> createState() => _DatePickerSheetState();
}

class _DatePickerSheetState extends State<_DatePickerSheet> {
  late DateTime _date = widget.initialDate;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.78;

    return _BottomPanel(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.journalChooseDateAction,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              CalendarDatePicker(
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                onDateChanged: (date) => _date = date,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _date),
                  child: Text(context.l10n.journalOpenEntryAction),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;

  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: _softDecoration(theme, radius: 18),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? semanticHint;

  const _Card({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.semanticHint,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.all(20),
      decoration: _softDecoration(Theme.of(context), radius: 24),
      child: child,
    );

    if (onTap == null && onLongPress == null) return content;
    return Semantics(
      button: onTap != null,
      hint: semanticHint,
      child: PressScale(onTap: onTap, onLongPress: onLongPress, child: content),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  final Widget child;

  const _BottomPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: child,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 42),
      child: Column(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary.withValues(alpha: 0.75),
            size: 38,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(body, textAlign: TextAlign.center, style: _muted(theme, 14)),
        ],
      ),
    );
  }
}

TextStyle _screenTitle(ThemeData theme) {
  return TextStyle(
    fontFamily: AppTheme.sansFamily,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
    color: theme.colorScheme.onSurface,
  );
}

TextStyle _muted(ThemeData theme, double size) {
  return TextStyle(color: theme.appColors.textSecondary, fontSize: size);
}

BoxDecoration _softDecoration(ThemeData theme, {required double radius}) {
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.9)),
  );
}
