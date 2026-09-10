import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../l10n/l10n.dart';
import '../../providers/providers.dart';
import '../../services/analytics_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animations.dart';
import '../../widgets/paywall_sheet.dart';
import '../../services/pro_entry_point.dart';
import '../preferences.dart';
import '../widgets/pro_gate.dart';
import '../widgets/section_intro.dart';

BoxDecoration _softDecoration(ThemeData theme, {double radius = 22}) {
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor),
  );
}

/// Standalone screen reached from the Recovery hub (Pro unlocked).
class RecoveryMetricsScreen extends StatelessWidget {
  const RecoveryMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
          children: staggered([
            Row(
              children: [
                _CircleBackButton(onTap: () => Navigator.of(context).pop()),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.l10n.recoveryMetricsTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'recoveryMetrics'),
            const RecoveryMetricsView(),
          ]),
        ),
      ),
    );
  }
}

/// The Pro section dropped into the Insights tab - handles the lock state.
class RecoveryMetricsSection extends ConsumerWidget {
  const RecoveryMetricsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isPro = ref.watch(proProvider);
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              context.l10n.recoveryMetricsTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            if (!isPro) const ProLockBadge(),
          ],
        ),
        const SizedBox(height: 12),
        if (isPro)
          const RecoveryMetricsView()
        else
          _LockedTeaser(
            calmInsightsEnabled: calmInsightsEnabled,
            onTap: () => PaywallSheet.show(
              context,
              entryPoint: ProEntryPoint.recoveryMetrics,
            ),
          ),
      ],
    );
  }
}

class _LockedTeaser extends StatelessWidget {
  final VoidCallback onTap;
  final bool calmInsightsEnabled;

  const _LockedTeaser({required this.onTap, required this.calmInsightsEnabled});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PressScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: _softDecoration(theme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(LineIcons.fire, color: theme.colorScheme.primary, size: 26),
            const SizedBox(height: 12),
            Text(
              context.l10n.recoveryMetricsTeaserTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              calmInsightsEnabled
                  ? context.l10n.recoveryMetricsCalmTeaserBody
                  : context.l10n.recoveryMetricsDetailedTeaserBody,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: onTap,
                child: Text(context.l10n.recoveryMetricsUnlockPro),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The metrics content itself. Assumes Pro (or a context where showing it is
/// fine); does no gating of its own.
class RecoveryMetricsView extends ConsumerWidget {
  const RecoveryMetricsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);
    final delays = ref.watch(delaySessionProvider).asData?.value ?? const [];
    final erp = ref.watch(erpExerciseSessionProvider).asData?.value ?? const [];
    final steps = ref.watch(exposureStepProvider).asData?.value ?? const [];
    final responses =
        ref.watch(responsePreventionProvider).asData?.value ?? const [];
    final surfs = ref.watch(urgeSurfProvider).asData?.value ?? const [];

    final metrics = AnalyticsService.buildRecoveryMetrics(
      delaySessions: delays,
      erpSessions: erp,
      exposureSteps: steps,
      responsePreventionLogs: responses,
      urgeSurfSessions: surfs,
    );

    if (!metrics.hasAnyData) {
      return _EmptyMetrics(calmInsightsEnabled: calmInsightsEnabled);
    }

    return Column(
      children: [
        if (!calmInsightsEnabled) ...[
          _StreakCard(days: metrics.practiceStreakDays),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: Icons.stairs_rounded,
                value: metrics.exposuresCompleted.toDouble(),
                label: context.l10n.recoveryMetricsExposuresDone,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                icon: Icons.self_improvement_rounded,
                value: metrics.sessionsPracticed.toDouble(),
                label: context.l10n.recoveryMetricsSessionsPracticed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _MetricCard(
          icon: Icons.trending_down_rounded,
          value: metrics.avgUrgeReduction,
          fractionDigits: 1,
          label: context.l10n.recoveryMetricsAverageUrgeDrop,
          fullWidth: true,
        ),
        if (!calmInsightsEnabled) ...[
          const SizedBox(height: 12),
          _WeeklyStrip(activity: metrics.weeklyActivity),
        ],
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  final int days;
  const _StreakCard({required this.days});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withValues(alpha: 0.14),
            ),
            child: Icon(
              LineIcons.fire,
              color: theme.colorScheme.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.recoveryMetricsDayStreak(days),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final double value;
  final int fractionDigits;
  final String label;
  final bool fullWidth;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    this.fractionDigits = 0,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: _softDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(height: 14),
          AnimatedCounter(
            value: value,
            fractionDigits: fractionDigits,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: context.appColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyStrip extends StatelessWidget {
  final List<bool> activity; // oldest → today
  const _WeeklyStrip({required this.activity});

  static const _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = DateTime.now();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.recoveryMetricsThisWeek,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < activity.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i == activity.length - 1 ? 0 : 6,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: activity[i]
                                ? theme.colorScheme.primary
                                : theme.dividerColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _labels[(today
                                      .subtract(Duration(days: 6 - i))
                                      .weekday -
                                  1) %
                              7],
                          style: TextStyle(
                            color: context.appColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyMetrics extends StatelessWidget {
  final bool calmInsightsEnabled;

  const _EmptyMetrics({required this.calmInsightsEnabled});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _softDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LineIcons.fire, color: theme.colorScheme.primary, size: 26),
          const SizedBox(height: 12),
          Text(
            context.l10n.recoveryMetricsEmptyTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            calmInsightsEnabled
                ? context.l10n.recoveryMetricsCalmEmptyBody
                : context.l10n.recoveryMetricsDetailedEmptyBody,
            style: TextStyle(
              color: context.appColors.textSecondary,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CircleBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PressScale(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: _softDecoration(theme, radius: 14),
        child: const Icon(LineIcons.angleLeft, size: 20),
      ),
    );
  }
}
