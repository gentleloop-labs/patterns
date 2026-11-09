// Cross-checks between the Flutter app and the native SwiftUI rewrite
// (`apple/Packages/PatternsCore`). The native app opens the files Flutter
// wrote, in place, so both must agree exactly on the database, backups,
// timestamps and journal rich text.
//
// Writing fixtures (run after any change to the data layer):
//   PATTERNS_WRITE_NATIVE_FIXTURES=1 flutter test test/native_fixtures_test.dart
// writes apple/Fixtures/flutter/, which the Swift tests read.
//
// The Swift tests write apple/Fixtures/swift-out/. When that folder exists,
// the second group checks Flutter can read everything native wrote.
// `apple/scripts/compat-check.sh` runs the whole loop.

import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/database/db_helper.dart';
import 'package:patterns/widgets/rich_journal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final _fixturesDir = Directory('apple/Fixtures/flutter');
final _swiftOutDir = Directory('apple/Fixtures/swift-out');
final _writeFixtures =
    Platform.environment['PATTERNS_WRITE_NATIVE_FIXTURES'] == '1';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(sqfliteFfiInit);

  late Directory temp;
  setUp(() async {
    temp = await Directory.systemTemp.createTemp('patterns-native-fixtures-');
  });
  tearDown(() async {
    await DbHelper.resetDatabaseAfterTesting();
    await temp.delete(recursive: true);
  });

  group('Flutter -> native fixtures', () {
    test('write databases, backups and parity cases', () async {
      await _fixturesDir.create(recursive: true);

      // v10 database through the real Flutter create path.
      final v10 = '${temp.path}/v10.db';
      await DbHelper.configureDatabaseForTesting(
        factory: databaseFactoryFfi,
        path: v10,
      );
      await DbHelper.instance.importAll(jsonEncode(_fixtureBackup()));
      final v10Export = await DbHelper.instance.exportAll();
      await DbHelper.resetDatabaseAfterTesting();
      await _copy(v10, 'v10.db');
      await _write('v10.expected.json', v10Export);
      await _write('v10-backup.json', v10Export);
      await _writeBytes('v10-backup.zip', _bundle(v10Export));

      // Older installs: the same file with later tables removed and an older
      // user_version, as a user who skipped updates would have it. The
      // expected export comes from Flutter's own upgrade path.
      for (final version in _legacyVersions.keys) {
        final legacy = '${temp.path}/v$version.db';
        await File(v10).copy(legacy);
        final raw = await databaseFactoryFfi.openDatabase(legacy);
        for (final table in _tablesAddedAfter(version)) {
          await raw.execute('DROP TABLE $table');
        }
        await raw.execute('PRAGMA user_version = $version');
        await raw.close();
        await _copy(legacy, 'v$version.db');

        final upgraded = '${temp.path}/v$version-upgraded.db';
        await File(legacy).copy(upgraded);
        await DbHelper.configureDatabaseForTesting(
          factory: databaseFactoryFfi,
          path: upgraded,
        );
        await _write(
          'v$version.expected.json',
          await DbHelper.instance.exportAll(),
        );
        await DbHelper.resetDatabaseAfterTesting();
      }

      await _write('validation-cases.json', jsonEncode(_validationCases()));
      await _write('dates.json', jsonEncode(_dateCases()));
      await _write('journal-content.json', jsonEncode(_journalCases()));
    }, skip: !_writeFixtures);
  });

  group('native -> Flutter', () {
    final swiftDb = File('${_swiftOutDir.path}/swift.db');
    final present = swiftDb.existsSync();

    test('Flutter opens and reads the database native wrote', () async {
      final copy = '${temp.path}/swift.db';
      await swiftDb.copy(copy);
      await DbHelper.configureDatabaseForTesting(
        factory: databaseFactoryFfi,
        path: copy,
      );
      final db = await DbHelper.instance.database;
      expect(await db.getVersion(), 10);

      // Every typed getter must parse every row native wrote.
      final helper = DbHelper.instance;
      expect(await helper.getJournalEntries(), isNotEmpty);
      expect(await helper.getOcdEntries(), isNotEmpty);
      await helper.getDelaySessions();
      await helper.getActiveErpExercisePlans();
      await helper.getErpExerciseSessions();
      await helper.getActiveExposureHierarchies();
      await helper.getExposureSteps();
      await helper.getResponsePreventionLogs();
      await helper.getUrgeSurfSessions();
      await helper.getProgramEnrollments();
      await helper.getProgramTaskProgress();
      await helper.getBehavioralExperiments();
      await helper.getExposureReflections();
      await helper.getActionPlans();
      await helper.getImplementationIntentions();
      await helper.getUncertaintyLogs();
      await helper.getExposureMaterials();
      await helper.getYbocsAssessments();

      final expected = jsonDecode(
        await File('${_swiftOutDir.path}/swift.expected.json').readAsString(),
      );
      expect(jsonDecode(await helper.exportAll()), expected);
    }, skip: !present);

    test('Flutter restores the backup bundle native exported', () async {
      final zip = await File(
        '${_swiftOutDir.path}/swift-backup.zip',
      ).readAsBytes();
      final summary = DbHelper.previewBundle(zip);
      expect(summary.journalCount, greaterThan(0));

      final archive = ZipDecoder().decodeBytes(zip);
      final data = archive.files.firstWhere((f) => f.name == 'data.json');
      final materials = archive.files
          .where((f) => f.isFile && f.name.startsWith('materials/'))
          .map((f) => f.name)
          .toList();
      expect(materials, isNotEmpty);

      await DbHelper.configureDatabaseForTesting(
        factory: databaseFactoryFfi,
        path: '${temp.path}/restored.db',
      );
      final json = utf8.decode(data.content as List<int>);
      await DbHelper.instance.importAll(json);
      expect(
        jsonDecode(await DbHelper.instance.exportAll()),
        jsonDecode(json),
      );
    }, skip: !present);
  });
}

