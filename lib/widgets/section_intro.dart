import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../app_preferences.dart';
import '../theme/app_colors.dart';
import 'animations.dart';
import 'recovery_ui.dart';

/// Copy for the one-time intro card shown the first time a user opens a
/// section. Keyed by a short [SectionIntro.id]. Kept in one place so all the
/// blurbs are easy to edit without touching the screens themselves.
const Map<String, ({String title, List<String> points})> sectionIntros = {
  // --- Main tabs ---
  'today': (
    title: 'Where the day starts',
    points: [
      'Your practice so far, and the one next thing worth doing today.',
      'A minute here is plenty. With OCD, showing up often beats going hard.',
    ],
  ),
  'journal': (
    title: 'Get it out of your head',
    points: [
      'Write down the intrusive thought, what OCD demanded, and what you did instead.',
      'Writing it down is not the same as arguing with it, and that is the point.',
    ],
  ),
  'track': (
    title: 'Log what OCD did',
    points: [
      'Note the obsession or the compulsion while it is fresh, and rate the distress from 0 to 10.',
      'A few weeks of these show your triggers, and show which responses loosen the grip.',
    ],
  ),
  'recoveryHub': (
    title: 'Everything for practising ERP',
    points: [
      'Tools grouped the way the work goes: see where you are, plan, practise, review.',
      'If it is a hard moment right now, grounding stays one tap away up top.',
    ],
  ),
  'insights': (
    title: 'What the pattern looks like',
    points: [
      'Your distress, your practice, and your Y-BOCS scores across weeks instead of one bad hour.',
      'OCD does not improve in a straight line. Seeing the line helps anyway.',
    ],
  ),

  // --- Free recovery tools ---
  'guidedErp': (
    title: 'Face it on purpose, in small steps',
    points: [
      'Short exposures to practise with, sized so you can actually do one today.',
      'The aim is to stay with the discomfort and leave the compulsion undone.',
    ],
  ),
  'compulsionDelay': (
    title: 'Put time between the urge and the ritual',
    points: [
      'Set a delay, then let the urge peak and drop without feeding it.',
      'Every delay is evidence you can hold the feeling without obeying it.',
    ],
  ),
  'emergencyToolkit': (
    title: 'For the hard moments',
    points: [
      'Fast grounding for when the distress spikes and the compulsion feels compulsory.',
      'Keep it a tap away. You do not have to think clearly to use it.',
    ],
  ),
  'copingLibrary': (
    title: 'Skills worth revisiting',
    points: [
      'Ways to steady yourself when an urge lands, so you are not deciding while flooded.',
      'These sit alongside ERP. They are for riding out the moment, not for making the doubt go away.',
    ],
  ),

  // --- Pro recovery tools ---
  'exposureHierarchy': (
    title: 'Build your fear ladder',
    points: [
      'List the situations OCD makes you avoid, and rank them from easiest to hardest.',
      'Climb one rung at a time. The bottom rung counts as much as the top one.',
    ],
  ),
  'recoveryMetrics': (
    title: 'What your practice adds up to',
    points: [
      'Exposures done, compulsions delayed, and how far the urge usually drops.',
      'Small, steady numbers are what recovery actually looks like from the inside.',
    ],
  ),
  'urgeSurf': (
    title: 'Ride the urge out',
    points: [
      'Urges rise, crest, and fall on their own if you do not feed them.',
      'Surf one here instead of performing the compulsion.',
    ],
  ),
  'responsePrevention': (
    title: 'Leave the ritual undone',
    points: [
      'Log what set it off, and what you did instead of the compulsion.',
      'Not doing it is where the learning happens, not in the exposure alone.',
    ],
  ),
  'structuredPrograms': (
    title: 'A few weeks, planned for you',
    points: [
      'Week-by-week ERP for one OCD theme, so you are not designing it each day.',
      'Follow it loosely. Missing a day resets nothing.',
    ],
  ),
  'behavioralExperiments': (
    title: 'Test what OCD promises',
    points: [
      'Write the prediction down first, then record what actually happened.',
      'OCD forecasts with total confidence. Held to the record, it rarely holds up.',
    ],
  ),
  'exposureReflection': (
    title: 'Look back once it settles',
    points: [
      'Write up an exposure after the distress fades, not while you are in it.',
      'What OCD swore would happen, next to what did. That gap is the evidence.',
    ],
  ),
  'actionPlanner': (
    title: 'Decide before OCD asks',
    points: [
      'Name the situation, and choose your response while you are calm.',
      'Deciding in advance beats deciding while flooded.',
    ],
  ),
  'implementationIntentions': (
    title: 'If-then plans',
    points: [
      'Decide in advance: if OCD does this, I will do that instead.',
      'Pre-committing means the compulsion is no longer the automatic answer.',
    ],
  ),
  'uncertaintyTraining': (
    title: 'Practise not knowing',
    points: [
      'Short reps for sitting with doubt instead of checking or asking.',
      'OCD wants certainty. This is how you stop paying for it.',
    ],
  ),
  'exposureMaterials': (
    title: 'Your exposure materials',
    points: [
      'Keep the scripts, loop tapes, images, and links your exposures need.',
      'Ready in advance, so starting one is not its own hurdle.',
    ],
  ),
};

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
    final intro = sectionIntros[widget.id];
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

  Widget _buildCard(
    BuildContext context,
    ({String title, List<String> points}) intro,
  ) {
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
              Row(
                children: [
                  Icon(
                    LineIcons.lightbulb,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      intro.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (final point in intro.points) _bullet(theme, point),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _dismiss,
                  child: const Text('Got it'),
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
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.appColors.textSecondary,
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
