import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

const packageName = 'com.maskedsyntax.patterns';
const releaseVersion = '1.10.0';
const approvalToken = 'STORE_PACKAGE_APPROVED_1_10';
const apiRoot = 'https://androidpublisher.googleapis.com/androidpublisher/v3';
const uploadRoot =
    'https://androidpublisher.googleapis.com/upload/androidpublisher/v3';

final _jsonEncoder = JsonEncoder.withIndent('  ');

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.contains('--help')) {
    _usage();
    return;
  }

  final command = arguments.first;
  final options = _parseOptions(arguments.skip(1));
  final repository = Directory.current.absolute;

  switch (command) {
    case 'plan':
      final plan = await _buildPlan(repository, options);
      final output = File(
        options['output'] ?? 'release/1.10.0/google-play-sync-plan.json',
      );
      await _writeJson(output, plan);
      stdout.writeln(
        'Wrote a local-only Google Play plan for '
        '${(plan['listings'] as List).length} listings, '
        '${(plan['products'] as List).length} products, and '
        '${(plan['assets'] as Map)['phoneScreenshotCount']} screenshots to '
        '${output.path}.',
      );
      return;
    case 'inventory':
      final client = PlayClient(await _accessToken());
      final snapshot = await _inventory(client);
      final output = File(
        options['output'] ?? 'release/1.10.0/google-play-catalog-before.json',
      );
      await _writeJson(output, snapshot);
      stdout.writeln(
        'Saved the read-only Google Play catalogue snapshot to ${output.path}.',
      );
      return;
    case 'apply':
      if (options['confirm'] != approvalToken) {
        stderr.writeln(
          'Refusing remote writes. Pass --confirm=$approvalToken only after '
          'the release owner approves the review matrix.',
        );
        exitCode = 64;
        return;
      }
      final plan = await _buildPlan(repository, options);
      _requireApplyReady(plan, options);
      final client = PlayClient(await _accessToken());
      await _apply(client, plan, commit: options.containsKey('commit'));
      return;
    default:
      stderr.writeln('Unknown command: $command');
      _usage();
      exitCode = 64;
  }
}

void _usage() {
  stdout.writeln('''
Google Play 1.10 store synchronization

  dart run tool/google_play_store_sync.dart plan \\
    [--aab=build/app/outputs/bundle/release/app-release.aab] \\
    [--version-code=NN]

  dart run tool/google_play_store_sync.dart inventory \\
    [--output=release/1.10.0/google-play-catalog-before.json]

  dart run tool/google_play_store_sync.dart apply \\
    --confirm=$approvalToken --aab=/absolute/candidate.aab \\
    --version-code=NN [--commit]

`plan` is local-only and never authenticates. `inventory` performs read calls;
it creates and deletes a temporary edit solely to inspect build version codes
and listings. `apply` stages one edit containing the AAB, 11 listings, release
notes, 88 phone-screenshot slots, and 11 feature graphics. Without `--commit`
the validated edit is left staged and product records are not changed. With
`--commit`, the edit is committed and the four products are patched with the
field mask `listings` only. No command writes pricing or purchase options.

Authentication uses GOOGLE_PLAY_ACCESS_TOKEN first, then gcloud application
default credentials, then the active gcloud user token. Tokens are never
written to disk or printed.
''');
}

Map<String, String> _parseOptions(Iterable<String> arguments) {
  final result = <String, String>{};
  for (final argument in arguments) {
    if (!argument.startsWith('--')) {
      throw FormatException('Unexpected argument: $argument');
    }
    final value = argument.substring(2);
    final separator = value.indexOf('=');
    if (separator == -1) {
      result[value] = 'true';
    } else {
      result[value.substring(0, separator)] = value.substring(separator + 1);
    }
  }
  return result;
}