// MARK: - Fixture data

/// Tables introduced after each legacy version we ship a fixture for.
const _legacyVersions = <int, List<String>>{
  1: [
    'delay_sessions',
    'erp_exercise_plans',
    'erp_exercise_sessions',
    'exposure_hierarchies',
    'exposure_steps',
    'response_prevention_logs',
    'urge_surf_sessions',
    'program_enrollments',
    'program_task_progress',
    'behavioral_experiments',
    'exposure_reflections',
    'action_plans',
    'implementation_intentions',
    'uncertainty_log',
    'exposure_materials',
    'ybocs_assessments',
  ],
  4: [
    'response_prevention_logs',
    'urge_surf_sessions',
    'program_enrollments',
    'program_task_progress',
    'behavioral_experiments',
    'exposure_reflections',
    'action_plans',
    'implementation_intentions',
    'uncertainty_log',
    'exposure_materials',
    'ybocs_assessments',
  ],
  9: ['ybocs_assessments'],
};

List<String> _tablesAddedAfter(int version) => _legacyVersions[version]!;

String _ts(
  int y,
  int mo,
  int d,
  int h,
  int mi, [
  int s = 0,
  int ms = 0,
  int us = 0,
]) => DateTime(y, mo, d, h, mi, s, ms, us).toIso8601String();

