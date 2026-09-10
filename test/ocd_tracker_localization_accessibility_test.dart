import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/ocd_tracker_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _FakeOcdNotifier extends OcdNotifier {
  _FakeOcdNotifier(this.entries);

  final List<OcdEntry> entries;

  @override
  Future<List<OcdEntry>> build() async => List.of(entries);
}

class _ErrorOcdNotifier extends OcdNotifier {
  @override
  Future<List<OcdEntry>> build() async =>
      throw StateError('private database path');
}

class _SaveErrorOcdNotifier extends OcdNotifier {
  bool addCalled = false;
  bool get hasError => state.hasError;

  @override
  Future<List<OcdEntry>> build() async => const [];

  @override
  Future<bool> addEntry(OcdEntry entry) async {
    addCalled = true;
    state = const AsyncLoading();
    state = await AsyncValue.guard<List<OcdEntry>>(
      () async => throw StateError('private database path'),
    );
    return false;
  }
}

Widget _localizedHost({
  required OcdNotifier Function() notifier,
  required Widget home,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [ocdProvider.overrideWith(notifier)],
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
      home: home,
    ),
  );
}

OcdTrackerScreen _tracker() => OcdTrackerScreen(onAdd: () {}, onDelay: () {});

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('empty tracker follows the active Japanese locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedHost(
        notifier: () => _FakeOcdNotifier(const []),
        locale: const Locale('ja'),
        home: _tracker(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('記録'), findsOneWidget);
    expect(find.text('記録した出来事を絞り込む'), findsNothing);
    expect(find.bySemanticsLabel('記録した出来事を絞り込む'), findsOneWidget);
    expect(find.text('まだ出来事はありません'), findsOneWidget);
    expect(find.text('OCDの出来事を記録'), findsOneWidget);
    expect(find.text('No events yet'), findsNothing);
  });

  testWidgets('tracker load errors never expose raw exception text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedHost(
        notifier: _ErrorOcdNotifier.new,
        locale: const Locale('de'),
        home: _tracker(),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Ihre erfassten Momente konnten nicht geladen werden. Bitte versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('private database path'), findsNothing);
  });

  testWidgets('tracker cards expose localized values and controls', (
    tester,
  ) async {
    final entry = OcdEntry(
      id: 7,
      type: OcdType.obsession,
      datetime: DateTime(2026, 3, 10, 14, 30),
      content: '確認したくなる考え',
      distressLevel: 7,
      response: '少し待った',
      createdAt: DateTime(2026, 3, 10, 14, 30),
    );

    await tester.pumpWidget(
      _localizedHost(
        notifier: () => _FakeOcdNotifier([entry]),
        locale: const Locale('ja'),
        home: _tracker(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('強迫観念'), findsWidgets);
    expect(find.text('苦痛度7/10'), findsOneWidget);
    expect(find.byTooltip('出来事を編集'), findsOneWidget);
    expect(find.byTooltip('出来事を削除'), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        RegExp('強迫観念。3月10日.*14:30。苦痛度7/10。確認したくなる考え。対応：少し待った'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('tracker editor reflows at 200 percent and exposes semantics', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _localizedHost(
        notifier: () => _FakeOcdNotifier(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
        home: const OcdEventFlow(initialType: OcdType.obsession),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ereignis erfassen'), findsOneWidget);
    expect(find.bySemanticsLabel('Ereignistyp'), findsOneWidget);
    expect(find.bySemanticsLabel('Was sagte der Gedanke?'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -1800));
    await tester.pumpAndSettle();
    expect(find.text('5/10'), findsOneWidget);
    final distressSemantics = find.byWidgetPredicate(
      (widget) =>
          widget is Semantics &&
          widget.properties.label == 'Belastung, 0 bis 10',
    );
    expect(
      tester.widget<Semantics>(distressSemantics).properties.value,
      'Belastung 5 von 10',
    );
    expect(
      tester.widget<Semantics>(distressSemantics).properties.onIncrease,
      isNotNull,
    );
    expect(
      tester.getSize(find.byTooltip('Zurück')).height,
      greaterThanOrEqualTo(44),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty validation is warm and localized', (tester) async {
    await tester.pumpWidget(
      _localizedHost(
        notifier: () => _FakeOcdNotifier(const []),
        locale: const Locale('es'),
        home: const OcdEventFlow(initialType: OcdType.obsession),
      ),
    );
    await tester.pumpAndSettle();

    final saveButton = find.byKey(const ValueKey('ocd-save-event'));
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    await tester.tap(saveButton.first);
    await tester.pump();

    expect(
      find.text('Cuando esté listo, añada unas palabras sobre lo que ocurrió.'),
      findsOneWidget,
    );
  });

  testWidgets('save failures use safe localized copy', (tester) async {
    final notifier = _SaveErrorOcdNotifier();
    await tester.pumpWidget(
      _localizedHost(
        notifier: () => notifier,
        locale: const Locale('fr'),
        home: const OcdEventFlow(initialType: OcdType.obsession),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.bySemanticsLabel('Que disait la pensée ?'),
      'Une pensée à noter',
    );
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    final saveButton = find.byKey(const ValueKey('ocd-save-event'));
    await tester.drag(find.byType(ListView), const Offset(0, -1800));
    await tester.pumpAndSettle();
    await tester.tap(saveButton.first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(notifier.addCalled, isTrue);
    expect(notifier.hasError, isTrue);
    expect(
      find.bySemanticsLabel(
        'Impossible d’enregistrer votre événement. Veuillez réessayer.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('private database path'), findsNothing);
  });
}
