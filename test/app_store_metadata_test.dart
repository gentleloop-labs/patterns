import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('1.10 English App Store metadata stays within Apple limits', () {
    final version =
        jsonDecode(
              File('metadata/version/1.10.0/en-US.json').readAsStringSync(),
            )
            as Map<String, dynamic>;
    final appInfo =
        jsonDecode(File('metadata/app-info/en-US.json').readAsStringSync())
            as Map<String, dynamic>;

    expect((appInfo['name'] as String).runes.length, lessThanOrEqualTo(30));
    expect((appInfo['subtitle'] as String).runes.length, lessThanOrEqualTo(30));
    expect(
      (version['keywords'] as String).runes.length,
      lessThanOrEqualTo(100),
    );
    expect(
      (version['promotionalText'] as String).runes.length,
      lessThanOrEqualTo(170),
    );
    expect(
      (version['description'] as String).runes.length,
      lessThanOrEqualTo(4000),
    );
    expect(
      (version['whatsNew'] as String).runes.length,
      lessThanOrEqualTo(4000),
    );
  });
}
