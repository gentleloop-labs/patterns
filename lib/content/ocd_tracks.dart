/// ERP tracks written for a specific OCD theme.
///
/// A blank fear ladder is the hardest thing to fill in when you are the one
/// with the doubt, so each track is a few weeks of exposures already shaped for
/// one theme. Nothing here needs new storage: a track becomes a program, and the
/// existing enrollment and task-progress tables carry the state.
///
/// [OcdTrack.ybocsCategoryIds] point at the categories in `ybocs_content.dart`,
/// so a track can be suggested from what someone actually flagged on their last
/// self-check rather than from a second taxonomy that would drift out of step.
library;

class OcdTrackTask {
  final String id;
  final String label;
  const OcdTrackTask(this.id, this.label);
}

class OcdTrackWeek {
  final String title;
  final List<OcdTrackTask> tasks;
  const OcdTrackWeek({required this.title, required this.tasks});
}

class OcdTrack {
  final String id;
  final String title;
  final String blurb;

  /// Y-BOCS symptom category ids this track covers. Empty means the theme is
  /// not represented on the standard checklist, which is true of relationship
  /// OCD: the instrument predates that literature. An empty list is a
  /// deliberate statement, not a gap to be filled in later by inventing
  /// categories the Y-BOCS does not have.
  final List<String> ybocsCategoryIds;

  /// Pre-fills the free-text "Theme" field on an exposure ladder, so ladders
  /// and tracks share one vocabulary without needing a migration.
  final String hierarchyThemeLabel;

  /// Shown when a track is not backed by a Y-BOCS category, so nobody concludes
  /// their theme is missing from the self-check by accident.
  final String? checklistNote;

  final List<OcdTrackWeek> weeks;

  const OcdTrack({
    required this.id,
    required this.title,
    required this.blurb,
    required this.ybocsCategoryIds,
    required this.hierarchyThemeLabel,
    required this.weeks,
    this.checklistNote,
  });

  /// Program id used for enrollment. Namespaced so a track can never collide
  /// with a hand-written program id.
  String get programId => 'track_$id';

  /// True when this track covers something flagged on [themes], which are the
  /// category ids stored on a saved Y-BOCS assessment.
  bool matchesThemes(Iterable<String> themes) {
    if (ybocsCategoryIds.isEmpty) return false;
    return themes.any(ybocsCategoryIds.contains);
  }
}

