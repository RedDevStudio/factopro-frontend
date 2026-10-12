import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A scanned line in the barcode scanner sheet: product icon and name on the
/// start (right) side, then delete and the quantity stepper. The most
/// recently scanned line is highlighted with a "جدید" badge. Expects an RTL
/// [Directionality] ancestor.
class InvoiceScannerItemCard extends StatelessWidget {
  const InvoiceScannerItemCard({
    super.key,
    required this.item,
    this.isNew = false,
    this.onIncrement,
    this.onDecrement,
    this.onDeleteTap,
  });

  final InvoiceIssueItemData item;
  final bool isNew;
  final VoidCallback? onIncrement;

  /// Null disables the minus button (e.g. at a quantity of one).
  final VoidCallback? onDecrement;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final product = item.product;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNew
            ? colorScheme.primary.withValues(alpha: 0.08)
            : colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNew ? colorScheme.primary : colorScheme.outline,
          width: isNew ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(
              product.thumbnailIcon,
              size: 22,
              color: colorScheme.primary,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (isNew) ...[
                      const Gap(6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'جدید',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(4),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'فی: ${product.unitPrice.toPersianAmount()}  ',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                      TextSpan(
                        text: '${item.total.toPersianAmount()} تومان',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          const Gap(8),
          InvoiceStepperButton(
            icon: Icons.delete_outline_rounded,
            iconColor: colorScheme.error,
            backgroundColor: colorScheme.errorContainer,
            borderColor: colorScheme.errorContainer,
            onTap: onDeleteTap,
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InvoiceStepperButton(
                  icon: Icons.add_rounded,
                  iconColor: colorScheme.onSurface,
                  backgroundColor: colorScheme.outlineVariant,
                  borderColor: colorScheme.outlineVariant,
                  size: 26,
                  onTap: onIncrement,
                ),
                SizedBox(
                  width: 26,
                  child: Text(
                    item.quantity.toPersianDigits(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                InvoiceStepperButton(
                  icon: Icons.remove_rounded,
                  iconColor: onDecrement == null
                      ? colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
                      : colorScheme.onSurface,
                  backgroundColor: colorScheme.outlineVariant,
                  borderColor: colorScheme.outlineVariant,
                  size: 26,
                  onTap: onDecrement,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
