import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_amount_text.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_stepper_button.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/product_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A catalog product in the picker. While [quantity] is zero the footer shows
/// the "افزودن" button and the product note; once added it shows the
/// quantity stepper, line subtotal and (for discounted products) the saving
/// pill. Expects an RTL [Directionality] ancestor.
class InvoiceProductPickerCard extends StatelessWidget {
  const InvoiceProductPickerCard({
    super.key,
    required this.product,
    required this.quantity,
    this.onAddTap,
    this.onIncrement,
    this.onDecrement,
    this.onRemoveTap,
  });

  final InvoiceIssueProductData product;
  final int quantity;
  final VoidCallback? onAddTap;
  final VoidCallback? onIncrement;

  /// Null disables the minus button (e.g. at a quantity of one).
  final VoidCallback? onDecrement;
  final VoidCallback? onRemoveTap;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final discountLabel = product.discountLabel;
    final originalUnitPrice = product.originalUnitPrice;

    return Stack(
      children: [
        EditProductSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ProductThumbnail(icon: product.thumbnailIcon),
                  const Gap(12),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: discountLabel == null ? 0 : 48,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const Gap(6),
                          _CodeChip(code: product.code),
                          const Gap(6),
                          Wrap(
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              InvoiceAmountText(
                                value: product.unitPrice.toPersianAmount(),
                                fontSize: 15,
                              ),
                              if (originalUnitPrice != null)
                                Text(
                                  originalUnitPrice.toPersianAmount(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: colorScheme.onSurfaceVariant,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        colorScheme.onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(14),
              Divider(color: colorScheme.outline, height: 1),
              const Gap(14),
              if (quantity > 0)
                _buildSelectedFooter(context)
              else
                _buildAddFooter(context),
            ],
          ),
        ),
        if (discountLabel != null)
          PositionedDirectional(
            top: 0,
            end: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: colorScheme.error,
                borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(_radius),
                  bottomStart: Radius.circular(12),
                ),
              ),
              child: Text(
                discountLabel,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onError,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedFooter(BuildContext context) {
    final colorScheme = context.colorScheme;
    final saving = product.unitSaving * quantity;

    return Row(
      children: [
        _QuantityStepper(
          quantityLabel: quantity.toPersianDigits(),
          onIncrement: onIncrement,
          onDecrement: onDecrement,
          onRemoveTap: onRemoveTap,
        ),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (saving > 0) ...[
                _SavingPill(
                  label: 'سود شما: ${saving.toPersianAmount()} تومان',
                ),
                const Gap(6),
              ],
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'جمع جزء: ',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                    TextSpan(
                      text:
                          '${(product.unitPrice * quantity).toPersianAmount()} تومان',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddFooter(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final note = product.note;

    return Row(
      children: [
        Material(
          color: isDark ? colorScheme.primary : colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onAddTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: isDark
                        ? colorScheme.onPrimary
                        : colorScheme.onSecondary,
                  ),
                  const Gap(6),
                  Text(
                    'افزودن',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? colorScheme.onPrimary
                          : colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(12),
        if (note != null)
          Expanded(
            child: Text(
              note,
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
    );
  }
}

/// Grey "کد: FMR - 101" tag.
class _CodeChip extends StatelessWidget {
  const _CodeChip({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Text(
        'کد: $code',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Green "سود شما: ..." pill shown for discounted products.
class _SavingPill extends StatelessWidget {
  const _SavingPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isDark
              ? colorScheme.tertiary
              : colorScheme.onTertiaryContainer,
        ),
      ),
    );
  }
}

/// Bordered "+ count − 🗑" group, ordered from the start (right) side.
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantityLabel,
    this.onIncrement,
    this.onDecrement,
    this.onRemoveTap,
  });

  final String quantityLabel;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemoveTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final accent = isDark ? colorScheme.primary : colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InvoiceStepperButton(
            icon: Icons.add_rounded,
            iconColor: isDark ? colorScheme.onPrimary : colorScheme.onSecondary,
            backgroundColor: accent,
            borderColor: accent,
            onTap: onIncrement,
          ),
          SizedBox(
            width: 30,
            child: Text(
              quantityLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
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
            backgroundColor: colorScheme.surface,
            borderColor: colorScheme.outline,
            onTap: onDecrement,
          ),
          const Gap(4),
          InvoiceStepperButton(
            icon: Icons.delete_outline_rounded,
            iconColor: colorScheme.error,
            backgroundColor: colorScheme.errorContainer.withValues(
              alpha: isDark ? 0.4 : 0.5,
            ),
            borderColor: colorScheme.error.withValues(alpha: 0.3),
            onTap: onRemoveTap,
          ),
        ],
      ),
    );
  }
}
