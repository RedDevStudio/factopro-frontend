import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "انتخاب درگاه پرداخت امن" title row and a two-column grid of gateway
/// tiles. Expects an RTL [Directionality] ancestor.
class SubscriptionGatewaySection extends StatelessWidget {
  const SubscriptionGatewaySection({
    super.key,
    required this.gateways,
    required this.selectedIndex,
    this.onSelected,
  });

  final List<SubscriptionGatewayData> gateways;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    Widget tile(int index) => _GatewayTile(
      gateway: gateways[index],
      isSelected: index == selectedIndex,
      onTap: onSelected == null ? null : () => onSelected!(index),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_outlined,
              size: 18,
              color: SubscriptionColors.accentOf(context),
            ),
            const Gap(6),
            Expanded(
              child: Text(
                'انتخاب درگاه پرداخت امن',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Icon(Icons.gpp_good_rounded, size: 14, color: colorScheme.tertiary),
            const Gap(3),
            Text(
              'رمزنگاری ۲۵۶ بیتی',
              style: TextStyle(
                fontSize: 10,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const Gap(12),
        for (var i = 0; i < gateways.length; i += 2) ...[
          if (i > 0) const Gap(10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: tile(i)),
                const Gap(10),
                Expanded(
                  child: i + 1 < gateways.length
                      ? tile(i + 1)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Selection check on the start (right) side, gateway name and caption next
/// to it.
class _GatewayTile extends StatelessWidget {
  const _GatewayTile({
    required this.gateway,
    required this.isSelected,
    this.onTap,
  });

  final SubscriptionGatewayData gateway;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.tertiary
                      : colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 15,
                  color: isSelected
                      ? colorScheme.onTertiary
                      : colorScheme.primary.withValues(alpha: 0.35),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gateway.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      gateway.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
