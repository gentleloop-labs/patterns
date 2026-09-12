import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/l10n/app_localizations_en.dart';
import 'package:patterns/widgets/section_intro.dart';

/// House style, enforced so it does not drift back one screen at a time.
///
/// The em dash is the main offender: it slips in whenever copy gets written
/// quickly, and it reads wrong in an app that is trying to sound like a person
/// rather than a brochure. Rephrase instead of reaching for one.
///
/// "practice" as a verb is the other. British spelling is the noun/verb split:
/// you practise ERP (verb), and your practice grows (noun). Only the verb form
/// is checked, since "practice" the noun is correct.
void main() {
  group('section intros', () {
    final strings = AppLocalizationsEn();

    test('every intro has a title and at least one point', () {
      expect(sectionIntroIds, isNotEmpty);
      for (final id in sectionIntroIds) {
        final intro = localizedSectionIntro(strings, id);
        expect(intro, isNotNull, reason: 'copy for $id');
        expect(intro!.title, isNotEmpty, reason: 'title for $id');
        expect(intro.points, isNotEmpty, reason: 'points for $id');
      }
    });

    test('no em dashes', () {
      for (final id in sectionIntroIds) {
        final intro = localizedSectionIntro(strings, id)!;
        expect(intro.title, isNot(contains('—')), reason: 'title for $id');
        for (final point in intro.points) {
          expect(point, isNot(contains('—')), reason: 'point in $id');
        }
      }
    });

    test('does not promise the recovery score, which was removed', () {
      final today = localizedSectionIntro(strings, 'today');
      expect(today, isNotNull);
      for (final point in today!.points) {
        expect(point.toLowerCase(), isNot(contains('recovery score')));
      }
    });
  });

  group('lib/ source copy', () {
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .toList();

    test('finds source to scan', () {
      expect(dartFiles.length, greaterThan(50));
    });

    test('contains no em dashes', () {
      final offenders = <String>[];
      for (final file in dartFiles) {
        final lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          final line = lines[i];
          // Comments are for us, not for the reader, so they are exempt.
          if (line.trimLeft().startsWith('//')) continue;
          if (line.contains('—')) {
            offenders.add('${file.path}:${i + 1}: ${line.trim()}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'Rephrase instead of using an em dash:\n${offenders.join('\n')}',
      );
    });

    test('uses "practise" for the verb, not "practice"', () {
      // Verb contexts only. "practice" as a noun ("your practice", "ERP
      // practice") is correct and deliberately not matched.
      final verbForms = RegExp(
        r'\b(to practice|practice resisting|practice leaving|will practice|'
        r'want to practice|practice with\b)',
        caseSensitive: false,
      );
      final offenders = <String>[];
      for (final file in dartFiles) {
        final lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          if (verbForms.hasMatch(lines[i])) {
            offenders.add('${file.path}:${i + 1}: ${lines[i].trim()}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Use "practise" for the verb:\n${offenders.join('\n')}',
      );
    });
  });
}
