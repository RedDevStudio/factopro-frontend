import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_feature_item.dart';
import 'package:factopro/features/subscription/widgets/subscription_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Plan card: optional recommendation badge and selected check, tier icon,
/// title/subtitle, price (or free tag), included features and the CTA.
/// Expects an RTL [Directionality] ancestor.
class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    this.onSelect,
  });

  final SubscriptionPlanData plan;
  final bool isSelected;
  final VoidCallback? onSelect;

  bool get _isGold => plan.tier == SubscriptionPlanTier.gold;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final recommendationLabel = plan.recommendationLabel;

    return SubscriptionSectionCard(
      isElevated: isSelected,
      gradient: _isGold
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface,
                SubscriptionColors.goldContainerOf(context)
                    .withValues(alpha: isDark ? 0.3 : 0.55),
              ],
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (recommendationLabel != null || isSelected) ...[
            Row(
              children: [
                if (recommendationLabel != null)
                  Flexible(child: _RecommendationBadge(recommendationLabel)),
                const Spacer(),
                if (isSelected) const _SelectedCheck(),
              ],
            ),
            const Gap(14),
          ],
          _buildTitleRow(context),
          const Gap(16),
          for (final feature in plan.features) ...[
            SubscriptionFeatureItem(
              feature: feature,
              isPremium: plan.tier != SubscriptionPlanTier.basic,
            ),
            const Gap(10),
          ],
          const Gap(6),
          _buildCta(context),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (iconColor, iconBackground) = switch (plan.tier) {
      SubscriptionPlanTier.basic => (
        colorScheme.onSurfaceVariant,
        colorScheme.primary.withValues(alpha: 0.1),
      ),
      SubscriptionPlanTier.pro => (
        SubscriptionColors.accentOf(context),
        colorScheme.primary.withValues(alpha: 0.14),
      ),
      SubscriptionPlanTier.gold => (
        SubscriptionColors.goldOf(context),
        SubscriptionColors.goldContainerOf(context),
      ),
    };
    final tagLabel = plan.tagLabel;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(top: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(plan.icon, size: 22, color: iconColor),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(2),
              Text(
                plan.subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        if (plan.priceValue != null)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 130),
            child: _PriceBlock(plan: plan),
          )
        else if (tagLabel != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tagLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCta(BuildContext context) {
    final colorScheme = context.colorScheme;

    if (plan.isCurrent) {
      final background = colorScheme.primary.withValues(alpha: 0.14);
      return PrimaryButton(
        onTap: () {},
        labelText: plan.ctaLabel,
        labelFontSize: 14,
        icon: Icons.verified_outlined,
        backgroundColor: background,
        labelTextColor: colorScheme.onSurfaceVariant,
        borderColor: Colors.transparent,
      );
    }

    final accent = SubscriptionColors.accentOf(context);
    return PrimaryButton(
      onTap: onSelect ?? () {},
      labelText: isSelected
          ? (plan.selectedCtaLabel ?? plan.ctaLabel)
          : plan.ctaLabel,
      labelFontSize: 14,
      icon: isSelected ? Icons.stars_rounded : Icons.bolt_rounded,
      backgroundColor: accent,
      labelTextColor: SubscriptionColors.onAccentOf(context),
      borderColor: accent,
    );
  }
}

/// Struck-through original price above the current monthly price. Aligned to
/// the end (left) side of the title row.
class _PriceBlock extends StatelessWidget {
  const _PriceBlock({required this.plan});

  final SubscriptionPlanData plan;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final priceColor = plan.tier == SubscriptionPlanTier.gold
        ? SubscriptionColors.goldOf(context)
        : SubscriptionColors.accentOf(context);
    final originalPrice = plan.originalPriceValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (originalPrice != null)
          Text(
            originalPrice,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
              decorationColor: colorScheme.onSurfaceVariant,
            ),
          ),
        const Gap(2),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: plan.priceValue,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: ' ${plan.priceUnitLabel}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.end,
          style: TextStyle(color: priceColor),
        ),
      ],
    );
  }
}

/// Amber "پیشنهاد ویژه ..." pill of the recommended plan.
class _RecommendationBadge extends StatelessWidget {
  const _RecommendationBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final foreground = SubscriptionColors.onGoldContainerOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: SubscriptionColors.goldContainerOf(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 15, color: foreground),
          const Gap(4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Filled check circle marking the selected plan.
class _SelectedCheck extends StatelessWidget {
  const _SelectedCheck();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check_rounded, size: 16, color: colorScheme.onTertiary),
    );
  }
}
