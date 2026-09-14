import 'package:flutter/material.dart';

const kColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Main buttons, focused controls, links
  primary: Color(0xFF2563EB), // Blue
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEFF6FF),
  onPrimaryContainer: Color(0xFF1E3A8A),

  // Brand/navy accents and headings
  secondary: Color(0xFF1E3A8A), // Navy
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFEFF6FF),
  onSecondaryContainer: Color(0xFF1E3A8A),

  // Success
  tertiary: Color(0xFF059669),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFD1FAE5),
  onTertiaryContainer: Color(0xFF065F46),

  error: Color(0xFFE11D48),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFE4E6),
  onErrorContainer: Color(0xFF9F1239),

  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF0F172A),
  onSurfaceVariant: Color(0xFF475569),
  outline: Color(0xFFE2E8F0),
  outlineVariant: Color(0xFFF1F5F9),

  shadow: Color(0x33000000),
  scrim: Color(0x66000000),

  inverseSurface: Color(0xFF0F172A),
  onInverseSurface: Color(0xFFF8FAFC),
  inversePrimary: Color(0xFF3B82F6),
);

const kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Primary
  primary: Color(0xFF3B82F6), // Primary Vivid
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF1E293B), // Interactive Dark
  onPrimaryContainer: Color(0xFFEFF6FF),

  // Secondary
  secondary: Color(0xFF6366F1), // Indigo Accent
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF1E293B),
  onSecondaryContainer: Color(0xFFE0E7FF),

  // Tertiary
  tertiary: Color(0xFF10B981), // Success
  onTertiary: Color(0xFF052E2B),
  tertiaryContainer: Color(0xFF064E4B),
  onTertiaryContainer: Color(0xFFA7F3D0),

  // Error
  error: Color(0xFFF43F5E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFF4C1D2A),
  onErrorContainer: Color(0xFFFFD5DC),

  // Surfaces
  surface: Color(0xFF060E20),
  onSurface: Color(0xFFF8FAFC),

  // Variants / borders
  onSurfaceVariant: Color(0xFF94A3B8),
  outline: Color(0xFF1E293B),
  outlineVariant: Color(0xFF131B2E),

  // Misc
  shadow: Color(0x99000000),
  scrim: Color(0xCC000000),

  // Inverse
  inverseSurface: Color(0xFFF8FAFC),
  onInverseSurface: Color(0xFF0F172A),
  inversePrimary: Color(0xFF1E3A8A),
);
