import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/content/ocd_tracks.dart';
import 'package:patterns/content/ybocs_content.dart';
import 'package:patterns/mobile/screens/structured_programs_screen.dart';

void main() {
  group('track integrity', () {
    test('every ybocsCategoryId resolves to a real Y-BOCS category', () {
      // The whole point of keying tracks to the checklist is that suggestions
      // come from real assessment data. A typo here would silently mean a track
      // is never suggested, with nothing failing to say so.
      for (final track in ocdTracks) {
        for (final id in track.ybocsCategoryIds) {
          expect(
            ybocsCategoryFor(id),
            isNotNull,
            reason: 'track "${track.id}" references unknown category "$id"',
          );
        }
      }
    });

    test('track ids are unique', () {
      final ids = ocdTracks.map((t) => t.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('track program ids never collide with hand-written programs', () {
      final handWritten = erpPrograms.map((p) => p.id).toSet();
      for (final track in ocdTracks) {
        expect(handWritten, isNot(contains(track.programId)));
      }
    });

    test('task ids are unique within a track', () {
      for (final track in ocdTracks) {
        final ids = [
          for (final week in track.weeks)
            for (final task in week.tasks) task.id,
        ];
        expect(
          ids.toSet().length,
          ids.length,
          reason: 'duplicate task id in track "${track.id}"',
        );
      }
    });

    test('every track has weeks, tasks, and a theme label', () {
      expect(ocdTracks, isNotEmpty);
      for (final track in ocdTracks) {
        expect(track.weeks, isNotEmpty, reason: track.id);
        expect(track.hierarchyThemeLabel, isNotEmpty, reason: track.id);
        for (final week in track.weeks) {
          expect(week.tasks, isNotEmpty, reason: '${track.id}/${week.title}');
        }
      }
    });

    test('a track with no checklist category explains why', () {
      // Relationship OCD is the case: it is absent from the Y-BOCS because the
      // instrument predates that literature. Silence would read as an omission.
      for (final track in ocdTracks) {
        if (track.ybocsCategoryIds.isEmpty) {
          expect(
            track.checklistNote,
            isNotNull,
            reason: 'track "${track.id}" has no categories and no explanation',
          );
        }
      }
    });
  });

  group('theme matching', () {
    test('matches a track when the assessment flagged one of its categories', () {
      final contamination = ocdTracks.firstWhere(
        (t) => t.id == 'contamination',
      );

      expect(contamination.matchesThemes(['washing']), isTrue);
      expect(contamination.matchesThemes(['checking']), isFalse);
    });

    test('a track with no categories never claims a match', () {
      final relationship = ocdTracks.firstWhere((t) => t.id == 'relationship');

      expect(relationship.ybocsCategoryIds, isEmpty);
      expect(relationship.matchesThemes(['checking', 'washing']), isFalse);
      expect(relationship.matchesThemes(const []), isFalse);
    });
  });

  group('program conversion', () {
    test('preserves every task so progress counts line up', () {
      for (final track in ocdTracks) {
        final program = programForTrack(track);
        final trackTasks = track.weeks.fold<int>(
          0,
          (sum, w) => sum + w.tasks.length,
        );

        expect(program.id, track.programId);
        expect(program.weeks.length, track.weeks.length);
        expect(program.totalTasks, trackTasks);
      }
    });

    test('resolves a program id back to its track', () {
      final track = ocdTracks.first;

      expect(trackForProgramId(track.programId)?.id, track.id);
      expect(trackForProgramId('delay-4wk'), isNull);
    });
  });
}
