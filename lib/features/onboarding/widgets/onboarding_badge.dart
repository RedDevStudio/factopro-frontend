import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_colors.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_page_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Floating pill that overlaps a corner of the onboarding feature card.
class OnboardingBadge extends StatelessWidget {
  const OnboardingBadge({super.key, required this.badge, required this.accent});

  final OnboardingBadgeData badge;
  final OnboardingAccent accent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: ShapeDecoration(
        color: isDark ? colorScheme.outlineVariant : colorScheme.surface,
        shape: StadiumBorder(side: BorderSide(color: colorScheme.outline)),
        shadows: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            badge.icon,
            size: 14,
            color: OnboardingColors.toneOf(context, badge.tone, accent),
          ),
          const Gap(6),
          Text(
            badge.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
