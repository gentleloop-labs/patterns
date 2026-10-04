import 'dart:convert';
import 'dart:io';

Map<String, dynamic> readJson(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, dynamic>();

Map<String, Map<String, dynamic>> mapOfMaps(Object? value) =>
    (value as Map).map(
      (key, value) =>
          MapEntry(key as String, (value as Map).cast<String, dynamic>()),
    );

int count(Object? value) => (value as String? ?? '').runes.length;

String cell(Object? value) =>
    (value as String? ?? '').replaceAll('|', r'\|').replaceAll('\n', '<br>');

String html(Object? value) =>
    const HtmlEscape().convert(value?.toString() ?? '');

void main() {
  final apple = readJson('release/1.10.0/store-metadata-drafts.json');
  final appleLocales = mapOfMaps(apple['locales']);
  final play = readJson('release/1.10.0/google-play-metadata-drafts.json');
  final playLocales = mapOfMaps(play['locales']);
  final appleProducts = mapOfMaps(
    readJson('release/1.10.0/apple-iap-localizations.json')['products'],
  );
  final playProducts = mapOfMaps(
    readJson(
      'release/1.10.0/google-play-product-localizations.json',
    )['products'],
  );
  final shots = readJson('release/1.10.0/screenshot-locale-manifest.json');
  final storefronts = mapOfMaps(shots['storefronts']);
  final frames = (shots['frames'] as List).cast<Map>();
  final shotCopy = (shots['copy'] as Map).cast<String, dynamic>();

  final markdown = StringBuffer()
    ..writeln('# Patterns 1.10 store review matrix')
    ..writeln()
    ..writeln(
      'Status: **AI-assisted review ready, release-owner approval pending**',
    )
    ..writeln()
    ..writeln(
      'No metadata, product localization, or screenshot in this package has been uploaded. Build 61 is valid and in `Patterns Internal`. Physical accessibility and sandbox-purchase observations remain separate submission gates.',
    )
    ..writeln()
    ..writeln('## App Store metadata')
    ..writeln()
    ..writeln(
      '| Locale | Name | Subtitle | Keywords | Promo | Description | What’s New |',
    )
    ..writeln('| --- | --- | --- | --- | ---: | ---: | ---: |');
  for (final entry in appleLocales.entries) {
    final data = entry.value;
    markdown.writeln(
      '| ${entry.key} | ${cell(data['name'])} (${count(data['name'])}/30) '
      '| ${cell(data['subtitle'])} (${count(data['subtitle'])}/30) '
      '| ${cell(data['keywords'])} (${count(data['keywords'])}/100) '
      '| ${count(data['promotionalText'])}/170 '
      '| ${count(data['description'])}/4000 '
      '| ${count(data['whatsNew'])}/4000 |',
    );
  }
  markdown
    ..writeln()
    ..writeln(
      'Canonical full copy: `metadata/app-info/<locale>.json` and `metadata/version/1.10.0/<locale>.json`.',
    )
    ..writeln()
    ..writeln('## Google Play metadata')
    ..writeln()
    ..writeln(
      '| Locale | Title | Short description | Full description | Release notes |',
    )
    ..writeln('| --- | --- | --- | ---: | ---: |');
  for (final entry in playLocales.entries) {
    final source = appleLocales[entry.value['sourceLocale']]!;
    markdown.writeln(
      '| ${entry.key} | ${cell(entry.value['title'])} (${count(entry.value['title'])}/30) '
      '| ${cell(entry.value['shortDescription'])} (${count(entry.value['shortDescription'])}/80) '
      '| ${count(source['description'])}/4000 | ${count(source['whatsNew'])}/500 |',
    );
  }
  markdown
    ..writeln()
    ..writeln('Canonical full copy: `metadata/google-play/<locale>/`.')
    ..writeln()
    ..writeln('## Apple IAP localization')
    ..writeln()
    ..writeln('| Product | Locale | Name | Description | Version action |')
    ..writeln('| --- | --- | --- | --- | --- |');
  for (final product in appleProducts.entries) {
    final localizations = mapOfMaps(product.value['localizations']);
    for (final localization in localizations.entries) {
      markdown.writeln(
        '| `${product.key}` | ${localization.key} '
        '| ${cell(localization.value['name'])} (${count(localization.value['name'])}/30) '
        '| ${cell(localization.value['description'])} (${count(localization.value['description'])}/45) '
        '| ${product.value['versionAction']} |',
      );
    }
  }
  markdown
    ..writeln()
    ..writeln('## Google Play product localization')
    ..writeln()
    ..writeln('| Product | Locale | Title | Description | Update mask |')
    ..writeln('| --- | --- | --- | --- | --- |');
  for (final product in playProducts.entries) {
    final localizations = mapOfMaps(product.value['localizations']);
    for (final localization in localizations.entries) {
      markdown.writeln(
        '| `${product.key}` | ${localization.key} '
        '| ${cell(localization.value['title'])} (${count(localization.value['title'])}/55) '
        '| ${cell(localization.value['description'])} (${count(localization.value['description'])}/200) '
        '| `listings` |',
      );
    }
  }
  markdown
    ..writeln()
    ..writeln('## Screenshot mapping')
    ..writeln()
    ..writeln('| Store | Locale | Language asset set | Assets |')
    ..writeln('| --- | --- | --- | --- |');
  for (final store in storefronts.entries) {
    for (final locale in store.value.entries) {
      final assets = store.key == 'apple'
          ? '8 × 1290×2796 (`APP_IPHONE_67`)'
          : '8 × 1080×1920 + 1 × 1024×500 feature graphic';
      markdown.writeln(
        '| ${store.key} | ${locale.key} | ${locale.value} | $assets |',
      );
    }
  }
  markdown
    ..writeln()
    ..writeln('## Review status and unresolved gates')
    ..writeln()
    ..writeln(
      '- Copy review method: `ai_assisted`; never represented as native-speaker or clinician review.',
    )
    ..writeln(
      '- Automated limits, locale parity, prohibited claims, screenshot dimensions, alpha, and asset counts: passed.',
    )
    ..writeln(
      '- Apple PPP snapshot: unchanged across 12 configured/spot-check territories; no price write made.',
    )
    ..writeln(
      '- Google Play local plan and approval-gated sync tooling: ready; least-privilege API identity, read-only catalogue/price snapshot, version-code resolution, and signed AAB remain pending.',
    )
    ..writeln(
      '- Physical VoiceOver, TalkBack, sandbox purchase, tips, restore, and fix-affected import/export observations: not inferred from automation.',
    )
    ..writeln(
      '- Release-owner approval: pending. Remote store writes remain blocked until explicit approval.',
    );

  File('release/1.10.0/STORE-REVIEW-MATRIX.md')
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(markdown.toString());

  final htmlBuffer = StringBuffer()
    ..writeln(
      '<!doctype html><meta charset="utf-8"><title>Patterns 1.10 store copy review</title>',
    )
    ..writeln(
      '<style>body{max-width:1100px;margin:40px auto;padding:0 24px;background:#0d0d0c;color:#f3efe5;font:16px/1.55 -apple-system,BlinkMacSystemFont,sans-serif}h1,h2{color:#f4c95d}details{margin:18px 0;padding:18px;border:1px solid #403922;border-radius:14px;background:#171610}summary{cursor:pointer;font-weight:800}dt{margin-top:14px;color:#f4c95d;font-weight:700}dd{margin:4px 0;white-space:pre-wrap}.count{color:#aaa}code{color:#f7d97e}</style>',
    )
    ..writeln(
      '<h1>Patterns 1.10 complete store copy</h1><p>AI-assisted draft. No remote upload is authorized until release-owner approval.</p>',
    )
    ..writeln('<h2>App Store</h2>');
  for (final entry in appleLocales.entries) {
    htmlBuffer.writeln(
      '<details><summary>${html(entry.key)}: ${html(entry.value['name'])}</summary>',
    );
    for (final field in const [
      'name',
      'subtitle',
      'keywords',
      'promotionalText',
      'description',
      'whatsNew',
    ]) {
      htmlBuffer.writeln(
        '<dl><dt>${html(field)} <span class="count">${count(entry.value[field])}</span></dt><dd>${html(entry.value[field])}</dd></dl>',
      );
    }
    htmlBuffer.writeln('</details>');
  }
  htmlBuffer.writeln('<h2>Google Play</h2>');
  for (final entry in playLocales.entries) {
    final source = appleLocales[entry.value['sourceLocale']]!;
    htmlBuffer.writeln(
      '<details><summary>${html(entry.key)}: ${html(entry.value['title'])}</summary>',
    );
    htmlBuffer.writeln(
      '<dl><dt>shortDescription <span class="count">${count(entry.value['shortDescription'])}</span></dt><dd>${html(entry.value['shortDescription'])}</dd>',
    );
    htmlBuffer.writeln(
      '<dt>fullDescription <span class="count">${count(source['description'])}</span></dt><dd>${html(source['description'])}</dd>',
    );
    htmlBuffer.writeln(
      '<dt>releaseNotes <span class="count">${count(source['whatsNew'])}</span></dt><dd>${html(source['whatsNew'])}</dd></dl></details>',
    );
  }
  htmlBuffer.writeln('<h2>Screenshot alt text</h2>');
  for (final language in (shots['languageSets'] as List).cast<String>()) {
    htmlBuffer.writeln('<details><summary>${html(language)}</summary><ol>');
    final localized = (shotCopy[language] as List).cast<Map>();
    for (var index = 0; index < frames.length; index += 1) {
      htmlBuffer.writeln(
        '<li><code>${html(frames[index]['file'])}</code>: ${html(localized[index]['alt'])}</li>',
      );
    }
    htmlBuffer.writeln('</ol></details>');
  }
  final reviewRoot = Directory('.asc/metadata/1.10.0-review')
    ..createSync(recursive: true);
  File(
    '${reviewRoot.path}/complete-copy.html',
  ).writeAsStringSync(htmlBuffer.toString());
  File('${reviewRoot.path}/apple-plan.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert({'status': 'approval_required', 'appId': '6762611172', 'version': '1.10.0', 'buildNumber': '61', 'releaseType': 'MANUAL', 'locales': appleLocales.keys.toList(), 'screenshotsPerLocale': 8, 'displayType': 'APP_IPHONE_67', 'remoteWritesAuthorized': false})}\n',
  );
  File('${reviewRoot.path}/play-plan.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert({'status': 'approval_and_api_identity_required', 'packageName': 'com.maskedsyntax.patterns', 'versionName': '1.10.0', 'locales': playLocales.keys.toList(), 'screenshotsPerLocale': 8, 'featureGraphicsPerLocale': 1, 'transactionalEdit': true, 'productUpdateMask': 'listings', 'remoteWritesAuthorized': false})}\n',
  );
  stdout.writeln(
    'Generated the 1.10 store approval matrix and dedicated Apple/Play review artifacts.',
  );
}
