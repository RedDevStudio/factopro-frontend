import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Brightness-aware accents for the subscription screen.
///
/// [accentOf] is the navy brand accent in light mode and the vivid primary in
/// dark mode (the dark [ColorScheme.secondary] is indigo). The app's
/// [ColorScheme] has no "gold"/warning role, so the amber accents for the
/// recommended plan live here instead of being hardcoded in each widget.
class SubscriptionColors {
  const SubscriptionColors._();

  static bool _isDark(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark;

  static Color accentOf(BuildContext context) => _isDark(context)
      ? context.colorScheme.primary
      : context.colorScheme.secondary;

  static Color onAccentOf(BuildContext context) => _isDark(context)
      ? context.colorScheme.onPrimary
      : context.colorScheme.onSecondary;

  static Color goldOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFFF59E0B) : const Color(0xFFD97706);

  static Color goldContainerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFF78350F) : const Color(0xFFFEF3C7);

  static Color onGoldContainerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFFFDE68A) : const Color(0xFF92400E);
}
