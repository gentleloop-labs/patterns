import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

const packageName = 'com.maskedsyntax.patterns';
const apiRoot = 'https://androidpublisher.googleapis.com/androidpublisher/v3';
const uploadRoot =
    'https://androidpublisher.googleapis.com/upload/androidpublisher/v3';
const defaultAab = 'build/app/outputs/bundle/release/app-release.aab';

/// Ships a signed AAB with release notes to one Google Play track.
///
/// Unlike `google_play_store_sync.dart` (the one-off 1.10 store package),
/// this touches only the bundle and the track's release notes: listings,
/// screenshots, products, and prices are never sent.
Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.contains('--help')) {
    _usage();
    return;
  }
  final command = arguments.first;
  final options = _options(arguments.skip(1));
  final version = options['version'];
  final versionCode = int.tryParse(options['version-code'] ?? '');
  if (version == null || versionCode == null) {
    _usage();
    exitCode = 64;
    return;
  }
  final track = options['track'] ?? 'production';
  final aab = File(options['aab'] ?? defaultAab).absolute;
  final notes = _releaseNotes(version);

  stdout.writeln('Package:       $packageName');
  stdout.writeln('Release:       $version ($versionCode) -> $track');
  stdout.writeln('Release notes: ${notes.length} languages');
  if (!await aab.exists()) {
    throw StateError('The signed AAB does not exist: ${aab.path}');
  }
  stdout.writeln(
    'AAB:           ${aab.path} (${await aab.length()} bytes, '
    'sha256 ${sha256.convert(await aab.readAsBytes())})',
  );

  final client = PlayClient(await _accessToken(), await _quotaProject());
  final editId = await client.insertEdit();
  var committed = false;
  try {
    final highest = await _highestTrackedVersionCode(client, editId);
    stdout.writeln('Highest version code on any track: $highest');
    if (versionCode <= highest) {
      throw StateError(
        'Version code $versionCode must be higher than $highest.',
      );
    }

    if (command == 'check') {
      stdout.writeln('Check passed. Nothing was uploaded or changed.');
      return;
    }
    if (command != 'publish' || options['confirm'] != 'true') {
      throw StateError('Run `publish --confirm` to upload and release.');
    }

    final bundle = await client.upload(
      '/applications/$packageName/edits/$editId/bundles',
      aab,
    );
    if (bundle['versionCode'] != versionCode) {
      throw StateError(
        'Uploaded bundle has version code ${bundle['versionCode']}, '
        'expected $versionCode.',
      );
    }
    await client.send(
      'PUT',
      '/applications/$packageName/edits/$editId/tracks/$track',
      body: {
        'track': track,
        'releases': [
          {
            'name': '$version ($versionCode)',
            'versionCodes': ['$versionCode'],
            'status': 'completed',
            'releaseNotes': [
              for (final entry in notes.entries)
                {'language': entry.key, 'text': entry.value},
            ],
          },
        ],
      },
    );
    await client.send(
      'POST',
      '/applications/$packageName/edits/$editId:validate',
    );
    await client.send(
      'POST',
      '/applications/$packageName/edits/$editId:commit',
    );
    committed = true;
    stdout.writeln(
      'Committed edit $editId: $version ($versionCode) on $track. With '
      'managed publishing on, publish the change in Play Console.',
    );
  } finally {
    if (!committed) {
      await client.send('DELETE', '/applications/$packageName/edits/$editId');
    }
  }
}

void _usage() {
  stdout.writeln('''
Google Play release (bundle and release notes only)

  dart run tool/google_play_release.dart check \\
    --version=1.10.1 --version-code=62 [--aab=$defaultAab] [--track=production]

  dart run tool/google_play_release.dart publish --confirm \\
    --version=1.10.1 --version-code=62 [--aab=...] [--track=production]

Release notes come from metadata/google-play/<language>/release-notes-<version>.txt.
`check` only reads: it opens and discards an edit to compare version codes.
Authentication uses GOOGLE_PLAY_ACCESS_TOKEN, then gcloud credentials.
''');
}

