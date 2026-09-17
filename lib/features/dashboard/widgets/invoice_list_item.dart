import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/invoice_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvoiceListItem extends StatelessWidget {
  const InvoiceListItem({super.key, required this.invoice, this.onTap});

  final DashboardInvoice invoice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isOverdue = invoice.status == InvoiceStatus.overdue;
    final amountColor = isOverdue ? colorScheme.error : colorScheme.onSurface;
    final noteColor = isOverdue ? colorScheme.error : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.amount,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: amountColor,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      'تومان',
                      style: TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      invoice.customerName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${invoice.date} • شماره #${invoice.invoiceNumber}',
                      style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                InvoiceStatusBadge(status: invoice.status),
                const Spacer(),
                Text(
                  invoice.note,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: noteColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
