import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/mobile/screens/journal_screen.dart';
import 'package:patterns/theme/app_colors.dart';
import 'package:patterns/theme/app_theme.dart';

void main() {
  test('next-step card keeps its dark gradient in dark mode', () {
    expect(nextStepCardGradientColors(AppTheme.mobileDarkTheme), const [
      Color(0xFF23200F),
      Color(0xFF15140F),
    ]);
  });

  test('next-step card uses warm light surfaces in light mode', () {
    final gradient = nextStepCardGradientColors(AppTheme.mobileLightTheme);

    expect(gradient.last, AppColors.light.card);
    expect(gradient.first, isNot(const Color(0xFF23200F)));
    expect(gradient.every((color) => color.computeLuminance() > 0.8), isTrue);
  });
}
