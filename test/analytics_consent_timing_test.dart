import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/main_shell.dart';
import 'package:patterns/theme/app_theme.dart';
import 'package:patterns/widgets/activity_completion.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      hasStartedKey: true,
      tabTourSeenKey: true,
      analyticsConsentDecisionKey: AnalyticsConsentDecision.undecided.name,
      meaningfulActionCountKey: 0,
    });
    await initMobilePreferences();
  });

  testWidgets('first meaningful action cannot interrupt its quiet completion', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();

    final homeContext = tester.element(find.byType(MobileHome));
    showQuietCompletion(
      homeContext,
      const ActivityCompletionResult(ActivityCompletionKind.journal),
    );
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(homeContext);
    await container
        .read(meaningfulActionCountProvider.notifier)
        .record(MeaningfulAction.journal);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Done for now'), findsOneWidget);
    expect(find.text('Help improve Patterns?'), findsNothing);
    expect(analyticsConsentDecision, AnalyticsConsentDecision.undecided);
  });

  testWidgets('eligible consent prompt waits for a later Home mount', (
    tester,
  ) async {
    await mobilePreferences!.setInt(meaningfulActionCountKey, 1);
    await mobilePreferences!.setString(
      lastMeaningfulActionKey,
      MeaningfulAction.journal.name,
    );

    await tester.pumpWidget(_testApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Help improve Patterns?'), findsOneWidget);
    expect(find.textContaining('Journal entries, OCD content'), findsOneWidget);
  });
}

Widget _testApp() {
  return ProviderScope(
    child: MaterialApp(
      locale: const Locale('en'),
      theme: AppTheme.mobileDarkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MobileHome(),
    ),
  );
}
