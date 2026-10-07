import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Per-page accent of the onboarding flow. Each page tints its logo, hero
/// icon, halo, page indicator and primary button with its accent.
enum OnboardingAccent {
  /// Navy in light mode, vivid blue in dark mode (invoice and AI pages).
  brand,

  /// Success green (inventory page).
  success,

  /// Navy in light mode, indigo in dark mode (credit ledger page).
  ledger,
}

/// Semantic tone of small onboarding details (badge icons, info rows).
enum OnboardingTone { accent, success, warning, info, neutral }

/// Brightness-aware colors of the onboarding screens.
///
/// Accents resolve to [ColorScheme] roles; the app's [ColorScheme] has no
/// "warning" role, so the amber used by the speed badge and the expiry alert
/// lives here instead of being hardcoded in each widget.
class OnboardingColors {
  const OnboardingColors._();

  static bool _isDark(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark;

  static Color accentOf(BuildContext context, OnboardingAccent accent) {
    final colorScheme = context.colorScheme;
    return switch (accent) {
      OnboardingAccent.brand =>
        _isDark(context) ? colorScheme.primary : colorScheme.secondary,
      OnboardingAccent.success => colorScheme.tertiary,
      OnboardingAccent.ledger => colorScheme.secondary,
    };
  }

  static Color onAccentOf(BuildContext context, OnboardingAccent accent) {
    final colorScheme = context.colorScheme;
    return switch (accent) {
      OnboardingAccent.brand =>
        _isDark(context) ? colorScheme.onPrimary : colorScheme.onSecondary,
      OnboardingAccent.success => colorScheme.onTertiary,
      OnboardingAccent.ledger => colorScheme.onSecondary,
    };
  }

  /// Fill of the hero icon tile inside the feature card. The brand tile is a
  /// navy-to-blue (light) or blue-to-indigo (dark) gradient.
  static Gradient heroGradientOf(
    BuildContext context,
    OnboardingAccent accent,
  ) {
    final colorScheme = context.colorScheme;
    final start = accentOf(context, accent);
    final end = switch (accent) {
      OnboardingAccent.brand =>
        _isDark(context) ? colorScheme.secondary : colorScheme.primary,
      _ => Color.lerp(start, colorScheme.onPrimary, 0.12)!,
    };
    return LinearGradient(
      begin: AlignmentDirectional.topStart,
      end: AlignmentDirectional.bottomEnd,
      colors: [start, end],
    );
  }

  /// The light inventory page uses a tonal (pale green) hero tile instead of
  /// a solid one.
  static bool isHeroTonal(BuildContext context, OnboardingAccent accent) =>
      !_isDark(context) && accent == OnboardingAccent.success;

  static Color toneOf(
    BuildContext context,
    OnboardingTone tone,
    OnboardingAccent accent,
  ) {
    final colorScheme = context.colorScheme;
    return switch (tone) {
      OnboardingTone.accent => accentOf(context, accent),
      OnboardingTone.success => colorScheme.tertiary,
      OnboardingTone.warning => warningOf(context),
      OnboardingTone.info => colorScheme.primary,
      OnboardingTone.neutral => colorScheme.onSurfaceVariant,
    };
  }

  static Color warningOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFFF59E0B) : const Color(0xFFD97706);

  static Color warningContainerOf(BuildContext context) =>
      _isDark(context) ? const Color(0x3378350F) : const Color(0xFFFFFBEB);

  static Color warningBorderOf(BuildContext context) =>
      _isDark(context) ? const Color(0x80B45309) : const Color(0xFFFDE68A);

  static Color onWarningContainerOf(BuildContext context) =>
      _isDark(context) ? const Color(0xFFFDE68A) : const Color(0xFF92400E);

  /// Fill of the floating cards and badges.
  static Color cardOf(BuildContext context) => _isDark(context)
      ? Color.alphaBlend(
          context.colorScheme.primaryContainer.withValues(alpha: 0.55),
          context.colorScheme.outlineVariant,
        )
      : context.colorScheme.surface;

  /// Inactive page indicator dots.
  static Color inactiveDotOf(BuildContext context) =>
      context.colorScheme.onSurfaceVariant.withValues(alpha: 0.3);
}
