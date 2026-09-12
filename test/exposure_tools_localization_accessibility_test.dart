import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/mobile/screens/exposure_hierarchy_screen.dart';
import 'package:patterns/mobile/screens/exposure_materials_screen.dart';
import 'package:patterns/models/models.dart';
import 'package:patterns/providers/providers.dart';
import 'package:patterns/theme/app_theme.dart';

class _Calm extends CalmInsightsNotifier {
  _Calm(this.enabled);
  final bool enabled;

  @override
  bool build() => enabled;
}

class _Hierarchies extends ExposureHierarchyNotifier {
  _Hierarchies(this.items);
  final List<ExposureHierarchy> items;

  @override
  Future<List<ExposureHierarchy>> build() async => items;
}

class _Steps extends ExposureStepNotifier {
  _Steps(this.items);
  final List<ExposureStep> items;

  @override
  Future<List<ExposureStep>> build() async => items;
}

class _Materials extends ExposureMaterialNotifier {
  _Materials(this.items);
  final List<ExposureMaterial> items;
  bool deleteCalled = false;

  @override
  Future<List<ExposureMaterial>> build() async => items;

  @override
  Future<bool> delete(ExposureMaterial material) async {
    deleteCalled = true;
    state = AsyncData(items.where((item) => item.id != material.id).toList());
    return true;
  }
}

Widget _host({
  required Widget home,
  required bool calm,
  required List<ExposureHierarchy> hierarchies,
  required List<ExposureStep> steps,
  required _Materials Function() materials,
  Locale locale = const Locale('en'),
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
}) {
  return ProviderScope(
    key: UniqueKey(),
    overrides: [
      calmInsightsProvider.overrideWith(() => _Calm(calm)),
      exposureHierarchyProvider.overrideWith(() => _Hierarchies(hierarchies)),
      exposureStepProvider.overrideWith(() => _Steps(steps)),
      exposureMaterialProvider.overrideWith(materials),
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
      home: home,
    ),
  );
}

void main() {
  testWidgets('empty hierarchy and material libraries follow Japanese locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        home: const ExposureHierarchyScreen(),
        calm: true,
        hierarchies: const [],
        steps: const [],
        materials: () => _Materials(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('エクスポージャー階層'), findsOneWidget);
    expect(find.text('最初の階層を作る'), findsOneWidget);
    expect(find.text('Exposure Hierarchy'), findsNothing);

    await tester.pumpWidget(
      _host(
        home: const ExposureMaterialsScreen(),
        calm: true,
        hierarchies: const [],
        steps: const [],
        materials: () => _Materials(const []),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('エクスポージャー素材'), findsOneWidget);
    expect(find.text('素材をまとめる'), findsOneWidget);
    expect(find.text('Exposure Materials'), findsNothing);
  });

  testWidgets('Calm Insights hides calculated hierarchy progress', (
    tester,
  ) async {
    final hierarchy = ExposureHierarchy(
      id: 7,
      title: 'Door handles',
      theme: 'General',
      createdAt: DateTime(2026, 9, 12),
      updatedAt: DateTime(2026, 9, 12),
    );
    final steps = [
      ExposureStep(
        id: 1,
        hierarchyId: 7,
        orderIndex: 0,
        description: 'First step',
        difficulty: 2,
        anxietyRating: 3,
        status: ExposureStepStatus.completed,
      ),
      ExposureStep(
        id: 2,
        hierarchyId: 7,
        orderIndex: 1,
        description: 'Second step',
        difficulty: 4,
        anxietyRating: 5,
      ),
    ];

    await tester.pumpWidget(
      _host(
        home: const ExposureHierarchyScreen(),
        calm: false,
        hierarchies: [hierarchy],
        steps: steps,
        materials: () => _Materials(const []),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('1 of 2 steps · General'), findsOneWidget);
    final card = tester.getSemantics(find.bySemanticsLabel('Door handles'));
    expect(card.getSemanticsData().value, '1 of 2 steps · General');

    await tester.pumpWidget(
      _host(
        home: const ExposureHierarchyScreen(),
        calm: true,
        hierarchies: [hierarchy],
        steps: steps,
        materials: () => _Materials(const []),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('1 of 2 steps · General'), findsNothing);
    expect(find.text('General'), findsOneWidget);
  });

  testWidgets('hierarchy builder reflows at 200 percent German text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: const ExposureHierarchyBuilderScreen(),
        calm: true,
        hierarchies: const [],
        steps: const [],
        materials: () => _Materials(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Neue Hierarchie'), findsOneWidget);
    final create = find.text('Hierarchie erstellen');
    await tester.scrollUntilVisible(
      create,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(create);
    await tester.pumpAndSettle();
    await tester.tap(create);
    await tester.pumpAndSettle();

    expect(find.text('Geben Sie dieser Leiter einen Namen.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('material library reflows at 200 percent German text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _host(
        home: const ExposureMaterialsScreen(),
        calm: true,
        hierarchies: const [],
        steps: const [],
        materials: () => _Materials(const []),
        locale: const Locale('de'),
        textScaler: const TextScaler.linear(2),
        disableAnimations: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Expositionsmaterialien'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('material deletion is confirmed and announced in Japanese', (
    tester,
  ) async {
    final material = ExposureMaterial(
      id: 9,
      type: MaterialType.script,
      title: '自分の台本',
      text: '保存した文章',
      createdAt: DateTime(2026, 9, 12),
    );
    late _Materials notifier;

    await tester.pumpWidget(
      _host(
        home: const ExposureMaterialsScreen(),
        calm: true,
        hierarchies: const [],
        steps: const [],
        materials: () => notifier = _Materials([material]),
        locale: const Locale('ja'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('素材を削除'));
    await tester.pumpAndSettle();
    expect(find.text('この素材を削除しますか？'), findsOneWidget);

    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(notifier.deleteCalled, isTrue);
    expect(find.text('素材を削除しました。'), findsOneWidget);
  });
}
