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
