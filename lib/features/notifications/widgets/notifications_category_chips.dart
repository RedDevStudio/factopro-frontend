import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The horizontally scrollable row of notification category chips ("همه",
/// "مالی و تراکنش‌ها", "انبار و موجودی", ...). Expects an RTL
/// [Directionality] ancestor so scrolling starts from the right.
class NotificationsCategoryChips extends StatelessWidget {
  const NotificationsCategoryChips({
    super.key,
    required this.categories,
    required this.selected,
    this.onSelected,
  });

  final List<NotificationCategoryData> categories;
  final NotificationCategoryData selected;
  final ValueChanged<NotificationCategoryData>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
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

  final NotificationCategoryData category;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final brand = notificationBrandColor(context);
    final foreground = selected ? colorScheme.onPrimary : colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? brand : colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: selected ? brand : colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.tone != null) ...[
              Icon(
                Icons.circle,
                size: 7,
                color: notificationToneColors(context, category.tone!).$1,
              ),
              const Gap(6),
            ],
            Text(
              category.label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: foreground),
            ),
            const Gap(8),
            Container(
              constraints: const BoxConstraints(minWidth: 20),
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? colorScheme.onPrimary.withValues(alpha: 0.2)
                    : colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                category.count,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: selected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
