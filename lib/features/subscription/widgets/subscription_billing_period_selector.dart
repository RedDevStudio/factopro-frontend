import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "دوره پرداخت را انتخاب کنید" title row and the segmented period selector.
/// The first period sits on the start (right) side. Expects an RTL
/// [Directionality] ancestor.
class SubscriptionBillingPeriodSelector extends StatelessWidget {
  const SubscriptionBillingPeriodSelector({
    super.key,
    required this.periods,
    required this.selectedIndex,
    this.onSelected,
  });

  final List<SubscriptionBillingPeriodData> periods;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'دوره پرداخت را انتخاب کنید',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Icon(Icons.savings_outlined, size: 16, color: colorScheme.tertiary),
            const Gap(4),
            Text(
              'تخفیف سالانه',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: colorScheme.tertiary,
              ),
            ),
          ],
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              for (var i = 0; i < periods.length; i++)
                Expanded(
                  child: _PeriodOption(
                    period: periods[i],
                    isSelected: i == selectedIndex,
                    onTap: onSelected == null ? null : () => onSelected!(i),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PeriodOption extends StatelessWidget {
  const _PeriodOption({
    required this.period,
    required this.isSelected,
    this.onTap,
  });

  final SubscriptionBillingPeriodData period;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Text(
              period.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? SubscriptionColors.accentOf(context)
                    : colorScheme.onSurface,
              ),
            ),
            const Gap(4),
            Text(
              period.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: period.isDiscounted
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: period.isDiscounted
                    ? colorScheme.tertiary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
