import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patterns/app_preferences.dart';
import 'package:patterns/services/pro_service.dart';
import 'package:patterns/theme/app_theme.dart';
import 'package:patterns/widgets/paywall_sheet.dart';
import 'package:patterns/widgets/pro_gate.dart';

/// Guards the entitlement of existing lifetime purchasers ahead of the
/// 15 August 2026 price change from $14.99 to $39.99.
///
/// The price change itself is a store-console action on the same non-consumable
/// product (`com.maskedsyntax.patterns.pro`), so nobody who already owns Pro is
/// re-charged or downgraded. These tests pin the behaviour that guarantee rests
/// on, so a future refactor cannot quietly break it:
///
///   * a stored unlock is honoured, including across a provider rebuild
///     (which is what an app update looks like from the entitlement's side)
///   * a restored purchase grants Pro exactly like a fresh one
///   * a Pro user is never shown the paywall
///
/// The purchase-stream handler itself (`ProService._onPurchaseUpdates`) is not
/// covered here: it reaches for `InAppPurchase.instance`, and injecting that
/// would mean changing the entitlement architecture, which this release
/// deliberately does not do. Manual StoreKit and Play runs cover it instead.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await initAppPreferences();
  });

  Future<void> setStoredUnlock(bool value) async {
    SharedPreferences.setMockInitialValues({proUnlockedKey: value});
    await initAppPreferences();
  }

  group('stored entitlement', () {
    test('a fresh install with no purchase is not Pro', () {
      expect(ProService.isUnlocked, isFalse);
    });

    test('a stored unlock makes the user Pro', () async {
      await setStoredUnlock(true);
      expect(ProService.isUnlocked, isTrue);
    });

    test('the product id is unchanged, which is what keeps restore working',
        () {
      // If this ever changes, every existing purchase stops being recognised,
      // because `_onPurchaseUpdates` matches restored transactions on it.
      expect(ProService.productIdPro, 'com.maskedsyntax.patterns.pro');
    });

    test('proProvider reflects the stored unlock', () async {
      await setStoredUnlock(true);
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(proProvider), isTrue);
    });

    test('proProvider is false without a stored unlock', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(proProvider), isFalse);
    });
  });

  group('app update', () {
    test('a legacy purchaser stays Pro across a provider rebuild', () async {
      await setStoredUnlock(true);

      // Stand-in for an app update: the process restarts and every provider is
      // rebuilt, but the preference store on disk survives.
      final before = ProviderContainer();
      expect(before.read(proProvider), isTrue);
      before.dispose();

      final after = ProviderContainer();
      addTearDown(after.dispose);
      expect(after.read(proProvider), isTrue, reason: 'update revoked Pro');
      expect(ProService.isUnlocked, isTrue);
    });

    test('nothing in the entitlement path ever writes false', () async {
      await setStoredUnlock(true);
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Reading it repeatedly, including via refresh, must not clear it.
      container.read(proProvider);
      container.read(proProvider.notifier).refresh();

      expect(appPreferences?.getBool(proUnlockedKey), isTrue);
      expect(container.read(proProvider), isTrue);
    });
  });

  group('wipe all data', () {
    test('clears the unlock, which is why the wipe dialog warns about it',
        () async {
      await setStoredUnlock(true);
      expect(ProService.isUnlocked, isTrue);

      await clearLocalPreferences();

      // Documented, not desired: the purchase is safe with the store and comes
      // back via Restore. The settings dialog says so before wiping.
      expect(ProService.isUnlocked, isFalse);
    });
  });

  group('requirePro', () {
    testWidgets('lets a Pro user through and shows no paywall', (tester) async {
      await setStoredUnlock(true);
      var allowed = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.mobileDarkTheme,
            home: Consumer(
              builder: (context, ref, _) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () => allowed = requirePro(context, ref),
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(allowed, isTrue);
      expect(find.text('Patterns Pro'), findsNothing);
    });

    testWidgets('blocks a free user and opens a paywall', (tester) async {
      // The host VM reports as macOS, so `PaywallSheet.show` takes its desktop
      // branch here. This asserts the gate's contract (blocked, and something
      // was presented), not which paywall a given platform renders.
      await tester.binding.setSurfaceSize(const Size(1200, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      var allowed = true;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.mobileDarkTheme,
            home: Consumer(
              builder: (context, ref, _) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () => allowed = requirePro(context, ref),
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(allowed, isFalse);
      expect(find.byType(ElevatedButton), findsWidgets);
      expect(
        find.textContaining('Pro', findRichText: true),
        findsWidgets,
        reason: 'no paywall was presented to a free user',
      );
    });

    testWidgets('the mobile paywall tells a returning purchaser to restore', (
      tester,
    ) async {
      // Pumped directly rather than through `PaywallSheet.show`, which would
      // route to the desktop dialog on the host VM.
      await tester.binding.setSurfaceSize(const Size(1200, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: PaywallSheet())),
        ),
      );
      await tester.pump();

      // The reassurance has to sit above the price: a legacy owner who
      // reinstalls after the rise would otherwise be looking at $39.99 for
      // something they already paid for.
      expect(find.textContaining('Already bought Pro'), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);
    });
  });
}
