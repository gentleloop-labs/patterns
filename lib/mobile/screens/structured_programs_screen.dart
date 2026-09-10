import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/semantics.dart';

import '../../app_preferences.dart';
import '../../content/ocd_tracks.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/l10n.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../widgets/recovery_ui.dart';
import '../widgets/section_intro.dart';

// ---------------------------------------------------------------------------
// Program templates (code-defined content)
// ---------------------------------------------------------------------------

class ErpProgramTask {
  final String id;
  final bool fromTrack;
  const ErpProgramTask(this.id, {this.fromTrack = false});

  String localizedLabel(AppLocalizations strings) =>
      fromTrack ? strings.ocdTrackTask(id) : strings.structuredProgramTask(id);
}

class ErpProgramWeek {
  final String id;
  final bool fromTrack;
  final List<ErpProgramTask> tasks;
  const ErpProgramWeek({
    required this.id,
    required this.tasks,
    this.fromTrack = false,
  });

  String localizedTitle(AppLocalizations strings) =>
      fromTrack ? strings.ocdTrackWeek(id) : strings.structuredProgramWeek(id);
}

class ErpProgram {
  final String id;
  final String? trackId;
  final List<ErpProgramWeek> weeks;
  const ErpProgram({required this.id, required this.weeks, this.trackId});

  int get totalTasks => weeks.fold(0, (sum, w) => sum + w.tasks.length);

  String get _localizationKey => switch (id) {
    'delay-4wk' => 'delay4wk',
    'uncertainty-3wk' => 'uncertainty3wk',
    _ => id,
  };

  String get _trackLocalizationKey =>
      trackId == 'just-right' ? 'justRight' : trackId!;

  String localizedTitle(AppLocalizations strings) => trackId == null
      ? strings.structuredProgramTitle(_localizationKey)
      : strings.ocdTrackTitle(_trackLocalizationKey);

  String localizedSubtitle(AppLocalizations strings) => trackId == null
      ? strings.structuredProgramSubtitle(_localizationKey)
      : strings.ocdTrackBlurb(_trackLocalizationKey);
}

