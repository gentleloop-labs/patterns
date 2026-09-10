import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/l10n/app_localizations.dart';
import 'package:patterns/services/tip_jar.dart';

void main() {
  test('tip product IDs remain stable', () {
    expect(
      [
        TipJarService.productIdSmall,
        TipJarService.productIdMedium,
        TipJarService.productIdLarge,
      ],
      [
        'com.maskedsyntax.patterns.tip.small',
        'com.maskedsyntax.patterns.tip.medium',
        'com.maskedsyntax.patterns.tip.large',
      ],
    );
  });

  test('every locale explains that each tip unlocks no features', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final strings = lookupAppLocalizations(locale);
      final names = [
        strings.tipSmallTitle,
        strings.tipMediumTitle,
        strings.tipLargeTitle,
      ];
      final descriptions = [
        strings.tipSmallDescription,
        strings.tipMediumDescription,
        strings.tipLargeDescription,
      ];
      expect(names.every((value) => value.trim().isNotEmpty), isTrue);
      expect(descriptions.every((value) => value.trim().isNotEmpty), isTrue);
      expect(strings.tipJarBody.trim(), isNotEmpty);
      for (final productId in [
        TipJarService.productIdSmall,
        TipJarService.productIdMedium,
        TipJarService.productIdLarge,
      ]) {
        final copy = TipJarService.localizedCopy(strings, productId);
        expect(copy.title.trim(), isNotEmpty);
        expect(copy.description.trim(), isNotEmpty);
      }
    }
  });
}
