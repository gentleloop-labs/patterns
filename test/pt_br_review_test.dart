import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final arb =
      jsonDecode(File('lib/l10n/app_pt_BR.arb').readAsStringSync())
          as Map<String, dynamic>;
  final productCopy = arb.entries
      .where((entry) => !entry.key.startsWith('@') && entry.value is String)
      .map((entry) => entry.value as String)
      .join('\n');

  test('Brazilian Portuguese uses the reviewed clinical glossary', () {
    expect(productCopy, contains('TOC'));
    expect(productCopy, contains('EPR'));
    expect(productCopy, contains('Y-BOCS'));
    expect(productCopy, isNot(contains('OCD')));
    expect(productCopy, isNot(contains('ERP')));
    expect(productCopy, isNot(contains('reafirmação')));
    expect(productCopy, isNot(contains('autoquestionário')));
  });

  test('Brazilian Portuguese keeps quiet completion and safety boundaries', () {
    expect(arb['doneForNowAction'], 'Encerrar por agora');
    expect(
      arb['privacyClinicalBoundary'],
      contains('não oferece apoio de emergência'),
    );
    expect(arb['privacyClinicalBoundary'], contains('não substitui'));
    expect(arb['tipJarBody'], contains('não desbloqueiam nada'));
    expect(arb['privacyAnalytics'], contains('escolha de idioma'));
  });

  test('Brazilian Portuguese iOS permission copy uses TOC', () {
    final permissionCopy = File(
      'ios/Runner/pt-BR.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('TOC'));
    expect(permissionCopy, isNot(contains('OCD')));
  });
}
