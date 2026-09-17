import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SubscriptionPlanSelector extends StatelessWidget {
  const SubscriptionPlanSelector({
    super.key,
    required this.selectedPlan,
    required this.onPlanSelected,
  });

  final SubscriptionPlan selectedPlan;
  final ValueChanged<SubscriptionPlan> onPlanSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: SubscriptionPlan.values.reversed
          .map(
            (plan) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _PlanCard(
                  plan: plan,
                  selected: plan == selectedPlan,
                  onTap: () => onPlanSelected(plan),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  final SubscriptionPlan plan;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final highlightColor = colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: selected ? colorScheme.primaryContainer : colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? highlightColor : colorScheme.outline,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  plan.icon,
                  size: 22,
                  color: selected ? highlightColor : colorScheme.onSurfaceVariant,
                ),
                const Gap(8),
                Text(
                  plan.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(4),
                Text(
                  plan.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: -8,
              right: 8,
              left: 8,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'فعال',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
