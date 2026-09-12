import 'package:flutter/material.dart';

import '../app_preferences.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import 'animations.dart';
import 'recovery_ui.dart';

typedef SectionIntroCopy = ({String title, List<String> points});

/// Stable section IDs used by one-time intro preferences and the tab tour.
/// Display copy is always resolved from [AppLocalizations].
const sectionIntroIds = <String>{
  'today',
  'journal',
  'track',
  'recoveryHub',
  'insights',
  'guidedErp',
  'compulsionDelay',
  'emergencyToolkit',
  'copingLibrary',
  'exposureHierarchy',
  'recoveryMetrics',
  'urgeSurf',
  'responsePrevention',
  'structuredPrograms',
  'behavioralExperiments',
  'exposureReflection',
  'actionPlanner',
  'implementationIntentions',
  'uncertaintyTraining',
  'exposureMaterials',
};

const _recoveryToolForSection = <String, String>{
  'guidedErp': 'guidedErp',
  'compulsionDelay': 'compulsionDelay',
  'emergencyToolkit': 'emergencyToolkit',
  'copingLibrary': 'copingLibrary',
  'exposureHierarchy': 'exposureHierarchy',
  'recoveryMetrics': 'recoveryMetrics',
  'urgeSurf': 'urgeSurfing',
  'responsePrevention': 'responsePrevention',
  'structuredPrograms': 'structuredPrograms',
  'behavioralExperiments': 'behavioralExperiments',
  'exposureReflection': 'reflectionJournal',
  'actionPlanner': 'actionPlanner',
  'implementationIntentions': 'implementationIntentions',
  'uncertaintyTraining': 'uncertaintyTraining',
  'exposureMaterials': 'exposureMaterials',
};

SectionIntroCopy? localizedSectionIntro(
  AppLocalizations strings,
  String sectionId,
) {
  final main = switch (sectionId) {
    'today' => (
      title: strings.navToday,
      points: [strings.shellText('sectionTodayBody')],
    ),
    'journal' => (
      title: strings.navJournal,
      points: [strings.shellText('sectionJournalBody')],
    ),
    'track' => (
      title: strings.navTrack,
      points: [strings.shellText('sectionTrackBody')],
    ),
    'recoveryHub' => (
      title: strings.navRecovery,
      points: [strings.shellText('sectionRecoveryBody')],
    ),
    'insights' => (
      title: strings.navInsights,
      points: [strings.shellText('sectionInsightsBody')],
    ),
    _ => null,
  };
  if (main != null) return main;

  final toolId = _recoveryToolForSection[sectionId];
  if (toolId == null) return null;
  return (
    title: strings.recoveryToolTitle(toolId),
    points: [strings.recoveryToolSubtitle(toolId)],
  );
}

/// A one-time introduction card for a section. Shows the first time a user
/// opens the screen, then collapses to nothing on "Got it" (or if already
/// seen). Self-contained so stateless [ConsumerWidget] screens don't need to
/// become stateful - just drop `const SectionIntro(id: '<id>')` into the body.
class SectionIntro extends StatefulWidget {
  final String id;

  const SectionIntro({super.key, required this.id});

  static String _key(String id) => 'sectionSeen_$id';

  @override
  State<SectionIntro> createState() => _SectionIntroState();
}

class _SectionIntroState extends State<SectionIntro> {
  late bool _seen =
      mobilePreferences?.getBool(SectionIntro._key(widget.id)) ?? false;

  void _dismiss() {
    mobilePreferences?.setBool(SectionIntro._key(widget.id), true);
    setState(() => _seen = true);
  }

  @override
  Widget build(BuildContext context) {
    final intro = localizedSectionIntro(context.l10n, widget.id);
    final reduceMotion = motionDisabled(context);

    final content = (_seen || intro == null)
        ? const SizedBox(width: double.infinity)
        : _buildCard(context, intro);

    // AnimatedSize gives a smooth collapse on dismiss; skipped when the user
    // has reduced motion so it snaps instead.
    if (reduceMotion) return content;
    return AnimatedSize(
      duration: AppMotion.medium,
      curve: AppMotion.stateCurve,
      alignment: Alignment.topCenter,
      child: content,
    );
  }

  Widget _buildCard(BuildContext context, SectionIntroCopy intro) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: FadeSlideIn(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
          decoration: recoverySoftDecoration(theme),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in intro.points) _bullet(theme, point),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _dismiss,
                  child: Text(context.l10n.shellText('gotIt')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: ExcludeSemantics(
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.appColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.appColors.textSecondary,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