const ocdTracks = <OcdTrack>[
  OcdTrack(
    id: 'contamination',
    title: 'Contamination and washing',
    blurb:
        'For the fear that something is dirty, contagious, or unsafe to touch, '
        'and the washing and cleaning that follows.',
    ybocsCategoryIds: ['contamination', 'washing'],
    hierarchyThemeLabel: 'Contamination',
    weeks: [
      OcdTrackWeek(
        title: 'Week 1 · Touch, then wait',
        tasks: [
          OcdTrackTask(
            'ct1a',
            'Touch something that feels slightly unclean and leave your hands '
                'unwashed for five minutes',
          ),
          OcdTrackTask(
            'ct1b',
            'Rate the urge before and after, so you can watch it fall without '
                'the wash',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 2 · One wash, not three',
        tasks: [
          OcdTrackTask(
            'ct2a',
            'Wash once, normally, and do not go back for a second round',
          ),
          OcdTrackTask(
            'ct2b',
            'Leave one surface at home uncleaned for the whole week',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 3 · Carry it home',
        tasks: [
          OcdTrackTask(
            'ct3a',
            'Go somewhere that usually needs a wash afterwards, and do not '
                'wash when you get in',
          ),
          OcdTrackTask(
            'ct3b',
            'Write down what OCD said would happen, next to what did',
          ),
        ],
      ),
    ],
  ),
  OcdTrack(
    id: 'checking',
    title: 'Checking and doubt',
    blurb:
        'For locks, hobs, switches, emails, and anything you go back to because '
        'the memory of doing it does not feel convincing enough.',
    ybocsCategoryIds: ['checking', 'counting'],
    hierarchyThemeLabel: 'Checking',
    weeks: [
      OcdTrackWeek(
        title: 'Week 1 · Look once',
        tasks: [
          OcdTrackTask(
            'ck1a',
            'Check one thing a single time, then walk away without a second '
                'look',
          ),
          OcdTrackTask(
            'ck1b',
            'Leave the house once without a final sweep of the rooms',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 2 · No mental replay',
        tasks: [
          OcdTrackTask(
            'ck2a',
            'When the urge to replay the memory arrives, let the doubt sit '
                'there unresolved',
          ),
          OcdTrackTask(
            'ck2b',
            'Send one message without rereading it before or after',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 3 · Leave it unresolved',
        tasks: [
          OcdTrackTask(
            'ck3a',
            'Go a full day without going back to check anything twice',
          ),
          OcdTrackTask(
            'ck3b',
            'Note what actually went wrong, and what OCD promised would',
          ),
        ],
      ),
    ],
  ),
  OcdTrack(
    id: 'harm',
    title: 'Harm and taboo thoughts',
    blurb:
        'For intrusive thoughts about hurting someone, or thoughts that feel '
        'violent, sexual, or blasphemous. Having the thought is not the same as '
        'wanting it, and this track treats it that way.',
    ybocsCategoryIds: ['aggressive', 'sexual', 'religious'],
    hierarchyThemeLabel: 'Harm and taboo thoughts',
    weeks: [
      OcdTrackWeek(
        title: 'Week 1 · Let it be there',
        tasks: [
          OcdTrackTask(
            'hm1a',
            'Let one intrusive thought stay for a minute without arguing with '
                'it or pushing it away',
          ),
          OcdTrackTask(
            'hm1b',
            'Notice the mental review before it starts, and leave it alone',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 2 · Stop asking',
        tasks: [
          OcdTrackTask(
            'hm2a',
            'Resist asking anyone whether you are a good person, and do not '
                'search for it either',
          ),
          OcdTrackTask(
            'hm2b',
            'Stay in a situation you have been avoiding because of the thought',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 3 · No inner court case',
        tasks: [
          OcdTrackTask(
            'hm3a',
            'Go a day without checking your feelings for evidence about '
                'yourself',
          ),
          OcdTrackTask(
            'hm3b',
            'Write down what the week was like, without grading yourself in it',
          ),
        ],
      ),
    ],
  ),
  OcdTrack(
    id: 'relationship',
    title: 'Relationship doubt',
    blurb:
        'For the endless question of whether this is right, whether you love '
        'them enough, and whether the doubt itself is the answer.',
    ybocsCategoryIds: [],
    hierarchyThemeLabel: 'Relationship doubt',
    checklistNote:
        'The Y-BOCS checklist predates the research on relationship OCD, so '
        'this theme is not one of its categories. The track still works the '
        'same way.',
    weeks: [
      OcdTrackWeek(
        title: 'Week 1 · Stop testing',
        tasks: [
          OcdTrackTask(
            'rl1a',
            'Notice one compatibility test you run, and skip it once',
          ),
          OcdTrackTask(
            'rl1b',
            'Let a doubt about the relationship sit for ten minutes unanswered',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 2 · No reassurance',
        tasks: [
          OcdTrackTask(
            'rl2a',
            'Go a day without asking your partner, a friend, or the internet '
                'whether it is right',
          ),
          OcdTrackTask(
            'rl2b',
            'Do something together without monitoring how you feel during it',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 3 · Live with maybe',
        tasks: [
          OcdTrackTask(
            'rl3a',
            'Practise a "maybe, maybe not" answer whenever the question arrives',
          ),
          OcdTrackTask(
            'rl3b',
            'Reflect on the week without deciding anything about the future',
          ),
        ],
      ),
    ],
  ),
  OcdTrack(
    id: 'just-right',
    title: 'Just right and symmetry',
    blurb:
        'For the things that have to be even, ordered, or repeated until the '
        'feeling finally clicks. This track is about leaving it not-quite-right.',
    ybocsCategoryIds: ['symmetry_obs', 'ordering', 'repeating'],
    hierarchyThemeLabel: 'Just right',
    weeks: [
      OcdTrackWeek(
        title: 'Week 1 · Leave it crooked',
        tasks: [
          OcdTrackTask(
            'jr1a',
            'Leave one object slightly out of place and let the feeling sit',
          ),
          OcdTrackTask(
            'jr1b',
            'Do one thing once, even though it did not feel finished',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 2 · No repeating',
        tasks: [
          OcdTrackTask(
            'jr2a',
            'Resist redoing an action to make it land properly',
          ),
          OcdTrackTask(
            'jr2b',
            'Write something without going back to even out the wording',
          ),
        ],
      ),
      OcdTrackWeek(
        title: 'Week 3 · Good enough',
        tasks: [
          OcdTrackTask(
            'jr3a',
            'Get through a day leaving several things deliberately unfinished',
          ),
          OcdTrackTask(
            'jr3b',
            'Note whether the not-right feeling faded on its own',
          ),
        ],
      ),
    ],
  ),
];
