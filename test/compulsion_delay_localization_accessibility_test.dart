import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/compulsion_delay_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Ocds extends OcdNotifier {
  @override
  Future<List<OcdEntry>> build() async => const [];
}

class _SavedSession {
  DelaySession? value;
}

class _Delays extends DelaySessionNotifier {
  _Delays(this.output, this.succeeds);

  final _SavedSession output;
  final bool succeeds;

  @override
  Future<List<DelaySession>> build() async => const [];

  @override
  Future<bool> addSession(DelaySession session) async {
    if (succeeds) output.value = session;
    return succeeds;
  }
}

Widget _host({
  required Locale locale,
  required _SavedSession output,
  bool saveSucceeds = true,
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [
      ocdProvider.overrideWith(_Ocds.new),
      delaySessionProvider.overrideWith(() => _Delays(output, saveSucceeds)),
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
      home: const CompulsionDelayFlow(initialCompulsion: 'checking'),
    ),
  );
}

Future<void> _reachReflection(
  WidgetTester tester, {
  required String begin,
  required String stop,
}) async {
  await tester.scrollUntilVisible(
    find.text(begin),
    180,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pump();
  await tester.tap(find.text(begin));
  await tester.pump();
  await tester.tap(find.widgetWithText(OutlinedButton, stop).hitTestable());
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.widgetWithText(ElevatedButton, stop).hitTestable());
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void _usePhoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('delay saves before Japanese quiet completion', (tester) async {
    _usePhoneViewport(tester);
    final saved = _SavedSession();
    await tester.pumpWidget(_host(locale: const Locale('ja'), output: saved));
    await tester.pump();

    expect(find.text('衝動をいったん止める'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('今の衝動の強さは？'),
      180,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();
    final urgeSemanticsFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Semantics &&
          widget.properties.label == '今の衝動の強さは？',
    );
    expect(urgeSemanticsFinder, findsOneWidget);
    final urgeSemantics = tester.widget<Semantics>(urgeSemanticsFinder);
    expect(urgeSemantics.properties.value, contains('10段階中5'));

    await _reachReflection(tester, begin: '始める', stop: '終了する');
    expect(find.text('何が起きましたか？'), findsOneWidget);
    expect(find.textContaining('以下の記録は任意です'), findsOneWidget);

    await tester.tap(find.text('先延ばしにした'));
    await tester.tap(find.text('練習を保存'));
    await tester.pump();

    expect(saved.value, isNotNull);
    expect(saved.value!.compulsion, 'checking');
    expect(saved.value!.outcome, DelayOutcome.delayed);
    expect(find.text('練習を記録しました'), findsOneWidget);
    expect(find.text('今はここまで'), findsOneWidget);
    expect(find.textContaining('Patterns Pro'), findsNothing);
  });

  testWidgets('failed delay save never presents completion', (tester) async {
    _usePhoneViewport(tester);
    final saved = _SavedSession();
    await tester.pumpWidget(
      _host(locale: const Locale('de'), output: saved, saveSucceeds: false),
    );
    await tester.pump();

    await _reachReflection(
      tester,
      begin: 'Beginnen',
      stop: 'Ich muss aufhören',
    );
    await tester.tap(find.text('Aufgeschoben'));
    await tester.tap(find.text('Übung speichern'));
    await tester.pump();

    expect(saved.value, isNull);
    expect(
      find.text(
        'Deine Übung konnte nicht gespeichert werden. Bitte versuche es erneut.',
      ),
      findsOneWidget,
    );
    expect(find.text('Jetzt fertig'), findsNothing);
  });

  testWidgets('delay setup reflows at 200 percent text', (tester) async {
    _usePhoneViewport(tester);

    final saved = _SavedSession();
    await tester.pumpWidget(
      _host(
        locale: const Locale('fr'),
        output: saved,
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pump();

    expect(find.text('Mettre l’envie en pause'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(
      find.text('Personnaliser'),
      180,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();
    expect(find.text('Personnaliser'), findsOneWidget);
  });
}
