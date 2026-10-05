import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Horizontally scrollable category filter ("همه اقلام", "خواربار و برنج",
/// ...). A null category stands for "all". Expects an RTL [Directionality]
/// ancestor so scrolling starts from the right.
class InvoiceProductPickerCategoryChips extends StatelessWidget {
  const InvoiceProductPickerCategoryChips({
    super.key,
    required this.categories,
    required this.selected,
    this.onSelected,
  });

  static const allLabel = 'همه اقلام';

  final List<String> categories;
  final String? selected;
  final ValueChanged<String?>? onSelected;

  @override
  Widget build(BuildContext context) {
    final options = <String?>[null, ...categories];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (index, category) in options.indexed) ...[
            if (index > 0) const Gap(8),
            _CategoryChip(
              label: category ?? allLabel,
              isSelected: category == selected,
              onTap: onSelected == null ? null : () => onSelected!(category),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final selectedColor = isDark ? colorScheme.primary : colorScheme.secondary;
    final onSelectedColor = isDark
        ? colorScheme.onPrimary
        : colorScheme.onSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? selectedColor : colorScheme.outline,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? onSelectedColor : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
