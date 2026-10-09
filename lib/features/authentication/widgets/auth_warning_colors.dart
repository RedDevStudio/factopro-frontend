import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The app's [ColorScheme] has no dedicated "warning" role, so this exposes
/// a brightness-aware amber accent for the offline-login notice without
/// hardcoding a color that already has a home in [ColorScheme].
class AuthWarningColors {
  const AuthWarningColors._();

  static bool _isDark(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark;

  static Color of(BuildContext context) =>
      _isDark(context) ? const Color(0xFFF59E0B) : const Color(0xFFD97706);

  static Color containerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFF2B1D0E) : const Color(0xFFFFFBEB);

  static Color borderOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFF78350F) : const Color(0xFFFDE68A);

  static Color onContainerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFFFCD34D) : const Color(0xFFB45309);
}
