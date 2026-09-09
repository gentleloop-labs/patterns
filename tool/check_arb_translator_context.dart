import 'dart:convert';
import 'dart:io';

Never fail(String message) {
  stderr.writeln('ARB translator-context gate failed: $message');
  exit(1);
}

void main() {
  final file = File('lib/l10n/app_en.arb');
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final missing = <String>[];
  for (final key in data.keys.where(
    (key) => key != '@@locale' && !key.startsWith('@'),
  )) {
    final metadata = data['@$key'];
    if (metadata is! Map<String, dynamic> ||
        (metadata['description'] as String? ?? '').trim().isEmpty) {
      missing.add(key);
    }
  }
  if (missing.isNotEmpty) {
    fail(
      '${missing.length} message(s) lack an English description:\n'
      '${missing.join('\n')}',
    );
  }
  stdout.writeln('ARB translator-context gate passed.');
}
