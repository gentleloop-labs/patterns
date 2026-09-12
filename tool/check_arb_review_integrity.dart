import 'dart:convert';
import 'dart:io';

const localeFiles = <String, String>{
  'en': 'lib/l10n/app_en.arb',
  'pt-BR': 'lib/l10n/app_pt_BR.arb',
  'de': 'lib/l10n/app_de.arb',
  'ja': 'lib/l10n/app_ja.arb',
  'es': 'lib/l10n/app_es.arb',
  'fr': 'lib/l10n/app_fr.arb',
};

Never fail(String message) {
  stderr.writeln('ARB review-integrity gate failed: $message');
  exit(1);
}

Map<String, dynamic> readArb(String path) {
  try {
    return jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  } on Object catch (error) {
    fail('$path is not valid ARB JSON: $error');
  }
}

Map<String, String> messages(Map<String, dynamic> arb, String path) {
  final result = <String, String>{};
  for (final entry in arb.entries) {
    if (entry.key == '@@locale' || entry.key.startsWith('@')) continue;
    if (entry.value is! String) fail('$path:${entry.key} is not a string');
    result[entry.key] = entry.value as String;
  }
  return result;
}

Map<String, String> placeholderTypes(
  Map<String, dynamic> arb,
  String key,
  String path,
) {
  final metadata = arb['@$key'];
  if (metadata is! Map<String, dynamic>) {
    fail('$path:@$key is missing or is not an object');
  }
  final placeholders = metadata['placeholders'];
  if (placeholders == null) return const {};
  if (placeholders is! Map<String, dynamic>) {
    fail('$path:@$key.placeholders is not an object');
  }
  return placeholders.map((name, raw) {
    if (raw is! Map<String, dynamic>) {
      fail('$path:@$key.placeholders.$name is not an object');
    }
    return MapEntry(name, raw['type'] as String? ?? 'Object');
  });
}

List<String> icuSignatures(String message, String field) {
  final signatures = <String>[];

  void scan(String source) {
    var index = 0;
    while (index < source.length) {
      if (source[index] != '{') {
        index++;
        continue;
      }
      final close = matchingBrace(source, index, field);
      final content = source.substring(index + 1, close);
      final commas = topLevelCommas(content);
      if (commas.length >= 2) {
        final argument = content.substring(0, commas[0]).trim();
        final kind = content.substring(commas[0] + 1, commas[1]).trim();
        if (kind == 'plural' || kind == 'select' || kind == 'selectordinal') {
          final options = content.substring(commas[1] + 1);
          final cases = <String>[];
          var optionIndex = 0;
          while (optionIndex < options.length) {
            while (optionIndex < options.length &&
                _isWhitespace(options.codeUnitAt(optionIndex))) {
              optionIndex++;
            }
            if (optionIndex == options.length) break;
            final keyStart = optionIndex;
            while (optionIndex < options.length &&
                options[optionIndex] != '{') {
              optionIndex++;
            }
            if (optionIndex == options.length) {
              fail('$field contains malformed ICU $kind options');
            }
            final option = options.substring(keyStart, optionIndex).trim();
            if (option.isEmpty || option.contains(RegExp(r'\s'))) {
              fail('$field contains malformed ICU $kind case "$option"');
            }
            cases.add(option);
            final optionClose = matchingBrace(options, optionIndex, field);
            scan(options.substring(optionIndex + 1, optionClose));
            optionIndex = optionClose + 1;
          }
          if (!cases.contains('other')) {
            fail('$field ICU $kind for $argument has no other case');
          }
          cases.sort();
          // Select cases are stable wire/content IDs and must match exactly.
          // Plural categories and even whether grammatical number is needed
          // are language-specific (Japanese usually needs neither), so plural
          // blocks are validated above but are not compared with English.
          if (kind == 'select') {
            signatures.add('$argument:$kind:${cases.join(',')}');
          }
          index = close + 1;
          continue;
        }
      }
      scan(content);
      index = close + 1;
    }
  }

  scan(message);
  signatures.sort();
  return signatures;
}

int matchingBrace(String source, int open, String field) {
  var depth = 0;
  for (var index = open; index < source.length; index++) {
    if (source[index] == '{') depth++;
    if (source[index] == '}') {
      depth--;
      if (depth == 0) return index;
    }
  }
  fail('$field contains unbalanced ICU braces');
}

List<int> topLevelCommas(String source) {
  final result = <int>[];
  var depth = 0;
  for (var index = 0; index < source.length; index++) {
    if (source[index] == '{') depth++;
    if (source[index] == '}') depth--;
    if (source[index] == ',' && depth == 0) result.add(index);
  }
  return result;
}

bool _isWhitespace(int codeUnit) =>
    codeUnit == 0x20 ||
    codeUnit == 0x09 ||
    codeUnit == 0x0a ||
    codeUnit == 0x0d;

void main() {
  final arbs = {
    for (final entry in localeFiles.entries) entry.key: readArb(entry.value),
  };
  final englishArb = arbs['en']!;
  final englishMessages = messages(englishArb, localeFiles['en']!);
  final mismatches = <String>[];

  for (final entry in arbs.entries) {
    final locale = entry.key;
    final path = localeFiles[locale]!;
    final localeMessages = messages(entry.value, path);
    if (localeMessages.keys
            .toSet()
            .difference(englishMessages.keys.toSet())
            .isNotEmpty ||
        englishMessages.keys
            .toSet()
            .difference(localeMessages.keys.toSet())
            .isNotEmpty) {
      fail('$path message keys do not match the frozen English source');
    }

    for (final key in englishMessages.keys) {
      final expectedPlaceholders = placeholderTypes(
        englishArb,
        key,
        localeFiles['en']!,
      );
      final actualPlaceholders = placeholderTypes(entry.value, key, path);
      if (!_sameMap(expectedPlaceholders, actualPlaceholders)) {
        mismatches.add(
          '$path:$key placeholder names or types differ from English',
        );
      }
      final expectedIcu = icuSignatures(
        englishMessages[key]!,
        '${localeFiles['en']}:$key',
      );
      final actualIcu = icuSignatures(localeMessages[key]!, '$path:$key');
      if (!_sameList(expectedIcu, actualIcu)) {
        mismatches.add(
          '$path:$key ICU select arguments or cases differ from English',
        );
      }
    }
  }

  if (mismatches.isNotEmpty) fail(mismatches.join('\n'));

  stdout.writeln(
    'ARB review-integrity gate passed for ${englishMessages.length} messages in ${arbs.length} languages.',
  );
}

bool _sameMap(Map<String, String> first, Map<String, String> second) =>
    first.length == second.length &&
    first.entries.every((entry) => second[entry.key] == entry.value);

bool _sameList(List<String> first, List<String> second) =>
    first.length == second.length &&
    Iterable<int>.generate(
      first.length,
    ).every((index) => first[index] == second[index]);
