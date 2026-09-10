import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/screens/journal_screen.dart';
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

Widget _host({
  required JournalNotifier Function() notifier,
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
      theme: AppTheme.darkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: textScaler,
          disableAnimations: disableAnimations,
        ),
        child: child!,
      ),
      home: const JournalScreen(),
    ),
  );
}

JournalEntry _todayEntry() {
  final now = DateTime.now();
  return JournalEntry(
    date: DateFormat('yyyy-MM-dd').format(now),
    content: 'private journal text',
    createdAt: DateTime(now.year, now.month, now.day, 14, 5),
    updatedAt: now,
  );
}

void main() {
  testWidgets('desktop journal localizes its empty state in Japanese', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        notifier: () => _FakeJournalNotifier(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ジャーナルワークスペース'), findsOneWidget);
    expect(find.text('ジャーナル'), findsOneWidget);
    expect(find.textContaining('編集中：'), findsOneWidget);
    expect(find.bySemanticsLabel('日記エディター'), findsOneWidget);

    await tester.tap(find.text('保存'));
    await tester.pump();
    expect(find.text('まだ保存する内容がありません。書けそうなときに、一行から始めてください。'), findsOneWidget);
    expect(find.bySemanticsLabel('日記エディター'), findsOneWidget);
  });

  testWidgets('desktop journal uses localized dates and read-only semantics', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        notifier: () => _FakeJournalNotifier([_todayEntry()]),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Heute'), findsOneWidget);
    expect(find.textContaining('14:05'), findsWidgets);
    expect(
      find.bySemanticsLabel(RegExp('Schreibgeschützter Tagebucheintrag')),
      findsOneWidget,
    );
  });

  testWidgets('desktop journal never exposes raw load errors', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(notifier: _ErrorJournalNotifier.new, locale: const Locale('de')),
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

  testWidgets('desktop journal reflows at 200 percent text', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        notifier: () => _FakeJournalNotifier(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tagebuch-Arbeitsbereich'), findsOneWidget);
    expect(find.text('Neuer Eintrag'), findsOneWidget);
    expect(find.text('Einträge durchsuchen'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
