import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/semantics.dart';

import '../../l10n/l10n.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../widgets/recovery_ui.dart';
import '../widgets/section_intro.dart';

class ActionPlannerScreen extends ConsumerWidget {
  const ActionPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final plans = ref.watch(actionPlanProvider);

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
                      strings.actionPlanText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openCreate(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(strings.actionPlanText('newAction')),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              strings.actionPlanText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'actionPlanner'),
            plans.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(onCreate: () => _openCreate(context));
                }
                return Column(
                  children: [
                    for (final plan in items) ...[
                      _PlanCard(
                        plan: plan,
                        onToggle: (value) =>
                            _setCompleted(context, ref, plan, value),
                        onDelete: () => _confirmDelete(context, ref, plan),
                      ),
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
                strings.actionPlanText('loadError'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _openCreate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => const ActionPlanEditScreen(),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, ActionPlan plan) {
    final strings = context.l10n;
    final id = plan.id;
    if (id == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final largeText = MediaQuery.textScalerOf(sheetContext).scale(16) >= 24;
        final cancel = OutlinedButton(
          onPressed: () => Navigator.pop(sheetContext),
          child: Text(strings.actionPlanText('cancel')),
        );
        final delete = ElevatedButton(
          onPressed: () async {
            Navigator.pop(sheetContext);
            final deleted = await ref
                .read(actionPlanProvider.notifier)
                .delete(id);
            if (!context.mounted) return;
            final message = strings.actionPlanText(
              deleted ? 'deleteSuccess' : 'deleteError',
            );
            showAppSnackBar(
              context,
              message,
              type: deleted ? ToastType.success : ToastType.error,
            );
            await SemanticsService.sendAnnouncement(
              View.of(context),
              message,
              Directionality.of(context),
            );
          },
          child: Text(strings.actionPlanText('deleteAction')),
        );
        return SafeArea(
          top: false,
          child: Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.all(20),
            decoration: recoverySoftDecoration(
              Theme.of(sheetContext),
              radius: 28,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      strings.actionPlanText('deleteTitle'),
                      style: Theme.of(sheetContext).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    strings.actionPlanText('deleteBody'),
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (largeText) ...[
                    SizedBox(width: double.infinity, child: cancel),
                    const SizedBox(height: 10),
                    SizedBox(width: double.infinity, child: delete),
                  ] else
                    Row(
                      children: [
                        Expanded(child: cancel),
                        const SizedBox(width: 12),
                        Expanded(child: delete),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _setCompleted(
    BuildContext context,
    WidgetRef ref,
    ActionPlan plan,
    bool completed,
  ) async {
    final strings = context.l10n;
    final saved = await ref
        .read(actionPlanProvider.notifier)
        .setCompleted(plan, completed);
    if (!context.mounted) return;
    final message = strings.actionPlanText(
      saved
          ? (completed ? 'toggleSuccessComplete' : 'toggleSuccessIncomplete')
          : 'toggleError',
    );
    showAppSnackBar(
      context,
      message,
      type: saved ? ToastType.success : ToastType.error,
    );
    await SemanticsService.sendAnnouncement(
      View.of(context),
      message,
      Directionality.of(context),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final ActionPlan plan;
  final Future<void> Function(bool) onToggle;
  final VoidCallback onDelete;

  const _PlanCard({
    required this.plan,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final done = plan.completed;
    final state = strings.actionPlanText(
      done ? 'stateCompleted' : 'statePlanned',
    );
    final date = _prettyDate(context, plan.date);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: recoverySoftDecoration(theme),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            button: true,
            toggled: done,
            label: strings.actionPlanText(
              done ? 'toggleMarkIncomplete' : 'toggleMarkComplete',
            ),
            excludeSemantics: true,
            child: IconButton(
              onPressed: () => onToggle(!done),
              tooltip: strings.actionPlanText(
                done ? 'toggleMarkIncomplete' : 'toggleMarkComplete',
              ),
              constraints: const BoxConstraints.tightFor(width: 44, height: 44),
              padding: EdgeInsets.zero,
              icon: Icon(
                done
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: done
                    ? theme.colorScheme.primary
                    : context.appColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: strings.actionPlanCardSummary(
                    state,
                    plan.situation,
                    plan.plannedAction,
                  ),
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.situation,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          decoration: done ? TextDecoration.lineThrough : null,
                          color: done ? context.appColors.textSecondary : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan.plannedAction,
                        style: TextStyle(
                          color: context.appColors.textSecondary,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                if (date != null) ...[
                  const SizedBox(height: 8),
                  Semantics(
                    label: strings.actionPlanDateSummary(date),
                    excludeSemantics: true,
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_rounded,
                          size: 14,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            date,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (plan.notes?.trim().isNotEmpty ?? false) ...[
                  const SizedBox(height: 8),
                  Text(
                    plan.notes!,
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: strings.actionPlanText('deleteTooltip'),
            constraints: const BoxConstraints.tightFor(width: 44, height: 44),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }

  String? _prettyDate(BuildContext context, String? iso) {
    if (iso == null) return null;
    try {
      return context.formatFullDateWithWeekday(DateTime.parse(iso));
    } catch (_) {
      return iso;
    }
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreate;
  const _EmptyState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: recoverySoftDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.checklist_rounded,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 12),
          Semantics(
            header: true,
            child: Text(
              strings.actionPlanText('emptyTitle'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            strings.actionPlanText('emptyBody'),
            style: TextStyle(
              color: context.appColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCreate,
              child: Text(strings.actionPlanText('emptyAction')),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionPlanEditScreen extends ConsumerStatefulWidget {
  const ActionPlanEditScreen({super.key});

  @override
  ConsumerState<ActionPlanEditScreen> createState() =>
      _ActionPlanEditScreenState();
}

class _ActionPlanEditScreenState extends ConsumerState<ActionPlanEditScreen> {
  final _situation = TextEditingController();
  final _action = TextEditingController();
  final _notes = TextEditingController();
  DateTime? _date;
  bool _saving = false;

  @override
  void dispose() {
    _situation.dispose();
    _action.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    final strings = context.l10n;
    final situation = _situation.text.trim();
    final action = _action.text.trim();
    if (situation.isEmpty || action.isEmpty) {
      final message = strings.actionPlanText('validation');
      showAppSnackBar(context, message, type: ToastType.info);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    setState(() => _saving = true);
    final saved = await ref
        .read(actionPlanProvider.notifier)
        .add(
          ActionPlan(
            situation: situation,
            plannedAction: action,
            date: _date == null ? null : _storageDate(_date!),
            notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
            createdAt: DateTime.now(),
          ),
        );
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      final message = strings.actionPlanText('saveError');
      showAppSnackBar(context, message, type: ToastType.error);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    Navigator.of(context).pop();
    final message = strings.actionPlanText('saveSuccess');
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
    final selectedDate = _date == null
        ? strings.actionPlanText('pickDate')
        : context.formatFullDateWithWeekday(_date!);
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
                      strings.actionPlanText('editorTitle'),
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
              label: strings.actionPlanText('situationLabel'),
              hint: strings.actionPlanText('situationHint'),
              controller: _situation,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.actionPlanText('actionLabel'),
              hint: strings.actionPlanText('actionHint'),
              controller: _action,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            Text(
              strings.actionPlanText('dateLabel'),
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: recoverySoftDecoration(theme, radius: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: selectedDate,
                      excludeSemantics: true,
                      child: InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(14),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 44),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Icon(
                                Icons.event_rounded,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  selectedDate,
                                  style: TextStyle(
                                    color: _date == null
                                        ? context.appColors.textSecondary
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_date != null)
                    IconButton(
                      onPressed: () => setState(() => _date = null),
                      tooltip: strings.actionPlanText('clearDate'),
                      constraints: const BoxConstraints.tightFor(
                        width: 44,
                        height: 44,
                      ),
                      icon: const Icon(Icons.close_rounded),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.actionPlanText('notesLabel'),
              hint: strings.actionPlanText('notesHint'),
              controller: _notes,
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
                    : Text(strings.actionPlanText('saveAction')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

String _storageDate(DateTime value) {
  final year = value.year.toString().padLeft(4, '0');
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}
