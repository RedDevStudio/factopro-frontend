import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_colors.dart';
import 'package:flutter/material.dart';

/// The small colored circular status icon shown next to the customer name.
class InvoiceStatusIcon extends StatelessWidget {
  const InvoiceStatusIcon({super.key, required this.status});

  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    final (accent, container, _) = invoiceStatusColors(context, status);

    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: container, shape: BoxShape.circle),
      child: Icon(status.icon, size: 14, color: accent),
    );
  }
}
