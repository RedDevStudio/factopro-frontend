import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_amount_text.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A product line on the issue invoice screen: name, unit price and delete
/// button on top; quantity stepper and line total below. Expects an RTL
/// [Directionality] ancestor.
class InvoiceIssueItemCard extends StatelessWidget {
  const InvoiceIssueItemCard({
    super.key,
    required this.item,
    this.onIncrement,
    this.onDecrement,
    this.onDeleteTap,
  });

  final InvoiceIssueItemData item;
  final VoidCallback? onIncrement;

  /// Null disables the minus button (e.g. at a quantity of one).
  final VoidCallback? onDecrement;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return EditProductSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${item.product.unitPrice.toPersianAmount()} تومان',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              IconButton(
                onPressed: onDeleteTap,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 22,
                  color: colorScheme.error,
                ),
              ),
            ],
          ),
          const Gap(12),
          Divider(color: colorScheme.outline, height: 1),
          const Gap(12),
          Row(
            children: [
              _QuantityStepper(
                quantityLabel: item.quantity.toPersianDigits(),
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
              const Spacer(),
              InvoiceAmountText(value: item.total.toPersianAmount()),
            ],
          ),
        ],
      ),
    );
  }
}

/// Pill shaped "+ count −" stepper.
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantityLabel,
    this.onIncrement,
    this.onDecrement,
  });

  final String quantityLabel;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.outlineVariant
            : colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? colorScheme.outline
              : colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(icon: Icons.add_rounded, onTap: onIncrement),
          SizedBox(
            width: 40,
            child: Text(
              quantityLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          _StepperButton(icon: Icons.remove_rounded, onTap: onDecrement),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDark ? colorScheme.primaryContainer : colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: onTap == null
              ? colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
              : colorScheme.primary,
        ),
      ),
    );
  }
}
