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

class ImplementationIntentionsScreen extends ConsumerWidget {
  const ImplementationIntentionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final intentions = ref.watch(implementationIntentionProvider);

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
                      strings.implementationIntentionText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openCreate(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(strings.implementationIntentionText('newAction')),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              strings.implementationIntentionText('subtitle'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const SectionIntro(id: 'implementationIntentions'),
            intentions.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(onCreate: () => _openCreate(context));
                }
                return Column(
                  children: [
                    for (final intention in items) ...[
                      _IntentionCard(
                        intention: intention,
                        onDelete: () => _confirmDelete(context, ref, intention),
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
                strings.implementationIntentionText('loadError'),
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
        builder: (_) => const ImplementationIntentionEditScreen(),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ImplementationIntention intention,
  ) {
    final strings = context.l10n;
    final id = intention.id;
    if (id == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final largeText = MediaQuery.textScalerOf(sheetContext).scale(16) >= 24;
        final cancel = OutlinedButton(
          onPressed: () => Navigator.pop(sheetContext),
          child: Text(strings.implementationIntentionText('cancel')),
        );
        final delete = ElevatedButton(
          onPressed: () async {
            Navigator.pop(sheetContext);
            final deleted = await ref
                .read(implementationIntentionProvider.notifier)
                .delete(id);
            if (!context.mounted) return;
            final message = strings.implementationIntentionText(
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
          child: Text(strings.implementationIntentionText('deleteAction')),
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
                      strings.implementationIntentionText('deleteTitle'),
                      style: Theme.of(sheetContext).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    strings.implementationIntentionText('deleteBody'),
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

class _IntentionCard extends StatelessWidget {
  final ImplementationIntention intention;
  final VoidCallback onDelete;

  const _IntentionCard({required this.intention, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final statement = strings.implementationIntentionStatement(
      intention.trigger,
      intention.response,
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: recoverySoftDecoration(theme),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Semantics(
              label: statement,
              excludeSemantics: true,
              child: Text(
                statement,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: onDelete,
            tooltip: strings.implementationIntentionText('deleteTooltip'),
            constraints: const BoxConstraints.tightFor(width: 44, height: 44),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.close_rounded),
          ),
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
            Icons.lightbulb_outline_rounded,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 12),
          Semantics(
            header: true,
            child: Text(
              strings.implementationIntentionText('emptyTitle'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            strings.implementationIntentionText('emptyBody'),
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
              child: Text(strings.implementationIntentionText('emptyAction')),
            ),
          ),
        ],
      ),
    );
  }
}

class ImplementationIntentionEditScreen extends ConsumerStatefulWidget {
  const ImplementationIntentionEditScreen({super.key});

  @override
  ConsumerState<ImplementationIntentionEditScreen> createState() =>
      _ImplementationIntentionEditScreenState();
}

class _ImplementationIntentionEditScreenState
    extends ConsumerState<ImplementationIntentionEditScreen> {
  final _trigger = TextEditingController();
  final _response = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _trigger.dispose();
    _response.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final strings = context.l10n;
    final trigger = _trigger.text.trim();
    final response = _response.text.trim();
    if (trigger.isEmpty || response.isEmpty) {
      final message = strings.implementationIntentionText('validation');
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
        .read(implementationIntentionProvider.notifier)
        .add(
          ImplementationIntention(
            trigger: trigger,
            response: response,
            createdAt: DateTime.now(),
          ),
        );
    if (!mounted) return;
    if (!saved) {
      setState(() => _saving = false);
      final message = strings.implementationIntentionText('saveError');
      showAppSnackBar(context, message, type: ToastType.error);
      await SemanticsService.sendAnnouncement(
        View.of(context),
        message,
        Directionality.of(context),
      );
      return;
    }
    Navigator.of(context).pop();
    final message = strings.implementationIntentionText('saveSuccess');
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
                      strings.implementationIntentionText('editorTitle'),
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
              label: strings.implementationIntentionText('triggerLabel'),
              hint: strings.implementationIntentionText('triggerHint'),
              controller: _trigger,
              minLines: 2,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: strings.implementationIntentionText('responseLabel'),
              hint: strings.implementationIntentionText('responseHint'),
              controller: _response,
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
                    : Text(strings.implementationIntentionText('saveAction')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
