import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../l10n/l10n.dart';
import '../../theme/app_colors.dart';
import '../../services/app_events.dart';
import '../../services/pro_entry_point.dart';
import '../../widgets/animations.dart';
import '../preferences.dart';
import '../widgets/pro_gate.dart';
import 'action_planner_screen.dart';
import 'behavioral_experiments_screen.dart';
import 'compulsion_delay_screen.dart';
import 'coping_library_screen.dart';
import 'emergency_toolkit_screen.dart';
import 'erp_exercises_screen.dart';
import 'exposure_hierarchy_screen.dart';
import 'exposure_materials_screen.dart';
import 'exposure_reflection_screen.dart';
import 'implementation_intentions_screen.dart';
import 'recovery_metrics_screen.dart';
import 'response_prevention_screen.dart';
import 'structured_programs_screen.dart';
import 'uncertainty_training_screen.dart';
import 'urge_surf_screen.dart';
import 'ybocs_screen.dart';

/// Daily recovery cockpit: today-first ERP, compact tools, and visible progress.
class RecoveryHubScreen extends ConsumerWidget {
  const RecoveryHubScreen({super.key});

  /// Fast-access tools for a hard moment. These also appear under their journey
  /// stage below — a distressed user must not have to scan a journey to find a
  /// grounding tool. All three are free.
  static const _sosTools = <_RecoveryTool>[
    _RecoveryTool(
      icon: Icons.health_and_safety_rounded,
      destination: _RecoveryDestination.emergencyToolkit,
      stage: _Stage.practice,
    ),
    _RecoveryTool(
      icon: Icons.spa_rounded,
      destination: _RecoveryDestination.copingLibrary,
      stage: _Stage.practice,
    ),
    _RecoveryTool(
      icon: Icons.hourglass_bottom_rounded,
      destination: _RecoveryDestination.compulsionDelay,
      stage: _Stage.practice,
      fullscreen: true,
    ),
  ];

