import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

const packageName = 'com.maskedsyntax.patterns';
const releaseVersion = '1.10.0';
const approvalToken = 'STORE_PACKAGE_APPROVED_1_10';
const stagedStatePath = 'release/1.10.0/google-play-staged-edit.json';
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
      final client = PlayClient(
        await _accessToken(),
        quotaProject: await _quotaProject(),
      );
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
      final client = PlayClient(
        await _accessToken(),
        quotaProject: await _quotaProject(),
      );
      await _apply(
        client,
        plan,
        stateFile: File(options['state'] ?? stagedStatePath),
        commit: options.containsKey('commit'),
      );
      return;
    case 'verify-staged':
      final stateFile = File(options['state'] ?? stagedStatePath);
      final state = _readJson(stateFile);
      final plan = await _buildPlan(repository, {
        'aab': '${_map(state['aab'])['path']}',
        'version-code': '${state['versionCode']}',
      });
      final client = PlayClient(
        await _accessToken(),
        quotaProject: await _quotaProject(),
      );
      final verification = await _verifyStaged(client, plan, state);
      state['lastVerifiedAt'] = DateTime.now().toUtc().toIso8601String();
      state['verification'] = verification;
      await _writeJson(stateFile, state);
      stdout.writeln(
        'Verified staged Google Play edit ${state['editId']}: '
        '11 listings, 88 phone screenshots, 11 feature graphics, and '
        'version code ${state['versionCode']}.',
      );
      return;
    case 'commit-staged':
      if (options['confirm'] != approvalToken) {
        stderr.writeln(
          'Refusing remote writes. Pass --confirm=$approvalToken only after '
          'the release owner approves the review matrix.',
        );
        exitCode = 64;
        return;
      }
      final stateFile = File(options['state'] ?? stagedStatePath);
      final state = _readJson(stateFile);
      final plan = await _buildPlan(repository, {
        'aab': '${_map(state['aab'])['path']}',
        'version-code': '${state['versionCode']}',
      });
      final client = PlayClient(
        await _accessToken(),
        quotaProject: await _quotaProject(),
      );
      await _commitStaged(client, plan, state, stateFile);
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
    final internalTrack = await client.getJson(
      '/applications/$packageName/edits/$editId/tracks/internal',
    );
    final listingAssets = <Map<String, dynamic>>[];
    for (final listing in _list(listings['listings']).map(_map)) {
      final locale = '${listing['language']}';
      final phoneImages = _list(
        (await client.getJson(
          '/applications/$packageName/edits/$editId/listings/$locale/'
          'phoneScreenshots',
        ))['images'],
      );
      final featureImages = _list(
        (await client.getJson(
          '/applications/$packageName/edits/$editId/listings/$locale/'
          'featureGraphic',
        ))['images'],
      );
      listingAssets.add({
        'language': locale,
        'phoneScreenshotCount': phoneImages.length,
        'featureGraphicCount': featureImages.length,
      });
    }
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
      'listingAssets': listingAssets,
      'internalTrack': internalTrack,
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
  required File stateFile,
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

    final stagedState = <String, dynamic>{
      'schemaVersion': 1,
      'packageName': packageName,
      'releaseVersion': releaseVersion,
      'editId': editId,
      'status': 'staged_validated',
      'stagedAt': DateTime.now().toUtc().toIso8601String(),
      'versionCode': uploadedCode,
      'aab': aab,
      'localeCount': listingPlans.length,
      'phoneScreenshotCount': _map(plan['assets'])['phoneScreenshotCount'],
      'featureGraphicCount': _map(plan['assets'])['featureGraphicCount'],
      'priceWritesMade': false,
      'purchaseOptionWritesMade': false,
    };
    await _writeJson(stateFile, stagedState);

    if (!commit) {
      keepEdit = true;
      stdout.writeln(
        'Validated Google Play edit $editId. It is staged but not committed; '
        'product localizations and published state are unchanged. Resume from '
        '${stateFile.path}.',
      );
      return;
    }
    keepEdit = true;
    await _commitStaged(client, plan, stagedState, stateFile);
    committed = true;
  } finally {
    if (!keepEdit && !committed) await client.deleteEdit(editId);
  }
}

