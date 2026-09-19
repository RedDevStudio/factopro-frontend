import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_colors.dart';
import 'package:flutter/material.dart';

/// The full-width colored bar repeating the invoice status, shown inside
/// pending/overdue/cash-paid invoice cards.
class InvoiceStatusBanner extends StatelessWidget {
  const InvoiceStatusBanner({
    super.key,
    required this.status,
    required this.label,
    required this.icon,
  });

  final InvoiceStatus status;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final (accent, container, onContainer) = invoiceStatusColors(context, status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: container, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: accent),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 6, color: accent),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onContainer),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