Future<Map<String, dynamic>> _buildPlan(
  Directory repository,
  Map<String, String> options,
) async {
  final releaseDirectory = Directory('${repository.path}/release/1.10.0');
  final metadata = _readJson(
    File('${releaseDirectory.path}/google-play-metadata-drafts.json'),
  );
  final productDrafts = _readJson(
    File('${releaseDirectory.path}/google-play-product-localizations.json'),
  );
  final screenshots = _readJson(
    File('${releaseDirectory.path}/screenshot-locale-manifest.json'),
  );

  final localeDrafts = _map(metadata['locales']);
  final storefronts = _map(_map(screenshots['storefronts'])['play']);
  final frames = _list(screenshots['frames']);
  final listings = <Map<String, dynamic>>[];
  var screenshotCount = 0;
  var featureCount = 0;

  for (final locale in localeDrafts.keys) {
    final languageSet = storefronts[locale] as String?;
    if (languageSet == null) {
      throw StateError('Missing screenshot language mapping for $locale.');
    }
    final metadataDirectory = 'metadata/google-play/$locale';
    final phoneScreenshots = <Map<String, dynamic>>[];
    for (final frame in frames) {
      final name = _map(frame)['file'] as String;
      final relative =
          'app-store/patterns-screenshots/exports/localized/play/'
          '$languageSet/$name.png';
      phoneScreenshots.add(await _asset(repository, relative));
      screenshotCount += 1;
    }
    final feature = await _asset(
      repository,
      'app-store/patterns-screenshots/exports/localized/feature/'
      '$languageSet/patterns-feature-graphic-1024x500.png',
    );
    featureCount += 1;
    listings.add({
      'locale': locale,
      'languageSet': languageSet,
      'titlePath': '$metadataDirectory/title.txt',
      'shortDescriptionPath': '$metadataDirectory/short-description.txt',
      'fullDescriptionPath': '$metadataDirectory/full-description.txt',
      'releaseNotesPath':
          '$metadataDirectory/release-notes-$releaseVersion.txt',
      'phoneScreenshots': phoneScreenshots,
      'featureGraphic': feature,
    });
  }

  final products = <Map<String, dynamic>>[];
  for (final entry in _map(productDrafts['products']).entries) {
    final product = _map(entry.value);
    final localizations = _map(product['localizations']);
    products.add({
      'productId': entry.key,
      'kind': product['kind'],
      'httpMethod': 'PATCH',
      'updateMask': 'listings',
      'listings': [
        for (final localization in localizations.entries)
          {
            'languageCode': localization.key,
            'title': _map(localization.value)['title'],
            'description': _map(localization.value)['description'],
          },
      ],
      'preservedFields': [
        'purchaseOptions',
        'regionalPricingAndAvailabilityConfigs',
        'taxAndComplianceSettings',
        'restrictedPaymentCountries',
        'offerTags',
      ],
    });
  }

  final aabRelative =
      options['aab'] ?? 'build/app/outputs/bundle/release/app-release.aab';
  final aabFile = File(aabRelative).absolute;
  final aabExists = await aabFile.exists();
  final requestedVersionCode = int.tryParse(options['version-code'] ?? '');

  return {
    'schemaVersion': 1,
    'mode': 'local_plan_no_remote_writes',
    'packageName': packageName,
    'releaseVersion': releaseVersion,
    'track': 'internal',
    'transaction': {
      'listingChangesUseSingleEdit': true,
      'editContains': [
        'signed AAB',
        '11 localized listings',
        '11 localized release notes',
        '88 phone screenshot slots',
        '11 feature graphics',
        'internal track assignment',
      ],
      'productPatchTiming': 'after successful edit commit',
      'productPatchUpdateMask': 'listings',
    },
    'aab': {
      'path': _relative(repository, aabFile),
      'exists': aabExists,
      if (aabExists && requestedVersionCode != null) ...{
        'bytes': await aabFile.length(),
        'sha256': await _sha256(aabFile),
      },
      'expectedVersionCode': requestedVersionCode,
      'candidateReady': aabExists && requestedVersionCode != null,
      if (requestedVersionCode == null)
        'notReadyReason':
            'Resolve the next unused version code through read-only inventory, '
            'then build the same-source signed AAB.',
    },
    'listings': listings,
    'products': products,
    'assets': {
      'uniqueLanguageSets': storefronts.values.toSet().length,
      'remoteLocaleCount': storefronts.length,
      'phoneScreenshotCount': screenshotCount,
      'featureGraphicCount': featureCount,
    },
    'safety': {
      'approvalRequired': true,
      'approvalToken': approvalToken,
      'priceWrites': false,
      'purchaseOptionWrites': false,
      'availabilityWrites': false,
      'taxWrites': false,
    },
  };
}

