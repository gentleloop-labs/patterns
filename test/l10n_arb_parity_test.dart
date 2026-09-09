import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'every translated ARB has the same messages and metadata as English',
    () {
      final directory = Directory('lib/l10n');
      final files =
          directory
              .listSync()
              .whereType<File>()
              .where((file) => file.path.endsWith('.arb'))
              .toList()
            ..sort((a, b) => a.path.compareTo(b.path));

      final english = _keys(File('lib/l10n/app_en.arb'));
      for (final file in files) {
        final keys = _keys(file);
        expect(
          keys,
          english,
          reason: '${file.path} must stay in parity with app_en.arb',
        );
      }
    },
  );
}

Set<String> _keys(File file) {
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return data.keys.where((key) => key != '@@locale').toSet();
}
