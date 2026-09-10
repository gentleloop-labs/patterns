import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/journal_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _FakeJournalNotifier extends JournalNotifier {
  _FakeJournalNotifier(this.entries);

  final List<JournalEntry> entries;

  @override
  Future<List<JournalEntry>> build() async => List.of(entries);
}

class _ErrorJournalNotifier extends JournalNotifier {
  @override
  Future<List<JournalEntry>> build() async =>
      throw StateError('private database path');
}

Widget _localizedHost({
  required JournalNotifier Function() notifier,
  required Widget home,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [journalProvider.overrideWith(notifier)],
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

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('journal list and search follow the active Japanese locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedHost(
        notifier: () => _FakeJournalNotifier(const []),
        locale: const Locale('ja'),
        home: const JournalScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ジャーナル'), findsOneWidget);
    expect(find.text('ジャーナルのエントリーはまだありません'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('ジャーナルを検索'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('エントリーを検索'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '確認');
    await tester.pump();
    expect(find.byTooltip('検索を消去'), findsOneWidget);
    expect(find.text('「確認」に一致するエントリーはありません。'), findsOneWidget);
  });

  testWidgets('journal load errors never expose raw exception text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedHost(
        notifier: _ErrorJournalNotifier.new,
        locale: const Locale('de'),
        home: const JournalScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Die Tagebucheinträge konnten nicht geladen werden. Versuchen Sie es erneut.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('private database path'), findsNothing);
  });

  testWidgets(
    'journal editor exposes semantics and reflows at 200 percent text',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _localizedHost(
          notifier: () => _FakeJournalNotifier(const []),
          locale: const Locale('de'),
          textScaler: const TextScaler.linear(2),
          disableAnimations: true,
          home: JournalEntryEditor(date: DateTime(2026, 3, 10)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('10. März 2026'), findsOneWidget);
      expect(find.text('Gespeichert'), findsOneWidget);
      expect(find.bySemanticsLabel('Tagebuch-Editor'), findsOneWidget);
      expect(find.bySemanticsLabel('Fett'), findsOneWidget);
      expect(find.text('Text zum Formatieren auswählen'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
