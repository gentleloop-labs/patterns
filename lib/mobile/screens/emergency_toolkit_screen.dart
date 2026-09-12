import 'dart:async';

import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../widgets/recovery_ui.dart';
import '../widgets/section_intro.dart';
import 'compulsion_delay_screen.dart';
import 'coping_library_screen.dart';
import 'urge_surf_screen.dart';

/// Free crisis-support screen. Quick, calming actions for a high-distress
/// moment - never gated behind Pro.
class EmergencyToolkitScreen extends StatelessWidget {
  const EmergencyToolkitScreen({super.key});

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
                      strings.emergencyToolkitText('title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const SectionIntro(id: 'emergencyToolkit'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      strings.emergencyToolkitText('pauseTitle'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    strings.emergencyToolkitText('pauseBody'),
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              strings.emergencyToolkitText('boundary'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),
            _ActionTile(
              icon: Icons.air_rounded,
              title: strings.emergencyToolkitText('breathe'),
              subtitle: strings.emergencyToolkitText('breatheSubtitle'),
              onTap: () => _push(context, const BreathingScreen()),
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.hourglass_bottom_rounded,
              title: strings.emergencyToolkitText('delay'),
              subtitle: strings.emergencyToolkitText('delaySubtitle'),
              onTap: () =>
                  _pushFullscreen(context, const CompulsionDelayFlow()),
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.waves_rounded,
              title: strings.emergencyToolkitText('surf'),
              subtitle: strings.emergencyToolkitText('surfSubtitle'),
              onTap: () =>
                  _pushFullscreen(context, const UrgeSurfFlow(record: false)),
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.spa_rounded,
              title: strings.emergencyToolkitText('coping'),
              subtitle: strings.emergencyToolkitText('copingSubtitle'),
              onTap: () => _push(context, const CopingLibraryScreen()),
            ),
            const SizedBox(height: 24),
            Semantics(
              header: true,
              child: Text(
                strings.emergencyToolkitText('remindersTitle'),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 12),
            for (final key in const [
              'reminderThought',
              'reminderUrge',
              'reminderUncertainty',
            ]) ...[
              _StatementCard(text: strings.emergencyToolkitText(key)),
              const SizedBox(height: 10),
            ],
          ]),
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  void _pushFullscreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(fullscreenDialog: true, builder: (_) => screen),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      label: title,
      hint: subtitle,
      excludeSemantics: true,
      child: PressScale(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.all(16),
          decoration: recoverySoftDecoration(theme),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withValues(alpha: 0.14),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatementCard extends StatelessWidget {
  final String text;
  const _StatementCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: recoverySoftDecoration(theme),
      child: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          height: 1.45,
          fontFamily: AppTheme.displayFamily,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Breathing exercise
// ---------------------------------------------------------------------------

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  static const _phases = [
    (key: 'breatheIn', big: true),
    (key: 'hold', big: true),
    (key: 'breatheOut', big: false),
    (key: 'hold', big: false),
  ];
  static const _phaseDuration = Duration(seconds: 4);

  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_phaseDuration, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % _phases.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final phase = _phases[_index];
    final phaseLabel = strings.emergencyToolkitText(phase.key);
    final requestedSize = phase.big ? 240.0 : 130.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  CircleBackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        strings.emergencyToolkitText('breathe'),
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = requestedSize.clamp(
                    96.0,
                    constraints.biggest.shortestSide * 0.65,
                  );
                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Semantics(
                            liveRegion: true,
                            label: phaseLabel,
                            excludeSemantics: true,
                            child: AnimatedContainer(
                              duration: motionDisabled(context)
                                  ? Duration.zero
                                  : _phaseDuration,
                              curve: Curves.easeInOut,
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.16,
                                ),
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                phaseLabel,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            strings.emergencyToolkitText('breathingHint'),
                            style: TextStyle(
                              color: context.appColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
