import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String get effectiveLocaleName =>
      Localizations.localeOf(this).toLanguageTag();

  /// Formats a complete user-facing date without changing the ASCII ISO date
  /// used by storage and backups.
  String formatFullDate(DateTime date) =>
      DateFormat.yMMMMd(effectiveLocaleName).format(date);

  String formatFullDateWithWeekday(DateTime date) =>
      DateFormat.yMMMEd(effectiveLocaleName).format(date);

  String formatMonthDay(DateTime date) =>
      DateFormat.MMMd(effectiveLocaleName).format(date);

  String formatShortWeekday(DateTime date) =>
      DateFormat.E(effectiveLocaleName).format(date);

  String formatTime(DateTime date) =>
      DateFormat.jm(effectiveLocaleName).format(date);

  String formatMonthDayTime(DateTime date) =>
      DateFormat.MMMd(effectiveLocaleName).add_jm().format(date);

  String formatInteger(num value) =>
      NumberFormat.decimalPattern(effectiveLocaleName).format(value);

  String formatOneDecimal(num value) => NumberFormat.decimalPatternDigits(
    locale: effectiveLocaleName,
    decimalDigits: 1,
  ).format(value);

  String formatWholePercent(num value) =>
      NumberFormat.percentPattern(effectiveLocaleName).format(value / 100);
}
