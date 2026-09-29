import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_warning_colors.dart';
import 'package:flutter/material.dart';

/// Resolves a [DashboardAccentColor] to its `(foreground, container)` colors
/// for the current theme brightness.
extension DashboardAccentColorResolver on DashboardAccentColor {
  (Color, Color) resolve(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return switch (this) {
      DashboardAccentColor.primary => (
        colorScheme.primary,
        colorScheme.primaryContainer,
      ),
      DashboardAccentColor.secondary => (
        colorScheme.secondary,
        colorScheme.secondaryContainer,
      ),
      DashboardAccentColor.tertiary => (
        colorScheme.tertiary,
        colorScheme.tertiaryContainer,
      ),
      DashboardAccentColor.warning => (
        DashboardWarningColors.of(context),
        DashboardWarningColors.containerOf(context),
      ),
      // The ColorScheme has no violet role, mirroring DashboardWarningColors.
      DashboardAccentColor.violet =>
        isDark
            ? (const Color(0xFFC084FC), const Color(0xFF3B0764))
            : (const Color(0xFF9333EA), const Color(0xFFF3E8FF)),
      DashboardAccentColor.neutral => (
        colorScheme.onSurfaceVariant,
        isDark ? colorScheme.outline : colorScheme.outlineVariant,
      ),
    };
  }
}
