import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Unreviewed translations are available in debug/profile QA builds, but are
/// deliberately excluded from ordinary release builds. The release pipeline
/// must opt in only after the locale review manifest has passed.
const multilingualReleaseEnabled = bool.fromEnvironment(
  'PATTERNS_ENABLE_MULTILINGUAL',
  defaultValue: !kReleaseMode,
);

/// Languages that Patterns can render.
///
/// [system] delegates to the platform language list. The persisted values are
/// explicit rather than enum names so refactors cannot silently change the
/// preference wire format.
enum AppLanguage {
  system('system', null, 'System Default'),
  english('en', Locale('en'), 'English'),
  portugueseBrazil('pt-BR', Locale('pt', 'BR'), 'Português (Brasil)'),
  german('de', Locale('de'), 'Deutsch'),
  japanese('ja', Locale('ja'), '日本語'),
  spanish('es', Locale('es'), 'Español'),
  french('fr', Locale('fr'), 'Français');

  const AppLanguage(this.preferenceValue, this.localeOverride, this.nativeName);

  final String preferenceValue;
  final Locale? localeOverride;
  final String nativeName;

  static AppLanguage? fromPreference(String? value) {
    if (value == null) return null;
    for (final language in values) {
      if (language.preferenceValue == value) return language;
    }
    return null;
  }
}

const supportedAppLocales = <Locale>[
  Locale('en'),
  Locale('pt', 'BR'),
  Locale('de'),
  Locale('ja'),
  Locale('es'),
  Locale('fr'),
];

List<AppLanguage> availableAppLanguagesFor({
  required bool multilingualEnabled,
}) => multilingualEnabled
    ? AppLanguage.values
    : const [AppLanguage.system, AppLanguage.english];

List<AppLanguage> get availableAppLanguages =>
    availableAppLanguagesFor(multilingualEnabled: multilingualReleaseEnabled);

List<Locale> enabledAppLocalesFor({required bool multilingualEnabled}) =>
    multilingualEnabled ? supportedAppLocales : const [Locale('en')];

List<Locale> get enabledAppLocales =>
    enabledAppLocalesFor(multilingualEnabled: multilingualReleaseEnabled);

/// Resolves the platform locale list without mapping Portuguese from outside
/// Brazil to Brazilian Portuguese.
Locale resolveSystemLocale(
  List<Locale>? preferredLocales, {
  bool multilingualEnabled = multilingualReleaseEnabled,
}) {
  if (!multilingualEnabled) return const Locale('en');
  final locales = preferredLocales ?? const <Locale>[];

  for (final locale in locales) {
    final language = locale.languageCode.toLowerCase();
    final country = locale.countryCode?.toUpperCase();
    if (language == 'pt' && country == 'BR') {
      return const Locale('pt', 'BR');
    }
    if (language == 'en') return const Locale('en');
    if (language == 'de') return const Locale('de');
    if (language == 'ja') return const Locale('ja');
    if (language == 'es') return const Locale('es');
    if (language == 'fr') return const Locale('fr');
  }

  return const Locale('en');
}

Locale resolveEffectiveLocale(
  AppLanguage language,
  List<Locale>? preferredLocales, {
  bool multilingualEnabled = multilingualReleaseEnabled,
}) {
  if (!multilingualEnabled) return const Locale('en');
  return language.localeOverride ??
      resolveSystemLocale(
        preferredLocales,
        multilingualEnabled: multilingualEnabled,
      );
}

Locale? localeOverrideForBuild(
  AppLanguage language, {
  bool multilingualEnabled = multilingualReleaseEnabled,
}) {
  if (!multilingualEnabled) return const Locale('en');
  return language.localeOverride;
}
