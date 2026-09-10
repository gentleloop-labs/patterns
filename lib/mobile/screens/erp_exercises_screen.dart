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

enum _PracticePhase { setup, countdown, reflection }

class ErpExerciseTemplate {
  final String id;
  final String title;
  final String subtitle;
  final String intro;
  final String why;
  final List<String> instructions;
  final List<String> quickCues;
  final String exposurePrompt;
  final String predictionPrompt;
  final String commitmentPrompt;
  final int defaultSeconds;
  final IconData icon;

  const ErpExerciseTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.intro,
    required this.why,
    required this.instructions,
    required this.quickCues,
    required this.exposurePrompt,
    required this.predictionPrompt,
    required this.commitmentPrompt,
    required this.defaultSeconds,
    required this.icon,
  });
}

const erpExerciseTemplates = <ErpExerciseTemplate>[
  ErpExerciseTemplate(
    id: 'delay_checking',
    title: 'Delay Checking',
    subtitle: 'Practise leaving something unchecked for a short window.',
    intro:
        'Create a repeatable plan for moments when OCD pushes you to check locks, switches, messages, symptoms, or mistakes again.',
    why:
        'ERP works by letting your brain learn that uncertainty can be present without needing a ritual right away.',
    instructions: [
      'Define one checking rule before you begin.',
      'Do the planned check once if it is part of normal safety.',
      'Resist rechecking while the timer runs.',
      'Notice the urge without negotiating with it.',
    ],
    quickCues: ['Check once', 'No rechecking', 'Notice the urge'],
    exposurePrompt: 'What will you leave unchecked or checked only once?',
    predictionPrompt: 'What does OCD predict if you do not recheck?',
    commitmentPrompt: 'What checking ritual will you practise resisting?',
    defaultSeconds: 5 * 60,
    icon: Icons.fact_check_rounded,
  ),
  ErpExerciseTemplate(
    id: 'delay_reassurance',
    title: 'Delay Reassurance Seeking',
    subtitle: 'Wait before asking someone to make the fear feel certain.',
    intro:
        'Create a plan for urges to ask, confess, explain, or get someone to confirm that things are okay.',
    why:
        'Reassurance can feel helpful in the moment, but delaying it helps you build tolerance for not knowing.',
    instructions: [
      'Define the reassurance request before you begin.',
      'Do not send the message or ask the question during the timer.',
      'Let the discomfort rise and fall on its own.',
      'Return to what you were doing as gently as you can.',
    ],
    quickCues: ['Hold the ask', 'Let uncertainty stay', 'Return gently'],
    exposurePrompt: 'What reassurance do you want to ask for?',
    predictionPrompt: 'What does OCD say will happen if you do not ask?',
    commitmentPrompt: 'What message, confession, or question will you resist?',
    defaultSeconds: 10 * 60,
    icon: Icons.chat_bubble_outline_rounded,
  ),
  ErpExerciseTemplate(
    id: 'delay_googling',
    title: 'Delay Googling',
    subtitle: 'Postpone searching for certainty or proof.',
    intro:
        'Create a plan for moments when OCD wants you to search symptoms, meanings, risks, rules, or stories until you feel sure.',
    why:
        'Postponing research interrupts the certainty loop and gives your nervous system a chance to settle without a search.',
    instructions: [
      'Define the search before opening anything else.',
      'Close the search box or browser tab.',
      'Start the timer before reading anything else.',
      'Let the question stay unanswered for now.',
    ],
    quickCues: ['Close search', 'Start timer', 'Leave it unanswered'],
    exposurePrompt: 'What search or question will you leave unanswered?',
    predictionPrompt: 'What does OCD say you need to know right now?',
    commitmentPrompt: 'What search, article, or forum will you avoid?',
    defaultSeconds: 10 * 60,
    icon: Icons.search_off_rounded,
  ),
  ErpExerciseTemplate(
    id: 'delay_rumination',
    title: 'Delay Rumination',
    subtitle: 'Notice mental problem-solving without following it.',
    intro:
        'Create a plan for mental compulsions like replaying, proving, reviewing, or solving.',
    why:
        'Rumination can look like thinking, but ERP practice helps you step out of the loop without finishing the argument.',
    instructions: [
      'Name the loop: reviewing, solving, proving, or checking.',
      'Let the thought be unfinished.',
      'Bring attention back to one ordinary task or sensation.',
      'Restart gently each time the loop pulls you back.',
    ],
    quickCues: ['Name the loop', 'Leave unfinished', 'Return to task'],
    exposurePrompt: 'What thought loop will you leave unfinished?',
    predictionPrompt: 'What does OCD say you must solve or prove?',
    commitmentPrompt: 'What mental review or argument will you resist?',
    defaultSeconds: 5 * 60,
    icon: Icons.psychology_alt_rounded,
  ),
  ErpExerciseTemplate(
    id: 'delay_washing',
    title: 'Delay Washing',
    subtitle: 'Wait before washing, cleaning, or sanitizing again.',
    intro:
        'Create a plan for urges to wash, clean, sanitize, or reset because something feels contaminated.',
    why:
        'Waiting gives your brain practice learning that the feeling of contamination can be tolerated without an immediate ritual.',
    instructions: [
      'Define the normal hygiene boundary before starting.',
      'Start with a delay that feels challenging but possible.',
      'Keep your hands away from the sink or sanitizer during the timer.',
      'Let the discomfort be there without trying to make it perfect.',
    ],
    quickCues: ['Set boundary', 'Delay washing', 'Allow discomfort'],
    exposurePrompt: 'What normal hygiene boundary will you practice?',
    predictionPrompt: 'What does OCD predict if you do not wash again?',
    commitmentPrompt:
        'What extra washing, cleaning, or sanitizing will you resist?',
    defaultSeconds: 3 * 60,
    icon: Icons.water_drop_outlined,
  ),
];

