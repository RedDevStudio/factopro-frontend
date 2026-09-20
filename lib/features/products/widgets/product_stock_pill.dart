import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/product_warning_colors.dart';
import 'package:flutter/material.dart';

/// The small colored pill showing remaining stock, amber when running low.
class ProductStockPill extends StatelessWidget {
  const ProductStockPill({super.key, required this.label, required this.isLow});

  final String label;
  final bool isLow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final backgroundColor = isLow
        ? ProductWarningColors.containerOf(context)
        : colorScheme.tertiaryContainer;
    final textColor = isLow
        ? ProductWarningColors.onContainerOf(context)
        : colorScheme.onTertiaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