Map<String, dynamic> _fixtureBackup() {
  final a = _ts(2026, 3, 1, 8, 15, 4, 120, 45); // microseconds present
  final b = _ts(2026, 7, 19, 22, 0); // milliseconds only (.000)
  final c = _ts(2025, 12, 31, 23, 59, 59, 999, 999); // end of year
  final utc = DateTime.utc(2026, 10, 25, 1, 30).toIso8601String(); // with Z

  final rich = jsonEncode([
    {'insert': 'Today I '},
    {
      'insert': 'paused',
      'attributes': {'bold': true},
    },
    {'insert': ' before checking. '},
    {
      'insert': 'Small win.',
      'attributes': {'italic': true, 'bold': true},
    },
    {'insert': '\nBreathed'},
    {
      'insert': '\n',
      'attributes': {'list': 'bullet'},
    },
    {'insert': 'Waited ten minutes'},
    {
      'insert': '\n',
      'attributes': {'list': 'bullet'},
    },
    // An attribute the native editor does not edit must survive untouched.
    {'insert': 'Heading kept'},
    {
      'insert': '\n',
      'attributes': {'header': 2},
    },
  ]);

  return <String, dynamic>{
    'schema_version': 10,
    'journal': [
      {
        'id': 1,
        'date': '2026-03-01',
        'content': rich,
        'created_at': a,
        'updated_at': b,
      },
      {
        'id': 2,
        'date': '2025-12-31',
        'content': 'Legacy plain text from before rich text.\nSecond line.',
        'created_at': c,
        'updated_at': c,
      },
      {
        'id': 7,
        'date': '2026-07-19',
        'content': jsonEncode([
          {'insert': '今日は不安でしたが、確認しませんでした 🌱 "quotes" \\ slash /\n'},
        ]),
        'created_at': b,
        'updated_at': utc,
      },
      {
        'id': 8,
        'date': '2026-07-20',
        'content': '',
        'created_at': b,
        'updated_at': b,
      },
    ],
    'ocd': [
      {
        'id': 1,
        'type': 0,
        'datetime': a,
        'content': 'What if I left the stove on?',
        'distress_level': 7,
        'response': 'Noticed it and let it be',
        'action_taken': null,
        'created_at': a,
      },
      {
        'id': 2,
        'type': 1,
        'datetime': b,
        'content': 'Urge to re-read the message',
        'distress_level': 10,
        'response': 'Delayed',
        'action_taken': 'Read it once',
        'created_at': b,
      },
      {
        'id': 3,
        'type': 0,
        'datetime': c,
        'content': 'Ça va? ✓',
        'distress_level': 0,
        'response': '',
        'created_at': c,
      },
    ],
    'delay_sessions': [
      {
        'id': 1,
        'compulsion': 'Checking the lock',
        'planned_seconds': 600,
        'actual_seconds': 412,
        'completed': 0,
        'urge_before': 8,
        'urge_after': 3,
        'outcome': 1,
        'note': null,
        'created_at': a,
      },
      {
        'id': 2,
        'compulsion': 'Washing',
        'planned_seconds': 300,
        'actual_seconds': 300,
        'completed': 1,
        'urge_before': 6,
        'urge_after': 2,
        'outcome': 0,
        'note': 'Felt proud',
        'created_at': b,
      },
    ],
    'erp_exercise_plans': [
      {
        'id': 1,
        'exercise_id': 'contamination_doorknob',
        'exercise_title': 'Touch a doorknob',
        'trigger_or_exposure': 'Public doorknob',
        'fear_prediction': 'I will get sick',
        'prevention_commitment': 'No washing for 30 minutes',
        'default_seconds': 1800,
        'archived': 0,
        'created_at': a,
        'updated_at': b,
      },
      {
        'id': 2,
        'exercise_id': 'custom',
        'exercise_title': 'Archived plan',
        'trigger_or_exposure': '',
        'fear_prediction': '',
        'prevention_commitment': '',
        'default_seconds': 60,
        'archived': 1,
        'created_at': c,
        'updated_at': c,
      },
    ],
    'erp_exercise_sessions': [
      {
        'id': 1,
        'plan_id': 1,
        'exercise_id': 'contamination_doorknob',
        'exercise_title': 'Touch a doorknob',
        'trigger_or_exposure': 'Public doorknob',
        'fear_prediction': 'I will get sick',
        'prevention_commitment': 'No washing for 30 minutes',
        'planned_seconds': 1800,
        'actual_seconds': 1800,
        'completed': 1,
        'anxiety_before': 9,
        'anxiety_after': 4,
        'outcome': 0,
        'what_happened': 'Anxiety peaked then dropped',
        'learning': 'It passes',
        'note': null,
        'created_at': b,
      },
      {
        'id': 2,
        'plan_id': null,
        'exercise_id': 'quick',
        'exercise_title': 'Quick exposure',
        'trigger_or_exposure': '',
        'fear_prediction': '',
        'prevention_commitment': '',
        'planned_seconds': 120,
        'actual_seconds': 30,
        'completed': 0,
        'anxiety_before': 10,
        'anxiety_after': 10,
        'outcome': 2,
        'what_happened': '',
        'learning': '',
        'note': 'Stopped early',
        'created_at': c,
      },
    ],
    'exposure_hierarchies': [
      {
        'id': 1,
        'title': 'Contamination ladder',
        'theme': 'contamination',
        'archived': 0,
        'created_at': a,
        'updated_at': a,
      },
    ],
    'exposure_steps': [
      {
        'id': 1,
        'hierarchy_id': 1,
        'order_index': 0,
        'description': 'Touch the bin lid',
        'difficulty': 3,
        'anxiety_rating': 4,
        'status': 2,
        'completed_at': b,
      },
      {
        'id': 2,
        'hierarchy_id': 1,
        'order_index': 1,
        'description': 'Eat without washing',
        'difficulty': 9,
        'anxiety_rating': 10,
        'status': 0,
        'completed_at': null,
      },
    ],
    'response_prevention_logs': [
      {
        'id': 1,
        'datetime': a,
        'situation': 'Left the house',
        'outcome': 3,
        'anxiety_level': 6,
        'note': null,
        'linked_step_id': 1,
        'created_at': a,
      },
    ],
    'urge_surf_sessions': [
      {
        'id': 1,
        'datetime': b,
        'trigger': 'Saw a news story',
        'initial_urge': 7,
        'peak_urge': 9,
        'final_urge': 2,
        'duration_seconds': 540,
        'note': 'The wave passed',
        'created_at': b,
      },
    ],
    'program_enrollments': [
      {'id': 1, 'program_id': 'erp_foundations', 'created_at': a},
    ],
    'program_task_progress': [
      {
        'id': 1,
        'enrollment_id': 1,
        'week_index': 0,
        'task_id': 'w1_learn',
        'completed_at': b,
      },
    ],
    'behavioral_experiments': [
      {
        'id': 1,
        'datetime': a,
        'fear_prediction': 'If I don\'t check, something bad happens',
        'confidence': 85,
        'experiment': 'Skip checking once',
        'outcome': 'Nothing happened',
        'learning': 'My prediction was wrong',
        'status': 1,
        'created_at': a,
      },
      {
        'id': 2,
        'datetime': c,
        'fear_prediction': 'Planned one',
        'confidence': 100,
        'experiment': 'Try tomorrow',
        'outcome': '',
        'learning': '',
        'status': 0,
        'created_at': c,
      },
    ],
    'exposure_reflections': [
      {
        'id': 1,
        'datetime': b,
        'what_happened': 'Touched the doorknob',
        'ocd_predicted': 'I would panic',
        'actually_happened': 'Mild discomfort',
        'what_i_learned': 'I can tolerate it',
        'do_differently': 'Stay longer',
        'created_at': b,
      },
    ],
    'action_plans': [
      {
        'id': 1,
        'situation': 'Morning routine',
        'planned_action': 'Leave after one check',
        'date': '2026-03-02',
        'notes': null,
        'completed': 0,
        'created_at': a,
      },
      {
        'id': 2,
        'situation': 'Work',
        'planned_action': 'Send email without rereading',
        'date': null,
        'notes': 'Hard but done',
        'completed': 1,
        'created_at': b,
      },
    ],
    'implementation_intentions': [
      {
        'id': 1,
        'trigger': 'If I feel the urge to check',
        'response': 'Then I will name it and wait',
        'created_at': a,
      },
    ],
    'uncertainty_log': [
      {
        'id': 1,
        'datetime': a,
        'exercise_id': 'maybe_maybe_not',
        'willingness': 6,
        'note': null,
        'created_at': a,
      },
    ],
    'exposure_materials': [
      {
        'id': 1,
        'type': 0,
        'title': 'Script',
        'text': 'Maybe it happened, maybe it did not.',
        'url': null,
        'file_name': null,
        'linked_hierarchy_id': 1,
        'linked_step_id': null,
        'created_at': a,
      },
      {
        'id': 2,
        'type': 1,
        'title': 'Loop tape',
        'text': null,
        'url': null,
        'file_name': 'm_1772352904120045.m4a',
        'linked_hierarchy_id': 1,
        'linked_step_id': 2,
        'created_at': b,
      },
      {
        'id': 3,
        'type': 2,
        'title': 'Image',
        'text': null,
        'url': null,
        'file_name': 'm_1772352904999999.jpg',
        'linked_hierarchy_id': null,
        'linked_step_id': null,
        'created_at': b,
      },
      {
        'id': 4,
        'type': 3,
        'title': 'Link',
        'text': null,
        'url': 'https://example.org/exposure',
        'file_name': null,
        'linked_hierarchy_id': null,
        'linked_step_id': null,
        'created_at': c,
      },
    ],
    'ybocs_assessments': [
      {
        'id': 1,
        'datetime': a,
        'obsession_score': 14,
        'compulsion_score': 12,
        'total_score': 26,
        'severity': 3,
        'item_scores': '3,3,3,3,2,3,2,3,2,2',
        'themes': 'contamination,checking',
        'symptoms': 'cont_germs,check_locks',
        'created_at': a,
      },
      {
        'id': 2,
        'datetime': b,
        'obsession_score': 4,
        'compulsion_score': 2,
        'total_score': 6,
        'severity': 0,
        'item_scores': '1,1,1,1,0,1,1,0,0,0',
        'themes': '',
        'symptoms': null,
        'created_at': b,
      },
    ],
  };
}

