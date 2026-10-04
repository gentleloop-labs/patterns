import 'dart:convert';
import 'dart:io';

Map<String, dynamic> _read(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, dynamic>();

void _writeJson(String path, Map<String, dynamic> value) {
  final file = File(path)..parent.createSync(recursive: true);
  file.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(value)}\n',
  );
}

void _writeText(String path, String value) {
  final file = File(path)..parent.createSync(recursive: true);
  file.writeAsStringSync('${value.trim()}\n');
}

void main() {
  final apple = _read('release/1.10.0/store-metadata-drafts.json');
  final shared = (apple['shared'] as Map).cast<String, dynamic>();
  final appleLocales = (apple['locales'] as Map).cast<String, dynamic>();

  for (final entry in appleLocales.entries) {
    final locale = entry.key;
    final copy = (entry.value as Map).cast<String, dynamic>();
    _writeJson('metadata/app-info/$locale.json', {
      'name': copy['name'],
      'subtitle': copy['subtitle'],
      'privacyPolicyUrl': 'https://www.patternsocd.com/privacy',
    });
    _writeJson('metadata/version/1.10.0/$locale.json', {
      'description': copy['description'],
      'keywords': copy['keywords'],
      'marketingUrl': shared['marketingUrl'],
      'promotionalText': copy['promotionalText'],
      'supportUrl': shared['supportUrl'],
      'whatsNew': copy['whatsNew'],
    });
  }

  final play = _read('release/1.10.0/google-play-metadata-drafts.json');
  final playLocales = (play['locales'] as Map).cast<String, dynamic>();
  for (final entry in playLocales.entries) {
    final locale = entry.key;
    final listing = (entry.value as Map).cast<String, dynamic>();
    final source = (appleLocales[listing['sourceLocale']] as Map)
        .cast<String, dynamic>();
    final root = 'metadata/google-play/$locale';
    _writeText('$root/title.txt', listing['title'] as String);
    _writeText(
      '$root/short-description.txt',
      listing['shortDescription'] as String,
    );
    _writeText('$root/full-description.txt', source['description'] as String);
    _writeText('$root/release-notes-1.10.0.txt', source['whatsNew'] as String);
  }

  stdout.writeln(
    'Materialized ${appleLocales.length} App Store locales and '
    '${playLocales.length} Google Play locales.',
  );
}
