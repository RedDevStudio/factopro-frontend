import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_action_button.dart';
import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_banner.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_icon.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice, this.onTap});

  final InvoiceCardData invoice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isOverdue = invoice.status == InvoiceStatus.overdue;
    final amountColor = isOverdue ? colorScheme.error : colorScheme.onSurface;
    final amountLabelColor = isOverdue ? colorScheme.error : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.more_vert, size: 18, color: colorScheme.onSurfaceVariant),
                const Spacer(),
                InvoiceStatusPill(status: invoice.status),
              ],
            ),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            invoice.customerName,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          if (invoice.customerNote != null)
                            Text(
                              invoice.customerNote!,
                              style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                            ),
                        ],
                      ),
                      const Gap(4),
                      Text(
                        invoice.time.isEmpty
                            ? 'شماره: ${invoice.invoiceNumber}'
                            : 'شماره: ${invoice.invoiceNumber} • ${invoice.time}',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                      ),
                      const Gap(2),
                      Text(
                        invoice.date,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                InvoiceStatusIcon(status: invoice.status),
              ],
            ),
            const Gap(12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.amountLabel,
                      style: TextStyle(fontSize: 11, color: amountLabelColor),
                    ),
                    const Gap(2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Text(
                            'تومان',
                            style: TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant),
                          ),
                        ),
                        const Gap(2),
                        Text(
                          invoice.amountValue,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: amountColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        invoice.itemsDescription,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                      ),
                      if (invoice.secondaryDescription != null) ...[
                        const Gap(4),
                        Text(
                          invoice.secondaryDescription!,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (invoice.statusBannerLabel != null) ...[
              const Gap(12),
              InvoiceStatusBanner(
                status: invoice.status,
                label: invoice.statusBannerLabel!,
                icon: invoice.statusBannerIcon ?? invoice.status.icon,
              ),
            ],
            if (invoice.actions.isNotEmpty) ...[
              const Gap(12),
              Divider(color: colorScheme.outlineVariant, height: 1),
              const Gap(10),
              _InvoiceCardActionsRow(actions: invoice.actions),
            ],
          ],
        ),
      ),
    );
  }
}

class _InvoiceCardActionsRow extends StatelessWidget {
  const _InvoiceCardActionsRow({required this.actions});

  final List<InvoiceActionButtonData> actions;

  @override
  Widget build(BuildContext context) {
    final linkAction = actions.firstWhere(
      (action) => action.style == InvoiceActionStyle.link,
      orElse: () => actions.first,
    );
    final otherActions = actions.where((action) => action != linkAction).toList();

    return Row(
      children: [
        InvoiceActionButton(data: linkAction),
        const Gap(8),
        for (final action in otherActions) ...[
          Expanded(child: InvoiceActionButton(data: action)),
          if (action != otherActions.last) const Gap(8),
        ],
      ],
    );
  }
}