List<int> _bundle(String dataJson) {
  final archive = Archive();
  final data = utf8.encode(dataJson);
  archive.addFile(ArchiveFile('data.json', data.length, data));
  final tape = List<int>.generate(4096, (i) => (i * 31) % 256);
  final image = List<int>.generate(2048, (i) => (i * 7 + 3) % 256);
  archive.addFile(
    ArchiveFile('materials/m_1772352904120045.m4a', tape.length, tape),
  );
  archive.addFile(
    ArchiveFile('materials/m_1772352904999999.jpg', image.length, image),
  );
  return ZipEncoder().encode(archive)!;
}

// MARK: - Validation parity

/// For each table's first row and each column, mutate the value and record
/// whether Flutter's `previewBackup` accepts it (and the error message).
///
/// Stored compactly: one base backup plus, per case, either a root-level
/// replacement (`root`) or a single-cell change (`table`/`column` with
/// `remove` or `value`). The Swift test rebuilds each backup the same way.
Map<String, dynamic> _validationCases() {
  final base = _fixtureBackup();
  final cases = <Map<String, dynamic>>[];

  String run(Object? backup) {
    try {
      DbHelper.previewBackup(jsonEncode(backup));
      return 'ok';
    } on FormatException catch (e) {
      return 'format:${e.message}';
    } catch (e) {
      return 'error:${e.runtimeType}';
    }
  }

  void recordRoot(String name, Object? backup) {
    cases.add({'name': name, 'root': backup, 'result': run(backup)});
  }

  void recordTop(String name, String key, {Object? value, bool remove = false}) {
    final backup = Map<String, dynamic>.of(base);
    remove ? backup.remove(key) : backup[key] = value;
    cases.add({
      'name': name,
      'top': key,
      'remove': remove,
      'value': value,
      'result': run(backup),
    });
  }

  recordTop('valid', 'schema_version', value: 10);
  recordTop('schema missing', 'schema_version', remove: true);
  recordTop('schema older', 'schema_version', value: 3);
  recordTop('schema newer', 'schema_version', value: 11);
  recordTop('schema string', 'schema_version', value: '10');
  recordTop('schema double', 'schema_version', value: 10.0);
  recordTop('table not list', 'ocd', value: {'a': 1});
  recordTop('table null', 'ocd', value: null);
  recordTop('row not object', 'journal', value: ['nope']);
  recordRoot('root list', [1]);
  recordRoot('root string', 'x');

  final mutations = <String, Object? Function(Object?)>{
    'missing': (_) => _missing,
    'null': (_) => null,
    'string': (_) => 'x',
    'double': (_) => 1.5,
    'int_neg': (_) => -1,
    'int_big': (_) => 999,
    'bool': (_) => true,
    'bad_date': (_) => '2026-13-45Tbad',
    'space_date': (_) => '2026-03-01 08:15:04',
    'offset_date': (_) => '2026-03-01T08:15:04+05:30',
  };

  for (final table in base.keys.where((k) => k != 'schema_version')) {
    final rows = base[table] as List;
    if (rows.isEmpty) continue;
    final row = rows.first as Map<String, dynamic>;
    for (final column in row.keys) {
      for (final entry in mutations.entries) {
        final mutatedRow = Map<String, dynamic>.of(row);
        final value = entry.value(row[column]);
        if (identical(value, _missing)) {
          mutatedRow.remove(column);
        } else {
          mutatedRow[column] = value;
        }
        final backup = Map<String, dynamic>.of(base)
          ..[table] = [mutatedRow, ...rows.skip(1)];
        cases.add({
          'name': '$table.$column ${entry.key}',
          'table': table,
          'column': column,
          'remove': identical(value, _missing),
          'value': identical(value, _missing) ? null : value,
          'result': run(backup),
        });
      }
    }
  }
  return {'base': base, 'cases': cases};
}