  /// The full library, tagged by ERP journey stage and Pro status. Rendered
  /// grouped so users find a tool by where they are in their work rather than
  /// scanning a flat wall of tiles.
  static const _tools = <_RecoveryTool>[
    // Assess — see where you are.
    _RecoveryTool(
      icon: Icons.fact_check_rounded,
      destination: _RecoveryDestination.ybocsSelfCheck,
      stage: _Stage.assess,
      fullscreen: true,
    ),
    _RecoveryTool(
      icon: Icons.local_fire_department_rounded,
      destination: _RecoveryDestination.recoveryMetrics,
      stage: _Stage.assess,
      pro: true,
    ),
    // Plan — set up your practice.
    _RecoveryTool(
      icon: Icons.stairs_rounded,
      destination: _RecoveryDestination.exposureHierarchy,
      stage: _Stage.plan,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.folder_special_rounded,
      destination: _RecoveryDestination.exposureMaterials,
      stage: _Stage.plan,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.calendar_month_rounded,
      destination: _RecoveryDestination.structuredPrograms,
      stage: _Stage.plan,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.checklist_rounded,
      destination: _RecoveryDestination.actionPlanner,
      stage: _Stage.plan,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.lightbulb_outline_rounded,
      destination: _RecoveryDestination.implementationIntentions,
      stage: _Stage.plan,
      pro: true,
    ),
    // Practice — do the reps.
    _RecoveryTool(
      icon: Icons.self_improvement_rounded,
      destination: _RecoveryDestination.guidedErp,
      stage: _Stage.practice,
    ),
    _RecoveryTool(
      icon: Icons.hourglass_bottom_rounded,
      destination: _RecoveryDestination.compulsionDelay,
      stage: _Stage.practice,
      fullscreen: true,
    ),
    _RecoveryTool(
      icon: Icons.waves_rounded,
      destination: _RecoveryDestination.urgeSurfing,
      stage: _Stage.practice,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.shield_rounded,
      destination: _RecoveryDestination.responsePrevention,
      stage: _Stage.practice,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.help_outline_rounded,
      destination: _RecoveryDestination.uncertaintyTraining,
      stage: _Stage.practice,
      pro: true,
    ),
    // Review — reflect and learn.
    _RecoveryTool(
      icon: Icons.science_rounded,
      destination: _RecoveryDestination.behavioralExperiments,
      stage: _Stage.review,
      pro: true,
    ),
    _RecoveryTool(
      icon: Icons.menu_book_rounded,
      destination: _RecoveryDestination.reflectionJournal,
      stage: _Stage.review,
      pro: true,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(proProvider);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.appColors.surface, context.appColors.surface],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 116),
            children: staggered([
              const _RecoveryHeader(),
              const SizedBox(height: 16),
              _SosStrip(
                tools: _sosTools,
                onTap: (tool) => _open(
                  context,
                  tool.destination,
                  fullscreen: tool.fullscreen,
                ),
              ),
              const SizedBox(height: 18),
              for (final stage in _Stage.values) ...[
                _ToolSection(
                  title: context.l10n.recoveryStageTitle(stage.name),
                  subtitle: context.l10n.recoveryStageSubtitle(stage.name),
                  child: _ToolList(
                    tools: _tools.where((t) => t.stage == stage).toList(),
                    isPro: isPro,
                    onTap: (tool) =>
                        _openTool(context, ref, tool, isPro: isPro),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ]),
          ),
        ),
      ),
    );
  }

  void _openTool(
    BuildContext context,
    WidgetRef ref,
    _RecoveryTool tool, {
    required bool isPro,
  }) {
    if (tool.pro &&
        !isPro &&
        !requirePro(context, ref, entryPoint: tool.destination.proEntryPoint)) {
      return;
    }
    _open(context, tool.destination, fullscreen: tool.fullscreen);
  }

  void _open(
    BuildContext context,
    _RecoveryDestination destination, {
    bool fullscreen = false,
  }) {
    if (destination == _RecoveryDestination.guidedErp) {
      AppEvents.logErpOpened();
    }
    final screen = _screenFor(destination);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: fullscreen,
        builder: (_) => screen,
      ),
    );
  }

  Widget _screenFor(_RecoveryDestination destination) {
    switch (destination) {
      case _RecoveryDestination.guidedErp:
        return const ErpExercisesScreen(showBack: true);
      case _RecoveryDestination.ybocsSelfCheck:
        return const YbocsScreen();
      case _RecoveryDestination.compulsionDelay:
        return const CompulsionDelayFlow();
      case _RecoveryDestination.emergencyToolkit:
        return const EmergencyToolkitScreen();
      case _RecoveryDestination.copingLibrary:
        return const CopingLibraryScreen();
      case _RecoveryDestination.exposureHierarchy:
        return const ExposureHierarchyScreen();
      case _RecoveryDestination.exposureMaterials:
        return const ExposureMaterialsScreen();
      case _RecoveryDestination.responsePrevention:
        return const ResponsePreventionScreen();
      case _RecoveryDestination.structuredPrograms:
        return const StructuredProgramsScreen();
      case _RecoveryDestination.urgeSurfing:
        return const UrgeSurfScreen();
      case _RecoveryDestination.uncertaintyTraining:
        return const UncertaintyTrainingScreen();
      case _RecoveryDestination.actionPlanner:
        return const ActionPlannerScreen();
      case _RecoveryDestination.behavioralExperiments:
        return const BehavioralExperimentsScreen();
      case _RecoveryDestination.recoveryMetrics:
        return const RecoveryMetricsScreen();
      case _RecoveryDestination.reflectionJournal:
        return const ExposureReflectionScreen();
      case _RecoveryDestination.implementationIntentions:
        return const ImplementationIntentionsScreen();
    }
  }
}

enum _RecoveryDestination {
  guidedErp,
  ybocsSelfCheck,
  compulsionDelay,
  emergencyToolkit,
  copingLibrary,
  exposureHierarchy,
  exposureMaterials,
  responsePrevention,
  structuredPrograms,
  urgeSurfing,
  uncertaintyTraining,
  actionPlanner,
  behavioralExperiments,
  recoveryMetrics,
  reflectionJournal,
  implementationIntentions,
}

extension on _RecoveryDestination {
  ProEntryPoint get proEntryPoint => switch (this) {
    _RecoveryDestination.recoveryMetrics => ProEntryPoint.recoveryMetrics,
    _RecoveryDestination.exposureHierarchy => ProEntryPoint.exposureHierarchy,
    _RecoveryDestination.exposureMaterials => ProEntryPoint.exposureMaterials,
    _RecoveryDestination.structuredPrograms => ProEntryPoint.structuredPrograms,
    _RecoveryDestination.actionPlanner => ProEntryPoint.actionPlanner,
    _RecoveryDestination.implementationIntentions =>
      ProEntryPoint.implementationIntentions,
    _RecoveryDestination.urgeSurfing => ProEntryPoint.urgeSurfing,
    _RecoveryDestination.responsePrevention => ProEntryPoint.responsePrevention,
    _RecoveryDestination.uncertaintyTraining =>
      ProEntryPoint.uncertaintyTraining,
    _RecoveryDestination.behavioralExperiments =>
      ProEntryPoint.behavioralExperiments,
    _RecoveryDestination.reflectionJournal => ProEntryPoint.reflectionJournal,
    _RecoveryDestination.guidedErp ||
    _RecoveryDestination.ybocsSelfCheck ||
    _RecoveryDestination.compulsionDelay ||
    _RecoveryDestination.emergencyToolkit ||
    _RecoveryDestination.copingLibrary => ProEntryPoint.settings,
  };
}

