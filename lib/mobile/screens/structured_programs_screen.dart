import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/ocd_tracks.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../widgets/recovery_ui.dart';
import '../widgets/section_intro.dart';

// ---------------------------------------------------------------------------
// Program templates (code-defined content)
// ---------------------------------------------------------------------------

class ErpProgramTask {
  final String id;
  final String label;
  const ErpProgramTask(this.id, this.label);
}

class ErpProgramWeek {
  final String title;
  final List<ErpProgramTask> tasks;
  const ErpProgramWeek({required this.title, required this.tasks});
}

class ErpProgram {
  final String id;
  final String title;
  final String subtitle;
  final List<ErpProgramWeek> weeks;
  const ErpProgram({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.weeks,
  });

  int get totalTasks => weeks.fold(0, (sum, w) => sum + w.tasks.length);
}

const erpPrograms = <ErpProgram>[
  ErpProgram(
    id: 'delay-4wk',
    title: '4-Week Compulsion Delay',
    subtitle: 'Build delay tolerance, one week at a time',
    weeks: [
      ErpProgramWeek(
        title: 'Week 1 · Notice & name',
        tasks: [
          ErpProgramTask('w1a', 'Log 3 urges without acting immediately'),
          ErpProgramTask('w1b', 'Delay one compulsion by 1 minute, 3 times'),
        ],
      ),
      ErpProgramWeek(
        title: 'Week 2 · Stretch the gap',
        tasks: [
          ErpProgramTask('w2a', 'Delay compulsions by 5 minutes'),
          ErpProgramTask('w2b', 'Try urge surfing once'),
        ],
      ),
      ErpProgramWeek(
        title: 'Week 3 · Sit longer',
        tasks: [
          ErpProgramTask('w3a', 'Delay by 15 minutes'),
          ErpProgramTask('w3b', 'Resist one reassurance-seeking urge'),
        ],
      ),
      ErpProgramWeek(
        title: 'Week 4 · Daily practice',
        tasks: [
          ErpProgramTask('w4a', 'Complete one exposure each day'),
          ErpProgramTask('w4b', 'Reflect on what has changed'),
        ],
      ),
    ],
  ),
  ErpProgram(
    id: 'uncertainty-3wk',
    title: 'Uncertainty Tolerance',
    subtitle: 'Practise living with not knowing',
    weeks: [
      ErpProgramWeek(
        title: 'Week 1 · Leave it open',
        tasks: [
          ErpProgramTask('u1a', 'Leave one question unanswered'),
          ErpProgramTask('u1b', 'Resist checking once'),
        ],
      ),
      ErpProgramWeek(
        title: 'Week 2 · Maybe, maybe not',
        tasks: [
          ErpProgramTask('u2a', 'Use a "maybe, maybe not" response 3 times'),
          ErpProgramTask('u2b', 'Delay googling a worry'),
        ],
      ),
      ErpProgramWeek(
        title: 'Week 3 · Let it be',
        tasks: [
          ErpProgramTask('u3a', 'Go a day without seeking certainty'),
          ErpProgramTask('u3b', 'Reflect on your progress'),
        ],
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// OCD theme tracks
// ---------------------------------------------------------------------------

/// Adapts a themed track into the program shape the catalogue and detail screen
/// already understand, so enrollment and per-task progress work unchanged.
ErpProgram programForTrack(OcdTrack track) {
  return ErpProgram(
    id: track.programId,
    title: track.title,
    subtitle: track.blurb,
    weeks: [
      for (final week in track.weeks)
        ErpProgramWeek(
          title: week.title,
          tasks: [
            for (final task in week.tasks) ErpProgramTask(task.id, task.label),
          ],
        ),
    ],
  );
}

/// The track a program id came from, or null for a hand-written program.
OcdTrack? trackForProgramId(String programId) {
  for (final track in ocdTracks) {
    if (track.programId == programId) return track;
  }
  return null;
}

/// Every track as a program, in catalogue order.
final trackPrograms = <ErpProgram>[
  for (final track in ocdTracks) programForTrack(track),
];

// ---------------------------------------------------------------------------
// Catalog
// ---------------------------------------------------------------------------

class StructuredProgramsScreen extends ConsumerWidget {
  const StructuredProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final enrollments =
        ref.watch(programEnrollmentProvider).asData?.value ?? const [];
    final progress =
        ref.watch(programTaskProgressProvider).asData?.value ?? const [];
    // The newest self-check's flagged categories, used only to mark which
    // tracks are likely relevant. Never used to hide or reorder anything: the
    // whole catalogue stays visible whatever the assessment said.
    final assessments =
        ref.watch(ybocsAssessmentProvider).asData?.value ?? const [];
    final suggestedThemes = _newestThemes(assessments);

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
                  child: Text(
                    'Structured Programs',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Follow a guided, week-by-week plan at your own pace.',
              style: TextStyle(color: AppTheme.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'structuredPrograms'),
            _GroupLabel(
              label: 'By OCD theme',
              caption: suggestedThemes.isEmpty
                  ? 'Pick the one that sounds most like your OCD.'
                  : 'Your last self-check points at the ones marked below.',
            ),
            for (final track in ocdTracks) ...[
              _ProgramCard(
                program: programForTrack(track),
                enrollmentId: _enrollmentIdFor(enrollments, track.programId),
                completedTasks: _completedFor(
                  progress,
                  _enrollmentIdFor(enrollments, track.programId),
                ),
                suggested: track.matchesThemes(suggestedThemes),
                onTap: () => _open(context, ref, programForTrack(track)),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 12),
            const _GroupLabel(
              label: 'General practice',
              caption: 'Skills that apply whatever the theme is.',
            ),
            for (final program in erpPrograms) ...[
              _ProgramCard(
                program: program,
                enrollmentId: _enrollmentIdFor(enrollments, program.id),
                completedTasks: _completedFor(
                  progress,
                  _enrollmentIdFor(enrollments, program.id),
                ),
                onTap: () => _open(context, ref, program),
              ),
              const SizedBox(height: 10),
            ],
          ]),
        ),
      ),
    );
  }

  /// Themes from the most recent self-check. Picks by date rather than trusting
  /// the provider's ordering, so a change to the query cannot silently start
  /// suggesting tracks from a year-old assessment.
  List<String> _newestThemes(List<YbocsAssessment> assessments) {
    if (assessments.isEmpty) return const [];
    var newest = assessments.first;
    for (final a in assessments.skip(1)) {
      if (a.datetime.isAfter(newest.datetime)) newest = a;
    }
    return newest.themes;
  }

  int? _enrollmentIdFor(List<ProgramEnrollment> enrollments, String programId) {
    for (final e in enrollments) {
      if (e.programId == programId) return e.id;
    }
    return null;
  }

  int _completedFor(List<ProgramTaskProgress> progress, int? enrollmentId) {
    if (enrollmentId == null) return 0;
    return progress.where((p) => p.enrollmentId == enrollmentId).length;
  }

  Future<void> _open(
    BuildContext context,
    WidgetRef ref,
    ErpProgram program,
  ) async {
    final enrollmentId = await ref
        .read(programEnrollmentProvider.notifier)
        .enroll(program.id);
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ProgramDetailScreen(program: program, enrollmentId: enrollmentId),
      ),
    );
  }
}

