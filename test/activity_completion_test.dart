import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/widgets/activity_completion.dart';

void main() {
  Widget testApp(ActivityCompletionResult result, {Locale? locale}) {
    return MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: Builder(
          builder: (context) => FilledButton(
            onPressed: () => showQuietCompletion(context, result),
            child: const Text('finish'),
          ),
        ),
      ),
    );
  }

  testWidgets('journal completion is factual and closes only from its action', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(const ActivityCompletionResult(ActivityCompletionKind.journal)),
    );

    await tester.tap(find.text('finish'));
    await tester.pumpAndSettle();

    expect(find.text('Saved'), findsOneWidget);
    expect(
      find.text('Your journal entry is saved on this device.'),
      findsOneWidget,
    );
    expect(find.text('Done for now'), findsOneWidget);

    await tester.tapAt(const Offset(4, 4));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsOneWidget);

    await tester.tap(find.text('Done for now'));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);
  });

  testWidgets('completion copy follows the active locale', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ActivityCompletionResult(ActivityCompletionKind.erp),
        locale: const Locale('ja'),
      ),
    );

    await tester.tap(find.text('finish'));
    await tester.pumpAndSettle();

    expect(find.text('練習を記録しました'), findsOneWidget);
    expect(find.text('今はここまで'), findsOneWidget);
  });
}