/// The ERP journey stages the library is grouped into, ordered as a user
/// progresses. Plain-language titles/subtitles keep the framing calm.
enum _Stage { assess, plan, practice, review }

class _RecoveryTool {
  final IconData icon;
  final _RecoveryDestination destination;
  final _Stage stage;
  final bool pro;
  final bool fullscreen;

  const _RecoveryTool({
    required this.icon,
    required this.destination,
    required this.stage,
    this.pro = false,
    this.fullscreen = false,
  });

  String title(BuildContext context) =>
      context.l10n.recoveryToolTitle(destination.name);

  String subtitle(BuildContext context) =>
      context.l10n.recoveryToolSubtitle(destination.name);
}

class _RecoveryHeader extends StatelessWidget {
  const _RecoveryHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            context.l10n.recoveryTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.05,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          context.l10n.recoverySubtitle,
          style: TextStyle(
            color: context.appColors.textSecondary,
            fontSize: 14,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

/// Persistent quick-access to the in-the-moment tools, kept above the journey
/// stages so a distressed user reaches grounding in one tap.
class _SosStrip extends StatelessWidget {
  final List<_RecoveryTool> tools;
  final ValueChanged<_RecoveryTool> onTap;

  const _SosStrip({required this.tools, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _CockpitCard(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.favorite_rounded,
                color: context.appColors.accent,
                size: 16,
              ),
              SizedBox(width: 7),
              Semantics(
                header: true,
                child: Text(
                  context.l10n.recoveryImmediateHelpTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final stack = MediaQuery.textScalerOf(context).scale(1) > 1.3;
              final width = stack
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 16) / 3;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tool in tools)
                    SizedBox(
                      width: width,
                      child: _SosButton(tool: tool, onTap: () => onTap(tool)),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SosButton extends StatelessWidget {
  final _RecoveryTool tool;
  final VoidCallback onTap;

  const _SosButton({required this.tool, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = tool.title(context);
    final subtitle = tool.subtitle(context);
    return Semantics(
      button: true,
      label: title,
      value: subtitle,
      hint: context.l10n.recoveryOpenToolHint(title),
      onTap: onTap,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 72),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: context.appColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: context.appColors.border),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tool.icon, color: context.appColors.accent, size: 22),
                const SizedBox(height: 7),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    height: 1.2,
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

class _ToolSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _ToolSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _CockpitCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(subtitle, style: _mutedStyle(theme).copyWith(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Compact full-width rows for a stage's tools. Rows fill the card edge to edge
/// and stay tidy whether a stage holds two tools or five — no empty grid cells
/// or tall tiles with dead space in the middle.
class _ToolList extends StatelessWidget {
  final List<_RecoveryTool> tools;
  final bool isPro;
  final ValueChanged<_RecoveryTool> onTap;

  const _ToolList({
    required this.tools,
    required this.isPro,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < tools.length; i++) ...[
          if (i != 0)
            const Divider(height: 1, thickness: 1, color: Color(0xFF262521)),
          _ToolRow(
            tool: tools[i],
            locked: tools[i].pro && !isPro,
            onTap: () => onTap(tools[i]),
          ),
        ],
      ],
    );
  }
}

class _ToolRow extends StatelessWidget {
  final _RecoveryTool tool;
  final bool locked;
  final VoidCallback onTap;

  const _ToolRow({
    required this.tool,
    required this.locked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = tool.title(context);
    final subtitle = tool.subtitle(context);
    final hint = locked
        ? context.l10n.recoveryLockedToolHint(title)
        : context.l10n.recoveryOpenToolHint(title);
    return Semantics(
      button: true,
      label: title,
      value: subtitle,
      hint: hint,
      onTap: onTap,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.appColors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    tool.icon,
                    color: context.appColors.accent,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: _mutedStyle(theme).copyWith(fontSize: 11.5),
                      ),
                      if (locked) ...[
                        const SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LineIcons.lock,
                              color: context.appColors.textSecondary,
                              size: 13,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                context.l10n.recoveryProBadge,
                                style: _mutedStyle(theme).copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  LineIcons.angleRight,
                  color: context.appColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CockpitCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _CockpitCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: _cockpitDecoration(theme),
      child: child,
    );
  }
}

BoxDecoration _cockpitDecoration(ThemeData theme, {double radius = 20}) {
  final colors = theme.appColors;
  return BoxDecoration(
    color: colors.card,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: colors.border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.28 : 0.08,
        ),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
      BoxShadow(color: colors.accent.withValues(alpha: 0.035), blurRadius: 28),
    ],
  );
}

TextStyle _mutedStyle(ThemeData theme) =>
    TextStyle(color: theme.appColors.textSecondary, fontSize: 12, height: 1.25);
