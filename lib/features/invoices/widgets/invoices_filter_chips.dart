import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The horizontally scrollable row of status filter chips ("همه",
/// "تسویه شده", "در انتظار پرداخت", "سررسید گذشته").
class InvoicesFilterChips extends StatelessWidget {
  const InvoicesFilterChips({
    super.key,
    required this.filters,
    required this.selected,
    this.onSelected,
  });

  final List<InvoiceFilterData> filters;
  final InvoiceFilterData selected;
  final ValueChanged<InvoiceFilterData>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in filters) ...[
            _FilterChip(
              filter: filter,
              selected: filter == selected,
              onTap: onSelected == null ? null : () => onSelected!(filter),
            ),
            if (filter != filters.last) const Gap(8),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.filter, required this.selected, this.onTap});

  final InvoiceFilterData filter;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final dotColor = filter.status == null
        ? colorScheme.onSecondary
        : invoiceStatusColors(context, filter.status!).$1;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? colorScheme.secondary : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? colorScheme.secondary : colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (filter.status != null) ...[
              Icon(Icons.circle, size: 7, color: dotColor),
              const Gap(5),
            ],
            Text(
              '${filter.label} ${filter.count}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: selected ? colorScheme.onSecondary : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