const erpPrograms = <ErpProgram>[
  ErpProgram(
    id: 'delay-4wk',
    weeks: [
      ErpProgramWeek(
        id: 'delayW1',
        tasks: [ErpProgramTask('w1a'), ErpProgramTask('w1b')],
      ),
      ErpProgramWeek(
        id: 'delayW2',
        tasks: [ErpProgramTask('w2a'), ErpProgramTask('w2b')],
      ),
      ErpProgramWeek(
        id: 'delayW3',
        tasks: [ErpProgramTask('w3a'), ErpProgramTask('w3b')],
      ),
      ErpProgramWeek(
        id: 'delayW4',
        tasks: [ErpProgramTask('w4a'), ErpProgramTask('w4b')],
      ),
    ],
  ),
  ErpProgram(
    id: 'uncertainty-3wk',
    weeks: [
      ErpProgramWeek(
        id: 'uncertaintyW1',
        tasks: [ErpProgramTask('u1a'), ErpProgramTask('u1b')],
      ),
      ErpProgramWeek(
        id: 'uncertaintyW2',
        tasks: [ErpProgramTask('u2a'), ErpProgramTask('u2b')],
      ),
      ErpProgramWeek(
        id: 'uncertaintyW3',
        tasks: [ErpProgramTask('u3a'), ErpProgramTask('u3b')],
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
    trackId: track.id,
    weeks: [
      for (final week in track.weeks)
        ErpProgramWeek(
          id: week.id,
          fromTrack: true,
          tasks: [
            for (final task in week.tasks)
              ErpProgramTask(task.id, fromTrack: true),
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
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);
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
                  child: Semantics(
                    header: true,
                    child: Text(
                      context.l10n.structuredProgramText('title'),
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
              context.l10n.structuredProgramText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'structuredPrograms'),
            _GroupLabel(
              label: context.l10n.structuredProgramText('themeGroup'),
              caption: suggestedThemes.isEmpty
                  ? context.l10n.structuredProgramText('themeGroupEmpty')
                  : context.l10n.structuredProgramText('themeGroupMatched'),
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
                calmInsightsEnabled: calmInsightsEnabled,
                onTap: () => _open(context, ref, programForTrack(track)),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 12),
            _GroupLabel(
              label: context.l10n.structuredProgramText('generalGroup'),
              caption: context.l10n.structuredProgramText('generalCaption'),
            ),
            for (final program in erpPrograms) ...[
              _ProgramCard(
                program: program,
                enrollmentId: _enrollmentIdFor(enrollments, program.id),
                completedTasks: _completedFor(
                  progress,
                  _enrollmentIdFor(enrollments, program.id),
                ),
                calmInsightsEnabled: calmInsightsEnabled,
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
    late final int enrollmentId;
    try {
      enrollmentId = await ref
          .read(programEnrollmentProvider.notifier)
          .enroll(program.id);
    } catch (_) {
      if (context.mounted) {
        showAppSnackBar(
          context,
          context.l10n.structuredProgramText('enrollError'),
          type: ToastType.error,
        );
      }
      return;
    }
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
              color: context.appColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            style: TextStyle(
              color: context.appColors.textSecondary,
              fontSize: 12.5,
            ),
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
  final bool calmInsightsEnabled;

  /// Marks a track that matches the newest self-check. A hint, not a
  /// prescription: every track stays visible and openable.
  final bool suggested;

  const _ProgramCard({
    required this.program,
    required this.enrollmentId,
    required this.completedTasks,
    required this.onTap,
    required this.calmInsightsEnabled,
    this.suggested = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = program.totalTasks;
    final pct = total == 0 ? 0.0 : completedTasks / total;
    final started = enrollmentId != null;

    final title = program.localizedTitle(context.l10n);
    final subtitle = program.localizedSubtitle(context.l10n);
    final semanticsValue = started
        ? (calmInsightsEnabled
              ? context.l10n.structuredProgramText('started')
              : context.l10n.structuredProgramProgress(
                  completedTasks,
                  total,
                  (pct * 100).round(),
                ))
        : context.l10n.structuredProgramText('notStarted');

    return Semantics(
      button: true,
      label: title,
      value: semanticsValue,
      hint: context.l10n.structuredProgramText('openHint'),
      excludeSemantics: true,
      child: PressScale(
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
                      title,
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
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.14,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        context.l10n.structuredProgramText('selfCheckMatch'),
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  if (started && !calmInsightsEnabled)
                    Text(
                      context.formatWholePercent((pct * 100).round()),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.structuredProgramSummary(
                  program.weeks.length,
                  subtitle,
                ),
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
              if (started && !calmInsightsEnabled) ...[
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 6,
                    backgroundColor: theme.dividerColor,
                    valueColor: AlwaysStoppedAnimation(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
              ] else if (!started) ...[
                const SizedBox(height: 14),
                Text(
                  context.l10n.structuredProgramText('tapToStart'),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
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
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);
    final progressState = ref.watch(programTaskProgressProvider);
    final progress = progressState.asData?.value ?? const [];
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
    final track = trackForProgramId(program.id);
    final checklistNote = track?.localizedChecklistNote(context.l10n);
    final title = program.localizedTitle(context.l10n);

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
            if (checklistNote != null) ...[
              const SizedBox(height: 14),
              Text(
                checklistNote,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  height: 1.45,
                  fontSize: 12.5,
                ),
              ),
            ],
            if (progressState.hasError) ...[
              const SizedBox(height: 14),
              Text(
                context.l10n.structuredProgramText('progressLoadError'),
                style: TextStyle(color: context.appColors.textSecondary),
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
                      calmInsightsEnabled
                          ? context.l10n.structuredProgramText(
                              'activityRecorded',
                            )
                          : done == total
                          ? context.l10n.structuredProgramComplete(total)
                          : context.l10n.structuredProgramTaskProgress(
                              done,
                              total,
                            ),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (!calmInsightsEnabled)
                    Text(
                      context.formatWholePercent((pct * 100).round()),
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
                calmInsightsEnabled: calmInsightsEnabled,
                isDone: (taskId) => _isDone(progress, i, taskId),
                onToggleExpand: () => setState(
                  () => _expandedWeek = activeExpanded == i ? -1 : i,
                ),
                onToggleTask: (taskId, completed) async {
                  final saved = await ref
                      .read(programTaskProgressProvider.notifier)
                      .toggleTask(
                        enrollmentId: widget.enrollmentId,
                        weekIndex: i,
                        taskId: taskId,
                        completed: completed,
                      );
                  if (!context.mounted) return;
                  final message = saved
                      ? context.l10n.structuredProgramTaskChanged(
                          completed ? 'completed' : 'notCompleted',
                        )
                      : context.l10n.structuredProgramText('taskSaveError');
                  if (!saved) {
                    showAppSnackBar(context, message, type: ToastType.error);
                  }
                  await SemanticsService.sendAnnouncement(
                    View.of(context),
                    message,
                    Directionality.of(context),
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
  final bool calmInsightsEnabled;
  final bool Function(String taskId) isDone;
  final VoidCallback onToggleExpand;
  final Future<void> Function(String taskId, bool completed) onToggleTask;

  const _WeekSection({
    required this.week,
    required this.weekIndex,
    required this.expanded,
    required this.calmInsightsEnabled,
    required this.isDone,
    required this.onToggleExpand,
    required this.onToggleTask,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final doneCount = week.tasks.where((t) => isDone(t.id)).length;
    final allDone = doneCount == week.tasks.length;

    final title = week.localizedTitle(context.l10n);
    final state = allDone
        ? context.l10n.structuredProgramText('weekComplete')
        : context.l10n.structuredProgramText('weekNotComplete');
    return Container(
      decoration: recoverySoftDecoration(theme),
      child: Column(
        children: [
          Semantics(
            button: true,
            expanded: expanded,
            label: title,
            value: state,
            hint: context.l10n.structuredProgramText('weekToggleHint'),
            excludeSemantics: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: onToggleExpand,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 44),
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
                            : context.appColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (!calmInsightsEnabled)
                        Text(
                          context.l10n.structuredProgramCompactProgress(
                            doneCount,
                            week.tasks.length,
                          ),
                          style: TextStyle(
                            color: context.appColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(width: 6),
                      Icon(
                        expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: context.appColors.textSecondary,
                      ),
                    ],
                  ),
                ),
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
                      label: task.localizedLabel(context.l10n),
                      done: isDone(task.id),
                      onChanged: (v) => onToggleTask(task.id, v),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final String label;
  final bool done;
  final Future<void> Function(bool) onChanged;

  const _TaskRow({
    required this.label,
    required this.done,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      checked: done,
      label: label,
      hint: context.l10n.structuredProgramText('taskToggleHint'),
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onChanged(!done),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  done
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank,
                  color: done
                      ? theme.colorScheme.primary
                      : context.appColors.textSecondary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.35,
                      color: done
                          ? context.appColors.textSecondary
                          : theme.colorScheme.onSurface,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
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
