import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final arb =
      jsonDecode(File('lib/l10n/app_fr.arb').readAsStringSync())
          as Map<String, dynamic>;
  final productCopy = arb.entries
      .where(
        (entry) =>
            !entry.key.startsWith('@') &&
            !entry.key.startsWith('desktop') &&
            entry.value is String,
      )
      .map((entry) => entry.value as String)
      .join('\n');

  test('French uses the reviewed clinical glossary and polite vous voice', () {
    expect(productCopy, contains('trouble obsessionnel compulsif (TOC)'));
    expect(productCopy, contains('obsessions'));
    expect(productCopy, contains('compulsions'));
    expect(
      productCopy,
      contains('exposition avec prévention de la réponse (EPR)'),
    );
    expect(productCopy, contains('Y-BOCS'));
    expect(productCopy, contains('vous'));
    expect(productCopy, isNot(contains(RegExp(r'\bOCD\b'))));
    expect(productCopy, isNot(contains(RegExp(r'\bERP\b'))));
    expect(productCopy, isNot(contains('rétablissement')));
    expect(productCopy, isNot(contains('récupération')));
    expect(productCopy, isNot(contains(RegExp(r'\bInsights\b'))));
  });

  test('French keeps quiet completion and safety boundaries', () {
    expect(arb['doneForNowAction'], 'Terminer pour le moment');
    expect(
      arb['privacyClinicalBoundary'],
      contains('ne diagnostique ni ne traite'),
    );
    expect(arb['privacyClinicalBoundary'], contains('ne remplace pas'));
    expect(arb['privacyClinicalBoundary'], contains('aide d’urgence'));
    expect(arb['emergencyToolkitText'], contains('services d’urgence locaux'));
    expect(arb['tipJarBody'], contains('facultatifs'));
    expect(arb['tipJarBody'], contains('ne débloquent rien'));
    expect(arb['privacyAnalytics'], contains('choix de langue'));
  });

  test('French iOS permission copy uses localized clinical language', () {
    final permissionCopy = File(
      'ios/Runner/fr.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('TOC'));
    expect(permissionCopy, contains('votre appareil'));
    expect(permissionCopy, isNot(contains(RegExp(r'\bOCD\b'))));
  });
}