/// Section heading inside the catalogue. Keeps the themed tracks visually
/// separate from the general programs without nesting them in cards.
class _GroupLabel extends StatelessWidget {
  final String label;
  final String caption;

  const _GroupLabel({required this.label, required this.caption});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final ErpProgram program;
  final int? enrollmentId;
  final int completedTasks;
  final VoidCallback onTap;

  /// Marks a track that matches the newest self-check. A hint, not a
  /// prescription: every track stays visible and openable.
  final bool suggested;

  const _ProgramCard({
    required this.program,
    required this.enrollmentId,
    required this.completedTasks,
    required this.onTap,
    this.suggested = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = program.totalTasks;
    final pct = total == 0 ? 0.0 : completedTasks / total;
    final started = enrollmentId != null;

    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: recoverySoftDecoration(theme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    program.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (suggested && !started)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'From your self-check',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                if (started)
                  Text(
                    '${(pct * 100).round()}%',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${program.weeks.length} weeks · ${program.subtitle}',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
                height: 1.3,
              ),
            ),
            if (started) ...[
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: pct,
                  minHeight: 6,
                  backgroundColor: theme.dividerColor,
                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                ),
              ),
            ] else ...[
              const SizedBox(height: 14),
              Text(
                'Tap to start',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail
// ---------------------------------------------------------------------------

class ProgramDetailScreen extends ConsumerStatefulWidget {
  final ErpProgram program;
  final int enrollmentId;

  const ProgramDetailScreen({
    super.key,
    required this.program,
    required this.enrollmentId,
  });

  @override
  ConsumerState<ProgramDetailScreen> createState() =>
      _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends ConsumerState<ProgramDetailScreen> {
  int? _expandedWeek;

  bool _isDone(
    List<ProgramTaskProgress> progress,
    int weekIndex,
    String taskId,
  ) {
    return progress.any(
      (p) =>
          p.enrollmentId == widget.enrollmentId &&
          p.weekIndex == weekIndex &&
          p.taskId == taskId,
    );
  }

  int _currentWeek(List<ProgramTaskProgress> progress) {
    for (var i = 0; i < widget.program.weeks.length; i++) {
      final week = widget.program.weeks[i];
      final allDone = week.tasks.every((t) => _isDone(progress, i, t.id));
      if (!allDone) return i;
    }
    return widget.program.weeks.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress =
        ref.watch(programTaskProgressProvider).asData?.value ?? const [];
    final program = widget.program;
    final total = program.totalTasks;
    final done = progress
        .where((p) => p.enrollmentId == widget.enrollmentId)
        .length;
    final pct = total == 0 ? 0.0 : done / total;
    final currentWeek = _currentWeek(progress);
    final activeExpanded = _expandedWeek ?? currentWeek;
    // Only themed tracks carry a note, and only when the theme is absent from
    // the Y-BOCS checklist.
    final checklistNote = trackForProgramId(program.id)?.checklistNote;

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
                  child: Text(
                    program.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            if (checklistNote != null) ...[
              const SizedBox(height: 14),
              Text(
                checklistNote,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  height: 1.45,
                  fontSize: 12.5,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: recoverySoftDecoration(theme, radius: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      done == total
                          ? 'Program complete. Wonderful work.'
                          : '$done of $total tasks done',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '${(pct * 100).round()}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            for (var i = 0; i < program.weeks.length; i++) ...[
              _WeekSection(
                week: program.weeks[i],
                weekIndex: i,
                expanded: activeExpanded == i,
                isFuture: i > currentWeek,
                isDone: (taskId) => _isDone(progress, i, taskId),
                onToggleExpand: () => setState(
                  () => _expandedWeek = activeExpanded == i ? -1 : i,
                ),
                onToggleTask: (taskId, completed) {
                  ref
                      .read(programTaskProgressProvider.notifier)
                      .toggleTask(
                        enrollmentId: widget.enrollmentId,
                        weekIndex: i,
                        taskId: taskId,
                        completed: completed,
                      );
                },
              ),
              const SizedBox(height: 10),
            ],
          ]),
        ),
      ),
    );
  }
}

class _WeekSection extends StatelessWidget {
  final ErpProgramWeek week;
  final int weekIndex;
  final bool expanded;
  final bool isFuture;
  final bool Function(String taskId) isDone;
  final VoidCallback onToggleExpand;
  final void Function(String taskId, bool completed) onToggleTask;

  const _WeekSection({
    required this.week,
    required this.weekIndex,
    required this.expanded,
    required this.isFuture,
    required this.isDone,
    required this.onToggleExpand,
    required this.onToggleTask,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final doneCount = week.tasks.where((t) => isDone(t.id)).length;
    final allDone = doneCount == week.tasks.length;

    return Opacity(
      opacity: isFuture ? 0.55 : 1.0,
      child: Container(
        decoration: recoverySoftDecoration(theme),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: onToggleExpand,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      allDone
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      color: allDone
                          ? theme.colorScheme.primary
                          : AppTheme.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        week.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      '$doneCount/${week.tasks.length}',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppTheme.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            if (expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Column(
                  children: [
                    for (final task in week.tasks)
                      _TaskRow(
                        label: task.label,
                        done: isDone(task.id),
                        onChanged: (v) => onToggleTask(task.id, v),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final String label;
  final bool done;
  final ValueChanged<bool> onChanged;

  const _TaskRow({
    required this.label,
    required this.done,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onChanged(!done),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              done ? Icons.check_box_rounded : Icons.check_box_outline_blank,
              color: done ? theme.colorScheme.primary : AppTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.35,
                  color: done
                      ? AppTheme.textSecondary
                      : theme.colorScheme.onSurface,
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
