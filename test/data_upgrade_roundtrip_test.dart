import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/database/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temporaryDirectory;

  setUpAll(sqfliteFfiInit);

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'patterns-data-upgrade-',
    );
  });

  tearDown(() async {
    await DbHelper.resetDatabaseAfterTesting();
    await temporaryDirectory.delete(recursive: true);
  });

  test('1.9 schema v10 data survives 1.10 open and JSON round trip', () async {
    final sourcePath = '${temporaryDirectory.path}/patterns-1.9.db';
    await DbHelper.configureDatabaseForTesting(
      factory: databaseFactoryFfi,
      path: sourcePath,
    );

    final fixture = _patterns190Backup();
    await DbHelper.instance.importAll(jsonEncode(fixture));

    final sourceDatabase = await DbHelper.instance.database;
    expect(await sourceDatabase.getVersion(), 10);
    final tables = await sourceDatabase.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' "
      "AND name NOT LIKE 'sqlite_%' ORDER BY name",
    );
    expect(tables.map((row) => row['name']), containsAll(_dataTables));

    // Reopening the exact file exercises the same on-disk upgrade path used
    // when 1.10 starts over an installed 1.9 database.
    await DbHelper.configureDatabaseForTesting(
      factory: databaseFactoryFfi,
      path: sourcePath,
    );
    final reopenedExport = jsonDecode(await DbHelper.instance.exportAll());
    expect(reopenedExport, fixture);

    final summary = DbHelper.previewBackup(jsonEncode(reopenedExport));
    expect(summary.journalCount, 1);
    expect(summary.ocdCount, 1);
    expect(summary.ybocsAssessmentCount, 1);

    final destinationPath = '${temporaryDirectory.path}/patterns-1.10.db';
    await DbHelper.configureDatabaseForTesting(
      factory: databaseFactoryFfi,
      path: destinationPath,
    );
    final exportedJson = jsonEncode(reopenedExport);
    await DbHelper.instance.importAll(exportedJson);

    // A restore replaces all data. Importing the same backup twice detects
    // stale rows or duplicate primary keys in any table.
    await DbHelper.instance.importAll(exportedJson);
    final roundTripped = jsonDecode(await DbHelper.instance.exportAll());
    expect(roundTripped, fixture);
  });

  test(
    'a 1.9 backup without later table keys replaces existing data',
    () async {
      await DbHelper.configureDatabaseForTesting(
        factory: databaseFactoryFfi,
        path: '${temporaryDirectory.path}/older-backup.db',
      );
      await DbHelper.instance.importAll(jsonEncode(_patterns190Backup()));

      final olderBackup = <String, dynamic>{
        'schema_version': 9,
        'journal': <dynamic>[],
        'ocd': <dynamic>[],
      };
      await DbHelper.instance.importAll(jsonEncode(olderBackup));

      final restored =
          jsonDecode(await DbHelper.instance.exportAll())
              as Map<String, dynamic>;
      for (final table in _dataTables) {
        expect(restored[table], isEmpty, reason: '$table was not replaced');
      }
    },
  );
}

const _dataTables = <String>[
  'journal',
  'ocd',
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
];

