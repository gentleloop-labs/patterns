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

class ExposureReflectionScreen extends ConsumerWidget {
  const ExposureReflectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final reflections = ref.watch(exposureReflectionProvider);

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
                      strings.exposureReflectionText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openCreate(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(strings.exposureReflectionText('newAction')),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              strings.exposureReflectionText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'exposureReflection'),
            reflections.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(onCreate: () => _openCreate(context));
                }
                return Column(
                  children: [
                    for (final r in items) ...[
                      _ReflectionCard(
                        reflection: r,
                        onDelete: () => _confirmDelete(context, ref, r),
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
                strings.exposureReflectionText('loadError'),
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
        builder: (_) => const ExposureReflectionEditScreen(),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ExposureReflection reflection,
  ) {
    final strings = context.l10n;
    final id = reflection.id;
    if (id == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final largeText = MediaQuery.textScalerOf(sheetContext).scale(16) >= 24;
        final cancel = OutlinedButton(
          onPressed: () => Navigator.pop(sheetContext),
          child: Text(strings.exposureReflectionText('cancel')),
        );
        final delete = ElevatedButton(
          onPressed: () async {
            Navigator.pop(sheetContext);
            final deleted = await ref
                .read(exposureReflectionProvider.notifier)
                .delete(id);
            if (!context.mounted) return;
            final message = strings.exposureReflectionText(
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
          child: Text(strings.exposureReflectionText('deleteAction')),
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
                      strings.exposureReflectionText('deleteTitle'),
                      style: Theme.of(sheetContext).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    strings.exposureReflectionText('deleteBody'),
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

class _ReflectionCard extends StatelessWidget {
  final ExposureReflection reflection;
  final VoidCallback onDelete;

  const _ReflectionCard({required this.reflection, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final date = context.formatMonthDay(reflection.datetime);
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
                  label: strings.exposureReflectionCardSummary(
                    date,
                    reflection.whatHappened,
                  ),
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reflection.whatHappened,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: TextStyle(
                          color: context.appColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              IconButton(
                onPressed: onDelete,
                tooltip: strings.exposureReflectionText('deleteTooltip'),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          if (reflection.whatILearned.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              reflection.whatILearned,
              style: TextStyle(
                color: context.appColors.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
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
            Icons.menu_book_rounded,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 12),
          Semantics(
            header: true,
            child: Text(
              strings.exposureReflectionText('emptyTitle'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            strings.exposureReflectionText('emptyBody'),
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
              child: Text(strings.exposureReflectionText('emptyAction')),
            ),
          ),
        ],
      ),
    );
  }
}

class ExposureReflectionEditScreen extends ConsumerStatefulWidget {
  const ExposureReflectionEditScreen({super.key});

  @override
  ConsumerState<ExposureReflectionEditScreen> createState() =>
      _ExposureReflectionEditScreenState();
}

class _ExposureReflectionEditScreenState
    extends ConsumerState<ExposureReflectionEditScreen> {
  final _whatHappened = TextEditingController();
  final _ocdPredicted = TextEditingController();
  final _actuallyHappened = TextEditingController();
  final _whatILearned = TextEditingController();
  final _doDifferently = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _whatHappened.dispose();
    _ocdPredicted.dispose();
    _actuallyHappened.dispose();
    _whatILearned.dispose();
    _doDifferently.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final strings = context.l10n;
    if (_whatHappened.text.trim().isEmpty) {
      final message = strings.exposureReflectionText('validation');
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
        .read(exposureReflectionProvider.notifier)
        .add(
          ExposureReflection(
            datetime: now,
            whatHappened: _whatHappened.text.trim(),
            ocdPredicted: _ocdPredicted.text.trim(),
            actuallyHappened: _actuallyHappened.text.trim(),
            whatILearned: _whatILearned.text.trim(),
            doDifferently: _doDifferently.text.trim(),
            createdAt: now,
          ),
        );
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      final message = strings.exposureReflectionText('saveError');
      showAppSnackBar(context, message, type: ToastType.error);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    Navigator.of(context).pop();
    final message = strings.exposureReflectionText('saveSuccess');
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
                      strings.exposureReflectionText('editorTitle'),
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
              label: strings.exposureReflectionText('whatHappenedLabel'),
              hint: strings.exposureReflectionText('whatHappenedHint'),
              controller: _whatHappened,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.exposureReflectionText('predictionLabel'),
              hint: strings.exposureReflectionText('predictionHint'),
              controller: _ocdPredicted,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.exposureReflectionText('actualLabel'),
              hint: strings.exposureReflectionText('actualHint'),
              controller: _actuallyHappened,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.exposureReflectionText('learningLabel'),
              hint: strings.exposureReflectionText('learningHint'),
              controller: _whatILearned,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.exposureReflectionText('nextTimeLabel'),
              hint: strings.exposureReflectionText('nextTimeHint'),
              controller: _doDifferently,
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
                    : Text(strings.exposureReflectionText('saveAction')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
