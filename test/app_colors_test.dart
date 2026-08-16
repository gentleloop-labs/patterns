import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/theme/app_colors.dart';
import 'package:patterns/theme/app_theme.dart';

/// The token layer only helps if it renders exactly what the constants render.
/// While the app is dark-only, any drift between the two is a visual regression
/// that nothing else would catch, because half the call sites still read the
/// constants directly and half read the tokens.
void main() {
  group('mobile dark tokens match the constants they replace', () {
    const c = AppColors.dark;

    test('surfaces', () {
      expect(c.surface, AppTheme.deepCharcoal);
      expect(c.card, AppTheme.charcoalCard);
      expect(c.input, AppTheme.charcoalInput);
      expect(c.border, AppTheme.softBorder);
    });

    test('text', () {
      expect(c.textPrimary, AppTheme.textPrimary);
      expect(c.textSecondary, AppTheme.textSecondary);
    });

    test('accents and states', () {
      expect(c.accent, AppTheme.warmYellow);
      expect(c.positive, AppTheme.softGreen);
      expect(c.negative, AppTheme.mutedRed);
      expect(c.obsessionChip, AppTheme.obsessionChip);
      expect(c.compulsionChip, AppTheme.compulsionChip);
    });
  });

  group('desktop dark tokens match the desktop constants', () {
    const c = AppColors.desktopDark;

    test('surfaces and text', () {
      expect(c.surface, AppTheme.darkBg);
      expect(c.card, AppTheme.darkCard);
      expect(c.border, AppTheme.darkBorder);
      expect(c.textPrimary, AppTheme.darkTextPrimary);
      expect(c.textSecondary, AppTheme.darkTextSecondary);
    });

    test('accent is the brighter desktop yellow', () {
      expect(c.accent, AppTheme.primaryYellow);
    });
  });

  group('theme wiring', () {
    test('the mobile theme carries the mobile tokens', () {
      expect(
        AppTheme.mobileDarkTheme.extension<AppColors>(),
        AppColors.dark,
      );
    });

    test('the desktop theme carries the desktop tokens', () {
      expect(AppTheme.darkTheme.extension<AppColors>(), AppColors.desktopDark);
    });

    test('tokens agree with the ColorScheme the theme already exposes', () {
      // If these two ever disagree, a screen's look depends on which of the two
      // it happens to read from.
      final scheme = AppTheme.mobileDarkTheme.colorScheme;
      const tokens = AppColors.dark;

      expect(tokens.accent, scheme.primary);
      expect(tokens.positive, scheme.secondary);
      expect(tokens.negative, scheme.error);
      expect(tokens.card, scheme.surface);
      expect(tokens.textPrimary, scheme.onSurface);
      expect(tokens.border, scheme.outline);
      expect(tokens.surface, AppTheme.mobileDarkTheme.scaffoldBackgroundColor);
    });
  });

  group('context accessor', () {
    testWidgets('reads the tokens from the active theme', (tester) async {
      AppColors? seen;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.mobileDarkTheme,
          home: Builder(
            builder: (context) {
              seen = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(seen, AppColors.dark);
    });

    testWidgets('falls back to the dark palette when the extension is absent', (
      tester,
    ) async {
      AppColors? seen;
      await tester.pumpWidget(
        MaterialApp(
          // A bare theme, as a widget test might pump.
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              seen = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(seen, AppColors.dark);
    });
  });

  group('lerp', () {
    test('interpolates every channel, so a theme swap can animate', () {
      final mid = AppColors.dark.lerp(AppColors.desktopDark, 0.5);

      expect(mid.surface, Color.lerp(AppTheme.deepCharcoal, AppTheme.darkBg, 0.5));
      expect(mid.accent, Color.lerp(AppTheme.warmYellow, AppTheme.primaryYellow, 0.5));
    });

    test('returns itself when there is nothing to interpolate towards', () {
      expect(AppColors.dark.lerp(null, 0.5), AppColors.dark);
    });
  });
}