Future<Map<String, dynamic>> _asset(
  Directory repository,
  String relative,
) async {
  final file = File('${repository.path}/$relative');
  if (!await file.exists()) {
    throw StateError('Missing store asset: $relative');
  }
  return {
    'path': relative,
    'bytes': await file.length(),
    'sha256': await _sha256(file),
  };
}

void _requireApplyReady(
  Map<String, dynamic> plan,
  Map<String, String> options,
) {
  final aab = _map(plan['aab']);
  if (aab['exists'] != true) {
    throw StateError('The signed AAB does not exist: ${aab['path']}');
  }
  if (aab['expectedVersionCode'] == null) {
    throw StateError('Apply requires --version-code=NN.');
  }
  if (!options.containsKey('commit')) {
    stdout.writeln(
      'Staging mode: the edit will be validated but not committed. Product '
      'localizations will remain unchanged.',
    );
  }
}

Future<Map<String, dynamic>> _inventory(PlayClient client) async {
  final products = await client.listOneTimeProducts();
  String? editId;
  try {
    editId = await client.insertEdit();
    final listings = await client.getJson(
      '/applications/$packageName/edits/$editId/listings',
    );
    final bundles = await client.getJson(
      '/applications/$packageName/edits/$editId/bundles',
    );
    final apks = await client.getJson(
      '/applications/$packageName/edits/$editId/apks',
    );
    final versionCodes = <int>{};
    for (final source in [bundles['bundles'], apks['apks']]) {
      for (final item in _list(source)) {
        final code = int.tryParse('${_map(item)['versionCode']}');
        if (code != null) versionCodes.add(code);
      }
    }
    final sortedCodes = versionCodes.toList()..sort();
    return {
      'capturedAt': DateTime.now().toUtc().toIso8601String(),
      'readOnlyInspection': true,
      'temporaryEditDeleted': true,
      'packageName': packageName,
      'nextUnusedVersionCode': sortedCodes.isEmpty ? 1 : sortedCodes.last + 1,
      'existingVersionCodes': sortedCodes,
      'listings': listings['listings'] ?? const [],
      'oneTimeProducts': products,
      'priceWritesMade': false,
    };
  } finally {
    if (editId != null) await client.deleteEdit(editId);
  }
}

