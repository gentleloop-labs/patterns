import 'dart:convert';
import 'dart:io';

const requiredInAppLocales = {'en', 'pt-BR', 'de', 'ja', 'es', 'fr'};
const requiredStorefrontLocales = {
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
const requiredReviewFields = {
  'copyFrozen',
  'clinical',
  'privacy',
  'accessibility',
};

Never _fail(String message) {
  stderr.writeln('Multilingual release gate failed: $message');
  exit(1);
}

void main(List<String> args) {
  final path = args.isEmpty
      ? 'release/1.10.0/reviewed-locales.json'
      : args.single;
  final file = File(path);
  if (!file.existsSync()) _fail('missing reviewer manifest at $path');

  late final Map<String, dynamic> manifest;
  try {
    manifest = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  } on Object catch (error) {
    _fail('invalid JSON: $error');
  }

  final locales =
      (manifest['requiredInAppLocales'] as List<dynamic>? ?? const [])
          .cast<String>()
          .toSet();
  if (!locales.containsAll(requiredInAppLocales) ||
      locales.length != requiredInAppLocales.length) {
    _fail('in-app locale set does not match the 1.10 contract');
  }

  final storefronts =
      (manifest['requiredStorefrontLocales'] as List<dynamic>? ?? const [])
          .cast<String>()
          .toSet();
  if (!storefronts.containsAll(requiredStorefrontLocales) ||
      storefronts.length != requiredStorefrontLocales.length) {
    _fail('storefront locale set does not match the 1.10 contract');
  }

  final reviews = (manifest['reviews'] as Map<String, dynamic>? ?? const {});
  for (final locale in requiredInAppLocales) {
    final review = reviews[locale];
    if (review is! Map<String, dynamic>) _fail('$locale has no review record');
    for (final field in requiredReviewFields) {
      if (review[field] != true) _fail('$locale.$field is not signed off');
    }
  }

  final storefrontReviews =
      (manifest['storefrontReviews'] as Map<String, dynamic>? ?? const {});
  for (final locale in requiredStorefrontLocales) {
    if (storefrontReviews[locale] != true) {
      _fail('$locale storefront copy is not signed off');
    }
  }

  if (manifest['physicalIphoneAccessibilityVerified'] != true) {
    _fail('physical iPhone accessibility verification is incomplete');
  }
  if (manifest['approvedByReleaseOwner'] != true) {
    _fail('release owner approval is missing');
  }

  stdout.writeln('Multilingual release gate passed for Patterns 1.10.0.');
}
