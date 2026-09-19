import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The small pill badge (dot + label) used at the top of an invoice card and
/// inside the filter chips row.
class InvoiceStatusPill extends StatelessWidget {
  const InvoiceStatusPill({super.key, required this.status, this.label});

  final InvoiceStatus status;

  /// Overrides [InvoiceStatus.badgeLabel], used e.g. to append the number of
  /// overdue days.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final (dotColor, backgroundColor, textColor) = invoiceStatusColors(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 7, color: dotColor),
          const Gap(5),
          Text(
            label ?? status.badgeLabel,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
