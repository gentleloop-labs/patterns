import 'dart:convert';
import 'dart:io';

const requiredLocales = {
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

Never fail(String message) {
  stderr.writeln('Store draft validation failed: $message');
  exit(1);
}

int length(Object? value) => (value as String? ?? '').runes.length;

void main() {
  final metadata =
      jsonDecode(
            File(
              'release/1.10.0/store-metadata-drafts.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final locales = (metadata['locales'] as Map<String, dynamic>).map(
    (key, value) => MapEntry(key, (value as Map).cast<String, dynamic>()),
  );
  if (locales.keys.toSet().difference(requiredLocales).isNotEmpty ||
      requiredLocales.difference(locales.keys.toSet()).isNotEmpty) {
    fail('metadata locale set is incomplete');
  }
  const limits = {
    'name': 30,
    'subtitle': 30,
    'keywords': 100,
    'promotionalText': 170,
    'description': 4000,
    'whatsNew': 4000,
  };
  for (final entry in locales.entries) {
    for (final limit in limits.entries) {
      final count = length(entry.value[limit.key]);
      if (count == 0 || count > limit.value) {
        fail('${entry.key}.${limit.key} is $count/${limit.value} characters');
      }
    }
    final keywords = (entry.value['keywords'] as String)
        .split(',')
        .map((value) => value.trim().toLowerCase())
        .toList();
    if (keywords.toSet().length != keywords.length) {
      fail('${entry.key}.keywords contains duplicates');
    }
  }

  final iaps =
      jsonDecode(
            File(
              'release/1.10.0/iap-localization-drafts.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final products = iaps['products'] as Map<String, dynamic>;
  if (products.length != 4) fail('expected exactly four IAP products');
  for (final product in products.entries) {
    final data = (product.value as Map).cast<String, dynamic>();
    final translations = (data['localizations'] as Map<String, dynamic>);
    if (translations.keys.toSet().difference(requiredLocales).isNotEmpty ||
        requiredLocales.difference(translations.keys.toSet()).isNotEmpty) {
      fail('${product.key} locale set is incomplete');
    }
    for (final localization in translations.entries) {
      final copy = (localization.value as Map).cast<String, dynamic>();
      if (length(copy['name']) == 0 || length(copy['description']) == 0) {
        fail('${product.key}.${localization.key} contains an empty field');
      }
    }
  }
  stdout.writeln('Store drafts pass field, locale, and length validation.');
}