Future<Map<String, dynamic>> _verifyStaged(
  PlayClient client,
  Map<String, dynamic> plan,
  Map<String, dynamic> state,
) async {
  if (state['status'] != 'staged_validated') {
    throw StateError(
      'Expected staged_validated state, found ${state['status']}.',
    );
  }
  final editId = state['editId'] as String;
  final listingPlans = _list(plan['listings']).map(_map).toList();
  final remoteListings = _list(
    (await client.getJson(
      '/applications/$packageName/edits/$editId/listings',
    ))['listings'],
  ).map(_map).toList();
  final byLanguage = {
    for (final listing in remoteListings) '${listing['language']}': listing,
  };
  final expectedLanguages = {
    for (final listing in listingPlans) '${listing['locale']}',
  };
  if (byLanguage.keys.toSet().difference(expectedLanguages).isNotEmpty ||
      expectedLanguages.difference(byLanguage.keys.toSet()).isNotEmpty) {
    throw StateError(
      'Staged listing locales do not match the approved 11-locale set.',
    );
  }

  var phoneScreenshotCount = 0;
  var featureGraphicCount = 0;
  for (final listing in listingPlans) {
    final locale = listing['locale'] as String;
    final remote = byLanguage[locale]!;
    final expectedFields = {
      'title': _readText(listing['titlePath'] as String),
      'shortDescription': _readText(listing['shortDescriptionPath'] as String),
      'fullDescription': _readText(listing['fullDescriptionPath'] as String),
    };
    for (final entry in expectedFields.entries) {
      if (remote[entry.key] != entry.value) {
        throw StateError('$locale ${entry.key} differs from approved copy.');
      }
    }
    final phoneImages = _list(
      (await client.getJson(
        '/applications/$packageName/edits/$editId/listings/$locale/'
        'phoneScreenshots',
      ))['images'],
    );
    final featureImages = _list(
      (await client.getJson(
        '/applications/$packageName/edits/$editId/listings/$locale/'
        'featureGraphic',
      ))['images'],
    );
    if (phoneImages.length != 8 || featureImages.length != 1) {
      throw StateError(
        '$locale has ${phoneImages.length} phone screenshots and '
        '${featureImages.length} feature graphics; expected 8 and 1.',
      );
    }
    phoneScreenshotCount += phoneImages.length;
    featureGraphicCount += featureImages.length;
  }

  final bundles = _list(
    (await client.getJson(
      '/applications/$packageName/edits/$editId/bundles',
    ))['bundles'],
  ).map(_map).toList();
  final expectedVersionCode = state['versionCode'];
  if (!bundles.any(
    (bundle) => '${bundle['versionCode']}' == '$expectedVersionCode',
  )) {
    throw StateError(
      'Version code $expectedVersionCode is absent from staged bundles.',
    );
  }
  final track = await client.getJson(
    '/applications/$packageName/edits/$editId/tracks/internal',
  );
  final releases = _list(track['releases']).map(_map).toList();
  if (!releases.any(
    (release) => _list(
      release['versionCodes'],
    ).any((code) => '$code' == '$expectedVersionCode'),
  )) {
    throw StateError(
      'Version code $expectedVersionCode is absent from the internal track.',
    );
  }
  await client.postJson(
    '/applications/$packageName/edits/$editId:validate',
    const {},
  );
  return {
    'localeCount': byLanguage.length,
    'phoneScreenshotCount': phoneScreenshotCount,
    'featureGraphicCount': featureGraphicCount,
    'bundleVersionCode': expectedVersionCode,
    'internalTrackStatus': 'verified',
  };
}

Future<void> _commitStaged(
  PlayClient client,
  Map<String, dynamic> plan,
  Map<String, dynamic> state,
  File stateFile,
) async {
  final status = '${state['status']}';
  if (status == 'committed') {
    stdout.writeln('Google Play edit ${state['editId']} is already committed.');
    return;
  }
  if (status == 'staged_validated') {
    state['verification'] = await _verifyStaged(client, plan, state);
    state['lastVerifiedAt'] = DateTime.now().toUtc().toIso8601String();
    await _writeJson(stateFile, state);
    await client.postJson(
      '/applications/$packageName/edits/${state['editId']}:commit',
      const {},
    );
    state['status'] = 'edit_committed_product_patch_pending';
    state['editCommittedAt'] = DateTime.now().toUtc().toIso8601String();
    state['patchedProductIds'] = <String>[];
    await _writeJson(stateFile, state);
  } else if (status != 'edit_committed_product_patch_pending') {
    throw StateError('Cannot resume Google Play state $status.');
  }

  final patched = <String>{
    for (final id in _list(state['patchedProductIds'])) '$id',
  };
  for (final productPlan in _list(plan['products']).map(_map)) {
    final productId = productPlan['productId'] as String;
    if (patched.contains(productId)) continue;
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
    patched.add(productId);
    state['patchedProductIds'] = patched.toList()..sort();
    await _writeJson(stateFile, state);
  }
  state['status'] = 'committed';
  state['completedAt'] = DateTime.now().toUtc().toIso8601String();
  state['productLocalizationCount'] = 44;
  await _writeJson(stateFile, state);
  stdout.writeln(
    'Committed Google Play 1.10 edit and patched four products with '
    'updateMask=listings. No pricing or purchase-option fields were sent.',
  );
}

class PlayClient {
  PlayClient(this.token, {this.quotaProject});

  final String token;
  final String? quotaProject;
  final http.Client _client = http.Client();

  Map<String, String> get _headers => {
    HttpHeaders.authorizationHeader: 'Bearer $token',
    HttpHeaders.acceptHeader: 'application/json',
    if (quotaProject != null) 'x-goog-user-project': quotaProject!,
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

Future<String?> _quotaProject() async {
  final environmentProject = Platform.environment['GOOGLE_CLOUD_QUOTA_PROJECT'];
  if (environmentProject != null && environmentProject.trim().isNotEmpty) {
    return environmentProject.trim();
  }
  final configDirectory =
      Platform.environment['CLOUDSDK_CONFIG'] ??
      '${Platform.environment['HOME']}/.config/gcloud';
  final adcFile = File('$configDirectory/application_default_credentials.json');
  if (await adcFile.exists()) {
    final quotaProject = _map(
      jsonDecode(await adcFile.readAsString()),
    )['quota_project_id'];
    if (quotaProject is String && quotaProject.trim().isNotEmpty) {
      return quotaProject.trim();
    }
  }
  try {
    final result = await Process.run('gcloud', [
      'config',
      'get-value',
      'project',
    ]);
    final project = '${result.stdout}'.trim();
    if (result.exitCode == 0 && project.isNotEmpty && project != '(unset)') {
      return project;
    }
  } on ProcessException {
    // A quota project is optional for service-account access.
  }
  return null;
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
