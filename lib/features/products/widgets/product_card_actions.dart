import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The delete + edit buttons shown at the bottom-left of a product card.
class ProductCardActions extends StatelessWidget {
  const ProductCardActions({super.key, this.onDeleteTap, this.onEditTap});

  final VoidCallback? onDeleteTap;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onDeleteTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorScheme.error.withValues(alpha: 0.3)),
            ),
            child: Icon(Icons.delete_outline, size: 17, color: colorScheme.error),
          ),
        ),
        const Gap(8),
        InkWell(
          onTap: onEditTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ویرایش',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const Gap(6),
                Icon(Icons.edit_outlined, size: 14, color: colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
