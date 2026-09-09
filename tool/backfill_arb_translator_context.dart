import 'dart:convert';
import 'dart:io';

String _label(String key) => key
    .replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (match) => '${match[1]} ${match[2]!.toLowerCase()}',
    )
    .replaceAll('_', ' ');

String _descriptionFor(String key) {
  final label = _label(key);
  if (key.startsWith('calm')) {
    return 'Calm Insights copy for $label. Keep it factual, neutral, and '
        'non-judgmental; do not imply a score, diagnosis, or treatment result.';
  }
  if (key.startsWith('completion') || key == 'doneForNowAction') {
    return 'Quiet completion copy for $label. Confirm only what was saved or '
        'recorded; do not praise, score, celebrate, or suggest another task.';
  }
  if (key.contains('Channel') ||
      key.startsWith('dailyReminder') ||
      key.startsWith('notification') ||
      key.endsWith('WindowCompleteTitle') ||
      key.endsWith('WindowCompleteBody') ||
      key.startsWith('updateAnnouncement')) {
    return 'Local notification or native notification-channel copy for '
        '$label. Keep it concise, gentle, and suitable outside the app.';
  }
  if (key.startsWith('export')) {
    return 'Manual export flow copy for $label. Preserve the distinction '
        'between local data and an unencrypted file the user chooses to save '
        'or share.';
  }
  if (key.startsWith('pdf')) {
    return 'Generated personal PDF report copy for $label. Preserve OCD, ERP, '
        'and Y-BOCS terminology, placeholders, and the non-diagnostic boundary.';
  }
  if (key.startsWith('severity')) {
    return 'Y-BOCS self-check severity-band label for $label. This is a '
        'standardized score description, not a diagnosis.';
  }
  if (key.startsWith('onboarding')) {
    return 'Onboarding copy for $label. Use warm, direct self-help language '
        'without reassurance, diagnosis, treatment claims, or pressure.';
  }
  if (key.startsWith('whatsNew') || key == 'continueToPatternsAction') {
    return 'Patterns 1.10 in-app announcement copy for $label. Mention only '
        'implemented behavior and preserve the local-data and review gates.';
  }
  if (key.startsWith('range')) {
    return 'Localized date-range label for $label in insights and exported '
        'reports.';
  }
  if (key.startsWith('nav')) {
    return 'Primary navigation label for the $label destination.';
  }
  if (key.startsWith('language') || key == 'systemDefault') {
    return 'Language-selection interface copy for $label. Language names '
        'themselves are shown in their native form elsewhere.';
  }
  if (key.startsWith('appearance')) {
    return 'Appearance-setting interface copy for $label.';
  }
  if (key.endsWith('Action') || key == 'cancelAction' || key == 'doneAction') {
    return 'Accessible action label for $label.';
  }
  return 'User-facing Patterns interface copy for $label.';
}

Map<String, dynamic> _read(File file) =>
    (jsonDecode(file.readAsStringSync()) as Map).cast<String, dynamic>();

void main() {
  final directory = Directory('lib/l10n');
  final englishFile = File('${directory.path}/app_en.arb');
  final english = _read(englishFile);

  for (final key in english.keys.toList()) {
    if (key.startsWith('@')) continue;
    final metadataKey = '@$key';
    final metadata = english[metadataKey] is Map
        ? (english[metadataKey] as Map).cast<String, dynamic>()
        : <String, dynamic>{};
    final description = metadata['description'];
    if (description is! String || description.trim().isEmpty) {
      metadata['description'] = _descriptionFor(key);
    }
    english[metadataKey] = metadata;
  }
  englishFile.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(english)}\n',
  );

  final translatedFiles = directory.listSync().whereType<File>().where(
    (file) => file.path.endsWith('.arb') && file.path != englishFile.path,
  );
  for (final file in translatedFiles) {
    final translated = _read(file);
    for (final entry in english.entries.where(
      (entry) => entry.key.startsWith('@') && entry.key != '@@locale',
    )) {
      if (translated.containsKey(entry.key)) continue;
      final sourceMetadata = (entry.value as Map).cast<String, dynamic>();
      final placeholders = sourceMetadata['placeholders'];
      translated[entry.key] = placeholders == null
          ? <String, dynamic>{}
          : <String, dynamic>{'placeholders': placeholders};
    }
    file.writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(translated)}\n',
    );
  }
}
