import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_amount_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Fixed bottom bar of the issue invoice screen: "جمع کل" total row and the
/// green "تایید و صدور فاکتور" button. Expects an RTL [Directionality]
/// ancestor.
class InvoiceIssueBottomBar extends StatelessWidget {
  const InvoiceIssueBottomBar({
    super.key,
    required this.totalLabel,
    this.onConfirmTap,
  });

  /// Pre-formatted grand total, e.g. "۳,۷۰۰,۰۰۰".
  final String totalLabel;
  final VoidCallback? onConfirmTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        14,
        16,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'جمع کل:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  InvoiceAmountText(
                    value: totalLabel,
                    fontSize: 22,
                    unitFontSize: 12,
                  ),
                ],
              ),
              const Gap(12),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.tertiary.withValues(alpha: 0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: PrimaryButton(
                  onTap: onConfirmTap ?? () {},
                  labelText: 'تایید و صدور فاکتور',
                  labelFontSize: 16,
                  icon: Icons.check_circle_outline_rounded,
                  isIconAtEnd: true,
                  backgroundColor: colorScheme.tertiary,
                  labelTextColor: colorScheme.onTertiary,
                  borderColor: colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
