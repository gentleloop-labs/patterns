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

class BehavioralExperimentsScreen extends ConsumerWidget {
  const BehavioralExperimentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final experiments = ref.watch(behavioralExperimentProvider);

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
                      strings.behavioralExperimentText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openCreate(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(strings.behavioralExperimentText('newAction')),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              strings.behavioralExperimentText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'behavioralExperiments'),
            experiments.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(onCreate: () => _openCreate(context));
                }
                return Column(
                  children: [
                    for (final exp in items) ...[
                      _ExperimentCard(
                        experiment: exp,
                        onRecord: () => _openOutcome(context, exp),
                        onDelete: () => _confirmDelete(context, ref, exp),
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
                strings.behavioralExperimentText('loadError'),
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
        builder: (_) => const BehavioralExperimentEditScreen(),
      ),
    );
  }

  void _openOutcome(BuildContext context, BehavioralExperiment exp) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => BehavioralExperimentEditScreen(existing: exp),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    BehavioralExperiment exp,
  ) {
    final strings = context.l10n;
    final id = exp.id;
    if (id == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final largeText = MediaQuery.textScalerOf(sheetContext).scale(16) >= 24;
        final cancel = OutlinedButton(
          onPressed: () => Navigator.pop(sheetContext),
          child: Text(strings.behavioralExperimentText('cancel')),
        );
        final delete = ElevatedButton(
          onPressed: () async {
            Navigator.pop(sheetContext);
            final deleted = await ref
                .read(behavioralExperimentProvider.notifier)
                .delete(id);
            if (!context.mounted) return;
            final message = strings.behavioralExperimentText(
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
          child: Text(strings.behavioralExperimentText('deleteAction')),
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
                      strings.behavioralExperimentText('deleteTitle'),
                      style: Theme.of(sheetContext).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    strings.behavioralExperimentText('deleteBody'),
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
}

class _ExperimentCard extends StatelessWidget {
  final BehavioralExperiment experiment;
  final VoidCallback onRecord;
  final VoidCallback onDelete;

  const _ExperimentCard({
    required this.experiment,
    required this.onRecord,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final completed = experiment.status == ExperimentStatus.completed;
    final status = strings.behavioralExperimentText(
      completed ? 'statusCompleted' : 'statusPlanned',
    );
    final confidence = strings.behavioralExperimentConfidence(
      context.formatWholePercent(experiment.confidence),
    );
    final date = context.formatMonthDay(experiment.datetime);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: recoverySoftDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Semantics(
                  label: strings.behavioralExperimentCardSummary(
                    status,
                    date,
                    confidence,
                    experiment.fearPrediction,
                    experiment.experiment,
                  ),
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.14,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  completed
                                      ? Icons.check_circle_outline_rounded
                                      : Icons.schedule_rounded,
                                  size: 16,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            confidence,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: context.appColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        experiment.fearPrediction,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        experiment.experiment,
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
              const SizedBox(width: 4),
              IconButton(
                onPressed: onDelete,
                tooltip: strings.behavioralExperimentText('deleteTooltip'),
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                icon: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: context.appColors.textSecondary,
                ),
              ),
            ],
          ),
          if (completed) ...[
            const SizedBox(height: 12),
            _LabeledBlock(
              label: strings.behavioralExperimentText('outcomeLabel'),
              value: experiment.outcome,
            ),
            if (experiment.learning.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              _LabeledBlock(
                label: strings.behavioralExperimentText('learningLabel'),
                value: experiment.learning,
              ),
            ],
          ] else ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onRecord,
                child: Text(strings.behavioralExperimentText('recordAction')),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LabeledBlock extends StatelessWidget {
  final String label;
  final String value;
  const _LabeledBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: context.appColors.textSecondary,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(height: 1.4)),
      ],
    );
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
            Icons.science_rounded,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 12),
          Semantics(
            header: true,
            child: Text(
              strings.behavioralExperimentText('emptyTitle'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            strings.behavioralExperimentText('emptyBody'),
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
              child: Text(strings.behavioralExperimentText('emptyAction')),
            ),
          ),
        ],
      ),
    );
  }
}

class BehavioralExperimentEditScreen extends ConsumerStatefulWidget {
  final BehavioralExperiment? existing;
  const BehavioralExperimentEditScreen({super.key, this.existing});

  @override
  ConsumerState<BehavioralExperimentEditScreen> createState() =>
      _BehavioralExperimentEditScreenState();
}

