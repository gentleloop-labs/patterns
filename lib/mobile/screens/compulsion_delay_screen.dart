import 'dart:async';
import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../services/app_events.dart';
import '../../services/notification_service.dart';
import '../../l10n/l10n.dart';
import '../../services/review_prompt.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/activity_completion.dart';
import '../first_run.dart';
import '../widgets/section_intro.dart';

enum _Phase { setup, countdown, reflection }

/// Compulsion Delay Tool - an active ERP practice. The user picks a compulsion,
/// chooses how long to sit with the urge, rides out a calm countdown, then
/// reflects on what happened. The whole flow stays gentle and non-punishing:
/// stopping early is always allowed and never scolded.
class CompulsionDelayFlow extends ConsumerStatefulWidget {
  final String? initialCompulsion;

  /// First-run mode: the very first thing a new user does. On completion the
  /// flow pops a [FirstRunActivityResult] (so the shell can show the result
  /// screen) and stays quiet — no "logged" toast, and it defers the notification
  /// permission ask to the result screen instead of the timer start.
  final bool firstRun;

  const CompulsionDelayFlow({
    super.key,
    this.initialCompulsion,
    this.firstRun = false,
  });

  @override
  ConsumerState<CompulsionDelayFlow> createState() =>
      _CompulsionDelayFlowState();
}

