import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/mobile/main_shell.dart';
import 'package:patterns/mobile/preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';

void main() {
  const contentKey = Key('mobile-content');

  setUp(() async {
    SharedPreferences.setMockInitialValues({appLockPreferenceKey: false});
    await initMobilePreferences();
  });

  testWidgets('mobile content remains centered and capped on large screens', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: MobileAppFrame(
            child: SizedBox.expand(
              key: contentKey,
              child: ColoredBox(color: Colors.black),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(contentKey)), const Size(560, 800));
    expect(tester.getTopLeft(find.byKey(contentKey)), const Offset(320, 0));
  });

  testWidgets('mobile content uses the available width on narrow screens', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: MobileAppFrame(
            child: SizedBox.expand(
              key: contentKey,
              child: ColoredBox(color: Colors.black),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(contentKey)), const Size(420, 800));
    expect(tester.getTopLeft(find.byKey(contentKey)), Offset.zero);
  });
}