Future<void> _apply(
  PlayClient client,
  Map<String, dynamic> plan, {
  required bool commit,
}) async {
  final editId = await client.insertEdit();
  var keepEdit = false;
  var committed = false;
  try {
    final listingPlans = _list(plan['listings']).map(_map).toList();
    for (final listing in listingPlans) {
      final locale = listing['locale'] as String;
      final body = {
        'language': locale,
        'title': _readText(listing['titlePath'] as String),
        'shortDescription': _readText(
          listing['shortDescriptionPath'] as String,
        ),
        'fullDescription': _readText(listing['fullDescriptionPath'] as String),
      };
      await client.putJson(
        '/applications/$packageName/edits/$editId/listings/$locale',
        body,
      );
      await client.delete(
        '/applications/$packageName/edits/$editId/listings/$locale/'
        'phoneScreenshots',
      );
      for (final asset in _list(listing['phoneScreenshots']).map(_map)) {
        await client.upload(
          '/applications/$packageName/edits/$editId/listings/$locale/'
              'phoneScreenshots',
          File(asset['path'] as String),
          'image/png',
        );
      }
      await client.delete(
        '/applications/$packageName/edits/$editId/listings/$locale/'
        'featureGraphic',
      );
      final feature = _map(listing['featureGraphic']);
      await client.upload(
        '/applications/$packageName/edits/$editId/listings/$locale/'
            'featureGraphic',
        File(feature['path'] as String),
        'image/png',
      );
    }

    final aab = _map(plan['aab']);
    final uploadedBundle = await client.upload(
      '/applications/$packageName/edits/$editId/bundles',
      File(aab['path'] as String),
      'application/octet-stream',
    );
    final uploadedCode = int.tryParse('${uploadedBundle['versionCode']}');
    if (uploadedCode != aab['expectedVersionCode']) {
      throw StateError(
        'Uploaded AAB version code $uploadedCode does not match expected '
        '${aab['expectedVersionCode']}.',
      );
    }

    final releaseNotes = [
      for (final listing in listingPlans)
        {
          'language': listing['locale'],
          'text': _readText(listing['releaseNotesPath'] as String),
        },
    ];
    await client.putJson(
      '/applications/$packageName/edits/$editId/tracks/internal',
      {
        'track': 'internal',
        'releases': [
          {
            'name': releaseVersion,
            'versionCodes': ['$uploadedCode'],
            'status': 'completed',
            'releaseNotes': releaseNotes,
          },
        ],
      },
    );
    await client.postJson(
      '/applications/$packageName/edits/$editId:validate',
      const {},
    );

    if (!commit) {
      keepEdit = true;
      stdout.writeln(
        'Validated Google Play edit $editId. It is staged but not committed; '
        'product localizations and published state are unchanged.',
      );
      return;
    }

    await client.postJson(
      '/applications/$packageName/edits/$editId:commit',
      const {},
    );
    committed = true;
    for (final productPlan in _list(plan['products']).map(_map)) {
      final productId = productPlan['productId'] as String;
      final current = await client.getJson(
        '/applications/$packageName/oneTimeProducts/$productId',
      );
      final regionsVersion = _map(current['regionsVersion'])['version'];
      if (regionsVersion == null) {
        throw StateError('Missing regionsVersion for $productId.');
      }
      await client.patchJson(
        '/applications/$packageName/onetimeproducts/$productId',
        {
          'packageName': packageName,
          'productId': productId,
          'listings': productPlan['listings'],
        },
        query: {
          'updateMask': 'listings',
          'regionsVersion.version': '$regionsVersion',
        },
      );
    }
    stdout.writeln(
      'Committed Google Play 1.10 edit and patched four products with '
      'updateMask=listings. No pricing or purchase-option fields were sent.',
    );
  } finally {
    if (!keepEdit && !committed) await client.deleteEdit(editId);
  }
}

class PlayClient {
  PlayClient(this.token);

  final String token;
  final http.Client _client = http.Client();

  Map<String, String> get _headers => {
    HttpHeaders.authorizationHeader: 'Bearer $token',
    HttpHeaders.acceptHeader: 'application/json',
  };

  Future<String> insertEdit() async {
    final result = await postJson('/applications/$packageName/edits', const {});
    final id = result['id'] as String?;
    if (id == null || id.isEmpty) throw StateError('Edit response had no id.');
    return id;
  }

  Future<void> deleteEdit(String editId) async {
    await delete('/applications/$packageName/edits/$editId');
  }

