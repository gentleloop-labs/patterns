import 'dart:convert';
import 'dart:io';

const appleLocales = {
  'en-US',
  'en-GB',
  'en-CA',
  'en-AU',
  'pt-BR',
  'de-DE',
  'ja',
  'es-MX',
  'es-ES',
  'fr-FR',
  'fr-CA',
};
const playLocales = {
  'en-US',
  'en-GB',
  'en-CA',
  'en-AU',
  'pt-BR',
  'de-DE',
  'ja-JP',
  'es-419',
  'es-ES',
  'fr-FR',
  'fr-CA',
};
const appleLimits = {
  'name': 30,
  'subtitle': 30,
  'keywords': 100,
  'promotionalText': 170,
  'description': 4000,
  'whatsNew': 4000,
};
const playLimits = {
  'title': 30,
  'shortDescription': 80,
  'fullDescription': 4000,
  'releaseNotes': 500,
};

Never fail(String message) {
  stderr.writeln('Store package validation failed: $message');
  exit(1);
}

int length(Object? value) => (value as String? ?? '').runes.length;

Map<String, dynamic> readJson(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, dynamic>();

Map<String, Map<String, dynamic>> mapOfMaps(Object? value) =>
    (value as Map).map(
      (key, value) =>
          MapEntry(key as String, (value as Map).cast<String, dynamic>()),
    );

void requireLocales(
  Iterable<String> actual,
  Set<String> expected,
  String label,
) {
  final found = actual.toSet();
  final missing = expected.difference(found);
  final extra = found.difference(expected);
  if (missing.isNotEmpty || extra.isNotEmpty) {
    fail('$label locale mismatch; missing=$missing extra=$extra');
  }
}

String normalized(String value) => value
    .toLowerCase()
    .replaceAll(RegExp(r'[^\p{L}\p{N}]+', unicode: true), ' ')
    .trim();

void validateClaims(String label, String value) {
  if (value.contains('—')) fail('$label contains an em dash');
  final copy = normalized(value);
  const prohibited = {
    'clinician reviewed',
    'clinically reviewed',
    'native speaker reviewed',
    'native speaker review',
    'treats ocd',
    'diagnoses ocd',
    'relieves anxiety',
    'anxiety relief',
    'guaranteed results',
  };
  for (final phrase in prohibited) {
    if (copy.contains(phrase))
      fail('$label contains prohibited claim "$phrase"');
  }
}

void validateAppleMetadata() {
  final draft = readJson('release/1.10.0/store-metadata-drafts.json');
  final locales = mapOfMaps(draft['locales']);
  requireLocales(locales.keys, appleLocales, 'App Store metadata');
  final english = locales['en-US']!;
  const anchors = {
    'name': 'Patterns: OCD & ERP Journal',
    'subtitle': 'Track urges, anxiety, triggers',
    'keywords':
        'compulsion,intrusive,thoughts,obsession,exposure,rumination,reassurance,reflect,therapy,cbt,log,dbt',
  };
  for (final anchor in anchors.entries) {
    if (english[anchor.key] != anchor.value) {
      fail('en-US ${anchor.key} no longer matches the live ASO anchor');
    }
  }

  for (final entry in locales.entries) {
    final indexedCopy = normalized(
      '${entry.value['name']} ${entry.value['subtitle']}',
    );
    for (final limit in appleLimits.entries) {
      final count = length(entry.value[limit.key]);
      if (count == 0 || count > limit.value) {
        fail('${entry.key}.${limit.key} is $count/${limit.value} characters');
      }
      validateClaims(
        'App Store ${entry.key}.${limit.key}',
        entry.value[limit.key] as String,
      );
    }
    final rawKeywords = entry.value['keywords'] as String;
    if (rawKeywords.contains(', ')) {
      fail('${entry.key}.keywords contains spaces after commas');
    }
    final keywords = rawKeywords.split(',').map(normalized).toList();
    if (keywords.any((value) => value.isEmpty)) {
      fail('${entry.key}.keywords contains an empty keyword');
    }
    if (keywords.toSet().length != keywords.length) {
      fail('${entry.key}.keywords contains duplicates');
    }
    for (final keyword in keywords) {
      if (RegExp(
        '(^| )${RegExp.escape(keyword)}( |\$)',
      ).hasMatch(indexedCopy)) {
        fail('${entry.key}.keywords duplicates indexed term "$keyword"');
      }
    }

    final appInfo = readJson('metadata/app-info/${entry.key}.json');
    final version = readJson('metadata/version/1.10.0/${entry.key}.json');
    for (final field in const ['name', 'subtitle']) {
      if (appInfo[field] != entry.value[field]) {
        fail('materialized app-info ${entry.key}.$field differs from draft');
      }
    }
    for (final field in const [
      'description',
      'keywords',
      'promotionalText',
      'whatsNew',
    ]) {
      if (version[field] != entry.value[field]) {
        fail('materialized version ${entry.key}.$field differs from draft');
      }
    }
  }
}

void validatePlayMetadata() {
  final draft = readJson('release/1.10.0/google-play-metadata-drafts.json');
  final apple = mapOfMaps(
    readJson('release/1.10.0/store-metadata-drafts.json')['locales'],
  );
  final locales = mapOfMaps(draft['locales']);
  requireLocales(locales.keys, playLocales, 'Google Play metadata');
  for (final entry in locales.entries) {
    final root = 'metadata/google-play/${entry.key}';
    final sourceLocale = entry.value['sourceLocale'] as String;
    final expected = {
      'title': entry.value['title'] as String,
      'shortDescription': entry.value['shortDescription'] as String,
      'fullDescription': apple[sourceLocale]!['description'] as String,
      'releaseNotes': apple[sourceLocale]!['whatsNew'] as String,
    };
    final files = {
      'title': '$root/title.txt',
      'shortDescription': '$root/short-description.txt',
      'fullDescription': '$root/full-description.txt',
      'releaseNotes': '$root/release-notes-1.10.0.txt',
    };
    for (final limit in playLimits.entries) {
      final value = expected[limit.key]!;
      final count = value.runes.length;
      if (count == 0 || count > limit.value) {
        fail('${entry.key}.${limit.key} is $count/${limit.value} characters');
      }
      validateClaims('Google Play ${entry.key}.${limit.key}', value);
      if (File(files[limit.key]!).readAsStringSync().trim() != value.trim()) {
        fail('materialized Play ${entry.key}.${limit.key} differs from draft');
      }
    }
  }
}

void validateProducts({
  required String path,
  required Set<String> locales,
  required String nameField,
  required int nameLimit,
  required int descriptionLimit,
}) {
  final products = mapOfMaps(readJson(path)['products']);
  if (products.length != 4) fail('$path must contain exactly four products');
  for (final product in products.entries) {
    final localizations = mapOfMaps(product.value['localizations']);
    requireLocales(localizations.keys, locales, '${product.key} in $path');
    for (final localization in localizations.entries) {
      final nameCount = length(localization.value[nameField]);
      final descriptionCount = length(localization.value['description']);
      if (nameCount == 0 || nameCount > nameLimit) {
        fail(
          '${product.key}.${localization.key} $nameField is $nameCount/$nameLimit',
        );
      }
      if (descriptionCount == 0 || descriptionCount > descriptionLimit) {
        fail(
          '${product.key}.${localization.key} description is $descriptionCount/$descriptionLimit',
        );
      }
      validateClaims(
        '$path ${product.key}.${localization.key}',
        localization.value['description'] as String,
      );
      if (product.value['kind'] == 'tip') {
        final copy = localization.value['description'] as String;
        const phrases = [
          'Unlocks no features',
          'unlocks no features',
          'Não libera recursos',
          'Keine neuen Funktionen',
          'schaltet keine Funktionen frei',
          '機能は追加されません',
          'No desbloquea funciones',
          'Ne débloque aucune fonction',
          'ne débloque aucune fonction',
        ];
        if (!phrases.any(copy.contains)) {
          fail(
            '${product.key}.${localization.key} does not say the tip unlocks no features',
          );
        }
      }
    }
  }
}

void validateScreenshotManifest() {
  final manifest = readJson('release/1.10.0/screenshot-locale-manifest.json');
  final languages = (manifest['languageSets'] as List).cast<String>().toSet();
  const expectedLanguages = {'en', 'pt-BR', 'de', 'ja', 'es', 'fr'};
  if (languages.length != 6 ||
      languages.difference(expectedLanguages).isNotEmpty ||
      expectedLanguages.difference(languages).isNotEmpty) {
    fail('screenshot language sets are incomplete');
  }
  final storefronts = mapOfMaps(manifest['storefronts']);
  requireLocales(storefronts['apple']!.keys, appleLocales, 'Apple screenshots');
  requireLocales(storefronts['play']!.keys, playLocales, 'Play screenshots');
  for (final store in storefronts.values) {
    for (final language in store.values) {
      if (!languages.contains(language))
        fail('unknown screenshot language $language');
    }
  }
  final frames = (manifest['frames'] as List).cast<Map>();
  if (frames.length != 8) fail('expected eight screenshot frames');
  final copy = (manifest['copy'] as Map).cast<String, dynamic>();
  requireLocales(copy.keys, languages, 'screenshot copy');
  for (final language in languages) {
    final localizedFrames = (copy[language] as List).cast<Map>();
    if (localizedFrames.length != 8) {
      fail('$language must contain eight screenshot copy records');
    }
    for (var index = 0; index < localizedFrames.length; index += 1) {
      final alt = localizedFrames[index]['alt'] as String? ?? '';
      if (alt.isEmpty || alt.runes.length > 140) {
        fail(
          '$language screenshot ${index + 1} alt text is ${alt.runes.length}/140',
        );
      }
      for (final value in localizedFrames[index].values.whereType<String>()) {
        if (value.contains('—'))
          fail('$language screenshot ${index + 1} contains an em dash');
      }
    }
  }
  final uiCopy = readJson('release/1.10.0/screenshot-ui-copy.json');
  final translatedLanguages = languages.difference({'en'});
  for (final entry in uiCopy.entries) {
    final translations = (entry.value as Map).cast<String, dynamic>();
    requireLocales(
      translations.keys,
      translatedLanguages,
      'UI copy "${entry.key}"',
    );
    for (final translation in translations.entries) {
      if (length(translation.value) == 0) {
        fail('UI copy "${entry.key}" is empty for ${translation.key}');
      }
      validateClaims(
        'screenshot UI ${translation.key} "${entry.key}"',
        translation.value as String,
      );
    }
  }
}

void main() {
  validateAppleMetadata();
  validatePlayMetadata();
  validateProducts(
    path: 'release/1.10.0/apple-iap-localizations.json',
    locales: appleLocales,
    nameField: 'name',
    nameLimit: 30,
    descriptionLimit: 45,
  );
  validateProducts(
    path: 'release/1.10.0/google-play-product-localizations.json',
    locales: playLocales,
    nameField: 'title',
    nameLimit: 55,
    descriptionLimit: 200,
  );
  validateScreenshotManifest();
  stdout.writeln(
    'Store package passes locale parity, field limits, indexed-keyword, '
    'product-copy, materialization, and prohibited-claim validation.',
  );
}
