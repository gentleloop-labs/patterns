import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final arb =
      jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
          as Map<String, dynamic>;
  final productCopy = arb.entries
      .where((entry) => !entry.key.startsWith('@') && entry.value is String)
      .map((entry) => entry.value as String)
      .join('\n');
  final mobileAndSharedCopy = arb.entries
      .where(
        (entry) =>
            !entry.key.startsWith('@') &&
            entry.value is String &&
            !entry.key.startsWith('desktop'),
      )
      .map((entry) => entry.value as String)
      .join('\n');

  test('German uses the reviewed clinical glossary and consistent address', () {
    expect(productCopy, contains('Zwangsstörung'));
    expect(productCopy, contains('Zwangsgedanke'));
    expect(productCopy, contains('Zwangshandlung'));
    expect(
      productCopy,
      contains('Reizkonfrontation mit Reaktionsverhinderung (ERP)'),
    );
    expect(productCopy, contains('Y-BOCS'));
    expect(productCopy, isNot(contains(RegExp(r'\bOCD\b'))));
    expect(
      productCopy,
      isNot(
        contains(
          RegExp(
            r'\b(du|dir|dich|dein|deine|deinem|deinen|deiner|deines)\b',
            caseSensitive: false,
          ),
        ),
      ),
    );
  });

  test('German keeps quiet completion and safety boundaries', () {
    expect(arb['doneForNowAction'], 'Für den Moment fertig');
    expect(arb['privacyClinicalBoundary'], contains('keine Notfallhilfe'));
    expect(arb['privacyClinicalBoundary'], contains('ersetzt keine'));
    expect(arb['emergencyToolkitText'], contains('örtlichen Notfalldienste'));
    expect(arb['tipJarBody'], contains('schalten keine Funktionen frei'));
    expect(arb['privacyAnalytics'], contains('Sprachauswahl'));
  });

  test('German back-translation keeps factual product and privacy framing', () {
    expect(mobileAndSharedCopy, isNot(contains('Genesung')));
    expect(arb['updateAnnouncementTitle'], isNot(contains('verbessert')));
    expect(
      arb['updateAnnouncementBody'],
      contains('Aktivitätszusammenfassungen'),
    );
    expect(arb['onboardingSelfCheckTitle'], isNot(contains('einschätzen')));
    expect(arb['pdfYbocsDescription'], contains('Selbstcheck in der App'));
    expect(arb['privacyAnalytics'], contains('Gebietsschema'));
    expect(arb['analyticsPromptBody'], contains('Belastungswerte'));
  });

  test('German Y-BOCS and emergency copy retain direct safety boundaries', () {
    final severityCopy = arb['ybocsSeverityBlurb'] as String;
    expect(
      RegExp(r'severe\{[^}]*keine Diagnose').hasMatch(severityCopy),
      isTrue,
    );
    expect(
      RegExp(r'extreme\{[^}]*keine Diagnose').hasMatch(severityCopy),
      isTrue,
    );
    expect(arb['emergencyToolkitText'], contains('in unmittelbarer Gefahr'));
    expect(arb['emergencyToolkitText'], isNot(contains('möglicherweise')));
    expect(arb['ybocsText'], isNot(contains('möglicherweise')));
  });

  test('German iOS permission copy uses localized clinical language', () {
    final permissionCopy = File(
      'ios/Runner/de.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('Zwangsmomenten'));
    expect(permissionCopy, isNot(contains(RegExp(r'\bOCD\b'))));
  });
}
