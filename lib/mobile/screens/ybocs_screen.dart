import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/semantics.dart';
import 'package:line_icons/line_icons.dart';

import '../../l10n/l10n.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../first_run.dart';
import '../widgets/recovery_ui.dart';
import 'ybocs_content.dart';

/// The Y-BOCS self-check: a staged flow that stays simple no matter how many
/// items it holds. Intro → symptom checklist → one-question-at-a-time severity
/// → results. Results can be saved locally for later reference.
///
/// This is a self-check aid, not a diagnosis — the UI says so at the start and
/// again at the end.
class YbocsScreen extends ConsumerStatefulWidget {
  /// First-run mode (the "understand my patterns" path). When the user finishes
  /// and saves, closing pops a [FirstRunActivityResult] so the shell shows the
  /// result screen.
  final bool firstRun;

  const YbocsScreen({super.key, this.firstRun = false});

  @override
  ConsumerState<YbocsScreen> createState() => _YbocsScreenState();
}

enum _Stage { intro, checklist, severity, results }

class _YbocsScreenState extends ConsumerState<YbocsScreen> {
  _Stage _stage = _Stage.intro;
  final Set<String> _selectedSymptoms = {};
  final List<int?> _answers = List<int?>.filled(
    ybocsSeverityQuestions.length,
    null,
  );
  int _questionIndex = 0;
  bool _saved = false;
  bool _saving = false;

  int get _obsessionScore {
    var sum = 0;
    for (var i = 0; i < ybocsSeverityQuestions.length; i++) {
      if (ybocsSeverityQuestions[i].dimension == YbocsDimension.obsessions) {
        sum += _answers[i] ?? 0;
      }
    }
    return sum;
  }

  int get _compulsionScore {
    var sum = 0;
    for (var i = 0; i < ybocsSeverityQuestions.length; i++) {
      if (ybocsSeverityQuestions[i].dimension == YbocsDimension.compulsions) {
        sum += _answers[i] ?? 0;
      }
    }
    return sum;
  }

  int get _total => _obsessionScore + _compulsionScore;

  List<YbocsSymptomCategory> get _selectedCategories => ybocsCategories
      .where((c) => c.items.any((i) => _selectedSymptoms.contains(i.id)))
      .toList();

  void _goTo(_Stage stage) => setState(() => _stage = stage);

  void _restart() {
    setState(() {
      _stage = _Stage.checklist;
      _selectedSymptoms.clear();
      for (var i = 0; i < _answers.length; i++) {
        _answers[i] = null;
      }
      _questionIndex = 0;
      _saved = false;
      _saving = false;
    });
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final strings = context.l10n;
    final now = DateTime.now();
    final assessment = YbocsAssessment(
      datetime: now,
      obsessionScore: _obsessionScore,
      compulsionScore: _compulsionScore,
      totalScore: _total,
      severity: ybocsSeverityForScore(_total),
      itemScores: _answers.map((a) => a ?? 0).toList(),
      themes: _selectedCategories.map((c) => c.id).toList(),
      symptoms: _selectedSymptoms.toList(),
      createdAt: now,
    );
    await ref.read(ybocsAssessmentProvider.notifier).add(assessment);
    if (!mounted) return;
    final failed = ref.read(ybocsAssessmentProvider).hasError;
    final message = strings.ybocsText(failed ? 'saveError' : 'saveSuccess');
    setState(() {
      _saved = !failed;
      _saving = false;
    });
    showAppSnackBar(
      context,
      message,
      type: failed ? ToastType.error : ToastType.success,
    );
    await SemanticsService.sendAnnouncement(
      View.of(context),
      message,
      Directionality.of(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: switch (_stage) {
          _Stage.intro => _IntroView(
            onBegin: () => _goTo(_Stage.checklist),
            onClose: () => Navigator.of(context).pop(),
          ),
          _Stage.checklist => _ChecklistView(
            selected: _selectedSymptoms,
            onToggle: (id) => setState(() {
              if (!_selectedSymptoms.add(id)) _selectedSymptoms.remove(id);
            }),
            onBack: () => _goTo(_Stage.intro),
            onContinue: () => _goTo(_Stage.severity),
          ),
          _Stage.severity => _SeverityView(
            index: _questionIndex,
            answers: _answers,
            onSelect: (score) =>
                setState(() => _answers[_questionIndex] = score),
            onBack: () {
              if (_questionIndex == 0) {
                _goTo(_Stage.checklist);
              } else {
                setState(() => _questionIndex--);
              }
            },
            onNext: () {
              if (_questionIndex == ybocsSeverityQuestions.length - 1) {
                _goTo(_Stage.results);
              } else {
                setState(() => _questionIndex++);
              }
            },
          ),
          _Stage.results => _ResultsView(
            obsessionScore: _obsessionScore,
            compulsionScore: _compulsionScore,
            total: _total,
            categories: _selectedCategories,
            saved: _saved,
            saving: _saving,
            onSave: _save,
            onRetake: _restart,
            onClose: () => Navigator.of(context).pop(
              widget.firstRun && _saved ? const FirstRunActivityResult() : null,
            ),
          ),
        },
      ),
    );
  }
}

