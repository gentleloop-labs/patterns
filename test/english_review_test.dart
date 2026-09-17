import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final arb =
      jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
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

  test('English uses factual self-help and clinical terminology', () {
    expect(productCopy, contains('exposure and response prevention (ERP)'));
    expect(productCopy, contains('Yale-Brown Obsessive Compulsive Scale'));
    expect(productCopy, contains('obsessions'));
    expect(productCopy, contains('compulsions'));
    expect(
      productCopy,
      isNot(contains(RegExp(r'\brecovery\b', caseSensitive: false))),
    );
    expect(productCopy, isNot(contains('Emergency Toolkit')));
    expect(productCopy, isNot(contains('Delete assessment')));
  });

  test('English keeps quiet completion and explicit safety boundaries', () {
    expect(arb['doneForNowAction'], 'Done for now');
    expect(
      arb['privacyClinicalBoundary'],
      contains('does not diagnose or treat'),
    );
    expect(arb['privacyClinicalBoundary'], contains('does not'));
    expect(arb['privacyClinicalBoundary'], contains('emergency support'));
    expect(
      arb['emergencyToolkitText'],
      contains('contact local emergency services'),
    );
    expect(arb['tipJarBody'], contains('optional'));
    expect(arb['tipJarBody'], contains('do not unlock anything'));
    expect(arb['privacyAnalytics'], contains('language choices'));
  });

  test('every Y-BOCS severity result remains non-diagnostic', () {
    final copy = arb['ybocsSeverityBlurb'] as String;
    for (final severity in [
      'subclinical',
      'mild',
      'moderate',
      'severe',
      'extreme',
    ]) {
      final start = copy.indexOf('$severity{');
      expect(start, isNonNegative, reason: severity);
      final next = copy.indexOf('}', start);
      final branch = copy.substring(start, next);
      expect(branch, contains('snapshot'), reason: severity);
      expect(branch, contains('not a diagnosis'), reason: severity);
    }
  });

  test('English release, Y-BOCS, and analytics copy stays factual', () {
    expect(arb['updateAnnouncementTitle'], 'Patterns has new tools');
    expect(
      arb['updateAnnouncementBody'],
      contains('factual activity summaries'),
    );
    expect(arb['updateAnnouncementTitle'], isNot(contains('better')));
    expect(arb['pdfYbocsDescription'], startsWith('An in-app self-check'));
    expect(arb['pdfYbocsDescription'], contains('out of 40'));
    expect(arb['pdfYbocsDescription'], contains('each out of 20'));
    expect(arb['analyticsPromptBody'], contains('ratings'));
    expect(arb['analyticsPromptBody'], contains('locale'));
    expect(arb['analyticsPromptBody'], contains('language choices'));
    expect(arb['analyticsPromptBody'], contains('stays off'));
  });

  test('English cross-language risk boundaries stay explicit', () {
    expect(arb['onboardingSelfCheckTitle'], contains('current patterns'));
    expect(arb['onboardingSelfCheckTitle'], isNot(contains('OCD')));
    expect(arb['emergencyToolkitText'], contains('immediate danger'));
    expect(arb['ybocsText'], contains('immediate danger'));
    expect(arb['privacyAnalytics'], contains('random installation ID'));
    expect(arb['privacyAnalytics'], contains('first-party service'));
    expect(arb['privacyAnalytics'], contains('local analytics ID'));
  });

  test('English iOS permission copy keeps data use narrow and local', () {
    final permissionCopy = File(
      'ios/Runner/en.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('only'));
    expect(permissionCopy, contains('stay on your device'));
    expect(permissionCopy, isNot(contains('diagnose')));
    expect(permissionCopy, isNot(contains('treat')));
  });
}
