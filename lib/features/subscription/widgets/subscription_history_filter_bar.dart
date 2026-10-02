import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Payment history filters.
enum SubscriptionHistoryFilter {
  all('همه تراکنش‌ها'),
  successful('موفق'),
  failed('ناموفق / لغو شده');

  const SubscriptionHistoryFilter(this.label);

  final String label;
}

/// Horizontally scrollable filter chips with per-filter count badges.
/// Expects an RTL [Directionality] ancestor.
class SubscriptionHistoryFilterBar extends StatelessWidget {
  const SubscriptionHistoryFilterBar({
    super.key,
    required this.counts,
    required this.selected,
    required this.onSelected,
  });

  final Map<SubscriptionHistoryFilter, int> counts;
  final SubscriptionHistoryFilter selected;
  final ValueChanged<SubscriptionHistoryFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final filter in SubscriptionHistoryFilter.values) ...[
            if (filter.index > 0) const Gap(8),
            _FilterChip(
              filter: filter,
              count: counts[filter] ?? 0,
              isSelected: filter == selected,
              onTap: () => onSelected(filter),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.filter,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final SubscriptionHistoryFilter filter;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);
    final onAccent = SubscriptionColors.onAccentOf(context);
    final background = isSelected
        ? accent
        : colorScheme.primary.withValues(alpha: 0.12);
    final foreground = isSelected ? onAccent : colorScheme.onSurface;
    final (badgeBackground, badgeForeground) = isSelected
        ? (onAccent.withValues(alpha: 0.2), onAccent)
        : switch (filter) {
            SubscriptionHistoryFilter.all => (colorScheme.surface, accent),
            SubscriptionHistoryFilter.successful => (
              colorScheme.tertiaryContainer,
              colorScheme.onTertiaryContainer,
            ),
            SubscriptionHistoryFilter.failed => (
              colorScheme.errorContainer,
              colorScheme.onErrorContainer,
            ),
          };

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                filter.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: foreground,
                ),
              ),
              const Gap(6),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: badgeBackground,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  _toPersianDigits(count),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: badgeForeground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _toPersianDigits(int value) => value
      .toString()
      .split('')
      .map((digit) => '۰۱۲۳۴۵۶۷۸۹'[int.parse(digit)])
      .join();
}