Map<String, dynamic> _patterns190Backup() {
  const created = '2026-09-14T09:30:00.000';
  const later = '2026-09-14T10:45:00.000';
  const richJournal =
      '[{"insert":"I noticed "},{"insert":"uncertainty",'
      '"attributes":{"bold":true}},{"insert":" today.\\n"}]';

  return <String, dynamic>{
    'schema_version': 10,
    'journal': [
      {
        'id': 101,
        'date': '2026-09-14',
        'content': richJournal,
        'created_at': created,
        'updated_at': later,
      },
    ],
    'ocd': [
      {
        'id': 102,
        'type': 0,
        'datetime': created,
        'content': 'Did I lock the door?',
        'distress_level': 7,
        'response': 'Allowed the uncertainty to remain.',
        'action_taken': 'Walked away without checking again.',
        'created_at': created,
      },
    ],
    'delay_sessions': [
      {
        'id': 201,
        'compulsion': 'Recheck the lock',
        'planned_seconds': 300,
        'actual_seconds': 300,
        'completed': 1,
        'urge_before': 8,
        'urge_after': 4,
        'outcome': 1,
        'note': 'The urge shifted on its own.',
        'created_at': created,
      },
    ],
    'erp_exercise_plans': [
      {
        'id': 202,
        'exercise_id': 'delay_checking',
        'exercise_title': 'Delay checking',
        'trigger_or_exposure': 'Leave after checking once',
        'fear_prediction': 'Something may go wrong',
        'prevention_commitment': 'No second check',
        'default_seconds': 300,
        'archived': 0,
        'created_at': created,
        'updated_at': later,
      },
    ],
    'erp_exercise_sessions': [
      {
        'id': 203,
        'plan_id': 202,
        'exercise_id': 'delay_checking',
        'exercise_title': 'Delay checking',
        'trigger_or_exposure': 'Leave after checking once',
        'fear_prediction': 'Something may go wrong',
        'prevention_commitment': 'No second check',
        'planned_seconds': 300,
        'actual_seconds': 280,
        'completed': 1,
        'anxiety_before': 7,
        'anxiety_after': 4,
        'outcome': 0,
        'what_happened': 'I continued with my day.',
        'learning': 'I can make room for uncertainty.',
        'note': 'Optional reflection retained.',
        'created_at': created,
      },
    ],
    'exposure_hierarchies': [
      {
        'id': 301,
        'title': 'Checking practice',
        'theme': 'checking',
        'archived': 0,
        'created_at': created,
        'updated_at': later,
      },
    ],
    'exposure_steps': [
      {
        'id': 302,
        'hierarchy_id': 301,
        'order_index': 0,
        'description': 'Leave after one check',
        'difficulty': 6,
        'anxiety_rating': 7,
        'status': 2,
        'completed_at': later,
      },
    ],
    'response_prevention_logs': [
      {
        'id': 303,
        'datetime': created,
        'situation': 'Wanted to recheck',
        'outcome': 1,
        'anxiety_level': 6,
        'note': 'Waited before deciding.',
        'linked_step_id': 302,
        'created_at': created,
      },
    ],
    'urge_surf_sessions': [
      {
        'id': 304,
        'datetime': created,
        'trigger': 'Urge to seek reassurance',
        'initial_urge': 8,
        'peak_urge': 9,
        'final_urge': 3,
        'duration_seconds': 240,
        'note': 'Observed without acting.',
        'created_at': created,
      },
    ],
    'program_enrollments': [
      {'id': 401, 'program_id': 'delay-4wk', 'created_at': created},
    ],
    'program_task_progress': [
      {
        'id': 402,
        'enrollment_id': 401,
        'week_index': 0,
        'task_id': 'w1a',
        'completed_at': later,
      },
    ],
    'behavioral_experiments': [
      {
        'id': 501,
        'datetime': created,
        'fear_prediction': 'I will not cope with uncertainty.',
        'confidence': 75,
        'experiment': 'Continue without reassurance.',
        'outcome': 'The feeling changed over time.',
        'learning': 'Certainty was not required.',
        'status': 1,
        'created_at': created,
      },
    ],
    'exposure_reflections': [
      {
        'id': 502,
        'datetime': created,
        'what_happened': 'I left after one check.',
        'ocd_predicted': 'I would need to return.',
        'actually_happened': 'I continued with my plans.',
        'what_i_learned': 'The urge can be present without action.',
        'do_differently': 'Repeat the same practice.',
        'created_at': created,
      },
    ],
    'action_plans': [
      {
        'id': 503,
        'situation': 'An urge to google a symptom',
        'planned_action': 'Return to the task in front of me',
        'date': '2026-09-15',
        'notes': 'Stored ISO date remains unchanged.',
        'completed': 0,
        'created_at': created,
      },
    ],
    'implementation_intentions': [
      {
        'id': 504,
        'trigger': 'If I notice a checking urge',
        'response': 'Then I pause and continue once',
        'created_at': created,
      },
    ],
    'uncertainty_log': [
      {
        'id': 505,
        'datetime': created,
        'exercise_id': 'maybe',
        'willingness': 7,
        'note': '「たぶん」をそのままにした。',
        'created_at': created,
      },
    ],
    'exposure_materials': [
      {
        'id': 506,
        'type': 1,
        'title': 'My loop tape',
        'text': null,
        'url': null,
        'file_name': 'm_123.m4a',
        'linked_hierarchy_id': 301,
        'linked_step_id': 302,
        'created_at': created,
      },
    ],
    'ybocs_assessments': [
      {
        'id': 601,
        'datetime': created,
        'obsession_score': 12,
        'compulsion_score': 9,
        'total_score': 21,
        'severity': 2,
        'item_scores': '3,2,3,2,2,2,2,1,2,2',
        'themes': 'checking,contamination',
        'symptoms': 'check_locks,wash_hands',
        'created_at': later,
      },
    ],
  };
}