// ── Intro ──────────────────────────────────────────────────────────────────

class _IntroView extends ConsumerWidget {
  final VoidCallback onBegin;
  final VoidCallback onClose;

  const _IntroView({required this.onBegin, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final history =
        ref.watch(ybocsAssessmentProvider).asData?.value ?? const [];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
      children: staggered([
        Row(
          children: [
            CircleBackButton(onTap: onClose),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  strings.ybocsText('title'),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          strings.ybocsText('introBody'),
          style: TextStyle(
            color: context.appColors.textSecondary,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        const _DisclaimerCard(),
        const SizedBox(height: 16),
        _CockpitCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IntroPoint(
                icon: Icons.checklist_rounded,
                title: strings.ybocsText('spotTitle'),
                body: strings.ybocsText('spotBody'),
              ),
              const SizedBox(height: 14),
              _IntroPoint(
                icon: Icons.speed_rounded,
                title: strings.ybocsText('impactTitle'),
                body: strings.ybocsText('impactBody'),
              ),
              const SizedBox(height: 14),
              _IntroPoint(
                icon: Icons.insights_rounded,
                title: strings.ybocsText('resultIntroTitle'),
                body: strings.ybocsText('resultIntroBody'),
              ),
            ],
          ),
        ),
        if (history.isNotEmpty) ...[
          const SizedBox(height: 16),
          _HistorySection(history: history),
        ],
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onBegin,
            child: Text(
              strings.ybocsText(history.isEmpty ? 'begin' : 'retakeAction'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          strings.ybocsText('privacyDuration'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 12.5,
          ),
        ),
      ]),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  const _DisclaimerCard();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.appColors.accent.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: context.appColors.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              strings.ybocsText('disclaimer'),
              style: TextStyle(
                color: context.appColors.textPrimary,
                height: 1.45,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroPoint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _IntroPoint({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.appColors.accent.withValues(alpha: 0.14),
          ),
          child: Icon(icon, color: context.appColors.accent, size: 21),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HistorySection extends ConsumerWidget {
  final List<YbocsAssessment> history;

  const _HistorySection({required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.l10n;
    return _CockpitCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              strings.ybocsText('historyTitle'),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            strings.ybocsText('historyBody'),
            style: TextStyle(
              color: context.appColors.textSecondary,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 12),
          for (final a in history.take(5)) ...[
            _HistoryRow(
              assessment: a,
              onDelete: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(strings.ybocsText('deleteTitle')),
                    content: Text(strings.ybocsText('deleteBody')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(strings.ybocsText('cancel')),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(strings.ybocsText('deleteAction')),
                      ),
                    ],
                  ),
                );
                if (confirmed == true && a.id != null) {
                  await ref
                      .read(ybocsAssessmentProvider.notifier)
                      .delete(a.id!);
                  if (!context.mounted) return;
                  final failed = ref.read(ybocsAssessmentProvider).hasError;
                  final message = strings.ybocsText(
                    failed ? 'deleteError' : 'deleteSuccess',
                  );
                  if (failed) {
                    showAppSnackBar(context, message, type: ToastType.error);
                  }
                  await SemanticsService.sendAnnouncement(
                    View.of(context),
                    message,
                    Directionality.of(context),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final YbocsAssessment assessment;
  final VoidCallback onDelete;

  const _HistoryRow({required this.assessment, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final severity = assessment.severity.localizedLabel(strings);
    final date = context.formatFullDate(assessment.datetime);
    final summary = strings.ybocsHistorySummary(
      severity,
      assessment.totalScore,
      date,
    );
    return Semantics(
      label: summary,
      container: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
        decoration: BoxDecoration(
          color: context.appColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.appColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: assessment.severity.color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$severity · ${assessment.totalScore}/40',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                LineIcons.trash,
                size: 18,
                color: context.appColors.textSecondary,
              ),
              tooltip: strings.ybocsText('deleteTooltip'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Checklist ────────────────────────────────────────────────────────────────

class _ChecklistView extends StatelessWidget {
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const _ChecklistView({
    required this.selected,
    required this.onToggle,
    required this.onBack,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final obsessions = ybocsCategories.where(
      (c) => c.kind == YbocsDimension.obsessions,
    );
    final compulsions = ybocsCategories.where(
      (c) => c.kind == YbocsDimension.compulsions,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Row(
            children: [
              CircleBackButton(onTap: onBack),
              const SizedBox(width: 12),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    strings.ybocsText('checklistTitle'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            children: staggered([
              Text(
                strings.ybocsText('checklistBody'),
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              _GroupLabel(
                label: strings.ybocsText('obsessions'),
                sub: strings.ybocsText('obsessionsDescription'),
              ),
              const SizedBox(height: 10),
              for (final c in obsessions) ...[
                _CategoryBlock(
                  category: c,
                  selected: selected,
                  onToggle: onToggle,
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 12),
              _GroupLabel(
                label: strings.ybocsText('compulsions'),
                sub: strings.ybocsText('compulsionsDescription'),
              ),
              const SizedBox(height: 10),
              for (final c in compulsions) ...[
                _CategoryBlock(
                  category: c,
                  selected: selected,
                  onToggle: onToggle,
                ),
                const SizedBox(height: 10),
              ],
            ]),
          ),
        ),
        _BottomBar(
          child: ElevatedButton(
            onPressed: onContinue,
            child: Text(strings.ybocsSelectedCount(selected.length)),
          ),
        ),
      ],
    );
  }
}

class _GroupLabel extends StatelessWidget {
  final String label;
  final String sub;

  const _GroupLabel({required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          sub,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}

class _CategoryBlock extends StatelessWidget {
  final YbocsSymptomCategory category;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _CategoryBlock({
    required this.category,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final count = category.items.where((i) => selected.contains(i.id)).length;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
      decoration: recoverySoftDecoration(theme, radius: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  category.localizedTitle(strings),
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5),
                ),
              ),
              if (count > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Semantics(
                    label: strings.ybocsCategorySelectedCount(count),
                    excludeSemantics: true,
                    child: Text(
                      context.formatInteger(count),
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          for (final item in category.items)
            _CheckRow(
              label: item.localizedLabel(strings),
              checked: selected.contains(item.id),
              onTap: () => onToggle(item.id),
            ),
        ],
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  final String label;
  final bool checked;
  final VoidCallback onTap;

  const _CheckRow({
    required this.label,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      checked: checked,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: motionDisabled(context)
                      ? Duration.zero
                      : AppMotion.fast,
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: checked
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: checked
                          ? theme.colorScheme.primary
                          : const Color(0xFF4A473F),
                      width: 1.5,
                    ),
                  ),
                  child: checked
                      ? Icon(
                          Icons.check_rounded,
                          size: 15,
                          color: theme.colorScheme.onPrimary,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.35,
                      color: checked
                          ? context.appColors.textPrimary
                          : context.appColors.textSecondary,
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

// ── Severity ─────────────────────────────────────────────────────────────────

class _SeverityView extends StatelessWidget {
  final int index;
  final List<int?> answers;
  final ValueChanged<int> onSelect;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _SeverityView({
    required this.index,
    required this.answers,
    required this.onSelect,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final total = ybocsSeverityQuestions.length;
    final question = ybocsSeverityQuestions[index];
    final answer = answers[index];
    final isLast = index == total - 1;
    final dimensionLabel = question.dimension == YbocsDimension.obsessions
        ? strings.ybocsText('obsessions')
        : strings.ybocsText('compulsions');
    final progress = strings.ybocsQuestionProgress(index + 1, total);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Row(
            children: [
              CircleBackButton(onTap: onBack),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      progress,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      dimensionLabel,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Semantics(
            label: progress,
            value: context.formatWholePercent((index + 1) / total * 100),
            child: ExcludeSemantics(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: (index + 1) / total,
                  minHeight: 6,
                  backgroundColor: const Color(0xFF2B2926),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.appColors.accent,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            key: ValueKey(index),
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            children: staggered([
              Text(
                question.localizedPrompt(strings),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i <= 4; i++) ...[
                _OptionRow(
                  label: question.localizedOption(strings, i),
                  selected: answer == i,
                  onTap: () => onSelect(i),
                ),
                const SizedBox(height: 10),
              ],
            ]),
          ),
        ),
        _BottomBar(
          child: ElevatedButton(
            onPressed: answer == null ? null : onNext,
            child: Text(strings.ybocsText(isLast ? 'seeResults' : 'next')),
          ),
        ),
      ],
    );
  }
}

class _OptionRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OptionRow({
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
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: AnimatedContainer(
          duration: motionDisabled(context) ? Duration.zero : AppMotion.fast,
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primary.withValues(alpha: 0.12)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? theme.colorScheme.primary : theme.dividerColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? theme.colorScheme.primary
                        : const Color(0xFF4A473F),
                    width: 2,
                  ),
                ),
                child: selected
                    ? Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Results ──────────────────────────────────────────────────────────────────

class _ResultsView extends StatelessWidget {
  final int obsessionScore;
  final int compulsionScore;
  final int total;
  final List<YbocsSymptomCategory> categories;
  final bool saved;
  final bool saving;
  final Future<void> Function() onSave;
  final VoidCallback onRetake;
  final VoidCallback onClose;

  const _ResultsView({
    required this.obsessionScore,
    required this.compulsionScore,
    required this.total,
    required this.categories,
    required this.saved,
    required this.saving,
    required this.onSave,
    required this.onRetake,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final severity = ybocsSeverityForScore(total);
    final hasObsessions =
        categories.any((c) => c.kind == YbocsDimension.obsessions) ||
        obsessionScore > 0;
    final hasCompulsions =
        categories.any((c) => c.kind == YbocsDimension.compulsions) ||
        compulsionScore > 0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Row(
            children: [
              CircleBackButton(onTap: onClose),
              const SizedBox(width: 12),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    strings.ybocsText('resultsTitle'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: staggered([
              _SeverityCard(severity: severity, total: total),
              const SizedBox(height: 14),
              _BreakdownCard(
                obsessionScore: obsessionScore,
                compulsionScore: compulsionScore,
              ),
              const SizedBox(height: 14),
              _TypesCard(
                hasObsessions: hasObsessions,
                hasCompulsions: hasCompulsions,
              ),
              if (categories.isNotEmpty) ...[
                const SizedBox(height: 14),
                _ThemesCard(categories: categories),
              ],
              const SizedBox(height: 14),
              const _NextStepsCard(),
            ]),
          ),
        ),
        _BottomBar(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stack = MediaQuery.textScalerOf(context).scale(1) >= 1.5;
              final retake = OutlinedButton(
                onPressed: saving ? null : onRetake,
                child: Text(strings.ybocsText('retake')),
              );
              final save = ElevatedButton(
                onPressed: saved || saving ? null : () => onSave(),
                child: Text(
                  strings.ybocsText(
                    saving ? 'saving' : (saved ? 'saved' : 'saveHistory'),
                  ),
                ),
              );
              if (stack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [save, const SizedBox(height: 8), retake],
                );
              }
              return Row(
                children: [
                  Expanded(child: retake),
                  const SizedBox(width: 12),
                  Expanded(flex: 2, child: save),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SeverityCard extends StatelessWidget {
  final YbocsSeverity severity;
  final int total;

  const _SeverityCard({required this.severity, required this.total});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final severityLabel = severity.localizedLabel(strings);
    final score = strings.ybocsScoreOutOf(total, 40);
    final summary = strings.ybocsSeveritySummary(
      severityLabel,
      score,
      severity.localizedBlurb(strings),
    );
    return Semantics(
      container: true,
      label: summary,
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              severity.color.withValues(alpha: 0.20),
              severity.color.withValues(alpha: 0.06),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: severity.color.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: [
                Text(
                  '$total',
                  style: TextStyle(
                    fontFamily: AppTheme.displayFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 52,
                    height: 1,
                    color: severity.color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    ' / 40',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: severity.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    severityLabel,
                    style: TextStyle(
                      color: severity.color,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              severity.localizedBlurb(strings),
              style: TextStyle(
                color: context.appColors.textPrimary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  final int obsessionScore;
  final int compulsionScore;

  const _BreakdownCard({
    required this.obsessionScore,
    required this.compulsionScore,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return _CockpitCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              strings.ybocsText('breakdownTitle'),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          const SizedBox(height: 14),
          _ScoreBar(
            label: strings.ybocsText('obsessions'),
            score: obsessionScore,
          ),
          const SizedBox(height: 12),
          _ScoreBar(
            label: strings.ybocsText('compulsions'),
            score: compulsionScore,
          ),
        ],
      ),
    );
  }
}

class _ScoreBar extends StatelessWidget {
  final String label;
  final int score; // out of 20

  const _ScoreBar({required this.label, required this.score});

  @override
  Widget build(BuildContext context) {
    final scoreLabel = context.l10n.ybocsScoreOutOf(score, 20);
    final summary = context.l10n.ybocsSubtotalSummary(label, scoreLabel);
    return Semantics(
      label: summary,
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
                ),
              ),
              Text(
                '$score/20',
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ExcludeSemantics(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: score / 20,
                minHeight: 8,
                backgroundColor: const Color(0xFF2B2926),
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.appColors.accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypesCard extends StatelessWidget {
  final bool hasObsessions;
  final bool hasCompulsions;

  const _TypesCard({required this.hasObsessions, required this.hasCompulsions});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final types = <String>[
      if (hasObsessions) strings.ybocsText('obsessions'),
      if (hasCompulsions) strings.ybocsText('compulsions'),
    ];
    final text = switch ((hasObsessions, hasCompulsions)) {
      (false, false) => strings.ybocsText('typesNone'),
      (true, true) => strings.ybocsText('typesBoth'),
      (true, false) => strings.ybocsText('typesObsessions'),
      (false, true) => strings.ybocsText('typesCompulsions'),
    };
    return _CockpitCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              strings.ybocsText('typesTitle'),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          if (types.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final t in types) _Chip(label: t)],
            ),
          if (types.isNotEmpty) const SizedBox(height: 12),
          Text(
            text,
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

class _ThemesCard extends StatelessWidget {
  final List<YbocsSymptomCategory> categories;

  const _ThemesCard({required this.categories});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return _CockpitCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              strings.ybocsText('themesTitle'),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            strings.ybocsText('themesBody'),
            style: TextStyle(
              color: context.appColors.textSecondary,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c in categories)
                _Chip(label: c.localizedTitle(strings)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;

  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _NextStepsCard extends StatelessWidget {
  const _NextStepsCard();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.appColors.accent.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: context.appColors.accent,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    strings.ybocsText('nextStepsTitle'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            strings.ybocsText('nextStepsBody'),
            style: TextStyle(
              color: context.appColors.textPrimary,
              height: 1.5,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared bits ──────────────────────────────────────────────────────────────

class _CockpitCard extends StatelessWidget {
  final Widget child;

  const _CockpitCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: recoverySoftDecoration(theme),
      child: child,
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Widget child;

  const _BottomBar({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: SizedBox(width: double.infinity, child: child),
    );
  }
}