  Future<List<dynamic>> listOneTimeProducts() async {
    final products = <dynamic>[];
    String? pageToken;
    do {
      final response = await getJson(
        '/applications/$packageName/oneTimeProducts',
        query: {
          'pageSize': '1000',
          if (pageToken != null) 'pageToken': pageToken,
        },
      );
      products.addAll(_list(response['oneTimeProducts']));
      pageToken = response['nextPageToken'] as String?;
    } while (pageToken != null && pageToken.isNotEmpty);
    return products;
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String>? query,
  }) => _send('GET', path, query: query);

  Future<Map<String, dynamic>> postJson(
    String path,
    Map<String, dynamic> body,
  ) => _send('POST', path, body: body);

  Future<Map<String, dynamic>> putJson(
    String path,
    Map<String, dynamic> body,
  ) => _send('PUT', path, body: body);

  Future<Map<String, dynamic>> patchJson(
    String path,
    Map<String, dynamic> body, {
    Map<String, String>? query,
  }) => _send('PATCH', path, body: body, query: query);

  Future<Map<String, dynamic>> delete(String path) => _send('DELETE', path);

  Future<Map<String, dynamic>> upload(
    String path,
    File file,
    String contentType,
  ) async {
    final uri = Uri.parse(
      '$uploadRoot$path',
    ).replace(queryParameters: const {'uploadType': 'media'});
    final response = await _client.post(
      uri,
      headers: {..._headers, HttpHeaders.contentTypeHeader: contentType},
      body: await file.readAsBytes(),
    );
    return _decode(response, 'POST', uri);
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? query,
  }) async {
    final uri = Uri.parse('$apiRoot$path').replace(queryParameters: query);
    final request = http.Request(method, uri)..headers.addAll(_headers);
    if (body != null) {
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.body = jsonEncode(body);
    }
    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);
    return _decode(response, method, uri);
  }

  Map<String, dynamic> _decode(http.Response response, String method, Uri uri) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      var message = response.body;
      try {
        final decoded = jsonDecode(response.body);
        message = '${_map(decoded)['error']}';
      } on FormatException {
        // Keep the non-JSON response body.
      }
      throw HttpException(
        '$method ${uri.path} failed with ${response.statusCode}: $message',
        uri: uri,
      );
    }
    if (response.body.trim().isEmpty) return <String, dynamic>{};
    return _map(jsonDecode(response.body));
  }
}

Future<String> _accessToken() async {
  final environmentToken = Platform.environment['GOOGLE_PLAY_ACCESS_TOKEN'];
  if (environmentToken != null && environmentToken.trim().isNotEmpty) {
    return environmentToken.trim();
  }
  for (final arguments in const [
    ['auth', 'application-default', 'print-access-token'],
    ['auth', 'print-access-token'],
  ]) {
    try {
      final result = await Process.run('gcloud', arguments);
      final token = '${result.stdout}'.trim();
      if (result.exitCode == 0 && token.isNotEmpty) return token;
    } on ProcessException {
      break;
    }
  }
  throw StateError(
    'No Google Play access token is available. Configure the least-privilege '
    'Publishing API identity outside this repository, then set '
    'GOOGLE_PLAY_ACCESS_TOKEN or authenticate gcloud.',
  );
}

Map<String, dynamic> _readJson(File file) {
  return _map(jsonDecode(file.readAsStringSync()));
}

String _readText(String path) => File(path).readAsStringSync().trim();

Map<String, dynamic> _map(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.cast<String, dynamic>();
  throw FormatException('Expected an object, got ${value.runtimeType}.');
}

List<dynamic> _list(dynamic value) {
  if (value == null) return const [];
  if (value is List) return value;
  throw FormatException('Expected a list, got ${value.runtimeType}.');
}

Future<String> _sha256(File file) async {
  return sha256.convert(await file.readAsBytes()).toString();
}

String _relative(Directory repository, File file) {
  final prefix = '${repository.path}/';
  return file.path.startsWith(prefix)
      ? file.path.substring(prefix.length)
      : file.path;
}

Future<void> _writeJson(File file, Map<String, dynamic> value) async {
  await file.parent.create(recursive: true);
  await file.writeAsString('${_jsonEncoder.convert(value)}\n');
}
