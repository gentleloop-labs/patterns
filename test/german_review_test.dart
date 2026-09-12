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

  test('German iOS permission copy uses localized clinical language', () {
    final permissionCopy = File(
      'ios/Runner/de.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('Zwangsmomenten'));
    expect(permissionCopy, isNot(contains(RegExp(r'\bOCD\b'))));
  });
}
