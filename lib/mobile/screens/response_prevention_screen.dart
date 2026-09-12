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

String _outcomeLabel(BuildContext context, ResponseOutcome outcome) {
  final key = switch (outcome) {
    ResponseOutcome.resisted => 'outcomeResisted',
    ResponseOutcome.delayed => 'outcomeDelayed',
    ResponseOutcome.partial => 'outcomePartial',
    ResponseOutcome.performed => 'outcomePerformed',
  };
  return context.l10n.responsePreventionText(key);
}

Color _outcomeColor(BuildContext context, ResponseOutcome outcome) {
  switch (outcome) {
    case ResponseOutcome.resisted:
      return context.appColors.positive;
    case ResponseOutcome.delayed:
      return context.appColors.accent;
    case ResponseOutcome.partial:
      return context.appColors.compulsionChip;
    case ResponseOutcome.performed:
      return context.appColors.negative;
  }
}

class ResponsePreventionScreen extends ConsumerWidget {
  const ResponsePreventionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final logs = ref.watch(responsePreventionProvider);

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
                      strings.responsePreventionText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openLog(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(strings.responsePreventionText('logAction')),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              strings.responsePreventionText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'responsePrevention'),
            logs.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(onLog: () => _openLog(context));
                }
                return Column(
                  children: [
                    for (final log in items) ...[
                      _LogCard(
                        log: log,
                        onDelete: () => _confirmDelete(context, ref, log),
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
                strings.responsePreventionText('loadError'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _openLog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => const ResponsePreventionLogScreen(),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ResponsePreventionLog log,
  ) {
    final strings = context.l10n;
    final id = log.id;
    if (id == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(20),
          decoration: recoverySoftDecoration(
            Theme.of(sheetContext),
            radius: 28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  strings.responsePreventionText('deleteTitle'),
                  style: Theme.of(
                    sheetContext,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                strings.responsePreventionText('deleteBody'),
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
                      child: Text(strings.responsePreventionText('cancel')),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(sheetContext);
                        final deleted = await ref
                            .read(responsePreventionProvider.notifier)
                            .deleteLog(id);
                        if (!context.mounted) return;
                        final message = strings.responsePreventionText(
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
                      child: Text(
                        strings.responsePreventionText('deleteAction'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final ResponsePreventionLog log;
  final VoidCallback onDelete;

  const _LogCard({required this.log, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _outcomeColor(context, log.outcome);
    final strings = context.l10n;
    final outcome = _outcomeLabel(context, log.outcome);
    final date = context.formatMonthDay(log.datetime);
    return Semantics(
      container: true,
      label: strings.responsePreventionLogSummary(
        outcome,
        date,
        log.anxietyLevel,
        log.situation,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: recoverySoftDecoration(theme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    outcome,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: TextStyle(
                    color: context.appColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onDelete,
                  tooltip: strings.responsePreventionText('deleteTooltip'),
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              log.situation,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.35),
            ),
            const SizedBox(height: 6),
            Text(
              strings.responsePreventionDistress(log.anxietyLevel),
              style: TextStyle(
                color: context.appColors.textSecondary,
                fontSize: 12,
              ),
            ),
            if (log.note != null && log.note!.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                log.note!,
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
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onLog;
  const _EmptyState({required this.onLog});

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
            Icons.shield_rounded,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 12),
          Semantics(
            header: true,
            child: Text(
              strings.responsePreventionText('emptyTitle'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            strings.responsePreventionText('emptyBody'),
            style: TextStyle(
              color: context.appColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLog,
              child: Text(strings.responsePreventionText('emptyAction')),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsePreventionLogScreen extends ConsumerStatefulWidget {
  const ResponsePreventionLogScreen({super.key});

  @override
  ConsumerState<ResponsePreventionLogScreen> createState() =>
      _ResponsePreventionLogScreenState();
}

class _ResponsePreventionLogScreenState
    extends ConsumerState<ResponsePreventionLogScreen> {
  final _situationController = TextEditingController();
  final _noteController = TextEditingController();
  ResponseOutcome _outcome = ResponseOutcome.resisted;
  double _anxiety = 5;
  bool _saving = false;

  @override
  void dispose() {
    _situationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final strings = context.l10n;
    final situation = _situationController.text.trim();
    if (situation.isEmpty) {
      showAppSnackBar(
        context,
        strings.responsePreventionText('situationValidation'),
        type: ToastType.info,
      );
      return;
    }
    setState(() => _saving = true);
    final now = DateTime.now();
    final log = ResponsePreventionLog(
      datetime: now,
      situation: situation,
      outcome: _outcome,
      anxietyLevel: _anxiety.round(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      createdAt: now,
    );
    final saved = await ref
        .read(responsePreventionProvider.notifier)
        .addLog(log);
    if (!mounted) return;
    final message = strings.responsePreventionText(
      saved ? 'saveSuccess' : 'saveError',
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
    final theme = Theme.of(context);
    final strings = context.l10n;
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
                      strings.responsePreventionText('editorTitle'),
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
              label: strings.responsePreventionText('situationLabel'),
              hint: strings.responsePreventionText('situationHint'),
              controller: _situationController,
              minLines: 2,
            ),
            const SizedBox(height: 20),
            Text(
              strings.responsePreventionText('outcomeQuestion'),
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            _OutcomePicker(
              outcome: _outcome,
              onChanged: (o) => setState(() => _outcome = o),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: recoverySoftDecoration(theme, radius: 18),
              child: RatingSlider(
                label: strings.responsePreventionText('distressLabel'),
                value: _anxiety,
                onChanged: (v) => setState(() => _anxiety = v),
                valueFormatter: strings.responsePreventionDistress,
              ),
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.responsePreventionText('noteLabel'),
              hint: strings.responsePreventionText('noteHint'),
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
                    : Text(strings.responsePreventionText('saveAction')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _OutcomePicker extends StatelessWidget {
  final ResponseOutcome outcome;
  final ValueChanged<ResponseOutcome> onChanged;

  const _OutcomePicker({required this.outcome, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 24;
    final choices = [
      for (final value in ResponseOutcome.values)
        Semantics(
          button: true,
          selected: outcome == value,
          child: InkWell(
            onTap: () => onChanged(value),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: motionDisabled(context)
                  ? Duration.zero
                  : AppMotion.fast,
              constraints: const BoxConstraints(minHeight: 44),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: outcome == value
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: outcome == value
                      ? theme.colorScheme.primary
                      : theme.dividerColor,
                ),
              ),
              child: Row(
                mainAxisSize: largeText ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  if (outcome == value) ...[
                    Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: theme.colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 4),
                  ],
                  if (largeText)
                    Expanded(
                      child: Text(
                        _outcomeLabel(context, value),
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: outcome == value
                              ? theme.colorScheme.onPrimary
                              : context.appColors.textSecondary,
                        ),
                      ),
                    )
                  else
                    Text(
                      _outcomeLabel(context, value),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: outcome == value
                            ? theme.colorScheme.onPrimary
                            : context.appColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
    ];
    if (largeText) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final choice in choices) ...[choice, const SizedBox(height: 8)],
        ],
      );
    }
    return Wrap(spacing: 8, runSpacing: 8, children: choices);
  }
}
