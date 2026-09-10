/// ERP tracks written for specific OCD themes.
///
/// Definitions contain stable identifiers only. Localized presentation is
/// resolved at render time, while enrollment and task progress continue to use
/// the existing program and task IDs.
library;

import '../l10n/app_localizations.dart';
import '../l10n/app_localizations_en.dart';

class OcdTrackTask {
  final String id;
  const OcdTrackTask(this.id);

  String localizedLabel(AppLocalizations strings) => strings.ocdTrackTask(id);

  /// English compatibility for the desktop UI, which is outside the 1.10
  /// mobile localization gate. The stored definition still contains only IDs.
  String get label => localizedLabel(AppLocalizationsEn());
}

class OcdTrackWeek {
  final String id;
  final List<OcdTrackTask> tasks;
  const OcdTrackWeek({required this.id, required this.tasks});

  String localizedTitle(AppLocalizations strings) => strings.ocdTrackWeek(id);

  /// English compatibility for the desktop UI excluded from the 1.10 gate.
  String get title => localizedTitle(AppLocalizationsEn());
}

class OcdTrack {
  final String id;

  /// Stable Y-BOCS category IDs represented by this track. Relationship OCD
  /// deliberately has no category because the checklist predates that work.
  final List<String> ybocsCategoryIds;
  final List<OcdTrackWeek> weeks;

  const OcdTrack({
    required this.id,
    required this.ybocsCategoryIds,
    required this.weeks,
  });

  String get programId => 'track_$id';

  String get _localizationKey => id == 'just-right' ? 'justRight' : id;

  String localizedTitle(AppLocalizations strings) =>
      strings.ocdTrackTitle(_localizationKey);

  /// English compatibility accessors keep the excluded desktop UI compiling
  /// without introducing presentation strings into the stable definitions.
  String get title => localizedTitle(AppLocalizationsEn());

  String localizedBlurb(AppLocalizations strings) =>
      strings.ocdTrackBlurb(_localizationKey);

  String get blurb => localizedBlurb(AppLocalizationsEn());

  String localizedHierarchyTheme(AppLocalizations strings) =>
      strings.ocdTrackTheme(_localizationKey);

  String get hierarchyThemeLabel =>
      localizedHierarchyTheme(AppLocalizationsEn());

  String? localizedChecklistNote(AppLocalizations strings) =>
      ybocsCategoryIds.isEmpty
      ? strings.ocdTrackChecklistNote(_localizationKey)
      : null;

  String? get checklistNote => localizedChecklistNote(AppLocalizationsEn());

  bool matchesThemes(Iterable<String> themes) {
    if (ybocsCategoryIds.isEmpty) return false;
    return themes.any(ybocsCategoryIds.contains);
  }
}

const ocdTracks = <OcdTrack>[
  OcdTrack(
    id: 'contamination',
    ybocsCategoryIds: ['contamination', 'washing'],
    weeks: [
      OcdTrackWeek(
        id: 'ct1',
        tasks: [OcdTrackTask('ct1a'), OcdTrackTask('ct1b')],
      ),
      OcdTrackWeek(
        id: 'ct2',
        tasks: [OcdTrackTask('ct2a'), OcdTrackTask('ct2b')],
      ),
      OcdTrackWeek(
        id: 'ct3',
        tasks: [OcdTrackTask('ct3a'), OcdTrackTask('ct3b')],
      ),
    ],
  ),
  OcdTrack(
    id: 'checking',
    ybocsCategoryIds: ['checking', 'counting'],
    weeks: [
      OcdTrackWeek(
        id: 'ck1',
        tasks: [OcdTrackTask('ck1a'), OcdTrackTask('ck1b')],
      ),
      OcdTrackWeek(
        id: 'ck2',
        tasks: [OcdTrackTask('ck2a'), OcdTrackTask('ck2b')],
      ),
      OcdTrackWeek(
        id: 'ck3',
        tasks: [OcdTrackTask('ck3a'), OcdTrackTask('ck3b')],
      ),
    ],
  ),
  OcdTrack(
    id: 'harm',
    ybocsCategoryIds: ['aggressive', 'sexual', 'religious'],
    weeks: [
      OcdTrackWeek(
        id: 'hm1',
        tasks: [OcdTrackTask('hm1a'), OcdTrackTask('hm1b')],
      ),
      OcdTrackWeek(
        id: 'hm2',
        tasks: [OcdTrackTask('hm2a'), OcdTrackTask('hm2b')],
      ),
      OcdTrackWeek(
        id: 'hm3',
        tasks: [OcdTrackTask('hm3a'), OcdTrackTask('hm3b')],
      ),
    ],
  ),
  OcdTrack(
    id: 'relationship',
    ybocsCategoryIds: [],
    weeks: [
      OcdTrackWeek(
        id: 'rl1',
        tasks: [OcdTrackTask('rl1a'), OcdTrackTask('rl1b')],
      ),
      OcdTrackWeek(
        id: 'rl2',
        tasks: [OcdTrackTask('rl2a'), OcdTrackTask('rl2b')],
      ),
      OcdTrackWeek(
        id: 'rl3',
        tasks: [OcdTrackTask('rl3a'), OcdTrackTask('rl3b')],
      ),
    ],
  ),
  OcdTrack(
    id: 'just-right',
    ybocsCategoryIds: ['symmetry_obs', 'ordering', 'repeating'],
    weeks: [
      OcdTrackWeek(
        id: 'jr1',
        tasks: [OcdTrackTask('jr1a'), OcdTrackTask('jr1b')],
      ),
      OcdTrackWeek(
        id: 'jr2',
        tasks: [OcdTrackTask('jr2a'), OcdTrackTask('jr2b')],
      ),
      OcdTrackWeek(
        id: 'jr3',
        tasks: [OcdTrackTask('jr3a'), OcdTrackTask('jr3b')],
      ),
    ],
  ),
];
