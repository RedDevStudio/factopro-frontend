import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/product_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The small inline legend above the product list: total items, low-stock
/// items and active discounts, each with a colored dot.
class ProductsStatsRow extends StatelessWidget {
  const ProductsStatsRow({
    super.key,
    required this.totalLabel,
    required this.lowStockLabel,
    required this.activeDiscountsLabel,
  });

  final String totalLabel;
  final String lowStockLabel;
  final String activeDiscountsLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 4,
      children: [
        _StatItem(label: activeDiscountsLabel, dotColor: ProductWarningColors.of(context)),
        _StatItem(label: lowStockLabel, dotColor: colorScheme.error),
        _StatItem(label: totalLabel, dotColor: colorScheme.primary),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.dotColor});

  final String label;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant)),
        const Gap(5),
        Icon(Icons.circle, size: 7, color: dotColor),
      ],
    );
  }
}
