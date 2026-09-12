import 'dart:ui' show SemanticsFlag;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/content/ybocs_content.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/ybocs_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _YbocsStore extends YbocsAssessmentNotifier {
  _YbocsStore({
    this.failSave = false,
    this.failDelete = false,
    List<YbocsAssessment> initial = const [],
  }) : saved = [...initial];

  final bool failSave;
  final bool failDelete;
  final List<YbocsAssessment> saved;

  @override
  Future<List<YbocsAssessment>> build() async => saved;

  @override
  Future<void> add(YbocsAssessment assessment) async {
    if (failSave) {
      state = AsyncError(
        StateError('expected test failure'),
        StackTrace.current,
      );
      return;
    }
    saved.add(assessment);
    state = AsyncData(List.of(saved));
  }

  @override
  Future<void> delete(int id) async {
    if (failDelete) {
      state = AsyncError(
        StateError('expected test failure'),
        StackTrace.current,
      );
      return;
    }
    saved.removeWhere((assessment) => assessment.id == id);
    state = AsyncData(List.of(saved));
  }
}

YbocsAssessment _assessment() => YbocsAssessment(
  id: 7,
  datetime: DateTime(2026, 9, 12),
  obsessionScore: 5,
  compulsionScore: 5,
  totalScore: 10,
  severity: YbocsSeverity.mild,
  itemScores: List.filled(10, 1),
  themes: const ['contamination'],
  symptoms: const ['con_dirt'],
  createdAt: DateTime(2026, 9, 12),
);

Widget _host({
  required Locale locale,
  required _YbocsStore store,
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    overrides: [ybocsAssessmentProvider.overrideWith(() => store)],
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
      home: const YbocsScreen(),
    ),
  );
}

Future<void> _reachResults(WidgetTester tester) async {
  await tester.tap(find.text('Begin'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
  for (var index = 0; index < ybocsSeverityQuestions.length; index++) {
    await tester.tap(find.text(ybocsSeverityQuestions[index].options.first));
    await tester.pumpAndSettle();
    await tester.tap(find.text(index == 9 ? 'See results' : 'Next'));
    await tester.pumpAndSettle();
  }
}

void main() {
  test('all six catalogs resolve every stable Y-BOCS content ID', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    for (final locale in AppLocalizations.supportedLocales) {
      final strings = await AppLocalizations.delegate.load(locale);
      if (locale.languageCode != 'en') {
        expect(
          ybocsSeverityQuestions.first.localizedPrompt(strings),
          isNot(ybocsSeverityQuestions.first.localizedPrompt(english)),
        );
      }
      for (final question in ybocsSeverityQuestions) {
        expect(question.localizedPrompt(strings), isNotEmpty);
        expect(question.localizedPrompt(strings), isNot(question.id));
        for (var score = 0; score <= 4; score++) {
          expect(question.localizedOption(strings, score), isNotEmpty);
        }
      }
      for (final category in ybocsCategories) {
        expect(category.localizedTitle(strings), isNotEmpty);
        expect(category.localizedTitle(strings), isNot(category.id));
        for (final symptom in category.items) {
          expect(symptom.localizedLabel(strings), isNotEmpty);
          expect(symptom.localizedLabel(strings), isNot(symptom.id));
        }
      }
      for (final severity in YbocsSeverity.values) {
        expect(severity.localizedLabel(strings), isNotEmpty);
        expect(severity.localizedBlurb(strings), isNotEmpty);
      }
    }
  });

  test(
    'stable Y-BOCS IDs resolve complete Japanese clinical content',
    () async {
      final strings = await AppLocalizations.delegate.load(const Locale('ja'));

      expect(ybocsSeverityQuestions.first.id, 'o_time');
      expect(
        ybocsSeverityQuestions.first.localizedPrompt(strings),
        '強迫観念にどのくらい時間を取られていますか？',
      );
      expect(
        ybocsCategories.first.items.first.localizedLabel(strings),
        '自分を傷つけるかもしれないという恐れ',
      );
      expect(localizedYbocsCategoryTitleFor('contamination', strings), '汚染');
      expect(localizedYbocsCategoryTitleFor('not_real', strings), isNull);
    },
  );

  testWidgets('Japanese checklist exposes checked controls to assistive tech', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(locale: const Locale('ja'), store: _YbocsStore()),
    );
    await tester.pumpAndSettle();

    expect(find.text('OCDセルフチェック'), findsOneWidget);
    await tester.tap(find.text('始める'));
    await tester.pumpAndSettle();

    final symptom = find.bySemanticsLabel('自分を傷つけるかもしれないという恐れ');
    expect(symptom, findsOneWidget);
    await tester.tap(symptom);
    await tester.pumpAndSettle();
    expect(
      tester
          .getSemantics(symptom)
          .getSemanticsData()
          .hasFlag(SemanticsFlag.isChecked),
      isTrue,
    );
  });

  testWidgets('German intro reflows at 200 percent with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        locale: const Locale('de'),
        store: _YbocsStore(),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('OCD-Selbstcheck'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.text('Beginnen'), findsOneWidget);
    await tester.tap(find.text('Beginnen'));
    await tester.pumpAndSettle();
    expect(find.text('Was kommt Ihnen bekannt vor?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed save stays retryable and reports a specific error', (
    tester,
  ) async {
    final store = _YbocsStore(failSave: true);
    await tester.pumpWidget(_host(locale: const Locale('en'), store: store));
    await tester.pumpAndSettle();

    await _reachResults(tester);
    await tester.tap(find.text('Save to my history'));
    await tester.pumpAndSettle();

    expect(
      find.text('This assessment could not be saved. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('Save to my history'), findsOneWidget);
    expect(store.saved, isEmpty);
  });

  testWidgets('failed delete keeps local history and reports the outcome', (
    tester,
  ) async {
    final store = _YbocsStore(failDelete: true, initial: [_assessment()]);
    await tester.pumpWidget(_host(locale: const Locale('en'), store: store));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -450));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete assessment'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(
      find.text('This assessment could not be deleted. Please try again.'),
      findsOneWidget,
    );
    expect(store.saved, hasLength(1));
  });
}
