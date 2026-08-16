import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/mobile/screens/journal_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

/// In-memory stand-in for the DB-backed notifier, matching the pattern in
/// ybocs_flow_test.dart so the flow can run headless.
class _FakeJournalNotifier extends JournalNotifier {
  _FakeJournalNotifier(this._store);

  final List<JournalEntry> _store;
  final deleted = <String>[];

  @override
  Future<List<JournalEntry>> build() async => List.of(_store);

  @override
  Future<void> deleteEntry(String date) async {
    deleted.add(date);
    _store.removeWhere((e) => e.date == date);
    state = AsyncData(List.of(_store));
  }
}

JournalEntry _entry(String date, String content) {
  return JournalEntry(
    date: date,
    content: content,
    createdAt: DateTime.parse(date),
    updatedAt: DateTime.parse(date),
  );
}

void main() {
  /// Hosts the shared clear-day action behind a button, which is what both real
  /// call sites reduce to: confirm, then delete on confirmation only.
  Widget host(_FakeJournalNotifier fake, DateTime date) {
    return ProviderScope(
      overrides: [journalProvider.overrideWith(() => fake)],
      child: MaterialApp(
        theme: AppTheme.mobileDarkTheme,
        home: Consumer(
          builder: (context, ref, _) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => confirmClearJournalDay(context, ref, date),
                child: const Text('clear'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('confirming clears that day and leaves other days alone', (
    tester,
  ) async {
    final fake = _FakeJournalNotifier([
      _entry('2026-03-10', 'wrong date'),
      _entry('2026-03-11', 'keep me'),
    ]);

    await tester.pumpWidget(host(fake, DateTime(2026, 3, 10)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('clear'));
    await tester.pumpAndSettle();

    // The sheet names the day, so nobody clears the wrong one by accident.
    expect(find.text('Clear this day?'), findsOneWidget);
    expect(find.textContaining('March 10, 2026'), findsOneWidget);

    await tester.tap(find.text('Clear the day'));
    await tester.pumpAndSettle();

    expect(fake.deleted, ['2026-03-10']);
    expect(fake._store.map((e) => e.date), ['2026-03-11']);
  });

  testWidgets('"Keep it" deletes nothing', (tester) async {
    final fake = _FakeJournalNotifier([_entry('2026-03-10', 'wrong date')]);

    await tester.pumpWidget(host(fake, DateTime(2026, 3, 10)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('clear'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keep it'));
    await tester.pumpAndSettle();

    expect(fake.deleted, isEmpty);
    expect(fake._store, hasLength(1));
  });

  testWidgets('dismissing the sheet without choosing deletes nothing', (
    tester,
  ) async {
    final fake = _FakeJournalNotifier([_entry('2026-03-10', 'wrong date')]);

    await tester.pumpWidget(host(fake, DateTime(2026, 3, 10)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('clear'));
    await tester.pumpAndSettle();
    // Tap the scrim above the sheet to dismiss it.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(fake.deleted, isEmpty);
    expect(fake._store, hasLength(1));
  });
}
