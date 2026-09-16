import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final arb =
      jsonDecode(File('lib/l10n/app_ja.arb').readAsStringSync())
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

  test('Japanese uses the reviewed clinical glossary and natural voice', () {
    expect(productCopy, contains('強迫性障害（強迫症）'));
    expect(productCopy, contains('強迫観念'));
    expect(productCopy, contains('強迫行為'));
    expect(productCopy, contains('曝露反応妨害法（ERP）'));
    expect(productCopy, contains('Y-BOCS'));
    expect(productCopy, isNot(contains(RegExp(r'\bOCD\b'))));
    expect(productCopy, isNot(contains('あなた')));
    expect(productCopy, isNot(contains('リカバリー')));
    expect(productCopy, isNot(contains('回復')));
    expect(productCopy, isNot(contains('エクスポージャー')));
  });

  test('Japanese keeps quiet completion and safety boundaries', () {
    expect(arb['doneForNowAction'], '今はここまで');
    expect(arb['privacyClinicalBoundary'], contains('診断や治療'));
    expect(arb['privacyClinicalBoundary'], contains('代替'));
    expect(arb['privacyClinicalBoundary'], contains('緊急支援'));
    expect(arb['emergencyToolkitText'], contains('地域の緊急窓口'));
    expect(arb['tipJarBody'], contains('任意'));
    expect(arb['tipJarBody'], contains('機能が追加されることはありません'));
    expect(arb['privacyAnalytics'], contains('言語選択'));
  });

  test('Japanese keeps release, onboarding, PDF, and privacy copy factual', () {
    expect(arb['updateAnnouncementTitle'], isNot(contains('より良く')));
    expect(arb['updateAnnouncementBody'], contains('事実に基づく要約'));
    expect(arb['onboardingSelfCheckTitle'], '今のパターンを確認したい');
    expect(arb['pdfYbocsDescription'], contains('40点満点'));
    expect(arb['pdfYbocsDescription'], contains('20点満点'));
    expect(arb['analyticsPromptBody'], contains('苦痛度'));
    expect(arb['analyticsPromptBody'], contains('地域設定'));
  });

  test('Japanese keeps Y-BOCS and immediate-support boundaries explicit', () {
    expect(arb['ybocsSeverityBlurb'], contains('severe{'));
    expect(arb['ybocsSeverityBlurb'], contains('extreme{'));
    expect(
      RegExp(r'(severe|extreme)\{[^}]*診断ではありません').allMatches(
        arb['ybocsSeverityBlurb'] as String,
      ),
      hasLength(2),
    );
    expect(arb['emergencyToolkitText'], contains('差し迫った危険'));
    expect(arb['ybocsText'], contains('差し迫った危険'));
  });

  test('Japanese iOS permission copy uses localized clinical language', () {
    final permissionCopy = File(
      'ios/Runner/ja.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('強迫症'));
    expect(permissionCopy, contains('曝露'));
    expect(permissionCopy, isNot(contains(RegExp(r'\bOCD\b'))));
    expect(permissionCopy, isNot(contains('暴露')));
  });
}
