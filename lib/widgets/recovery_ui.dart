import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../theme/app_colors.dart';
import 'animations.dart';

/// Shared building blocks for the Pro "Recovery" tools (Response Prevention,
/// Urge Surfing, and later trackers). Extracted here so each tool screen
/// doesn't re-declare them.

BoxDecoration recoverySoftDecoration(ThemeData theme, {double radius = 22}) {
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor),
  );
}

class CircleBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const CircleBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = MaterialLocalizations.of(context).backButtonTooltip;
    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: PressScale(
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: recoverySoftDecoration(theme, radius: 14),
            child: const Icon(LineIcons.angleLeft, size: 20),
          ),
        ),
      ),
    );
  }
}

class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int minLines;

  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines + 2,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

/// A 0–[max] slider with a label and a live "n/max" readout.
class RatingSlider extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final int max;
  final String Function(int value)? valueFormatter;

  const RatingSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.max = 10,
    this.valueFormatter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final roundedValue = value.round();
    final formattedValue =
        valueFormatter?.call(roundedValue) ?? '$roundedValue/$max';
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 24;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: largeText
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedValue,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: context.appColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      formattedValue,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
        ),
        MergeSemantics(
          child: Semantics(
            label: label,
            value: formattedValue,
            child: Slider(
              value: value,
              min: 0,
              max: max.toDouble(),
              divisions: max,
              onChanged: onChanged,
              semanticFormatterCallback: (sliderValue) =>
                  valueFormatter?.call(sliderValue.round()) ??
                  '${sliderValue.round()}/$max',
            ),
          ),
        ),
      ],
    );
  }
}