class _BehavioralExperimentEditScreenState
    extends ConsumerState<BehavioralExperimentEditScreen> {
  late final TextEditingController _predictionController;
  late final TextEditingController _experimentController;
  final _outcomeController = TextEditingController();
  final _learningController = TextEditingController();
  double _confidence = 70;
  bool _saving = false;

  bool get _outcomeMode => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _predictionController = TextEditingController(
      text: existing?.fearPrediction ?? '',
    );
    _experimentController = TextEditingController(
      text: existing?.experiment ?? '',
    );
    _confidence = (existing?.confidence ?? 70).toDouble();
  }

  @override
  void dispose() {
    _predictionController.dispose();
    _experimentController.dispose();
    _outcomeController.dispose();
    _learningController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final strings = context.l10n;
    if (_outcomeMode) {
      final outcome = _outcomeController.text.trim();
      if (outcome.isEmpty) {
        final message = strings.behavioralExperimentText('outcomeValidation');
        showAppSnackBar(context, message, type: ToastType.info);
        await SemanticsService.sendAnnouncement(
          View.of(context),
          message,
          Directionality.of(context),
        );
        return;
      }
      setState(() => _saving = true);
      final existing = widget.existing!;
      final saved = await ref
          .read(behavioralExperimentProvider.notifier)
          .edit(
            BehavioralExperiment(
              id: existing.id,
              datetime: existing.datetime,
              fearPrediction: existing.fearPrediction,
              confidence: existing.confidence,
              experiment: existing.experiment,
              outcome: outcome,
              learning: _learningController.text.trim(),
              status: ExperimentStatus.completed,
              createdAt: existing.createdAt,
            ),
          );
      if (!mounted) return;
      final message = strings.behavioralExperimentText(
        saved ? 'outcomeSaveSuccess' : 'saveError',
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
      return;
    }

    final prediction = _predictionController.text.trim();
    final experiment = _experimentController.text.trim();
    if (prediction.isEmpty || experiment.isEmpty) {
      final message = strings.behavioralExperimentText('planValidation');
      showAppSnackBar(context, message, type: ToastType.info);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    setState(() => _saving = true);
    final now = DateTime.now();
    final saved = await ref
        .read(behavioralExperimentProvider.notifier)
        .add(
          BehavioralExperiment(
            datetime: now,
            fearPrediction: prediction,
            confidence: _confidence.round(),
            experiment: experiment,
            createdAt: now,
          ),
        );
    if (!mounted) return;
    final message = strings.behavioralExperimentText(
      saved ? 'planSaveSuccess' : 'saveError',
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
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 24;
    final confidence = strings.behavioralExperimentConfidence(
      context.formatWholePercent(_confidence.round()),
    );
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
                      strings.behavioralExperimentText(
                        _outcomeMode ? 'outcomeEditorTitle' : 'newEditorTitle',
                      ),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (_outcomeMode) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: recoverySoftDecoration(theme, radius: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LabeledBlock(
                      label: strings.behavioralExperimentText('predictedLabel'),
                      value: widget.existing!.fearPrediction,
                    ),
                    const SizedBox(height: 10),
                    _LabeledBlock(
                      label: strings.behavioralExperimentText(
                        'testActionLabel',
                      ),
                      value: widget.existing!.experiment,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              LabeledField(
                label: strings.behavioralExperimentText('outcomeInputLabel'),
                hint: strings.behavioralExperimentText('outcomeInputHint'),
                controller: _outcomeController,
                minLines: 2,
              ),
              const SizedBox(height: 16),
              LabeledField(
                label: strings.behavioralExperimentText('learningInputLabel'),
                hint: strings.behavioralExperimentText('learningInputHint'),
                controller: _learningController,
                minLines: 2,
              ),
            ] else ...[
              LabeledField(
                label: strings.behavioralExperimentText('predictionInputLabel'),
                hint: strings.behavioralExperimentText('predictionInputHint'),
                controller: _predictionController,
                minLines: 2,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: recoverySoftDecoration(theme, radius: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExcludeSemantics(
                      child: largeText
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  strings.behavioralExperimentText(
                                    'confidenceQuestion',
                                  ),
                                  style: TextStyle(
                                    color: context.appColors.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  confidence,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    strings.behavioralExperimentText(
                                      'confidenceQuestion',
                                    ),
                                    style: TextStyle(
                                      color: context.appColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Text(
                                  confidence,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    MergeSemantics(
                      child: Semantics(
                        label: strings.behavioralExperimentText(
                          'confidenceQuestion',
                        ),
                        value: confidence,
                        child: Slider(
                          value: _confidence,
                          min: 0,
                          max: 100,
                          divisions: 20,
                          onChanged: (v) => setState(() => _confidence = v),
                          semanticFormatterCallback: (value) =>
                              strings.behavioralExperimentConfidence(
                                context.formatWholePercent(value.round()),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              LabeledField(
                label: strings.behavioralExperimentText('experimentInputLabel'),
                hint: strings.behavioralExperimentText('experimentInputHint'),
                controller: _experimentController,
                minLines: 2,
              ),
            ],
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
                        strings.behavioralExperimentText(
                          _outcomeMode ? 'saveOutcome' : 'saveExperiment',
                        ),
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
