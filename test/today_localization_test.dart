import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/desktop/home_screen.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/journal_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Journals extends JournalNotifier {
  _Journals(this.value);
  final List<JournalEntry> value;
  @override
  Future<List<JournalEntry>> build() async => value;
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

Widget _host({
  required Widget home,
  required Locale locale,
  List<JournalEntry> journals = const [],
  Size size = const Size(390, 844),
}) {
  return ProviderScope(
    overrides: [
      journalProvider.overrideWith(() => _Journals(journals)),
      ocdProvider.overrideWith(_Ocds.new),
      delaySessionProvider.overrideWith(_Delays.new),
      erpExerciseSessionProvider.overrideWith(_ErpSessions.new),
      exposureStepProvider.overrideWith(_Steps.new),
      responsePreventionProvider.overrideWith(_Responses.new),
      urgeSurfProvider.overrideWith(_Surfs.new),
      ybocsAssessmentProvider.overrideWith(_Ybocs.new),
    ],
    child: MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.mobileDarkTheme,
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: home,
      ),
    ),
  );
}

TodayScreen _mobileToday() => TodayScreen(
  onJournal: () {},
  onTrack: () {},
  onDelay: () {},
  onErp: () {},
  onInsights: () {},
  onSettings: () {},
  onNextStep: (_) {},
);

DesktopHomeScreen _desktopToday() => DesktopHomeScreen(
  onOpenJournal: () {},
  onOpenTrack: () {},
  onOpenRecovery: () {},
  onOpenInsights: () {},
  onOpenSettings: () {},
);

void main() {
  testWidgets('mobile first-run Today follows the Japanese locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(home: _mobileToday(), locale: const Locale('ja')),
    );
    await tester.pumpAndSettle();

    expect(find.text('何をしますか？'), findsOneWidget);
    expect(find.text('書き留める'), findsOneWidget);
    expect(find.text('反応する前に少し間を置きます。'), findsOneWidget);
    expect(find.text('Try a two-minute delay'), findsNothing);
  });

  testWidgets('mobile established Today follows the German locale', (
    tester,
  ) async {
    final now = DateTime.now();
    final entry = JournalEntry(
      date:
          '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      content: 'Test',
      createdAt: now,
      updatedAt: now,
    );
    await tester.pumpWidget(
      _host(
        home: _mobileToday(),
        locale: const Locale('de'),
        journals: [entry],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ihre Aktivitäten nehmen Gestalt an'), findsOneWidget);
    expect(find.text('IHR NÄCHSTER SCHRITT'), findsOneWidget);
    expect(find.text('Continue your practice'), findsNothing);
  });

  testWidgets('desktop Today follows the neutral Spanish locale', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: _desktopToday(),
        locale: const Locale('es'),
        size: const Size(1200, 900),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Acciones rápidas'), findsOneWidget);
    expect(find.text('Herramientas de recuperación'), findsOneWidget);
    expect(find.text('Recovery tools'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