Map<String, String> _options(Iterable<String> arguments) {
  final options = <String, String>{};
  for (final argument in arguments) {
    if (!argument.startsWith('--')) continue;
    final separator = argument.indexOf('=');
    if (separator == -1) {
      options[argument.substring(2)] = 'true';
    } else {
      options[argument.substring(2, separator)] = argument.substring(
        separator + 1,
      );
    }
  }
  return options;
}

Map<String, String> _releaseNotes(String version) {
  final notes = <String, String>{};
  final languages =
      Directory(
          'metadata/google-play',
        ).listSync().whereType<Directory>().toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final directory in languages) {
    final file = File('${directory.path}/release-notes-$version.txt');
    if (!file.existsSync()) {
      throw StateError('Missing release notes: ${file.path}');
    }
    final text = file.readAsStringSync().trim();
    if (text.isEmpty || text.length > 500) {
      throw StateError('${file.path} must be 1 to 500 characters.');
    }
    notes[directory.uri.pathSegments.lastWhere((s) => s.isNotEmpty)] = text;
  }
  if (notes.isEmpty) throw StateError('No Google Play release notes found.');
  return notes;
}

Future<int> _highestTrackedVersionCode(PlayClient client, String editId) async {
  final response = await client.send(
    'GET',
    '/applications/$packageName/edits/$editId/tracks',
  );
  var highest = 0;
  for (final track in (response['tracks'] as List? ?? const [])) {
    for (final release in ((track as Map)['releases'] as List? ?? const [])) {
      for (final code
          in ((release as Map)['versionCodes'] as List? ?? const [])) {
        final value = int.tryParse('$code') ?? 0;
        if (value > highest) highest = value;
      }
    }
  }
  return highest;
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
    'No Google Play access token is available. Set GOOGLE_PLAY_ACCESS_TOKEN '
    'or authenticate gcloud.',
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
    final quotaProject =
        (jsonDecode(await adcFile.readAsString()) as Map)['quota_project_id'];
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

class PlayClient {
  PlayClient(this.token, this.quotaProject);

  final String token;
  final String? quotaProject;
  final http.Client _client = http.Client();

  Map<String, String> get _headers => {
    HttpHeaders.authorizationHeader: 'Bearer $token',
    HttpHeaders.acceptHeader: 'application/json',
    if (quotaProject != null) 'x-goog-user-project': quotaProject!,
  };

  Future<String> insertEdit() async {
    final result = await send(
      'POST',
      '/applications/$packageName/edits',
      body: const {},
    );
    final id = result['id'] as String?;
    if (id == null || id.isEmpty) throw StateError('Edit response had no id.');
    return id;
  }

  Future<Map<String, dynamic>> upload(String path, File file) async {
    final uri = Uri.parse(
      '$uploadRoot$path',
    ).replace(queryParameters: const {'uploadType': 'media'});
    final response = await _client.post(
      uri,
      headers: {
        ..._headers,
        HttpHeaders.contentTypeHeader: 'application/octet-stream',
      },
      body: await file.readAsBytes(),
    );
    return _decode(response, 'POST', uri);
  }

  Future<Map<String, dynamic>> send(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$apiRoot$path');
    final request = http.Request(method, uri)..headers.addAll(_headers);
    if (body != null) {
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.body = jsonEncode(body);
    }
    final response = await http.Response.fromStream(
      await _client.send(request),
    );
    return _decode(response, method, uri);
  }

  Map<String, dynamic> _decode(http.Response response, String method, Uri uri) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        '$method ${uri.path} failed with ${response.statusCode}: '
        '${response.body}',
        uri: uri,
      );
    }
    if (response.body.trim().isEmpty) return <String, dynamic>{};
    return (jsonDecode(response.body) as Map).cast<String, dynamic>();
  }
}
