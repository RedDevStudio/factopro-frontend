import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The dark navy "امروز" (today) sales report card at the top of the
/// invoices screen, with an issued-invoices badge and two sub stats.
class InvoicesSalesReportCard extends StatelessWidget {
  const InvoicesSalesReportCard({
    super.key,
    required this.dateLabel,
    required this.issuedInvoicesLabel,
    required this.receivablesLabel,
    required this.receivablesAmount,
    required this.settledLabel,
    required this.settledAmount,
  });

  final String dateLabel;
  final String issuedInvoicesLabel;
  final String receivablesLabel;
  final String receivablesAmount;
  final String settledLabel;
  final String settledAmount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final onSecondary = colorScheme.onSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: onSecondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.event_note_outlined, size: 16, color: onSecondary),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  dateLabel,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSecondary),
                ),
              ),
            ],
          ),
          const Gap(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: onSecondary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 7, color: colorScheme.tertiary),
                  const Gap(5),
                  Text(
                    issuedInvoicesLabel,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: onSecondary),
                  ),
                ],
              ),
            ),
          ),
          const Gap(14),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _SubStat(label: receivablesLabel, amount: receivablesAmount),
                ),
                const Gap(10),
                Expanded(
                  child: _SubStat(label: settledLabel, amount: settledAmount),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubStat extends StatelessWidget {
  const _SubStat({required this.label, required this.amount});

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final onSecondary = colorScheme.onSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: onSecondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: onSecondary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 11, color: onSecondary.withValues(alpha: 0.75)),
          ),
          const Gap(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: Text(
                  'تومان',
                  style: TextStyle(fontSize: 10, color: onSecondary.withValues(alpha: 0.75)),
                ),
              ),
              const Gap(4),
              Flexible(
                child: Text(
                  amount,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
