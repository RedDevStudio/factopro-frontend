import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:flutter/material.dart';

/// The app's [ColorScheme] has no dedicated "warning" role, so this exposes
/// a brightness-aware amber accent for stock/critical notification states
/// without hardcoding a color that already has a home in [ColorScheme].
class NotificationWarningColors {
  const NotificationWarningColors._();

  static bool _isDark(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark;

  static Color of(BuildContext context) =>
      _isDark(context) ? const Color(0xFFF59E0B) : const Color(0xFFD97706);

  static Color containerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFF78350F) : const Color(0xFFFEF3C7);

  static Color onContainerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFFFDE68A) : const Color(0xFF92400E);
}

/// Resolves the (accent, container, onContainer) color triple for a
/// [NotificationTone], shared by icon boxes, tags, dots and buttons.
(Color accent, Color container, Color onContainer) notificationToneColors(
  BuildContext context,
  NotificationTone tone,
) {
  final colorScheme = context.colorScheme;

  return switch (tone) {
    NotificationTone.success => (
      colorScheme.tertiary,
      colorScheme.tertiaryContainer,
      colorScheme.onTertiaryContainer,
    ),
    NotificationTone.danger => (
      colorScheme.error,
      colorScheme.errorContainer,
      colorScheme.onErrorContainer,
    ),
    NotificationTone.warning => (
      NotificationWarningColors.of(context),
      NotificationWarningColors.containerOf(context),
      NotificationWarningColors.onContainerOf(context),
    ),
    NotificationTone.info => (
      colorScheme.primary,
      colorScheme.primaryContainer,
      colorScheme.onPrimaryContainer,
    ),
  };
}

/// Navy in light mode, vivid blue in dark mode — used for selected chips,
/// default filled buttons and the default unread dot.
Color notificationBrandColor(BuildContext context) {
  final colorScheme = context.colorScheme;
  return colorScheme.brightness == Brightness.dark ? colorScheme.primary : colorScheme.secondary;
}
