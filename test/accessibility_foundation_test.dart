import 'package:flutter/material.dart';
import 'dart:ui' show Tristate;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/widgets/animations.dart';
import 'package:patterns/widgets/rich_journal.dart';

void main() {
  Widget localizedApp(Widget child, {Locale locale = const Locale('en')}) {
    return MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(body: child),
    );
  }

  testWidgets('journal formatting controls expose labels, roles, and states', (
    tester,
  ) async {
    final controller = QuillController.basic();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      localizedApp(JournalFormatToolbar(controller: controller)),
    );

    final bold = find.bySemanticsLabel('Bold');
    expect(bold, findsOneWidget);
    expect(tester.getSize(bold).width, greaterThanOrEqualTo(44));
    expect(tester.getSize(bold).height, greaterThanOrEqualTo(44));

    var semantics = tester.getSemantics(bold);
    expect(semantics.flagsCollection.isButton, isTrue);
    expect(semantics.flagsCollection.isToggled, Tristate.isFalse);

    await tester.tap(bold);
    await tester.pump();
    semantics = tester.getSemantics(bold);
    expect(semantics.flagsCollection.isToggled, Tristate.isTrue);
  });

  testWidgets('animated numbers use locale formatting with motion disabled', (
    tester,
  ) async {
    await tester.pumpWidget(
      localizedApp(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: AnimatedCounter(value: 1234.5, fractionDigits: 1),
        ),
        locale: const Locale('de'),
      ),
    );

    expect(find.text('1.234,5'), findsOneWidget);
    expect(find.bySemanticsLabel('1.234,5'), findsOneWidget);
  });
}
