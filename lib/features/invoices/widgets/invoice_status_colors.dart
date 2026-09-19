import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_warning_colors.dart';
import 'package:flutter/material.dart';

/// Resolves the (accent, container, onContainer) color triple for an
/// [InvoiceStatus], shared by the badge, status icon and status banner.
(Color accent, Color container, Color onContainer) invoiceStatusColors(
  BuildContext context,
  InvoiceStatus status,
) {
  final colorScheme = context.colorScheme;

  return switch (status) {
    InvoiceStatus.paid => (
      colorScheme.tertiary,
      colorScheme.tertiaryContainer,
      colorScheme.onTertiaryContainer,
    ),
    InvoiceStatus.pendingPayment => (
      InvoiceWarningColors.of(context),
      InvoiceWarningColors.containerOf(context),
      InvoiceWarningColors.onContainerOf(context),
    ),
    InvoiceStatus.overdue => (
      colorScheme.error,
      colorScheme.errorContainer,
      colorScheme.onErrorContainer,
    ),
  };
}
