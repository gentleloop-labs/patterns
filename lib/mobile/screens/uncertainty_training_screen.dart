import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/semantics.dart';

import '../../app_preferences.dart';
import '../../l10n/l10n.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../widgets/recovery_ui.dart';
import '../widgets/section_intro.dart';

class UncertaintyExercise {
  final String id;
  const UncertaintyExercise({required this.id});
}

const uncertaintyExercises = <UncertaintyExercise>[
  UncertaintyExercise(id: 'maybe'),
  UncertaintyExercise(id: 'unanswered'),
  UncertaintyExercise(id: 'resist'),
];

class UncertaintyTrainingScreen extends ConsumerWidget {
  const UncertaintyTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);
    final logsValue = ref.watch(uncertaintyLogProvider);
    final logs = logsValue.asData?.value ?? const <UncertaintyLog>[];

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
                      strings.uncertaintyTrainingText('title'),
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
              strings.uncertaintyTrainingText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'uncertaintyTraining'),
            if (logsValue.hasError) ...[
              Text(
                strings.uncertaintyTrainingText('loadError'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
              const SizedBox(height: 12),
            ],
            for (final exercise in uncertaintyExercises) ...[
              _ExerciseCard(
                exercise: exercise,
                practiceCount: calmInsightsEnabled
                    ? null
                    : logs.where((l) => l.exerciseId == exercise.id).length,
                onTap: () => _openPractice(context, exercise),
              ),
              const SizedBox(height: 10),
            ],
          ]),
        ),
      ),
    );
  }

  void _openPractice(BuildContext context, UncertaintyExercise exercise) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => UncertaintyPracticeScreen(exercise: exercise),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final UncertaintyExercise exercise;
  final int? practiceCount;
  final VoidCallback onTap;

  const _ExerciseCard({
    required this.exercise,
    required this.practiceCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final title = strings.uncertaintyExerciseTitle(exercise.id);
    final intro = strings.uncertaintyExerciseIntro(exercise.id);
    final summary = practiceCount == null
        ? strings.uncertaintyExerciseSummary(title, intro)
        : strings.uncertaintyExerciseSummaryWithCount(
            title,
            intro,
            practiceCount!,
          );
    return Semantics(
      button: true,
      label: summary,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.all(18),
          decoration: recoverySoftDecoration(theme),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  if (practiceCount != null && practiceCount! > 0)
                    Text(
                      strings.uncertaintyPracticeCount(practiceCount!),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                intro,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UncertaintyPracticeScreen extends ConsumerStatefulWidget {
  final UncertaintyExercise exercise;
  const UncertaintyPracticeScreen({super.key, required this.exercise});

  @override
  ConsumerState<UncertaintyPracticeScreen> createState() =>
      _UncertaintyPracticeScreenState();
}

class _UncertaintyPracticeScreenState
    extends ConsumerState<UncertaintyPracticeScreen> {
  final _note = TextEditingController();
  double _willingness = 5;
  bool _saving = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _log() async {
    final strings = context.l10n;
    setState(() => _saving = true);
    final now = DateTime.now();
    final saved = await ref
        .read(uncertaintyLogProvider.notifier)
        .add(
          UncertaintyLog(
            datetime: now,
            exerciseId: widget.exercise.id,
            willingness: _willingness.round(),
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
            createdAt: now,
          ),
        );
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      final message = strings.uncertaintyTrainingText('saveError');
      showAppSnackBar(context, message, type: ToastType.error);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    Navigator.of(context).pop();
    final message = strings.uncertaintyTrainingText('saveSuccess');
    showAppSnackBar(context, message, type: ToastType.success);
    await SemanticsService.sendAnnouncement(
      View.of(context),
      message,
      Directionality.of(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final exercise = widget.exercise;
    final title = strings.uncertaintyExerciseTitle(exercise.id);
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: recoverySoftDecoration(theme, radius: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.uncertaintyExerciseIntro(exercise.id),
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    strings.uncertaintyTrainingText('whyLabel'),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: context.appColors.textSecondary,
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    strings.uncertaintyExerciseWhy(exercise.id),
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                strings.uncertaintyExercisePrompt(exercise.id),
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: recoverySoftDecoration(theme, radius: 18),
              child: RatingSlider(
                label: strings.uncertaintyTrainingText('willingnessLabel'),
                value: _willingness,
                onChanged: (v) => setState(() => _willingness = v),
                valueFormatter: strings.uncertaintyWillingness,
              ),
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.uncertaintyTrainingText('noteLabel'),
              hint: strings.uncertaintyTrainingText('noteHint'),
              controller: _note,
              minLines: 2,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _log,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(strings.uncertaintyTrainingText('saveAction')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
