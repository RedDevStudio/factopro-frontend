import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "صورت‌حساب نهایی ارتقا" card: itemized lines (label on the start/right
/// side, amount on the end/left side) and the large payable total. Expects an
/// RTL [Directionality] ancestor.
class SubscriptionInvoiceSummaryCard extends StatelessWidget {
  const SubscriptionInvoiceSummaryCard({
    super.key,
    required this.lines,
    required this.totalValue,
    required this.renewalNote,
  });

  final List<SubscriptionInvoiceLineData> lines;

  /// e.g. "۳,۸۱۲,۴۷۴".
  final String totalValue;

  /// e.g. "تمدید خودکار فعال نمی‌باشد".
  final String renewalNote;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: colorScheme.outline,
    );

    return SubscriptionSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'صورت‌حساب نهایی ارتقا',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const Gap(12),
          divider,
          const Gap(14),
          for (final line in lines) ...[
            _InvoiceLine(line: line),
            const Gap(12),
          ],
          const Gap(2),
          divider,
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مبلغ نهایی قابل پرداخت:',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      renewalNote,
                      style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: totalValue,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(
                          text: ' تومان',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(color: accent),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InvoiceLine extends StatelessWidget {
  const _InvoiceLine({required this.line});

  final SubscriptionInvoiceLineData line;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final labelColor = line.isDiscount
        ? colorScheme.tertiary
        : colorScheme.onSurfaceVariant;
    final valueColor = line.isDiscount
        ? colorScheme.tertiary
        : colorScheme.onSurface;
    final icon = line.icon;

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: labelColor),
          const Gap(4),
        ],
        Expanded(
          child: Text(
            line.label,
            style: TextStyle(fontSize: 12, color: labelColor),
          ),
        ),
        const Gap(8),
        Text(
          line.value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
