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

  test('every translated select message has the same cases as English', () {
    final directory = Directory('lib/l10n');
    final files =
        directory
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.arb'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    final english = _messages(File('lib/l10n/app_en.arb'));

    for (final file in files) {
      final messages = _messages(file);
      for (final entry in english.entries) {
        final expected = _selectCases(entry.value);
        if (expected == null) continue;
        expect(
          _selectCases(messages[entry.key]!),
          expected,
          reason: '${file.path}:${entry.key} must keep every select case',
        );
      }
    }
  });

  test('every translated placeholder keeps its English name and type', () {
    final directory = Directory('lib/l10n');
    final files =
        directory
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.arb'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    final english = _placeholderTypes(File('lib/l10n/app_en.arb'));

    for (final file in files) {
      expect(
        _placeholderTypes(file),
        english,
        reason: '${file.path} must preserve placeholder names and types',
      );
    }
  });
}

Set<String> _keys(File file) {
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return data.keys.where((key) => key != '@@locale').toSet();
}

Map<String, String> _messages(File file) {
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final entry in data.entries)
      if (!entry.key.startsWith('@') && entry.value is String)
        entry.key: entry.value as String,
  };
}

Map<String, Map<String, String>> _placeholderTypes(File file) {
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final key in data.keys.where(
      (key) => key != '@@locale' && !key.startsWith('@'),
    ))
      key: {
        for (final entry
            in (((data['@$key'] as Map<String, dynamic>)['placeholders']
                        as Map<String, dynamic>?) ??
                    const <String, dynamic>{})
                .entries)
          entry.key:
              (entry.value as Map<String, dynamic>)['type'] as String? ??
              'Object',
      },
  };
}

Set<String>? _selectCases(String message) {
  final prefix = RegExp(r'^\{[A-Za-z0-9_]+,\s*select,\s*');
  final match = prefix.firstMatch(message);
  if (match == null) return null;

  final cases = <String>{};
  var index = match.end;
  while (index < message.length - 1) {
    while (index < message.length && _isWhitespace(message.codeUnitAt(index))) {
      index++;
    }
    final start = index;
    while (index < message.length &&
        _isCaseCharacter(message.codeUnitAt(index))) {
      index++;
    }
    if (index == start || index >= message.length || message[index] != '{') {
      throw FormatException('Malformed ICU select message near index $index');
    }
    cases.add(message.substring(start, index));
    var depth = 1;
    index++;
    while (index < message.length && depth > 0) {
      if (message[index] == '{') depth++;
      if (message[index] == '}') depth--;
      index++;
    }
    if (depth != 0) throw const FormatException('Unbalanced ICU braces');
  }
  return cases;
}

bool _isWhitespace(int codeUnit) =>
    codeUnit == 0x20 ||
    codeUnit == 0x09 ||
    codeUnit == 0x0a ||
    codeUnit == 0x0d;

bool _isCaseCharacter(int codeUnit) =>
    (codeUnit >= 0x30 && codeUnit <= 0x39) ||
    (codeUnit >= 0x41 && codeUnit <= 0x5a) ||
    codeUnit == 0x5f ||
    (codeUnit >= 0x61 && codeUnit <= 0x7a);
