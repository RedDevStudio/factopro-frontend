import 'package:factopro/features/onboarding/widgets/onboarding_colors.dart';
import 'package:flutter/widgets.dart';

/// A floating pill around the feature card, e.g. "فوق سریع".
class OnboardingBadgeData {
  const OnboardingBadgeData({
    required this.label,
    required this.icon,
    this.tone = OnboardingTone.accent,
  });

  final String label;
  final IconData icon;
  final OnboardingTone tone;
}

/// The inset row at the bottom of the feature card.
class OnboardingInfoRowData {
  const OnboardingInfoRowData({
    required this.label,
    this.value,
    this.icon,
    this.showDot = false,
    this.tone = OnboardingTone.neutral,
    this.isValueSuccess = false,
    this.isSpread = false,
  });

  final String label;
  final String? value;

  /// Optional icon before [label], tinted with [tone].
  final IconData? icon;

  /// Shows a small success dot before [label].
  final bool showDot;

  /// [OnboardingTone.neutral], [OnboardingTone.info] and
  /// [OnboardingTone.warning] pick the row's container colors.
  final OnboardingTone tone;

  /// Paints [value] green instead of the regular text color.
  final bool isValueSuccess;

  /// Pushes [label] to the start and [value] to the end instead of centering
  /// them together.
  final bool isSpread;
}

/// Content of a single onboarding page.
class OnboardingPageData {
  const OnboardingPageData({
    required this.accent,
    required this.logoIcon,
    required this.heroIcon,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.infoRow,
    required this.topBadge,
    required this.bottomBadge,
    required this.title,
    required this.description,
    this.haloAccent,
    this.isCardSubtitleHighlighted = false,
    this.areBadgesMirrored = false,
  });

  final OnboardingAccent accent;

  /// Halo circle tint behind the card; defaults to [accent].
  final OnboardingAccent? haloAccent;

  /// Icon inside the header logo tile.
  final IconData logoIcon;

  /// Icon inside the feature card's hero tile.
  final IconData heroIcon;

  final String cardTitle;
  final String cardSubtitle;
  final bool isCardSubtitleHighlighted;
  final OnboardingInfoRowData infoRow;

  final OnboardingBadgeData topBadge;
  final OnboardingBadgeData bottomBadge;

  /// By default the top badge sits on the end (left) corner and the bottom
  /// badge on the start (right) corner; mirrored swaps them.
  final bool areBadgesMirrored;

  final String title;
  final String description;
}
