import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/product_card_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The horizontally scrollable row of category filter chips ("همه",
/// "خواربار و غلات", "روغن و چربی‌ها", ...).
class ProductsCategoryChips extends StatelessWidget {
  const ProductsCategoryChips({
    super.key,
    required this.categories,
    required this.selected,
    this.onSelected,
  });

  final List<ProductCategoryData> categories;
  final ProductCategoryData selected;
  final ValueChanged<ProductCategoryData>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
        children: [
          for (final category in categories) ...[
            _CategoryChip(
              category: category,
              selected: category == selected,
              onTap: onSelected == null ? null : () => onSelected!(category),
            ),
            if (category != categories.last) const Gap(8),
          ],
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category, required this.selected, this.onTap});

  final ProductCategoryData category;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? colorScheme.secondary : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? colorScheme.secondary : colorScheme.outline),
        ),
        child: Text(
          category.count == null ? category.label : '${category.label} (${category.count})',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: selected ? colorScheme.onSecondary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
