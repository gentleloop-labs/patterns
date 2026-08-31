import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns/mobile/screens/analytics_screen.dart';
import 'package:patterns/theme/app_colors.dart';
import 'package:patterns/theme/app_theme.dart';

void main() {
  test('selected Insights tab uses the light theme accent treatment', () {
    final colors = insightSegmentColors(
      AppTheme.mobileLightTheme,
      selected: true,
    );

    expect(colors.background, AppColors.light.accent);
    expect(colors.foreground, Colors.white);
    expect(
      _contrast(colors.foreground, colors.background),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('unselected Insights tabs remain quiet in light mode', () {
    final colors = insightSegmentColors(
      AppTheme.mobileLightTheme,
      selected: false,
    );

    expect(colors.background, Colors.transparent);
    expect(colors.foreground, AppColors.light.textSecondary);
  });

  test('selected Insights tab keeps its existing dark treatment', () {
    final colors = insightSegmentColors(
      AppTheme.mobileDarkTheme,
      selected: true,
    );

    expect(colors.background, const Color(0xFF27251C));
    expect(colors.foreground, AppColors.dark.accent);
  });
}

double _contrast(Color foreground, Color background) {
  final foregroundLuminance = foreground.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}
