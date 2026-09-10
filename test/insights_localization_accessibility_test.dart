import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/analytics_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Journals extends JournalNotifier {
  _Journals(this.entries);
  final List<JournalEntry> entries;
  @override
  Future<List<JournalEntry>> build() async => entries;
}

class _JournalError extends JournalNotifier {
  @override
  Future<List<JournalEntry>> build() async =>
      throw StateError('private database path');
}

class _Ocds extends OcdNotifier {
  @override
  Future<List<OcdEntry>> build() async => const [];
}

class _Delays extends DelaySessionNotifier {
  @override
  Future<List<DelaySession>> build() async => const [];
}

class _ErpSessions extends ErpExerciseSessionNotifier {
  @override
  Future<List<ErpExerciseSession>> build() async => const [];
}

class _Steps extends ExposureStepNotifier {
  @override
  Future<List<ExposureStep>> build() async => const [];
}

class _Responses extends ResponsePreventionNotifier {
  @override
  Future<List<ResponsePreventionLog>> build() async => const [];
}

class _Surfs extends UrgeSurfNotifier {
  @override
  Future<List<UrgeSurfSession>> build() async => const [];
}

class _Ybocs extends YbocsAssessmentNotifier {
  @override
  Future<List<YbocsAssessment>> build() async => const [];
}

class _Calm extends CalmInsightsNotifier {
  _Calm(this.enabled);
  final bool enabled;
  @override
  bool build() => enabled;
}

Widget _host({
  required JournalNotifier Function() journals,
  required bool calm,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [
      journalProvider.overrideWith(journals),
      ocdProvider.overrideWith(_Ocds.new),
      delaySessionProvider.overrideWith(_Delays.new),
      erpExerciseSessionProvider.overrideWith(_ErpSessions.new),
      exposureStepProvider.overrideWith(_Steps.new),
      responsePreventionProvider.overrideWith(_Responses.new),
      urgeSurfProvider.overrideWith(_Surfs.new),
      ybocsAssessmentProvider.overrideWith(_Ybocs.new),
      calmInsightsProvider.overrideWith(() => _Calm(calm)),
    ],
    child: MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mobileDarkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: textScaler,
          disableAnimations: disableAnimations,
        ),
        child: child!,
      ),
      home: const AnalyticsScreen(),
    ),
  );
}

List<JournalEntry> _recentJournals() {
  final now = DateTime.now();
  return [
    for (var index = 0; index < 3; index++)
      JournalEntry(
        id: index + 1,
        date: now
            .subtract(Duration(days: index))
            .toIso8601String()
            .split('T')
            .first,
        content: 'Local journal text $index',
        createdAt: now.subtract(Duration(days: index)),
        updatedAt: now.subtract(Duration(days: index)),
      ),
  ];
}

void main() {
  testWidgets(
    'Calm Insights is factual and hides pressure metrics in Japanese',
    (tester) async {
      await tester.pumpWidget(
        _host(
          journals: () => _Journals(_recentJournals()),
          calm: true,
          locale: const Locale('ja'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('インサイト'), findsOneWidget);
      expect(find.text('最近の記録'), findsOneWidget);
      expect(find.textContaining('日記 3件'), findsOneWidget);
      expect(find.text('練習の経過'), findsNothing);
      expect(find.text('継続性'), findsNothing);
      expect(find.textContaining('増加'), findsNothing);
      expect(find.textContaining('減少'), findsNothing);
    },
  );

  testWidgets('Insights charts expose localized text alternatives', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        journals: () => _Journals(_recentJournals()),
        calm: true,
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel(RegExp('気分の推移。記録点：')), findsOneWidget);
  });

  testWidgets('Insights reflows controls at 200 percent text', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        journals: () => _Journals(const []),
        calm: false,
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Übersicht'), findsOneWidget);
    expect(find.bySemanticsLabel('Zwangsgedanken'), findsOneWidget);
    expect(find.byTooltip('Zeitraum ändern'), findsOneWidget);
    expect(
      tester.getSize(find.byTooltip('Zeitraum ändern')).height,
      greaterThanOrEqualTo(44),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Insights load errors never expose raw exception text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        journals: _JournalError.new,
        calm: true,
        locale: const Locale('fr'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Impossible de charger votre aperçu. Veuillez réessayer.'),
      findsOneWidget,
    );
    expect(find.textContaining('private database path'), findsNothing);
  });
}
