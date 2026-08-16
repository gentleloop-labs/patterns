import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Semantic colour tokens, resolved from the active theme rather than read as
/// compile-time constants.
///
/// Why this exists: nearly every screen currently reads colours straight off
/// [AppTheme] as `static const` values, which means they cannot change with the
/// theme. That is fine while the app is dark-only, and it is the single reason a
/// light theme is a large job rather than a small one. Moving a call site from
/// `AppTheme.textSecondary` to `context.appColors.textSecondary` makes it
/// theme-aware without changing what it renders today.
///
/// The values here are deliberately identical to the existing constants, so
/// migrating a call site is a no-op visually. A light variant can then be added
/// in one place instead of ~700.
///
/// Two things to know when migrating a call site:
///  * A reference inside a `const` expression has to lose its `const`, since a
///    theme lookup is a runtime value.
///  * Top-level and static helpers need a `BuildContext` or `AppColors` passed
///    in; roughly a fifth of the current call sites are in helpers like that.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// Page background, behind everything else.
  final Color surface;

  /// Raised card and sheet fill.
  final Color card;

  /// Text field and other input fill.
  final Color input;

  /// Hairline borders and dividers.
  final Color border;

  /// Primary body text.
  final Color textPrimary;

  /// Supporting text, labels, and captions.
  final Color textSecondary;

  /// Accent used for emphasis and interactive affordances.
  final Color accent;

  /// Improvement, completion, and other good news.
  final Color positive;

  /// Setbacks, destructive actions, and errors.
  final Color negative;

  /// Obsession type chip on the Track list.
  final Color obsessionChip;

  /// Compulsion type chip on the Track list.
  final Color compulsionChip;

  const AppColors({
    required this.surface,
    required this.card,
    required this.input,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.positive,
    required this.negative,
    required this.obsessionChip,
    required this.compulsionChip,
  });

  /// The mobile dark palette, matching the existing [AppTheme] constants
  /// exactly. Changing a value here changes the app; that is the point, but it
  /// is also why these must stay in step with the constants until every call
  /// site has moved over.
  static const AppColors dark = AppColors(
    surface: AppTheme.deepCharcoal,
    card: AppTheme.charcoalCard,
    input: AppTheme.charcoalInput,
    border: AppTheme.softBorder,
    textPrimary: AppTheme.textPrimary,
    textSecondary: AppTheme.textSecondary,
    accent: AppTheme.warmYellow,
    positive: AppTheme.softGreen,
    negative: AppTheme.mutedRed,
    obsessionChip: AppTheme.obsessionChip,
    compulsionChip: AppTheme.compulsionChip,
  );

  /// The desktop dark palette, which uses its own greys and a brighter yellow.
  static const AppColors desktopDark = AppColors(
    surface: AppTheme.darkBg,
    card: AppTheme.darkCard,
    input: AppTheme.darkSurface,
    border: AppTheme.darkBorder,
    textPrimary: AppTheme.darkTextPrimary,
    textSecondary: AppTheme.darkTextSecondary,
    accent: AppTheme.primaryYellow,
    positive: AppTheme.softGreen,
    negative: AppTheme.mutedRed,
    obsessionChip: AppTheme.obsessionChip,
    compulsionChip: AppTheme.compulsionChip,
  );

  @override
  AppColors copyWith({
    Color? surface,
    Color? card,
    Color? input,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? positive,
    Color? negative,
    Color? obsessionChip,
    Color? compulsionChip,
  }) {
    return AppColors(
      surface: surface ?? this.surface,
      card: card ?? this.card,
      input: input ?? this.input,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
      obsessionChip: obsessionChip ?? this.obsessionChip,
      compulsionChip: compulsionChip ?? this.compulsionChip,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      input: Color.lerp(input, other.input, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      obsessionChip: Color.lerp(obsessionChip, other.obsessionChip, t)!,
      compulsionChip: Color.lerp(compulsionChip, other.compulsionChip, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  /// Semantic colours for the active theme.
  ///
  /// Falls back to the mobile dark palette if the extension is missing, so a
  /// widget pumped in a bare `MaterialApp` in a test cannot crash on a null.
  AppColors get appColors => Theme.of(this).appColors;
}

extension AppColorsTheme on ThemeData {
  /// Semantic colours, for the many helpers that already take a [ThemeData]
  /// rather than a [BuildContext]. Migrating those needs no signature change.
  AppColors get appColors => extension<AppColors>() ?? AppColors.dark;
}
