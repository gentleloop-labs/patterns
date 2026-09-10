import 'dart:ui' show SemanticsFlag;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/content/ocd_tracks.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/structured_programs_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Calm extends CalmInsightsNotifier {
  _Calm(this.enabled);
  final bool enabled;

  @override
  bool build() => enabled;
}

class _Progress extends ProgramTaskProgressNotifier {
  _Progress(this.initial);
  final List<ProgramTaskProgress> initial;

  @override
  Future<List<ProgramTaskProgress>> build() async => initial;

  @override
  Future<bool> toggleTask({
    required int enrollmentId,
    required int weekIndex,
    required String taskId,
    required bool completed,
  }) async {
    final current = [...state.asData?.value ?? const <ProgramTaskProgress>[]];
    current.removeWhere(
      (item) =>
          item.enrollmentId == enrollmentId &&
          item.weekIndex == weekIndex &&
          item.taskId == taskId,
    );
    if (completed) {
      current.add(
        ProgramTaskProgress(
          enrollmentId: enrollmentId,
          weekIndex: weekIndex,
          taskId: taskId,
          completedAt: DateTime(2026, 9, 10),
        ),
      );
    }
    state = AsyncData(current);
    return true;
  }
}

Widget _host({
  required bool calm,
  required Locale locale,
  TextScaler textScaler = TextScaler.noScaling,
  List<ProgramTaskProgress> progress = const [],
}) {
  return ProviderScope(
    overrides: [
      calmInsightsProvider.overrideWith(() => _Calm(calm)),
      programTaskProgressProvider.overrideWith(() => _Progress(progress)),
    ],
    child: MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mobileDarkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: child!,
      ),
      home: ProgramDetailScreen(
        program: programForTrack(
          ocdTracks.firstWhere((track) => track.id == 'checking'),
        ),
        enrollmentId: 7,
      ),
    ),
  );
}

void main() {
  testWidgets(
    'Calm Insights hides progress pressure but keeps localized task choices',
    (tester) async {
      await tester.pumpWidget(_host(calm: true, locale: const Locale('ja')));
      await tester.pumpAndSettle();

      expect(find.text('確認と疑い'), findsOneWidget);
      expect(find.text('タスクの選択は端末内に記録されます。'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.textContaining('%'), findsNothing);
      expect(find.bySemanticsLabel('第1週・一度だけ見る'), findsOneWidget);

      final firstTask = find.bySemanticsLabel('一つのものを一度だけ確認し、二度目を見ずに離れる');
      expect(firstTask, findsOneWidget);
      await tester.tap(firstTask);
      await tester.pumpAndSettle();

      expect(
        tester
            .getSemantics(firstTask)
            .getSemanticsData()
            .hasFlag(SemanticsFlag.isChecked),
        isTrue,
      );
    },
  );

  testWidgets('program details reflow at 200 percent German text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        calm: false,
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kontrollieren und Zweifel'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
