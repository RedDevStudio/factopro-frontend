import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/invoice_list_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RecentInvoicesSection extends StatelessWidget {
  const RecentInvoicesSection({
    super.key,
    required this.invoices,
    this.onViewAllTap,
    this.onInvoiceTap,
  });

  final List<DashboardInvoice> invoices;
  final VoidCallback? onViewAllTap;
  final ValueChanged<DashboardInvoice>? onInvoiceTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            InkWell(
              onTap: onViewAllTap,
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, size: 15, color: colorScheme.primary),
                  const Gap(4),
                  Text(
                    'مشاهده همه',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'آخرین فاکتورها',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const Gap(12),
        for (final invoice in invoices) ...[
          InvoiceListItem(
            invoice: invoice,
            onTap: onInvoiceTap == null ? null : () => onInvoiceTap!(invoice),
          ),
          if (invoice != invoices.last) const Gap(10),
        ],
      ],
    );
  }
}
