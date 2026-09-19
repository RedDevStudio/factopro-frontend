import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A single action button rendered at the bottom of an invoice card. Its
/// look adapts to [InvoiceActionButtonData.style].
class InvoiceActionButton extends StatelessWidget {
  const InvoiceActionButton({super.key, required this.data, this.accentColor});

  final InvoiceActionButtonData data;

  /// Background/border/text color for a filled or outlined-emphasis button.
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return switch (data.style) {
      InvoiceActionStyle.link => InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_left, size: 16, color: colorScheme.primary),
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      InvoiceActionStyle.outlined => InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.icon, size: 15, color: colorScheme.onSurfaceVariant),
              const Gap(6),
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
      InvoiceActionStyle.filled => InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: accentColor ?? colorScheme.tertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.icon, size: 15, color: colorScheme.onPrimary),
              const Gap(6),
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    };
  }
}
