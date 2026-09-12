import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/semantics.dart';

import '../../l10n/l10n.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../widgets/recovery_ui.dart';
import '../widgets/section_intro.dart';

class UrgeSurfScreen extends ConsumerWidget {
  const UrgeSurfScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final sessions = ref.watch(urgeSurfProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 116),
          children: staggered([
            Row(
              children: [
                CircleBackButton(onTap: () => Navigator.of(context).pop()),
                const SizedBox(width: 12),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      strings.urgeSurfText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              strings.urgeSurfText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            const SectionIntro(id: 'urgeSurf'),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _startSurf(context),
                icon: const Icon(Icons.waves_rounded, size: 18),
                label: Text(strings.urgeSurfText('startAction')),
              ),
            ),
            const SizedBox(height: 22),
            Semantics(
              header: true,
              child: Text(
                strings.urgeSurfText('historyTitle'),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 12),
            sessions.when(
              data: (items) {
                if (items.isEmpty) {
                  return Text(
                    strings.urgeSurfText('emptyHistory'),
                    style: TextStyle(color: context.appColors.textSecondary),
                  );
                }
                return Column(
                  children: [
                    for (final s in items) ...[
                      _SurfCard(session: s),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, _) => Text(
                strings.urgeSurfText('loadError'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _startSurf(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => const UrgeSurfFlow(),
      ),
    );
  }
}

class _SurfCard extends StatelessWidget {
  final UrgeSurfSession session;
  const _SurfCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final mins = (session.durationSeconds / 60).floor();
    final secs = session.durationSeconds % 60;
    final trigger = session.trigger.isEmpty
        ? strings.urgeSurfText('triggerFallback')
        : session.trigger;
    final duration = strings.urgeSurfRecordedDuration(mins, secs);
    final summary = strings.urgeSurfHistorySummary(
      session.initialUrge,
      session.peakUrge,
      session.finalUrge,
      duration,
    );
    return Semantics(
      container: true,
      label: strings.urgeSurfSessionSemantics(
        trigger,
        context.formatMonthDay(session.datetime),
        summary,
      ),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: recoverySoftDecoration(theme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    trigger,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  context.formatMonthDay(session.datetime),
                  style: TextStyle(
                    color: context.appColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              summary,
              style: TextStyle(
                color: context.appColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Surf flow
// ---------------------------------------------------------------------------

enum _Phase { setup, surfing, reflection }

class UrgeSurfFlow extends ConsumerStatefulWidget {
  /// When false (e.g. launched from the free Emergency Toolkit), the session is
  /// not persisted - surfing stays free, while tracking/history is Pro.
  final bool record;

  const UrgeSurfFlow({super.key, this.record = true});

  @override
  ConsumerState<UrgeSurfFlow> createState() => _UrgeSurfFlowState();
}

class _UrgeSurfFlowState extends ConsumerState<UrgeSurfFlow>
    with SingleTickerProviderStateMixin {
  _Phase _phase = _Phase.setup;
  final _triggerController = TextEditingController();
  final _noteController = TextEditingController();

  double _initialUrge = 6;
  double _currentUrge = 6;
  double _finalUrge = 4;
  int _peakUrge = 6;
  int _plannedSeconds = 180;
  bool _saving = false;

  late final AnimationController _timer = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _timer.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finishSurf(announceCompletion: true);
      }
    });
  }

  @override
  void dispose() {
    _timer.dispose();
    _triggerController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _begin() {
    setState(() {
      _currentUrge = _initialUrge;
      _peakUrge = _initialUrge.round();
      _finalUrge = _initialUrge;
      _phase = _Phase.surfing;
    });
    _timer
      ..duration = Duration(seconds: _plannedSeconds)
      ..forward(from: 0);
  }

  void _finishSurf({required bool announceCompletion}) {
    if (_phase != _Phase.surfing) return;
    _timer.stop();
    HapticFeedback.mediumImpact();
    setState(() => _phase = _Phase.reflection);
    if (announceCompletion) {
      SemanticsService.sendAnnouncement(
        View.of(context),
        context.l10n.urgeSurfText('timerComplete'),
        Directionality.of(context),
      );
    }
  }

  void _endEarly() {
    _finishSurf(announceCompletion: false);
  }

  Future<void> _save() async {
    final strings = context.l10n;
    setState(() => _saving = true);
    var saved = true;
    if (widget.record) {
      final now = DateTime.now();
      final actualSeconds = (_plannedSeconds * _timer.value).round();
      final session = UrgeSurfSession(
        datetime: now,
        trigger: _triggerController.text.trim(),
        initialUrge: _initialUrge.round(),
        peakUrge: _peakUrge,
        finalUrge: _finalUrge.round(),
        durationSeconds: actualSeconds == 0 ? _plannedSeconds : actualSeconds,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        createdAt: now,
      );
      saved = await ref.read(urgeSurfProvider.notifier).addSession(session);
    }
    if (!mounted) return;
    final message = strings.urgeSurfText(
      saved ? (widget.record ? 'saveSuccess' : 'finishSuccess') : 'saveError',
    );
    if (!saved) {
      setState(() => _saving = false);
      showAppSnackBar(context, message, type: ToastType.error);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    Navigator.of(context).pop();
    showAppSnackBar(context, message, type: ToastType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: motionDisabled(context) ? Duration.zero : AppMotion.medium,
          child: switch (_phase) {
            _Phase.setup => _buildSetup(),
            _Phase.surfing => _buildSurfing(),
            _Phase.reflection => _buildReflection(),
          },
        ),
      ),
    );
  }

  Widget _buildSetup() {
    final theme = Theme.of(context);
    final strings = context.l10n;
    return ListView(
      key: const ValueKey('setup'),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
      children: staggered([
        Row(
          children: [
            CircleBackButton(onTap: () => Navigator.of(context).pop()),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  strings.urgeSurfText('setupTitle'),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        LabeledField(
          label: strings.urgeSurfText('triggerLabel'),
          hint: strings.urgeSurfText('triggerHint'),
          controller: _triggerController,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: recoverySoftDecoration(theme, radius: 18),
          child: RatingSlider(
            label: strings.urgeSurfText('initialUrgeLabel'),
            value: _initialUrge,
            onChanged: (v) => setState(() => _initialUrge = v),
            valueFormatter: strings.urgeSurfRating,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          strings.urgeSurfText('durationQuestion'),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        _DurationPicker(
          seconds: _plannedSeconds,
          onChanged: (s) => setState(() => _plannedSeconds = s),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _begin,
            child: Text(strings.urgeSurfText('begin')),
          ),
        ),
      ]),
    );
  }

  Widget _buildSurfing() {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final reduceMotion = motionDisabled(context);
    return ListView(
      key: const ValueKey('surfing'),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      children: [
        const SizedBox(height: 12),
        Semantics(
          header: true,
          child: Text(
            strings.urgeSurfText('surfingTitle'),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          strings.urgeSurfText('surfingBody'),
          textAlign: TextAlign.center,
          style: TextStyle(color: context.appColors.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 32),
        AnimatedBuilder(
          animation: _timer,
          builder: (context, _) {
            final remaining = (_plannedSeconds * (1 - _timer.value)).ceil();
            final mins = (remaining / 60).floor();
            final secs = remaining % 60;
            final paddedSeconds = secs.toString().padLeft(2, '0');
            return Center(
              child: Semantics(
                label: strings.urgeSurfTimeRemaining(mins, secs),
                excludeSemantics: true,
                child: SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: reduceMotion
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.dividerColor,
                                    width: 8,
                                  ),
                                ),
                              )
                            : CircularProgressIndicator(
                                value: 1 - _timer.value,
                                strokeWidth: 8,
                                backgroundColor: theme.dividerColor,
                                valueColor: AlwaysStoppedAnimation(
                                  theme.colorScheme.primary,
                                ),
                              ),
                      ),
                      Text(
                        strings.urgeSurfTimerDisplay(mins, paddedSeconds),
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppTheme.displayFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: recoverySoftDecoration(theme, radius: 18),
          child: RatingSlider(
            label: strings.urgeSurfText('currentUrgeLabel'),
            value: _currentUrge,
            onChanged: (v) => setState(() {
              _currentUrge = v;
              if (v.round() > _peakUrge) _peakUrge = v.round();
            }),
            valueFormatter: strings.urgeSurfRating,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _endEarly,
            child: Text(strings.urgeSurfText('doneAction')),
          ),
        ),
      ],
    );
  }

  Widget _buildReflection() {
    final theme = Theme.of(context);
    final strings = context.l10n;
    return ListView(
      key: const ValueKey('reflection'),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
      children: staggered([
        Semantics(
          header: true,
          child: Text(
            strings.urgeSurfText('reflectionTitle'),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: recoverySoftDecoration(theme, radius: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.urgeSurfText('waveTitle'),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                strings.urgeSurfWaveSummary(_initialUrge.round(), _peakUrge),
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: recoverySoftDecoration(theme, radius: 18),
          child: RatingSlider(
            label: strings.urgeSurfText('finalUrgeLabel'),
            value: _finalUrge,
            onChanged: (v) => setState(() => _finalUrge = v),
            valueFormatter: strings.urgeSurfRating,
          ),
        ),
        const SizedBox(height: 16),
        LabeledField(
          label: strings.urgeSurfText('noteLabel'),
          hint: strings.urgeSurfText('noteHint'),
          controller: _noteController,
          minLines: 2,
        ),
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    strings.urgeSurfText(
                      widget.record ? 'saveAction' : 'finishAction',
                    ),
                  ),
          ),
        ),
      ]),
    );
  }
}

class _DurationPicker extends StatelessWidget {
  final int seconds;
  final ValueChanged<int> onChanged;

  const _DurationPicker({required this.seconds, required this.onChanged});

  static const _options = [60, 180, 300];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 24;
    final children = [
      for (final option in _options)
        Semantics(
          button: true,
          selected: seconds == option,
          child: InkWell(
            onTap: () => onChanged(option),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: motionDisabled(context)
                  ? Duration.zero
                  : AppMotion.fast,
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 44),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              decoration: BoxDecoration(
                color: seconds == option
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (seconds == option) ...[
                    Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: theme.colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Flexible(
                    child: Text(
                      strings.urgeSurfDuration(option ~/ 60),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: seconds == option
                            ? theme.colorScheme.onPrimary
                            : context.appColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: recoverySoftDecoration(theme, radius: 16),
      child: largeText
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children
                  .map(
                    (child) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: child,
                    ),
                  )
                  .toList(),
            )
          : Row(
              children: children
                  .map((child) => Expanded(child: child))
                  .toList(),
            ),
    );
  }
}
