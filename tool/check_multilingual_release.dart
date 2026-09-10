import 'dart:convert';
import 'dart:io';

const requiredInAppLocales = {'en', 'pt-BR', 'de', 'ja', 'es', 'fr'};
const requiredAppStoreLocales = {
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
const requiredGooglePlayLocales = {
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
const requiredReviewPasses = {
  'copyFrozen',
  'contextAwareTranslation',
  'linguisticConsistencyAndBackTranslation',
  'clinicalCrisisPrivacyPaymentAccessibility',
  'placeholdersPluralsFormattingTerminology',
  'renderedMobileLayout',
};
const requiredIosDevicePasses = {
  'voiceOver',
  'maximumTextAndDisplayScale',
  'reducedMotion',
  'nonColour',
  'lightDarkPortraitLandscape',
  'purchasesAndRestore',
};
const requiredAndroidDevicePasses = {
  'talkBack',
  'maximumFontAndDisplayScale',
  'reducedMotion',
  'nonColour',
  'lightDarkPortraitLandscape',
  'purchasesAndRestore',
};

Never _fail(String message) {
  stderr.writeln('Multilingual release gate failed: $message');
  exit(1);
}

Map<String, dynamic> _map(dynamic value, String field) {
  if (value is Map<String, dynamic>) return value;
  _fail('$field is missing or is not an object');
}

Set<String> _stringSet(dynamic value, String field) {
  if (value is! List<dynamic> || value.any((item) => item is! String)) {
    _fail('$field is missing or is not a string list');
  }
  return value.cast<String>().toSet();
}

void _requireExactSet(Set<String> actual, Set<String> expected, String field) {
  if (actual.length != expected.length || !actual.containsAll(expected)) {
    _fail('$field does not match the 1.10 mobile contract');
  }
}

void _requireTrueFields(
  Map<String, dynamic> record,
  Set<String> fields,
  String prefix,
) {
  for (final field in fields) {
    if (record[field] != true) _fail('$prefix.$field is incomplete');
  }
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

  _requireExactSet(
    _stringSet(manifest['requiredInAppLocales'], 'requiredInAppLocales'),
    requiredInAppLocales,
    'requiredInAppLocales',
  );
  final storefrontLocales = _map(
    manifest['requiredStorefrontLocales'],
    'requiredStorefrontLocales',
  );
  _requireExactSet(
    _stringSet(
      storefrontLocales['appStore'],
      'requiredStorefrontLocales.appStore',
    ),
    requiredAppStoreLocales,
    'requiredStorefrontLocales.appStore',
  );
  _requireExactSet(
    _stringSet(
      storefrontLocales['googlePlay'],
      'requiredStorefrontLocales.googlePlay',
    ),
    requiredGooglePlayLocales,
    'requiredStorefrontLocales.googlePlay',
  );

  final reviews = _map(manifest['reviews'], 'reviews');
  for (final locale in requiredInAppLocales) {
    final review = _map(reviews[locale], 'reviews.$locale');
    if (review['reviewMethod'] != 'ai_assisted') {
      _fail('reviews.$locale.reviewMethod must truthfully be ai_assisted');
    }
    _requireTrueFields(
      _map(review['passes'], 'reviews.$locale.passes'),
      requiredReviewPasses,
      'reviews.$locale.passes',
    );
    if (review['identifiedRevisions'] is! List<dynamic>) {
      _fail('reviews.$locale.identifiedRevisions must be a list');
    }
    final unresolved = review['unresolvedRisks'];
    if (unresolved is! List<dynamic> || unresolved.isNotEmpty) {
      _fail('reviews.$locale has unresolved risks');
    }
    _requireTrueFields(
      _map(review['physicalDeviceQa'], 'reviews.$locale.physicalDeviceQa'),
      const {'ios', 'android'},
      'reviews.$locale.physicalDeviceQa',
    );
    if (review['releaseOwnerApproved'] != true) {
      _fail('reviews.$locale.releaseOwnerApproved is missing');
    }
  }

  final storefrontReviews = _map(
    manifest['storefrontReviews'],
    'storefrontReviews',
  );
  for (final store in const ['appStore', 'googlePlay']) {
    final records = _map(storefrontReviews[store], 'storefrontReviews.$store');
    final locales = store == 'appStore'
        ? requiredAppStoreLocales
        : requiredGooglePlayLocales;
    for (final locale in locales) {
      final record = _map(records[locale], 'storefrontReviews.$store.$locale');
      if (record['reviewMethod'] != 'ai_assisted') {
        _fail(
          'storefrontReviews.$store.$locale.reviewMethod is not ai_assisted',
        );
      }
      if (record['textReviewed'] != true ||
          record['iapCopyReviewed'] != true ||
          record['screenshotsReviewed'] != true ||
          record['releaseOwnerApproved'] != true) {
        _fail('storefrontReviews.$store.$locale is incomplete');
      }
      final unresolved = record['unresolvedRisks'];
      if (unresolved is! List<dynamic> || unresolved.isNotEmpty) {
        _fail('storefrontReviews.$store.$locale has unresolved risks');
      }
    }
  }

  final physicalDeviceQa = _map(
    manifest['physicalDeviceQa'],
    'physicalDeviceQa',
  );
  _requireTrueFields(
    _map(physicalDeviceQa['ios'], 'physicalDeviceQa.ios'),
    requiredIosDevicePasses,
    'physicalDeviceQa.ios',
  );
  _requireTrueFields(
    _map(physicalDeviceQa['android'], 'physicalDeviceQa.android'),
    requiredAndroidDevicePasses,
    'physicalDeviceQa.android',
  );
  if (manifest['releaseOwnerApproval'] != true) {
    _fail('release owner approval is missing');
  }

  stdout.writeln(
    'Multilingual release gate passed for Patterns 1.10.0 on iOS and Android.',
  );
}
