import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../l10n/l10n.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../services/review_prompt.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/activity_completion.dart';
import '../../widgets/app_snack_bar.dart';
import '../first_run.dart';

class OcdTrackerScreen extends ConsumerStatefulWidget {
  final VoidCallback onAdd;
  final VoidCallback onDelay;

  const OcdTrackerScreen({
    super.key,
    required this.onAdd,
    required this.onDelay,
  });

  @override
  ConsumerState<OcdTrackerScreen> createState() => _OcdTrackerScreenState();
}

class _OcdTrackerScreenState extends ConsumerState<OcdTrackerScreen> {
  OcdType? _selectedType;
  OcdType? _previousType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final entriesAsync = ref.watch(filteredOcdProvider);
    final useStackedHeader = MediaQuery.textScalerOf(context).scale(1) > 1.3;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeSlideIn(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                child: Flex(
                  direction: useStackedHeader ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (useStackedHeader)
                      Semantics(
                        header: true,
                        child: Text(
                          strings.trackerTitle,
                          style: _screenTitle(theme),
                        ),
                      )
                    else
                      Expanded(
                        child: Semantics(
                          header: true,
                          child: Text(
                            strings.trackerTitle,
                            style: _screenTitle(theme),
                          ),
                        ),
                      ),
                    if (useStackedHeader) const SizedBox(height: 12),
                    _PauseUrgePill(onTap: widget.onDelay),
                  ],
                ),
              ),
            ),
            FadeSlideIn(
              delay: const Duration(milliseconds: 60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _FilterBar(
                  selectedType: _selectedType,
                  onChanged: (type) {
                    if (type == _selectedType) return;
                    setState(() {
                      _previousType = _selectedType;
                      _selectedType = type;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: entriesAsync.when(
                data: (entries) {
                  final filtered = _selectedType == null
                      ? entries
                      : entries
                            .where((entry) => entry.type == _selectedType)
                            .toList();
                  final previousIndex = _typeOrder(_previousType);
                  final currentIndex = _typeOrder(_selectedType);
                  final goingForward = currentIndex >= previousIndex;
                  final body = filtered.isEmpty
                      ? KeyedSubtree(
                          key: ValueKey(
                            'empty-${_selectedType?.name ?? 'all'}',
                          ),
                          child: _EmptyTrackState(onAdd: widget.onAdd),
                        )
                      : ListView.builder(
                          key: ValueKey(_selectedType?.name ?? 'all'),
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 116),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return FadeSlideIn(
                              delay: Duration(
                                milliseconds: 18 * index.clamp(0, 3),
                              ),
                              duration: AppMotion.medium,
                              offset: AppMotion.smallOffset,
                              child: _OcdEventCard(entry: filtered[index]),
                            );
                          },
                        );
                  return PageTransitionSwitcher(
                    duration: AppMotion.medium,
                    reverse: !goingForward,
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
                    child: body,
                  );
                },
                loading: () => Center(
                  child: Semantics(
                    liveRegion: true,
                    label: strings.trackerLoadingLabel,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) => Center(
                  child: Semantics(
                    liveRegion: true,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        strings.trackerLoadError,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OcdEventFlow extends ConsumerStatefulWidget {
  final OcdType initialType;
  final OcdEntry? entry;

  /// First-run mode (the "write something down" path). On save the flow pops a
  /// [FirstRunActivityResult] and stays quiet so the shell can show the result
  /// screen.
  final bool firstRun;

  const OcdEventFlow({
    super.key,
    required this.initialType,
    this.entry,
    this.firstRun = false,
  });

  @override
  ConsumerState<OcdEventFlow> createState() => _OcdEventFlowState();
}

class _OcdEventFlowState extends ConsumerState<OcdEventFlow> {
  late OcdType _type = widget.initialType;
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _actionController = TextEditingController();
  final TextEditingController _responseController = TextEditingController();
  double _distress = 5;
  bool _saving = false;
  bool get _isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    final entry = widget.entry;
    if (entry == null) return;
    _type = entry.type;
    _contentController.text = entry.content;
    _actionController.text = entry.actionTaken ?? '';
    _responseController.text = entry.response;
    _distress = entry.distressLevel.toDouble();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _actionController.dispose();
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    tooltip: strings.backAction,
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(LineIcons.angleLeft),
                  ),
                  Expanded(
                    child: Text(
                      _isEditing
                          ? strings.trackerEditTitle
                          : strings.trackerAddTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                children: staggered([
                  _TypeToggle(
                    selected: _type,
                    onChanged: (type) => setState(() => _type = type),
                  ),
                  const SizedBox(height: 22),
                  _FlowField(
                    controller: _contentController,
                    label: _type == OcdType.obsession
                        ? strings.trackerThoughtLabel
                        : strings.trackerUrgeLabel,
                    hint: _type == OcdType.obsession
                        ? strings.trackerThoughtHint
                        : strings.trackerUrgeHint,
                    minLines: 4,
                  ),
                  const SizedBox(height: 16),
                  _FlowField(
                    controller: _actionController,
                    label: strings.trackerActionLabel,
                    hint: strings.trackerActionHint,
                    minLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _FlowField(
                    controller: _responseController,
                    label: strings.trackerResponseLabel,
                    hint: strings.trackerResponseHint,
                    minLines: 3,
                  ),
                  const SizedBox(height: 22),
                  _DistressCard(
                    value: _distress,
                    onChanged: (value) => setState(() => _distress = value),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const ValueKey('ocd-save-event'),
                      onPressed: _saving ? null : _save,
                      child: AnimatedSwitcher(
                        duration: motionDisabled(context)
                            ? Duration.zero
                            : AppMotion.fast,
                        child: Text(
                          _saving
                              ? strings.trackerSavingAction
                              : _isEditing
                              ? strings.trackerUpdateAction
                              : strings.trackerSaveAction,
                          key: ValueKey(_saving),
                        ),
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

  Future<void> _save() async {
    if (_contentController.text.trim().isEmpty) {
      showAppSnackBar(
        context,
        context.l10n.trackerContentRequired,
        type: ToastType.info,
      );
      return;
    }
    setState(() => _saving = true);
    final existing = widget.entry;
    final now = DateTime.now();
    final entry = OcdEntry(
      id: existing?.id,
      type: _type,
      datetime: existing?.datetime ?? now,
      content: _contentController.text.trim(),
      distressLevel: _distress.round(),
      response: _responseController.text.trim(),
      actionTaken: _actionController.text.trim().isEmpty
          ? null
          : _actionController.text.trim(),
      createdAt: existing?.createdAt ?? now,
    );
    final saved = _isEditing
        ? await ref.read(ocdProvider.notifier).updateEntry(entry)
        : await ref.read(ocdProvider.notifier).addEntry(entry);
    if (!saved) {
      if (mounted) {
        setState(() => _saving = false);
        showAppSnackBar(
          context,
          _isEditing
              ? context.l10n.trackerUpdateError
              : context.l10n.trackerSaveError,
          type: ToastType.error,
        );
      }
      return;
    }
    try {
      await ReviewPromptService.recordOcdSaved(entry.distressLevel);
    } on Object {
      // The event is already safely stored. Review eligibility must never turn
      // a successful save into a failed completion.
    }
    if (mounted) setState(() => _saving = false);
    if (widget.firstRun && mounted) {
      Navigator.pop(context, const FirstRunActivityResult());
      return;
    }
    if (mounted) {
      await showQuietCompletion(
        context,
        ActivityCompletionResult(
          ActivityCompletionKind.trackedMoment,
          updated: _isEditing,
        ),
      );
      if (mounted) returnToNeutralHome(context);
    }
  }
}

class _FilterBar extends StatelessWidget {
  final OcdType? selectedType;
  final ValueChanged<OcdType?> onChanged;

  const _FilterBar({required this.selectedType, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    final chips = [
      _FilterChip(
        label: strings.trackerFilterAll,
        selected: selectedType == null,
        onTap: () => onChanged(null),
      ),
      _FilterChip(
        label: strings.trackerFilterObsessions,
        selected: selectedType == OcdType.obsession,
        onTap: () => onChanged(OcdType.obsession),
      ),
      _FilterChip(
        label: strings.trackerFilterCompulsions,
        selected: selectedType == OcdType.compulsion,
        onTap: () => onChanged(OcdType.compulsion),
      ),
    ];
    return Semantics(
      container: true,
      label: strings.trackerFilterGroupLabel,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: _softDecoration(Theme.of(context), radius: 22),
        child: stacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [for (final chip in chips) chip],
              )
            : Row(children: [for (final chip in chips) Expanded(child: chip)]),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
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
      child: ExcludeSemantics(
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: AnimatedContainer(
              duration: motionDisabled(context)
                  ? Duration.zero
                  : AppMotion.fast,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: selected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
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
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OcdEventCard extends ConsumerWidget {
  final OcdEntry entry;

  const _OcdEventCard({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final date = context.formatMonthDayTime(entry.datetime);
    final type = entry.type == OcdType.obsession
        ? strings.trackerTypeObsession
        : strings.trackerTypeCompulsion;
    final response = entry.response.isEmpty
        ? strings.trackerNoStrategy
        : entry.response;

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: strings.trackerEventSummary(
        type,
        date,
        entry.distressLevel,
        entry.content,
        response,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: _softDecoration(theme, radius: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _TypeChip(type: entry.type),
                Text(date, style: _muted(theme, 12)),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: strings.trackerEditTooltip,
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  iconSize: 18,
                  color: context.appColors.textSecondary,
                  onPressed: entry.id == null
                      ? null
                      : () => _openEditor(context, entry),
                  icon: const Icon(LineIcons.edit),
                ),
                IconButton(
                  tooltip: strings.trackerDeleteTooltip,
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  iconSize: 18,
                  color: context.appColors.textSecondary,
                  onPressed: entry.id == null
                      ? null
                      : () => _confirmDelete(context, ref, entry),
                  icon: const Icon(LineIcons.trash),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              entry.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTheme.sansFamily,
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                height: 1.38,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.trackerDistressValue(entry.distressLevel),
                  style: TextStyle(
                    color: _distressColor(theme, entry.distressLevel),
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  response,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _muted(theme, 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openEditor(BuildContext context, OcdEntry entry) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => OcdEventFlow(initialType: entry.type, entry: entry),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, OcdEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.trackerDeleteTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.trackerDeleteBody,
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
                    child: Text(context.l10n.cancelAction),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(sheetContext);
                      final deleted = await ref
                          .read(ocdProvider.notifier)
                          .deleteEntry(entry.id!);
                      if (context.mounted) {
                        showAppSnackBar(
                          context,
                          deleted
                              ? context.l10n.trackerDeletedMessage
                              : context.l10n.trackerDeleteError,
                          type: deleted ? ToastType.success : ToastType.error,
                        );
                      }
                    },
                    child: Text(context.l10n.trackerDeleteAction),
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

class _TypeToggle extends StatelessWidget {
  final OcdType selected;
  final ValueChanged<OcdType> onChanged;

  const _TypeToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    final chips = [
      _FilterChip(
        label: strings.trackerTypeObsession,
        selected: selected == OcdType.obsession,
        onTap: () => onChanged(OcdType.obsession),
      ),
      _FilterChip(
        label: strings.trackerTypeCompulsion,
        selected: selected == OcdType.compulsion,
        onTap: () => onChanged(OcdType.compulsion),
      ),
    ];
    return Semantics(
      container: true,
      label: strings.trackerTypeGroupLabel,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: _softDecoration(Theme.of(context), radius: 24),
        child: stacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [for (final chip in chips) chip],
              )
            : Row(children: [for (final chip in chips) Expanded(child: chip)]),
      ),
    );
  }
}

class _FlowField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int minLines;

  const _FlowField({
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
        ExcludeSemantics(
          child: Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 9),
        Semantics(
          textField: true,
          label: label,
          child: TextField(
            controller: controller,
            minLines: minLines,
            maxLines: minLines + 2,
            decoration: InputDecoration(hintText: hint),
          ),
        ),
      ],
    );
  }
}

class _DistressCard extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _DistressCard({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final rounded = value.round();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme, radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                strings.trackerDistressLabel,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                strings.trackerDistressShortValue(rounded),
                style: TextStyle(
                  color: _distressColor(theme, rounded),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Semantics(
            label: strings.trackerDistressLabel,
            value: strings.trackerDistressValue(rounded),
            increasedValue: rounded < 10
                ? strings.trackerDistressValue(rounded + 1)
                : null,
            decreasedValue: rounded > 0
                ? strings.trackerDistressValue(rounded - 1)
                : null,
            onIncrease: rounded < 10
                ? () => onChanged((rounded + 1).toDouble())
                : null,
            onDecrease: rounded > 0
                ? () => onChanged((rounded - 1).toDouble())
                : null,
            child: ExcludeSemantics(
              child: Slider(
                value: value,
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PauseUrgePill extends StatelessWidget {
  final VoidCallback onTap;

  const _PauseUrgePill({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = context.l10n.trackerPauseUrgeAction;

    return Semantics(
      button: true,
      label: label,
      child: ExcludeSemantics(
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.24),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LineIcons.hourglassHalf,
                    color: theme.colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    label,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final OcdType type;

  const _TypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    final isObsession = type == OcdType.obsession;
    final color = isObsession
        ? context.appColors.obsessionChip
        : context.appColors.compulsionChip;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isObsession
            ? context.l10n.trackerTypeObsession
            : context.l10n.trackerTypeCompulsion,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EmptyTrackState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyTrackState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LineIcons.bullseye,
            color: theme.colorScheme.primary.withValues(alpha: 0.8),
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.trackerEmptyTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.trackerEmptyBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.appColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: onAdd,
            child: Text(context.l10n.trackerEmptyAction),
          ),
        ],
      ),
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
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: const EdgeInsets.all(21),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: theme.dividerColor),
          ),
          child: child,
        ),
      ),
    );
  }
}

TextStyle _screenTitle(ThemeData theme) {
  return TextStyle(
    fontFamily: AppTheme.sansFamily,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
    color: theme.colorScheme.onSurface,
  );
}

TextStyle _muted(ThemeData theme, double size) {
  return TextStyle(color: theme.appColors.textSecondary, fontSize: size);
}

BoxDecoration _softDecoration(ThemeData theme, {required double radius}) {
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.9)),
  );
}

Color _distressColor(ThemeData theme, int level) {
  if (level <= 3) return theme.appColors.positive;
  if (level <= 7) return theme.appColors.accent;
  return theme.appColors.negative;
}

int _typeOrder(OcdType? type) {
  if (type == null) return 0;
  if (type == OcdType.obsession) return 1;
  return 2;
}