ErpExerciseTemplate _templateForId(String id) {
  return erpExerciseTemplates.firstWhere(
    (template) => template.id == id,
    orElse: () => erpExerciseTemplates.first,
  );
}

class ErpExercisesScreen extends ConsumerWidget {
  /// When true the screen shows a back button (it's pushed from the Recovery
  /// hub rather than hosted directly as a tab).
  final bool showBack;

  const ErpExercisesScreen({super.key, this.showBack = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final plans = ref.watch(erpExercisePlanProvider);
    final sessions = ref.watch(erpExerciseSessionProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 116),
          children: staggered([
            if (showBack) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: _RoundIconButton(
                  icon: LineIcons.angleLeft,
                  onTap: () => Navigator.of(context).pop(),
                  semanticLabel: context.l10n.backAction,
                ),
              ),
              const SizedBox(height: 12),
            ],
            _Header(
              title: context.l10n.erpPlanText('title'),
              subtitle: context.l10n.erpPlanText('subtitle'),
            ),
            const SizedBox(height: 20),
            const SectionIntro(id: 'guidedErp'),
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.erpPlanText('myPlans'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openPlanEditor(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(context.l10n.erpPlanText('newAction')),
                ),
              ],
            ),
            const SizedBox(height: 12),
            plans.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyPlansCard(
                    onCreate: () => _openPlanEditor(context),
                  );
                }
                return Column(
                  children: [
                    for (final plan in items) ...[
                      _PlanCard(
                        plan: plan,
                        onPractice: () => _openPractice(context, plan),
                        onEdit: () => _openPlanEditor(context, plan: plan),
                        onArchive: () => _confirmArchive(context, ref, plan),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) => Text(
                context.l10n.erpPlanText('plansError'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              context.l10n.erpPlanText('recentPractice'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            sessions.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyRecentPractice(theme: theme);
                }
                return Column(
                  children: [
                    for (final item in items.take(4)) ...[
                      _RecentPracticeRow(session: item),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) => Text(
                context.l10n.erpPlanText('historyError'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _openPlanEditor(BuildContext context, {ErpExercisePlan? plan}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ErpPlanEditorScreen(plan: plan),
      ),
    );
  }

  void _openPractice(BuildContext context, ErpExercisePlan plan) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ErpPlanPracticeFlow(plan: plan),
      ),
    );
  }

  void _confirmArchive(
    BuildContext context,
    WidgetRef ref,
    ErpExercisePlan plan,
  ) {
    final id = plan.id;
    if (id == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sheetContext.l10n.erpPlanText('archiveTitle'),
              style: Theme.of(
                sheetContext,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              sheetContext.l10n.erpPlanText('archiveBody'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: Text(sheetContext.l10n.erpPlanText('keepAction')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(sheetContext);
                      await ref
                          .read(erpExercisePlanProvider.notifier)
                          .archivePlan(id);
                    },
                    child: Text(sheetContext.l10n.erpPlanText('archiveAction')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ErpPlanEditorScreen extends ConsumerStatefulWidget {
  final ErpExercisePlan? plan;

  const ErpPlanEditorScreen({super.key, this.plan});

  @override
  ConsumerState<ErpPlanEditorScreen> createState() =>
      _ErpPlanEditorScreenState();
}

class _ErpPlanEditorScreenState extends ConsumerState<ErpPlanEditorScreen> {
  late ErpExerciseTemplate _template;
  late int _defaultSeconds;
  bool _custom = false;
  double _customMinutes = 10;
  final TextEditingController _exposureController = TextEditingController();
  final TextEditingController _predictionController = TextEditingController();
  final TextEditingController _commitmentController = TextEditingController();
  bool _saving = false;

  bool get _isEditing => widget.plan != null;

  @override
  void initState() {
    super.initState();
    final plan = widget.plan;
    _template = plan == null
        ? erpExerciseTemplates.first
        : _templateForId(plan.exerciseId);
    _defaultSeconds = plan?.defaultSeconds ?? _template.defaultSeconds;
    _custom = !const {60, 300, 900}.contains(_defaultSeconds);
    _customMinutes = (_defaultSeconds / 60).clamp(1, 60).toDouble();
    _exposureController.text = plan?.triggerOrExposure ?? '';
    _predictionController.text = plan?.fearPrediction ?? '';
    _commitmentController.text = plan?.preventionCommitment ?? '';
  }

  @override
  void dispose() {
    _exposureController.dispose();
    _predictionController.dispose();
    _commitmentController.dispose();
    super.dispose();
  }

  Future<void> _savePlan() async {
    if (_exposureController.text.trim().isEmpty) {
      showAppSnackBar(
        context,
        context.l10n.erpPlanText('exposureValidation'),
        type: ToastType.info,
      );
      return;
    }
    if (_commitmentController.text.trim().isEmpty) {
      showAppSnackBar(
        context,
        context.l10n.erpPlanText('commitmentValidation'),
        type: ToastType.info,
      );
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now();
    final existing = widget.plan;
    final plan = ErpExercisePlan(
      id: existing?.id,
      exerciseId: _template.id,
      exerciseTitle: _template.title,
      triggerOrExposure: _exposureController.text.trim(),
      fearPrediction: _predictionController.text.trim(),
      preventionCommitment: _commitmentController.text.trim(),
      defaultSeconds: _custom ? _customMinutes.round() * 60 : _defaultSeconds,
      archived: existing?.archived ?? false,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final saved = _isEditing
        ? await ref.read(erpExercisePlanProvider.notifier).updatePlan(plan)
        : await ref.read(erpExercisePlanProvider.notifier).addPlan(plan);
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      showAppSnackBar(
        context,
        context.l10n.erpPlanText('saveError'),
        type: ToastType.error,
      );
      return;
    }
    Navigator.pop(context);
    showAppSnackBar(
      context,
      context.l10n.erpPlanText(_isEditing ? 'updated' : 'created'),
      type: ToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _SimpleHeader(
              title: context.l10n.erpPlanText(
                _isEditing ? 'editTitle' : 'createTitle',
              ),
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
                children: staggered([
                  Text(
                    context.l10n.erpPlanText('exerciseType'),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _TemplateSelector(
                    selectedId: _template.id,
                    onSelected: _selectTemplate,
                  ),
                  const SizedBox(height: 14),
                  _SelectedTemplatePanel(template: _template),
                  const SizedBox(height: 18),
                  _PracticeGuidePanel(template: _template),
                  const SizedBox(height: 18),
                  _LabeledTextField(
                    controller: _exposureController,
                    label: context.l10n.erpPlanText('exposureTarget'),
                    hint: _template.exposurePrompt,
                    minLines: 2,
                  ),
                  const SizedBox(height: 14),
                  _LabeledTextField(
                    controller: _predictionController,
                    label: context.l10n.erpPlanText('ocdPrediction'),
                    hint: _template.predictionPrompt,
                    minLines: 2,
                  ),
                  const SizedBox(height: 14),
                  _LabeledTextField(
                    controller: _commitmentController,
                    label: context.l10n.erpPlanText('preventionCommitment'),
                    hint: _template.commitmentPrompt,
                    minLines: 2,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    context.l10n.erpPlanText('defaultDuration'),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _DurationPicker(
                    seconds: _defaultSeconds,
                    custom: _custom,
                    onPreset: (seconds) => setState(() {
                      _custom = false;
                      _defaultSeconds = seconds;
                    }),
                    onCustom: () => setState(() => _custom = true),
                  ),
                  if (_custom) ...[
                    const SizedBox(height: 12),
                    _CustomMinutes(
                      minutes: _customMinutes,
                      onChanged: (value) => setState(() {
                        _customMinutes = value;
                        _defaultSeconds = value.round() * 60;
                      }),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saving ? null : _savePlan,
                    child: Text(
                      _saving
                          ? context.l10n.erpPlanText('saving')
                          : context.l10n.erpPlanText(
                              _isEditing ? 'saveAction' : 'createAction',
                            ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTemplate(ErpExerciseTemplate template) {
    setState(() {
      _template = template;
      if (!_custom) _defaultSeconds = template.defaultSeconds;
      _customMinutes = (_defaultSeconds / 60).clamp(1, 60).toDouble();
    });
  }
}

class ErpPlanPracticeFlow extends ConsumerStatefulWidget {
  final ErpExercisePlan plan;

  /// First-run mode (the "practise responding differently" path). On save the
  /// flow pops a [FirstRunActivityResult] and stays quiet, deferring the
  /// notification permission ask to the result screen.
  final bool firstRun;

  const ErpPlanPracticeFlow({
    super.key,
    required this.plan,
    this.firstRun = false,
  });

  @override
  ConsumerState<ErpPlanPracticeFlow> createState() =>
      _ErpPlanPracticeFlowState();
}

class _ErpPlanPracticeFlowState extends ConsumerState<ErpPlanPracticeFlow>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  _PracticePhase _phase = _PracticePhase.setup;
  double _anxietyBefore = 5;
  double _anxietyAfter = 5;
  DelayOutcome? _outcome;
  final TextEditingController _whatHappenedController = TextEditingController();
  final TextEditingController _learningController = TextEditingController();
  late final AnimationController _timer = AnimationController(vsync: this);
  DateTime? _timerStartedAt;
  DateTime? _timerEndsAt;
  bool _completionNotificationScheduled = false;
  bool _completed = false;
  int _actualSeconds = 0;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timer.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finishTimer(completed: true);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_phase == _PracticePhase.countdown) {
      _cancelCompletionNotification();
    }
    _timer.dispose();
    _whatHappenedController.dispose();
    _learningController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_phase != _PracticePhase.countdown) return;
    if (state == AppLifecycleState.resumed) {
      _syncTimerWithClock();
      if (_phase == _PracticePhase.countdown) {
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

  void _begin() {
    AppEvents.logErpSessionStarted();
    _anxietyAfter = _anxietyBefore;
    final startedAt = DateTime.now();
    _timerStartedAt = startedAt;
    _timerEndsAt = startedAt.add(Duration(seconds: widget.plan.defaultSeconds));
    _completionNotificationScheduled = false;
    if (!widget.firstRun) unawaited(NotificationService.requestPermission());
    _timer
      ..duration = Duration(seconds: widget.plan.defaultSeconds)
      ..forward(from: 0);
    setState(() => _phase = _PracticePhase.countdown);
  }

  void _finishTimer({required bool completed, bool haptic = true}) {
    if (_phase != _PracticePhase.countdown) return;
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
      _phase = _PracticePhase.reflection;
    });
  }

  int _actualElapsedSeconds({required bool completed}) {
    final plannedSeconds = widget.plan.defaultSeconds;
    if (completed) return plannedSeconds;
    final startedAt = _timerStartedAt;
    if (startedAt != null) {
      return DateTime.now()
          .difference(startedAt)
          .inSeconds
          .clamp(0, plannedSeconds)
          .toInt();
    }
    final remaining = (_timer.duration ?? Duration.zero) * (1 - _timer.value);
    return (plannedSeconds - remaining.inSeconds)
        .clamp(0, plannedSeconds)
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
    final totalMs = Duration(
      seconds: widget.plan.defaultSeconds,
    ).inMilliseconds;
    final progress = (elapsedMs / totalMs).clamp(0.0, 0.999);
    _timer
      ..duration = Duration(seconds: widget.plan.defaultSeconds)
      ..forward(from: progress);
  }

  void _scheduleCompletionNotification() {
    final endsAt = _timerEndsAt;
    if (endsAt == null) return;
    unawaited(() async {
      final scheduled =
          await NotificationService.schedulePracticeTimerCompletion(
            id: NotificationService.erpTimerNotificationId,
            endsAt: endsAt,
            title: context.l10n.erpWindowCompleteTitle,
            body: context.l10n.erpWindowCompleteBody,
            strings: context.l10n,
          );
      if (mounted) _completionNotificationScheduled = scheduled;
    }());
  }

  void _cancelCompletionNotification() {
    _completionNotificationScheduled = false;
    unawaited(
      NotificationService.cancelPracticeTimerCompletion(
        NotificationService.erpTimerNotificationId,
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
              context.l10n.erpFlowText('stopTitle'),
              style: Theme.of(
                sheetContext,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.erpFlowText('stopBody'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            _ErpStopActions(
              keepGoing: context.l10n.erpFlowText('keepGoing'),
              stop: context.l10n.erpFlowText('stop'),
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
        context.l10n.erpFlowText('outcomeValidation'),
        type: ToastType.info,
      );
      return;
    }
    setState(() => _saving = true);
    final plan = widget.plan;
    final session = ErpExerciseSession(
      planId: plan.id,
      exerciseId: plan.exerciseId,
      exerciseTitle: plan.exerciseTitle,
      triggerOrExposure: plan.triggerOrExposure,
      fearPrediction: plan.fearPrediction,
      preventionCommitment: plan.preventionCommitment,
      plannedSeconds: plan.defaultSeconds,
      actualSeconds: _actualSeconds,
      completed: _completed,
      anxietyBefore: _anxietyBefore.round(),
      anxietyAfter: _anxietyAfter.round(),
      outcome: _outcome!,
      whatHappened: _whatHappenedController.text.trim(),
      learning: _learningController.text.trim(),
      createdAt: DateTime.now(),
    );
    final saved = await ref
        .read(erpExerciseSessionProvider.notifier)
        .addSession(session);
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      showAppSnackBar(
        context,
        context.l10n.erpFlowText('saveError'),
        type: ToastType.error,
      );
      return;
    }
    // Milestone only: the exposure text, predictions and reflections stay local.
    AppEvents.logFirstExposureCompleted(ranToCompletion: _completed);
    await ReviewPromptService.recordErpPracticeCompleted();
    if (!mounted) return;
    if (widget.firstRun) {
      Navigator.pop(
        context,
        FirstRunActivityResult(
          intensityBefore: _anxietyBefore.round(),
          intensityAfter: _anxietyAfter.round(),
        ),
      );
      return;
    }
    await showQuietCompletion(
      context,
      const ActivityCompletionResult(ActivityCompletionKind.erp),
    );
    if (mounted) returnToNeutralHome(context);
  }

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
              _PracticePhase.setup => _buildSetup(context),
              _PracticePhase.countdown => _buildCountdown(context),
              _PracticePhase.reflection => _buildReflection(context),
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSetup(BuildContext context) {
    final template = _templateForId(widget.plan.exerciseId);
    return Column(
      children: [
        _SimpleHeader(
          title: widget.plan.exerciseTitle,
          onBack: () => Navigator.pop(context),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
            children: staggered([
              _IconBadge(icon: template.icon),
              const SizedBox(height: 18),
              _PlanReviewCard(
                exposure: widget.plan.triggerOrExposure,
                prediction: widget.plan.fearPrediction,
                commitment: widget.plan.preventionCommitment,
              ),
              const SizedBox(height: 18),
              _RatingCard(
                label: context.l10n.erpFlowText('anxietyBefore'),
                value: _anxietyBefore,
                onChanged: (value) => setState(() => _anxietyBefore = value),
              ),
              const SizedBox(height: 16),
              _CommitmentCard(
                label: context.l10n.erpFlowText('duration'),
                text: _formatDuration(
                  Duration(seconds: widget.plan.defaultSeconds),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _begin,
                child: Text(context.l10n.erpFlowText('start')),
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
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
      child: Column(
        children: [
          _SimpleHeader(title: widget.plan.exerciseTitle, onBack: _confirmStop),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              children: [
                AnimatedBuilder(
                  animation: _timer,
                  builder: (context, _) {
                    final total = _timer.duration ?? Duration.zero;
                    final remaining = total * (1 - _timer.value);
                    final displayTime = _formatDuration(remaining);
                    return Center(
                      child: Semantics(
                        liveRegion: remaining.inSeconds == 0,
                        label: context.l10n.timerRemaining(displayTime),
                        excludeSemantics: true,
                        child: _ProgressRing(
                          progress: _timer.value,
                          trackColor: theme.dividerColor.withValues(
                            alpha: 0.45,
                          ),
                          progressColor: theme.colorScheme.primary,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                displayTime,
                                style: TextStyle(
                                  fontFamily: AppTheme.displayFamily,
                                  fontSize: 52,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context.l10n.erpFlowText('countdownCue'),
                                style: TextStyle(
                                  color: context.appColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 26),
                _CommitmentCard(
                  label: context.l10n.erpFlowText('resisting'),
                  text: widget.plan.preventionCommitment,
                ),
                const SizedBox(height: 18),
                Text(
                  context.l10n.erpFlowText('countdownBody'),
                  textAlign: TextAlign.center,
                  style: _bodyText(theme),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _confirmStop,
              child: Text(context.l10n.erpFlowText('stopEarly')),
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
        _SimpleHeader(
          title: context.l10n.erpFlowText('reflectionTitle'),
          onBack: () => setState(() => _phase = _PracticePhase.setup),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
            children: staggered([
              Text(
                context.l10n.erpReflectionStatus(
                  _completed ? 'completed' : 'early',
                ),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.l10n.erpFlowText('reflectionBody'),
                style: _bodyText(theme),
              ),
              const SizedBox(height: 18),
              _PlanReviewCard(
                exposure: widget.plan.triggerOrExposure,
                prediction: widget.plan.fearPrediction,
                commitment: widget.plan.preventionCommitment,
              ),
              const SizedBox(height: 18),
              _RatingCard(
                label: context.l10n.erpFlowText('anxietyAfter'),
                value: _anxietyAfter,
                onChanged: (value) => setState(() => _anxietyAfter = value),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.erpFlowText('outcomeQuestion'),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              _OutcomePicker(
                selected: _outcome,
                onChanged: (value) => setState(() => _outcome = value),
              ),
              const SizedBox(height: 16),
              _LabeledTextField(
                controller: _whatHappenedController,
                label: context.l10n.erpFlowText('whatHappened'),
                hint: context.l10n.erpFlowText('whatHappenedHint'),
                minLines: 3,
              ),
              const SizedBox(height: 14),
              _LabeledTextField(
                controller: _learningController,
                label: context.l10n.erpFlowText('learning'),
                hint: context.l10n.erpFlowText('learningHint'),
                minLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: Text(
                  context.l10n.erpFlowText(_saving ? 'saving' : 'save'),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Header({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: _muted(theme, 14)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimpleHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _SimpleHeader({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 16, 8),
      child: Row(
        children: [
          _RoundIconButton(
            icon: LineIcons.angleLeft,
            onTap: onBack,
            semanticLabel: context.l10n.backAction,
          ),
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

class _EmptyPlansCard extends StatelessWidget {
  final VoidCallback onCreate;

  const _EmptyPlansCard({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _softDecoration(theme, radius: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.self_improvement_rounded,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.erpPlanText('emptyTitle'),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(context.l10n.erpPlanText('emptyBody'), style: _bodyText(theme)),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: onCreate,
            child: Text(context.l10n.erpPlanText('createAction')),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final ErpExercisePlan plan;
  final VoidCallback onPractice;
  final VoidCallback onEdit;
  final VoidCallback onArchive;

  const _PlanCard({
    required this.plan,
    required this.onPractice,
    required this.onEdit,
    required this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final template = _templateForId(plan.exerciseId);
    return PressScale(
      onTap: onPractice,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: _softDecoration(theme, radius: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _IconBadge(icon: template.icon, compact: true),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.exerciseTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.delayMinutes(
                          (plan.defaultSeconds / 60).ceil(),
                        ),
                        style: _muted(theme, 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<_PlanMenuAction>(
                  icon: Icon(
                    LineIcons.verticalEllipsis,
                    color: context.appColors.textSecondary,
                  ),
                  onSelected: (action) {
                    switch (action) {
                      case _PlanMenuAction.edit:
                        onEdit();
                      case _PlanMenuAction.archive:
                        onArchive();
                    }
                  },
                  tooltip: context.l10n.erpPlanText('moreActions'),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: _PlanMenuAction.edit,
                      child: Text(context.l10n.erpPlanText('editAction')),
                    ),
                    PopupMenuItem(
                      value: _PlanMenuAction.archive,
                      child: Text(
                        context.l10n.erpPlanText('archivePlanAction'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              plan.triggerOrExposure,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: _bodyText(theme),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.erpPlanResist(plan.preventionCommitment),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: _muted(theme, 13).copyWith(height: 1.35),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PlanMenuAction { edit, archive }

class _TemplateSelector extends StatelessWidget {
  final String selectedId;
  final ValueChanged<ErpExerciseTemplate> onSelected;

  const _TemplateSelector({required this.selectedId, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: erpExerciseTemplates.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final template = erpExerciseTemplates[index];
          final selected = template.id == selectedId;
          return _TemplatePill(
            template: template,
            selected: selected,
            onTap: () => onSelected(template),
          );
        },
      ),
    );
  }
}

class _TemplatePill extends StatelessWidget {
  final ErpExerciseTemplate template;
  final bool selected;
  final VoidCallback onTap;

  const _TemplatePill({
    required this.template,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return PressScale(
      onTap: onTap,
      scale: 0.96,
      child: AnimatedContainer(
        duration: AppMotion.medium,
        curve: AppMotion.stateCurve,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: selected
              ? primary.withValues(alpha: 0.18)
              : context.appColors.input,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? primary.withValues(alpha: 0.72)
                : theme.dividerColor.withValues(alpha: 0.75),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              template.icon,
              size: 17,
              color: selected ? primary : context.appColors.textSecondary,
            ),
            const SizedBox(width: 7),
            Text(
              _shortTemplateTitle(template.title),
              style: theme.textTheme.labelLarge?.copyWith(
                color: selected ? primary : theme.colorScheme.onSurface,
                fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedTemplatePanel extends StatelessWidget {
  final ErpExerciseTemplate template;

  const _SelectedTemplatePanel({required this.template});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _softDecoration(theme, radius: 22),
      child: Row(
        children: [
          _IconBadge(icon: template.icon, compact: true),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  template.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _muted(theme, 13).copyWith(height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _DurationBadge(seconds: template.defaultSeconds),
        ],
      ),
    );
  }
}

class _PracticeGuidePanel extends StatelessWidget {
  final ErpExerciseTemplate template;

  const _PracticeGuidePanel({required this.template});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _softDecoration(theme, radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tips_and_updates_outlined,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.erpPlanText('practiceGuide'),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            template.why,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _muted(theme, 13).copyWith(height: 1.35),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final cue in template.quickCues) _CueChip(label: cue),
            ],
          ),
        ],
      ),
    );
  }
}

class _DurationBadge extends StatelessWidget {
  final int seconds;

  const _DurationBadge({required this.seconds});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        context.l10n.delayMinutes((seconds / 60).ceil()),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _CueChip extends StatelessWidget {
  final String label;

  const _CueChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.16),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _RecentPracticeRow extends StatelessWidget {
  final ErpExerciseSession session;

  const _RecentPracticeRow({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratingChange = context.l10n.erpPlanRatingChange(
      session.anxietyBefore,
      session.anxietyAfter,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _softDecoration(theme, radius: 20),
      child: Row(
        children: [
          Icon(
            Icons.self_improvement_rounded,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.exerciseTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  session.learning.isNotEmpty
                      ? session.learning
                      : session.triggerOrExposure,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _muted(theme, 12).copyWith(height: 1.3),
                ),
                const SizedBox(height: 3),
                Text(
                  context.formatMonthDayTime(session.createdAt),
                  style: _muted(theme, 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            ratingChange,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyRecentPractice extends StatelessWidget {
  final ThemeData theme;

  const _EmptyRecentPractice({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme, radius: 22),
      child: Text(
        context.l10n.erpPlanText('historyEmpty'),
        style: _muted(theme, 14),
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int minLines;

  const _LabeledTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines + 2,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            height: 1.35,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: context.appColors.textSecondary.withValues(alpha: 0.58),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _CommitmentCard extends StatelessWidget {
  final String label;
  final String text;

  const _CommitmentCard({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme, radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(text, style: _bodyText(theme)),
        ],
      ),
    );
  }
}

class _PlanReviewCard extends StatelessWidget {
  final String exposure;
  final String prediction;
  final String commitment;

  const _PlanReviewCard({
    required this.exposure,
    required this.prediction,
    required this.commitment,
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
          _ReviewLine(
            label: context.l10n.erpFlowText('exposure'),
            value: exposure,
          ),
          if (prediction.isNotEmpty) ...[
            const SizedBox(height: 10),
            _ReviewLine(
              label: context.l10n.erpFlowText('prediction'),
              value: prediction,
            ),
          ],
          const SizedBox(height: 10),
          _ReviewLine(
            label: context.l10n.erpFlowText('commitment'),
            value: commitment,
          ),
        ],
      ),
    );
  }
}

class _ReviewLine extends StatelessWidget {
  final String label;
  final String value;

  const _ReviewLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(value, style: _bodyText(theme)),
      ],
    );
  }
}

class _RatingCard extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _RatingCard({
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
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: context.appColors.textSecondary,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.trackerDistressShortValue(value.round()),
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 5,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 13),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 22),
            ),
            child: Semantics(
              label: label,
              value: context.l10n.erpIntensityValue(value.round()),
              child: Slider(
                value: value,
                min: 0,
                max: 10,
                divisions: 10,
                semanticFormatterCallback: (next) =>
                    context.l10n.erpIntensityValue(next.round()),
                onChanged: onChanged,
              ),
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
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: _softDecoration(Theme.of(context), radius: 24),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
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
        ],
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
          Row(
            children: [
              Text(
                context.l10n.erpPlanText('customDuration'),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
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
            label: context.l10n.erpPlanText('customDuration'),
            value: context.l10n.delayCustomMinutesValue(minutes.round()),
            child: Slider(
              value: minutes,
              min: 1,
              max: 60,
              divisions: 59,
              semanticFormatterCallback: (value) =>
                  context.l10n.delayCustomMinutesValue(value.round()),
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
          label: context.l10n.erpOutcome(outcome.name),
          selected: selected == outcome,
          onTap: () => onChanged(outcome),
        ),
    ];
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    return Container(
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
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final bool compact;

  const _IconBadge({required this.icon, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = compact ? 46.0 : 64.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(compact ? 14 : 20),
      ),
      child: Icon(
        icon,
        color: theme.colorScheme.primary,
        size: compact ? 23 : 32,
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
    return PressScale(
      onTap: onTap,
      child: Semantics(
        button: true,
        label: semanticLabel,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: theme.dividerColor),
          ),
          child: Icon(icon, size: 18, color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _ErpStopActions extends StatelessWidget {
  final String keepGoing;
  final String stop;
  final VoidCallback onKeepGoing;
  final VoidCallback onStop;

  const _ErpStopActions({
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
      child: Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: theme.dividerColor),
        ),
        child: child,
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final Widget child;

  const _ProgressRing({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress,
          trackColor: trackColor,
          progressColor: progressColor,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;

  const _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = 14.0;
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    final active = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    canvas.drawArc(
      rect.deflate(stroke / 2),
      -math.pi / 2,
      math.pi * 2,
      false,
      track,
    );
    canvas.drawArc(
      rect.deflate(stroke / 2),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      active,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}

BoxDecoration _softDecoration(ThemeData theme, {required double radius}) {
  return BoxDecoration(
    color: theme.appColors.input,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.75)),
  );
}

TextStyle _bodyText(ThemeData theme) {
  return theme.textTheme.bodyMedium!.copyWith(
    color: theme.appColors.textSecondary,
    height: 1.5,
  );
}

TextStyle _muted(ThemeData theme, double size) {
  return theme.textTheme.bodyMedium!.copyWith(
    color: theme.appColors.textSecondary,
    fontSize: size,
  );
}

String _formatDuration(Duration duration) {
  final total = duration.inSeconds.clamp(0, 24 * 60 * 60);
  final minutes = total ~/ 60;
  final seconds = total % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String _shortTemplateTitle(String title) {
  return title.replaceFirst('Delay ', '').replaceFirst(' Seeking', '');
}
