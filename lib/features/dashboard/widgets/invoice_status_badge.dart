import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvoiceStatusBadge extends StatelessWidget {
  const InvoiceStatusBadge({super.key, required this.status});

  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (dotColor, backgroundColor, textColor) = switch (status) {
      InvoiceStatus.paid => (
        colorScheme.tertiary,
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
      ),
      InvoiceStatus.pendingPayment => (
        DashboardWarningColors.of(context),
        DashboardWarningColors.containerOf(context),
        DashboardWarningColors.onContainerOf(context),
      ),
      InvoiceStatus.overdue => (
        colorScheme.error,
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 7, color: dotColor),
          const Gap(4),
          Text(
            status.label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
