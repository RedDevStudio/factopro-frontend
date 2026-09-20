import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/product_card_data.dart';
import 'package:factopro/features/products/widgets/product_warning_colors.dart';
import 'package:flutter/material.dart';

/// Resolves the (accent, container, onContainer) color triple for a
/// [ProductInfoType], shared across product cards.
(Color accent, Color container, Color onContainer) productInfoColors(
  BuildContext context,
  ProductInfoType type,
) {
  final colorScheme = context.colorScheme;

  return switch (type) {
    ProductInfoType.neutral => (
      colorScheme.onSurfaceVariant,
      colorScheme.outlineVariant,
      colorScheme.onSurfaceVariant,
    ),
    ProductInfoType.warning => (
      ProductWarningColors.of(context),
      ProductWarningColors.containerOf(context),
      ProductWarningColors.onContainerOf(context),
    ),
    ProductInfoType.success => (
      colorScheme.tertiary,
      colorScheme.tertiaryContainer,
      colorScheme.onTertiaryContainer,
    ),
  };
}

/// The small pill at the bottom of a product card summarizing its warranty,
/// expiry, time-limited discount or best-seller status.
class ProductInfoBanner extends StatelessWidget {
  const ProductInfoBanner({
    super.key,
    required this.label,
    required this.icon,
    required this.type,
  });

  final String label;
  final IconData icon;
  final ProductInfoType type;

  @override
  Widget build(BuildContext context) {
    final (accent, container, onContainer) = productInfoColors(context, type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: container, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: onContainer),
            ),
          ),
          const SizedBox(width: 6),
          Icon(icon, size: 14, color: accent),
        ],
      ),
    );
  }
}
