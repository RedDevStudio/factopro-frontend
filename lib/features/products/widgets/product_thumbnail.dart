import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The product's square image placeholder, with an optional "تخفیف" ribbon
/// badge in the corner for discounted items.
class ProductThumbnail extends StatelessWidget {
  const ProductThumbnail({super.key, required this.icon, this.discountRibbonLabel});

  final IconData icon;
  final String? discountRibbonLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 30, color: colorScheme.onSurfaceVariant),
        ),
        if (discountRibbonLabel != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.error,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                discountRibbonLabel!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onError,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