class _CompulsionDelayFlowState extends ConsumerState<CompulsionDelayFlow>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  _Phase _phase = _Phase.setup;

  // Setup
  final TextEditingController _compulsionController = TextEditingController();
  double _urgeBefore = 5;
  int _plannedSeconds = 5 * 60;
  bool _custom = false;
  double _customMinutes = 10;

  // Countdown
  late final AnimationController _timer = AnimationController(vsync: this);
  DateTime? _timerStartedAt;
  DateTime? _timerEndsAt;
  bool _completionNotificationScheduled = false;

  // Reflection
  double _urgeAfter = 5;
  DelayOutcome? _outcome;
  final TextEditingController _noteController = TextEditingController();
  bool _completed = false;
  int _actualSeconds = 0;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.firstRun) {
      // A short, achievable first win — a couple of minutes of space.
      _plannedSeconds = 2 * 60;
    }
    if (widget.initialCompulsion != null) {
      _compulsionController.text = widget.initialCompulsion!;
    }
    _timer.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finishTimer(completed: true);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_phase == _Phase.countdown) {
      _cancelCompletionNotification();
    }
    _timer.dispose();
    _compulsionController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_phase != _Phase.countdown) return;
    if (state == AppLifecycleState.resumed) {
      _syncTimerWithClock();
      if (_phase == _Phase.countdown) {
        _cancelCompletionNotification();
      }
      return;
    }
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _scheduleCompletionNotification();
    }
  }

  // ----- phase transitions -----

  void _begin() {
    if (_compulsionController.text.trim().isEmpty) {
      showAppSnackBar(
        context,
        context.l10n.delayNameUrgeValidation,
        type: ToastType.info,
      );
      return;
    }
    _plannedSeconds = _custom ? (_customMinutes.round() * 60) : _plannedSeconds;
    // The urge the user named is intentionally not a parameter.
    AppEvents.logFirstCompulsionDelayStarted();
    _urgeAfter = _urgeBefore;
    final startedAt = DateTime.now();
    _timerStartedAt = startedAt;
    _timerEndsAt = startedAt.add(Duration(seconds: _plannedSeconds));
    _completionNotificationScheduled = false;
    // In first-run mode we hold the notification permission ask until the result
    // screen (the honest moment, after a completed activity).
    if (!widget.firstRun) unawaited(NotificationService.requestPermission());
    _timer
      ..duration = Duration(seconds: _plannedSeconds)
      ..forward(from: 0);
    setState(() => _phase = _Phase.countdown);
  }

  void _finishTimer({required bool completed, bool haptic = true}) {
    if (_phase != _Phase.countdown) return;
    final actualSeconds = _actualElapsedSeconds(completed: completed);
    _timer.stop();
    _timerStartedAt = null;
    _timerEndsAt = null;
    _cancelCompletionNotification();
    if (completed && haptic) {
      unawaited(HapticFeedback.mediumImpact());
    }
    setState(() {
      _completed = completed;
      _actualSeconds = actualSeconds;
      _phase = _Phase.reflection;
    });
  }

  int _actualElapsedSeconds({required bool completed}) {
    if (completed) return _plannedSeconds;
    final startedAt = _timerStartedAt;
    if (startedAt != null) {
      return DateTime.now()
          .difference(startedAt)
          .inSeconds
          .clamp(0, _plannedSeconds)
          .toInt();
    }
    final remaining = (_timer.duration ?? Duration.zero) * (1 - _timer.value);
    return (_plannedSeconds - remaining.inSeconds)
        .clamp(0, _plannedSeconds)
        .toInt();
  }

  void _syncTimerWithClock() {
    final startedAt = _timerStartedAt;
    final endsAt = _timerEndsAt;
    if (startedAt == null || endsAt == null) return;
    final now = DateTime.now();
    final wasBackgroundScheduled = _completionNotificationScheduled;
    if (!now.isBefore(endsAt)) {
      _finishTimer(completed: true, haptic: !wasBackgroundScheduled);
      return;
    }
    final elapsedMs = now.difference(startedAt).inMilliseconds;
    final totalMs = Duration(seconds: _plannedSeconds).inMilliseconds;
    final progress = (elapsedMs / totalMs).clamp(0.0, 0.999);
    _timer
      ..duration = Duration(seconds: _plannedSeconds)
      ..forward(from: progress);
  }

  void _scheduleCompletionNotification() {
    final endsAt = _timerEndsAt;
    if (endsAt == null) return;
    unawaited(() async {
      final scheduled =
          await NotificationService.schedulePracticeTimerCompletion(
            id: NotificationService.pauseTimerNotificationId,
            endsAt: endsAt,
            title: context.l10n.practiceWindowCompleteTitle,
            body: context.l10n.practiceWindowCompleteBody,
            strings: context.l10n,
          );
      if (mounted) _completionNotificationScheduled = scheduled;
    }());
  }

  void _cancelCompletionNotification() {
    _completionNotificationScheduled = false;
    unawaited(
      NotificationService.cancelPracticeTimerCompletion(
        NotificationService.pauseTimerNotificationId,
      ),
    );
  }

  void _confirmStop() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.delayStopEarlyTitle,
              style: Theme.of(
                sheetContext,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.delayStopEarlyBody,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            _StopActions(
              keepGoing: context.l10n.delayKeepGoingAction,
              stop: context.l10n.delayStopAction,
              onKeepGoing: () => Navigator.pop(sheetContext),
              onStop: () {
                Navigator.pop(sheetContext);
                _finishTimer(completed: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_outcome == null) {
      showAppSnackBar(
        context,
        context.l10n.delayOutcomeValidation,
        type: ToastType.info,
      );
      return;
    }
    setState(() => _saving = true);
    final session = DelaySession(
      compulsion: _compulsionController.text.trim(),
      plannedSeconds: _plannedSeconds,
      actualSeconds: _actualSeconds,
      completed: _completed,
      urgeBefore: _urgeBefore.round(),
      urgeAfter: _urgeAfter.round(),
      outcome: _outcome!,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      createdAt: DateTime.now(),
    );
    final saved = await ref
        .read(delaySessionProvider.notifier)
        .addSession(session);
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      showAppSnackBar(
        context,
        context.l10n.delaySaveError,
        type: ToastType.error,
      );
      return;
    }
    AppEvents.logFirstCompulsionDelayCompleted(ranToCompletion: _completed);
    await ReviewPromptService.recordUrgePracticeCompleted();
    if (!mounted) return;
    if (widget.firstRun) {
      // Hand back to the shell, which shows the honest result screen. No toast
      // and no review prompt here — the result screen owns the follow-up.
      Navigator.pop(
        context,
        FirstRunActivityResult(
          intensityBefore: _urgeBefore.round(),
          intensityAfter: _urgeAfter.round(),
        ),
      );
      return;
    }
    await showQuietCompletion(
      context,
      const ActivityCompletionResult(ActivityCompletionKind.compulsionDelay),
    );
    if (mounted) returnToNeutralHome(context);
  }

  // ----- build -----

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageTransitionSwitcher(
          duration: AppMotion.medium,
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
          child: KeyedSubtree(
            key: ValueKey(_phase),
            child: switch (_phase) {
              _Phase.setup => _buildSetup(context),
              _Phase.countdown => _buildCountdown(context),
              _Phase.reflection => _buildReflection(context),
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSetup(BuildContext context) {
    final theme = Theme.of(context);
    final ocdAsync = ref.watch(ocdProvider);
    final suggestions = ocdAsync.maybeWhen(
      data: (entries) {
        final seen = <String>{};
        final out = <String>[];
        for (final e in entries) {
          if (e.type != OcdType.compulsion) continue;
          final text = e.content.trim();
          if (text.isEmpty || !seen.add(text.toLowerCase())) continue;
          out.add(text);
          if (out.length >= 6) break;
        }
        return out;
      },
      orElse: () => const <String>[],
    );

    return Column(
      children: [
        _Header(
          title: context.l10n.delaySetupTitle,
          onBack: () => Navigator.pop(context),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
            children: staggered([
              const SectionIntro(id: 'compulsionDelay'),
              Text(
                context.l10n.delayUrgeQuestion,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 9),
              TextField(
                controller: _compulsionController,
                minLines: 1,
                maxLines: 3,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: context.l10n.delayUrgeHint,
                ),
              ),
              if (suggestions.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in suggestions)
                      _SuggestionChip(
                        label: s,
                        selected:
                            _compulsionController.text.trim().toLowerCase() ==
                            s.toLowerCase(),
                        onTap: () => setState(() {
                          _compulsionController.text = s;
                        }),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              _UrgeCard(
                label: context.l10n.delayUrgeBeforeLabel,
                value: _urgeBefore,
                onChanged: (v) => setState(() => _urgeBefore = v),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.delayDurationQuestion,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              _DurationPicker(
                seconds: _plannedSeconds,
                custom: _custom,
                onPreset: (secs) => setState(() {
                  _custom = false;
                  _plannedSeconds = secs;
                }),
                onCustom: () => setState(() => _custom = true),
              ),
              if (_custom) ...[
                const SizedBox(height: 16),
                _CustomMinutes(
                  minutes: _customMinutes,
                  onChanged: (m) => setState(() => _customMinutes = m),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _begin,
                  child: Text(context.l10n.delayBeginAction),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildCountdown(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            context.l10n.delayCountdownTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.delayCountdownBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.appColors.textSecondary,
              height: 1.45,
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _timer,
                builder: (context, _) {
                  final total = _timer.duration ?? Duration.zero;
                  final remaining = total * (1 - _timer.value);
                  final displayTime = _formatRemaining(remaining);
                  return Semantics(
                    liveRegion: remaining.inSeconds == 0,
                    label: context.l10n.timerRemaining(displayTime),
                    excludeSemantics: true,
                    child: SizedBox(
                      width: 240,
                      height: 240,
                      child: CustomPaint(
                        painter: _RingPainter(
                          progress: _timer.value,
                          trackColor: theme.dividerColor.withValues(alpha: 0.6),
                          progressColor: theme.colorScheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            displayTime,
                            style: TextStyle(
                              fontFamily: AppTheme.displayFamily,
                              fontSize: 52,
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _confirmStop,
              child: Text(context.l10n.delayStopAction),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReflection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _Header(title: context.l10n.delayReflectionTitle, onBack: null),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
            children: staggered([
              Text(
                context.l10n.delayReflectionStatus(
                  _completed ? 'completed' : 'early',
                ),
                style: theme.textTheme.titleMedium?.copyWith(height: 1.4),
              ),
              const SizedBox(height: 24),
              _UrgeCard(
                label: context.l10n.delayUrgeAfterLabel,
                value: _urgeAfter,
                onChanged: (v) => setState(() => _urgeAfter = v),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.delayOutcomeQuestion,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              _OutcomePicker(
                selected: _outcome,
                onChanged: (o) => setState(() => _outcome = o),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.delayNoteLabel,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 9),
              TextField(
                controller: _noteController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: context.l10n.delayNoteHint,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: AnimatedSwitcher(
                    duration: motionDisabled(context)
                        ? Duration.zero
                        : const Duration(milliseconds: 220),
                    child: Text(
                      _saving
                          ? context.l10n.delaySavingAction
                          : context.l10n.delaySaveAction,
                      key: ValueKey(_saving),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

String _formatRemaining(Duration d) {
  final seconds = d.inSeconds.clamp(0, 1 << 31);
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
}

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const _Header({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              tooltip: context.l10n.backAction,
              onPressed: onBack,
              icon: const Icon(LineIcons.angleLeft),
            )
          else
            const SizedBox(width: 12),
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UrgeCard extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _UrgeCard({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme, radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: value, end: value),
                duration: motionDisabled(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                builder: (context, v, _) {
                  final rounded = v.round();
                  return AnimatedDefaultTextStyle(
                    duration: motionDisabled(context)
                        ? Duration.zero
                        : const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      color: _urgeColor(theme, rounded),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                    child: Text(
                      context.l10n.trackerDistressShortValue(rounded),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          Semantics(
            label: label,
            value: context.l10n.delayUrgeValue(value.round()),
            increasedValue: context.l10n.delayUrgeValue(
              math.min(10, value.round() + 1),
            ),
            decreasedValue: context.l10n.delayUrgeValue(
              math.max(0, value.round() - 1),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 10,
              divisions: 10,
              semanticFormatterCallback: (next) =>
                  context.l10n.delayUrgeValue(next.round()),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationPicker extends StatelessWidget {
  final int seconds;
  final bool custom;
  final ValueChanged<int> onPreset;
  final VoidCallback onCustom;

  const _DurationPicker({
    required this.seconds,
    required this.custom,
    required this.onPreset,
    required this.onCustom,
  });

  static const _presets = <int>[60, 300, 900];

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      for (final preset in _presets)
        _SegmentChip(
          label: context.l10n.delayMinutes(preset ~/ 60),
          selected: !custom && seconds == preset,
          onTap: () => onPreset(preset),
        ),
      _SegmentChip(
        label: context.l10n.delayCustomAction,
        selected: custom,
        onTap: onCustom,
      ),
    ];
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    return Semantics(
      container: true,
      label: context.l10n.delayDurationGroupLabel,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: _softDecoration(Theme.of(context), radius: 24),
        child: stacked
            ? Column(
                children: [
                  for (final chip in chips)
                    SizedBox(width: double.infinity, child: chip),
                ],
              )
            : Row(children: [for (final chip in chips) Expanded(child: chip)]),
      ),
    );
  }
}

class _CustomMinutes extends StatelessWidget {
  final double minutes;
  final ValueChanged<double> onChanged;

  const _CustomMinutes({required this.minutes, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme, radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                context.l10n.delayCustomTitle,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                context.l10n.delayMinutes(minutes.round()),
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Semantics(
            label: context.l10n.delayCustomTitle,
            value: context.l10n.delayCustomMinutesValue(minutes.round()),
            child: Slider(
              value: minutes,
              min: 1,
              max: 60,
              divisions: 59,
              semanticFormatterCallback: (next) =>
                  context.l10n.delayCustomMinutesValue(next.round()),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutcomePicker extends StatelessWidget {
  final DelayOutcome? selected;
  final ValueChanged<DelayOutcome> onChanged;

  const _OutcomePicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      for (final outcome in DelayOutcome.values)
        _SegmentChip(
          label: context.l10n.delayOutcome(outcome.name),
          selected: selected == outcome,
          onTap: () => onChanged(outcome),
        ),
    ];
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    return Semantics(
      container: true,
      label: context.l10n.delayOutcomeGroupLabel,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: _softDecoration(Theme.of(context), radius: 24),
        child: stacked
            ? Column(
                children: [
                  for (final chip in chips)
                    SizedBox(width: double.infinity, child: chip),
                ],
              )
            : Row(children: [for (final chip in chips) Expanded(child: chip)]),
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      onTap: onTap,
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: AnimatedContainer(
            duration: motionDisabled(context)
                ? Duration.zero
                : const Duration(milliseconds: 180),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
            decoration: BoxDecoration(
              color: selected ? theme.colorScheme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected
                    ? theme.colorScheme.onPrimary
                    : context.appColors.textSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SuggestionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primary.withValues(alpha: 0.16)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : theme.dividerColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? theme.colorScheme.primary
                  : context.appColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _StopActions extends StatelessWidget {
  final String keepGoing;
  final String stop;
  final VoidCallback onKeepGoing;
  final VoidCallback onStop;

  const _StopActions({
    required this.keepGoing,
    required this.stop,
    required this.onKeepGoing,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[
      OutlinedButton(onPressed: onKeepGoing, child: Text(keepGoing)),
      ElevatedButton(onPressed: onStop, child: Text(stop)),
    ];
    if (MediaQuery.textScalerOf(context).scale(1) > 1.3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [buttons.first, const SizedBox(height: 12), buttons.last],
      );
    }
    return Row(
      children: [
        Expanded(child: buttons.first),
        const SizedBox(width: 12),
        Expanded(child: buttons.last),
      ],
    );
  }
}

class _BottomPanel extends StatelessWidget {
  final Widget child;

  const _BottomPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: const EdgeInsets.all(21),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: theme.dividerColor),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress; // 0..1 elapsed
  final Color trackColor;
  final Color progressColor;

  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 12.0;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    // Remaining arc shrinks clockwise from the top as time elapses.
    final sweep = 2 * math.pi * (1 - progress.clamp(0.0, 1.0));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.trackColor != trackColor ||
      old.progressColor != progressColor;
}

BoxDecoration _softDecoration(ThemeData theme, {required double radius}) {
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.9)),
  );
}

Color _urgeColor(ThemeData theme, int level) {
  if (level <= 3) return theme.appColors.positive;
  if (level <= 7) return theme.appColors.accent;
  return theme.appColors.negative;
}
