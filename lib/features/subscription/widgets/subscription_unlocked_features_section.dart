import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "امکانات ویژه آنلاک‌شده" title row with the "فعال در حساب شما" pill and a
/// card per unlocked feature. Expects an RTL [Directionality] ancestor.
class SubscriptionUnlockedFeaturesSection extends StatelessWidget {
  const SubscriptionUnlockedFeaturesSection({
    super.key,
    required this.features,
  });

  final List<SubscriptionUnlockedFeatureData> features;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              child: Icon(
                Icons.star_rounded,
                size: 14,
                color: SubscriptionColors.onAccentOf(context),
              ),
            ),
            const Gap(8),
            Expanded(
              child: Text(
                'امکانات ویژه آنلاک‌شده',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'فعال در حساب شما',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ],
        ),
        const Gap(12),
        for (var i = 0; i < features.length; i++) ...[
          if (i > 0) const Gap(10),
          _UnlockedFeatureCard(feature: features[i]),
        ],
      ],
    );
  }
}

/// Icon tile, title (+ optional badge) and one-line description, with a
/// success check on the end (left) side.
class _UnlockedFeatureCard extends StatelessWidget {
  const _UnlockedFeatureCard({required this.feature});

  final SubscriptionUnlockedFeatureData feature;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (iconColor, iconBackground) = feature.isGift
        ? (
            SubscriptionColors.goldOf(context),
            SubscriptionColors.goldContainerOf(context),
          )
        : (
            SubscriptionColors.accentOf(context),
            colorScheme.primary.withValues(alpha: 0.12),
          );
    final badgeLabel = feature.badgeLabel;

    return SubscriptionSectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(feature.icon, size: 22, color: iconColor),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        feature.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (badgeLabel != null) ...[
                      const Gap(6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: SubscriptionColors.onGoldContainerOf(context),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          badgeLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: SubscriptionColors.goldContainerOf(context),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(4),
                Text(
                  feature.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Icon(
            Icons.check_circle_rounded,
            size: 20,
            color: colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
