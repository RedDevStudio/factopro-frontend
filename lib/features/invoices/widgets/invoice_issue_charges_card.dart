import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Delivery fee input plus the invoice-level discount: method selector
/// (code / percent / amount) and the matching value field. Expects an RTL
/// [Directionality] ancestor.
class InvoiceIssueChargesCard extends StatelessWidget {
  const InvoiceIssueChargesCard({
    super.key,
    required this.deliveryFeeController,
    required this.discountController,
    required this.discountMethod,
    this.onDiscountMethodChanged,
  });

  final TextEditingController deliveryFeeController;
  final TextEditingController discountController;
  final InvoiceIssueDiscountMethod discountMethod;
  final ValueChanged<InvoiceIssueDiscountMethod>? onDiscountMethodChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final unitLabel = discountMethod.unitLabel;
    final isCode = discountMethod == InvoiceIssueDiscountMethod.code;

    return EditProductSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditProductTextField(
            label: 'هزینه پیک (تومان)',
            controller: deliveryFeeController,
            hintText: '۰',
            keyboardType: TextInputType.number,
            isBoldValue: true,
          ),
          const Gap(16),
          Divider(color: colorScheme.outline, height: 1),
          const Gap(16),
          Row(
            children: [
              Text(
                'تخفیف',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  'روش محاسبه تخفیف را انتخاب کنید',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          _DiscountMethodSelector(
            selected: discountMethod,
            onChanged: onDiscountMethodChanged,
          ),
          const Gap(14),
          Text(
            discountMethod.fieldLabel,
            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
          ),
          const Gap(8),
          TextField(
            controller: discountController,
            keyboardType: isCode ? TextInputType.text : TextInputType.number,
            textDirection: isCode ? TextDirection.ltr : null,
            textAlign: isCode ? TextAlign.right : TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            decoration: editProductInputDecoration(
              context,
              hintText: discountMethod.hintText,
              suffix: unitLabel == null
                  ? null
                  : Text(
                      unitLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Three-way segmented control, ordered from the start (right) side as
/// declared in [InvoiceIssueDiscountMethod].
class _DiscountMethodSelector extends StatelessWidget {
  const _DiscountMethodSelector({required this.selected, this.onChanged});

  final InvoiceIssueDiscountMethod selected;
  final ValueChanged<InvoiceIssueDiscountMethod>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    Widget option(InvoiceIssueDiscountMethod method) {
      final isSelected = method == selected;

      return Expanded(
        child: GestureDetector(
          onTap: onChanged == null ? null : () => onChanged!(method),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 9),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !isSelected
                  ? Colors.transparent
                  : isDark
                  ? colorScheme.primary.withValues(alpha: 0.15)
                  : colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected && isDark
                    ? colorScheme.primary.withValues(alpha: 0.6)
                    : Colors.transparent,
              ),
              boxShadow: isSelected && !isDark
                  ? [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              method.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          for (final method in InvoiceIssueDiscountMethod.values)
            option(method),
        ],
      ),
    );
  }
}