const _missing = Object();

// MARK: - Timestamp parity

List<Map<String, dynamic>> _dateCases() {
  final inputs = <String>[
    '2026-03-01T08:15:04.120045',
    '2026-03-01T08:15:04.120',
    '2026-03-01T08:15:04.000',
    '2026-03-01T08:15:04',
    '2026-03-01 08:15:04',
    '2026-03-01T08:15',
    '2026-03-01T08',
    '2026-03-01',
    '20260301T081504',
    '2026-03-01T08:15:04.1',
    '2026-03-01T08:15:04.1234567',
    '2026-03-01T08:15:04.9999996',
    '2026-03-01T08:15:04Z',
    '2026-03-01T08:15:04.5z',
    '2026-03-01T08:15:04+05:30',
    '2026-03-01T08:15:04-0800',
    '2026-03-01T08:15:04 +01',
    '+002026-03-01T08:15:04',
    '2026-02-30T08:15:04',
    'nope',
    '2026-3-1',
    '',
  ];
  final out = <Map<String, dynamic>>[];
  for (final input in inputs) {
    final parsed = DateTime.tryParse(input);
    out.add({
      'input': input,
      'valid': parsed != null,
      if (parsed != null) ...{
        'utc': parsed.isUtc,
        // UTC instants compare by epoch; local ones by wall-clock fields,
        // which are independent of the machine's time zone.
        if (parsed.isUtc) 'epochMicros': parsed.microsecondsSinceEpoch,
        if (!parsed.isUtc)
          'local': [
            parsed.year,
            parsed.month,
            parsed.day,
            parsed.hour,
            parsed.minute,
            parsed.second,
            parsed.millisecond,
            parsed.microsecond,
          ],
      },
    });
  }

  final formatted = <Map<String, dynamic>>[];
  for (final f in [
    [2026, 3, 1, 8, 15, 4, 120, 45],
    [2026, 3, 1, 8, 15, 4, 0, 0],
    [2026, 3, 1, 8, 15, 4, 0, 7],
    [2026, 12, 31, 23, 59, 59, 999, 999],
    [1999, 1, 1, 0, 0, 0, 1, 0],
    [2026, 1, 9, 5, 4, 3, 21, 900],
  ]) {
    formatted.add({
      'local': f,
      'string': DateTime(
        f[0],
        f[1],
        f[2],
        f[3],
        f[4],
        f[5],
        f[6],
        f[7],
      ).toIso8601String(),
    });
  }
  formatted.add({
    'utcEpochMicros': DateTime.utc(
      2026,
      10,
      25,
      1,
      30,
      0,
      5,
      0,
    ).microsecondsSinceEpoch,
    'string': DateTime.utc(2026, 10, 25, 1, 30, 0, 5, 0).toIso8601String(),
  });
  return [
    {'parse': out, 'format': formatted},
  ];
}

