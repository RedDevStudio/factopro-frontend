import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_action_button.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A payment history entry: status icon, title, date/time and amount, then
/// either the gateway/tracking-code box with invoice actions (successful) or
/// the failure reason with the refund note (failed). Expects an RTL
/// [Directionality] ancestor.
class SubscriptionTransactionCard extends StatelessWidget {
  const SubscriptionTransactionCard({
    super.key,
    required this.transaction,
    this.onViewInvoiceTap,
  });

  final SubscriptionTransactionData transaction;
  final VoidCallback? onViewInvoiceTap;

  @override
  Widget build(BuildContext context) {
    return SubscriptionSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummaryRow(context),
          const Gap(14),
          if (transaction.isSuccessful)
            ..._buildSuccessDetails(context)
          else
            ..._buildFailureDetails(context),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isSuccessful = transaction.isSuccessful;
    final statusColor = isSuccessful ? colorScheme.tertiary : colorScheme.error;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSuccessful
                ? colorScheme.tertiaryContainer
                : colorScheme.errorContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isSuccessful
                ? Icons.check_circle_outline_rounded
                : Icons.highlight_off_rounded,
            size: 24,
            color: statusColor,
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(4),
              Text(
                '${transaction.dateLabel}  •  ${transaction.timeLabel}',
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.amount,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: statusColor,
              ),
            ),
            Text(
              'تومان',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildSuccessDetails(BuildContext context) {
    final colorScheme = context.colorScheme;
    final gatewayName = transaction.gatewayName;
    final trackingCode = transaction.trackingCode;

    return [
      if (gatewayName != null || trackingCode != null) ...[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                transaction.gatewayIcon,
                size: 17,
                color: colorScheme.onSurfaceVariant,
              ),
              const Gap(6),
              Expanded(
                child: Text(
                  gatewayName ?? '',
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurface),
                ),
              ),
              if (trackingCode != null) ...[
                const Gap(8),
                Text(
                  'کد پیگیری:',
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(6),
                Text(
                  trackingCode,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Gap(12),
      ],
      if (transaction.hasPdfReceipt)
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SubscriptionActionButton(
                label: 'مشاهده فاکتور',
                icon: Icons.receipt_long_rounded,
                style: SubscriptionActionButtonStyle.filled,
                onTap: onViewInvoiceTap,
              ),
            ),
            const Gap(10),
            const Expanded(
              child: SubscriptionActionButton(
                label: 'فیش PDF',
                icon: Icons.download_rounded,
              ),
            ),
          ],
        )
      else
        SubscriptionActionButton(
          label: 'مشاهده فاکتور',
          icon: Icons.visibility_outlined,
          onTap: onViewInvoiceTap,
        ),
    ];
  }

  List<Widget> _buildFailureDetails(BuildContext context) {
    final colorScheme = context.colorScheme;
    final failureReason = transaction.failureReason;
    final failureBadgeLabel = transaction.failureBadgeLabel;
    final failureNote = transaction.failureNote;

    return [
      if (failureReason != null)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 17,
                color: colorScheme.error,
              ),
              const Gap(6),
              Expanded(
                child: Text(
                  failureReason,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
              if (failureBadgeLabel != null) ...[
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    failureBadgeLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      const Gap(10),
      Row(
        children: [
          Expanded(
            child: Text(
              failureNote ?? '',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'پیگیری مغایرت',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ];
  }
}
