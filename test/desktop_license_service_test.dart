import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:patterns/app_preferences.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/services/desktop_license_service.dart';
import 'package:patterns/widgets/paywall_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const service = DesktopLicenseService();

  test('desktop checkout accepts HTTPS URLs only', () {
    expect(
      DesktopCommerceConfiguration.parseCheckoutUrl(
        'https://example.com/checkout',
      )?.host,
      'example.com',
    );
    expect(
      DesktopCommerceConfiguration.parseCheckoutUrl(
        'http://example.com/checkout',
      ),
      isNull,
    );
    expect(DesktopCommerceConfiguration.parseCheckoutUrl('not a url'), isNull);
  });

  test('activates only a matching active product license', () async {
    final client = MockClient((request) async {
      expect(
        request.url.toString(),
        'https://api.lemonsqueezy.com/v1/licenses/activate',
      );
      expect(request.headers['Accept'], 'application/json');
      expect(
        request.headers['Content-Type'],
        'application/x-www-form-urlencoded',
      );
      expect(request.bodyFields['license_key'], 'valid-key');
      expect(request.bodyFields['instance_name'], 'Patterns Desktop');
      return http.Response(
        jsonEncode({
          'activated': true,
          'license_key': {'status': 'active'},
          'meta': {'product_id': 42},
        }),
        200,
      );
    });

    expect(
      await service.activate(
        ' valid-key ',
        client: client,
        expectedProductId: '42',
      ),
      DesktopLicenseActivationStatus.activated,
    );
  });

  test('rejects a valid license belonging to another product', () async {
    final client = MockClient(
      (_) async => http.Response(
        jsonEncode({
          'activated': true,
          'license_key': {'status': 'active'},
          'meta': {'product_id': 99},
        }),
        200,
      ),
    );

    expect(
      await service.activate(
        'valid-key',
        client: client,
        expectedProductId: '42',
      ),
      DesktopLicenseActivationStatus.rejected,
    );
  });

  test('does not call the network without release configuration', () async {
    var called = false;
    final client = MockClient((_) async {
      called = true;
      return http.Response('{}', 200);
    });

    expect(
      await service.activate('some-key', client: client),
      DesktopLicenseActivationStatus.notConfigured,
    );
    expect(called, isFalse);
  });

  test('does not call the network for an empty key', () async {
    var called = false;
    final client = MockClient((_) async {
      called = true;
      return http.Response('{}', 200);
    });

    expect(
      await service.activate('   ', client: client, expectedProductId: '42'),
      DesktopLicenseActivationStatus.invalid,
    );
    expect(called, isFalse);
  });

  test('maps malformed and network responses to unavailable', () async {
    final malformed = MockClient((_) async => http.Response('not-json', 200));
    final networkFailure = MockClient((_) async => throw Exception('offline'));

    expect(
      await service.activate('key', client: malformed, expectedProductId: '42'),
      DesktopLicenseActivationStatus.unavailable,
    );
    expect(
      await service.activate(
        'key',
        client: networkFailure,
        expectedProductId: '42',
      ),
      DesktopLicenseActivationStatus.unavailable,
    );
  });

  testWidgets('an arbitrary local key cannot unlock Desktop Pro', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({proUnlockedKey: false});
    await initAppPreferences();
    await tester.binding.setSurfaceSize(const Size(900, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(body: DesktopPaywallView()),
        ),
      ),
    );

    await tester.tap(find.text('Already purchased? Enter your license key'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'DESKTOP-TEST-KEY');
    await tester.tap(find.text('Activate license'));
    await tester.pumpAndSettle();

    expect(appPreferences?.getBool(proUnlockedKey), isFalse);
    expect(
      find.text('License activation is unavailable in this build.'),
      findsOneWidget,
    );
  });

  testWidgets('German desktop commerce reflows at 200% text size', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(680, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('de'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Scaffold(
              body: SingleChildScrollView(child: DesktopPaywallView()),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Patterns Desktop Pro freischalten'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