// MARK: - Journal rich-text parity

List<Map<String, dynamic>> _journalCases() {
  final contents = <String>[
    ...(_fixtureBackup()['journal'] as List).map(
      (r) => (r as Map)['content'] as String,
    ),
    '[]',
    '{"insert":"not a list"}',
    '[{"delete":3}]',
    // A Delta without a closing newline is left out: Quill rejects it only
    // through an `assert`, which is off in release builds, so `flutter test`
    // and shipped Flutter disagree. Flutter never writes one.
    '[{"insert":{"image":"x.png"}},{"insert":"\\n"}]',
    '[{"insert":"\\n\\n  spaced  \\n\\n"}]',
    '[{"insert":"a"},{"insert":"\\n","attributes":{"list":"bullet"}},'
        '{"insert":"\\n","attributes":{"list":"bullet"}},{"insert":"b\\n"}]',
    '[{"insert":"x","attributes":null},{"insert":"\\n"}]',
    '[{"insert":"a","attributes":{"bold":true}},'
        '{"insert":"b","attributes":{"bold":true}},{"insert":"\\n"}]',
    '[{"insert":"one"},{"insert":"\\n","attributes":{"list":"bullet"}},'
        '{"insert":"two"},{"insert":"\\n","attributes":{"list":"bullet"}},'
        '{"insert":"three"},{"insert":"\\n","attributes":{"list":"bullet"}},'
        '{"insert":"after\\n"}]',
    '[{"insert":"x","attributes":{}},{"insert":"y\\n"}]',
    '[{"insert":"mixed","attributes":{"italic":true}},'
        '{"insert":"\\n\\n","attributes":{"list":"bullet"}},{"insert":"end\\n"}]',
    '[{"insert":"line\\nbreak inside","attributes":{"bold":true}},'
        '{"insert":"\\n"}]',
    '   ',
    '42',
    'not json [',
  ];
  return [
    for (final content in contents)
      {
        'content': content,
        'plainText': plainTextFromStored(content),
        // What the editor saves when the entry is opened and saved unedited.
        'resaved': storedFromDocument(documentFromStored(content)),
        'runs': [
          for (final run in richRunsFromStored(content))
            {'text': run.text, 'bold': run.bold, 'italic': run.italic},
        ],
      },
  ];
}

// MARK: - IO

Future<void> _copy(String from, String name) async {
  await File(from).copy('${_fixturesDir.path}/$name');
}

Future<void> _write(String name, String contents) async {
  await File('${_fixturesDir.path}/$name').writeAsString(contents);
}

Future<void> _writeBytes(String name, List<int> bytes) async {
  await File('${_fixturesDir.path}/$name').writeAsBytes(bytes);
}
