import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

Never fail(String message) {
  stderr.writeln('Copy-freeze gate failed: $message');
  exit(1);
}

Map<String, dynamic> asMap(dynamic value, String field) {
  if (value is Map<String, dynamic>) return value;
  fail('$field is missing or is not an object');
}

void main(List<String> args) {
  final manifestPath = args.isEmpty
      ? 'release/1.10.0/source-freeze.json'
      : args.single;
  final manifestFile = File(manifestPath);
  if (!manifestFile.existsSync()) fail('missing manifest at $manifestPath');

  late final Map<String, dynamic> manifest;
  try {
    manifest =
        jsonDecode(manifestFile.readAsStringSync()) as Map<String, dynamic>;
  } on Object catch (error) {
    fail('invalid JSON: $error');
  }

  if (manifest['release'] != '1.10.0' || manifest['status'] != 'frozen') {
    fail('manifest is not a frozen Patterns 1.10.0 source');
  }
  final sourceCommit = manifest['sourceCommit'];
  if (sourceCommit is! String ||
      !RegExp(r'^[0-9a-f]{40}$').hasMatch(sourceCommit)) {
    fail('sourceCommit must be a full Git commit hash');
  }

  final artifacts = manifest['artifacts'];
  if (artifacts is! List<dynamic> || artifacts.isEmpty) {
    fail('artifacts must be a non-empty list');
  }
  for (var index = 0; index < artifacts.length; index++) {
    final artifact = asMap(artifacts[index], 'artifacts[$index]');
    final path = artifact['path'];
    final expectedHash = artifact['sha256'];
    if (path is! String || path.isEmpty)
      fail('artifacts[$index].path is invalid');
    if (expectedHash is! String ||
        !RegExp(r'^[0-9a-f]{64}$').hasMatch(expectedHash)) {
      fail('artifacts[$index].sha256 is invalid');
    }
    final file = File(path);
    if (!file.existsSync()) fail('frozen artifact is missing: $path');
    final actualHash = sha256.convert(file.readAsBytesSync()).toString();
    if (actualHash != expectedHash) {
      fail('$path changed after the English source freeze');
    }

    if (artifact['kind'] == 'canonical_flutter_arb') {
      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final actualCount = data.keys
          .where((key) => key != '@@locale' && !key.startsWith('@'))
          .length;
      if (artifact['messageCount'] != actualCount) {
        fail('$path message count changed after the English source freeze');
      }
    }
  }

  stdout.writeln(
    'Copy-freeze gate passed for ${artifacts.length} Patterns 1.10.0 source artifacts.',
  );
}
