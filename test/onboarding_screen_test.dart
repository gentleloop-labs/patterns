import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/mobile/first_run.dart';
import 'package:patterns/mobile/screens/onboarding_screen.dart';
import 'package:patterns/theme/app_theme.dart';

void main() {
  testWidgets('S1 shows the promise and privacy, not a teaching carousel', (
    tester,
  ) async {
    await _pumpOnboarding(tester);

    expect(find.textContaining('calm, private place'), findsOneWidget);
    expect(find.textContaining('stays on this device'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    // No paywall / Pro comparison up front.
    expect(find.text('Unlock Pro'), findsNothing);
    expect(find.text('Start free'), findsNothing);
  });

  testWidgets('Get started reveals the five "what would help" choices', (
    tester,
  ) async {
    await _pumpOnboarding(tester);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('What would help right now?'), findsOneWidget);
    expect(find.text("I'm dealing with an urge"), findsOneWidget);
    expect(find.text('I want to write something down'), findsOneWidget);
    expect(find.text("I'm just exploring"), findsOneWidget);
  });

  testWidgets('choosing a path reports it via onChoosePath', (tester) async {
    FirstRunPath? chosen;
    await _pumpOnboarding(tester, onChoose: (p) => chosen = p);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.tap(find.text("I'm dealing with an urge"));
    await tester.pump();

    expect(chosen, FirstRunPath.urge);
  });

  testWidgets('import existing data stays available on S1', (tester) async {
    var imported = false;
    await _pumpOnboarding(tester, onImport: () => imported = true);

    await tester.tap(find.text('Import existing data'));
    await tester.pump();

    expect(imported, isTrue);
  });

  testWidgets('onboarding text uses fixed light-on-dark colors', (
    tester,
  ) async {
    await _pumpOnboarding(tester);

    final title = tester.widget<Text>(
      find.textContaining('calm, private place'),
    );
    expect(title.style?.color, AppTheme.textPrimary);
  });
}

Widget _host(Widget child) {
  return MaterialApp(theme: AppTheme.mobileDarkTheme, home: child);
}

Future<void> _pumpOnboarding(
  WidgetTester tester, {
  void Function(FirstRunPath)? onChoose,
  VoidCallback? onImport,
}) async {
  await tester.pumpWidget(
    _host(
      WelcomeScreen(
        onChoosePath: onChoose ?? (_) {},
        onImport: onImport ?? () {},
      ),
    ),
  );
  await tester.pumpAndSettle();
}
