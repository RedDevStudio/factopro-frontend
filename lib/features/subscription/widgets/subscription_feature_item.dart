import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Check icon on the start (right) side followed by the feature label.
/// Expects an RTL [Directionality] ancestor.
class SubscriptionFeatureItem extends StatelessWidget {
  const SubscriptionFeatureItem({
    super.key,
    required this.feature,
    this.isPremium = false,
  });

  final SubscriptionFeatureData feature;

  /// Premium plans use a filled verified badge instead of an outlined check.
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isPremium ? Icons.verified_rounded : Icons.check_circle_outline,
          size: 18,
          color: colorScheme.tertiary,
        ),
        const Gap(8),
        Expanded(
          child: Text(
            feature.label,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              fontWeight: feature.isHighlighted || isPremium
                  ? FontWeight.bold
                  : FontWeight.w500,
              color: feature.isHighlighted
                  ? SubscriptionColors.accentOf(context)
                  : colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
