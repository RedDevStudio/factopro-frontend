import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:factopro/features/products/widgets/product_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "قیمت‌گذاری و انبار" card: profit margin badge, selling/purchase prices,
/// current stock stepper and the low-stock warning row. Expects an RTL
/// [Directionality] ancestor.
class EditProductPricingSection extends StatelessWidget {
  const EditProductPricingSection({
    super.key,
    required this.sellingPriceController,
    required this.purchasePriceController,
    required this.profitMarginLabel,
    required this.stockCountLabel,
    required this.lowStockThresholdLabel,
    this.showLowStockWarning = true,
    this.onStockIncrement,
    this.onStockDecrement,
  });

  final TextEditingController sellingPriceController;
  final TextEditingController purchasePriceController;

  /// e.g. "۳۵٪ حاشیه سود".
  final String profitMarginLabel;

  /// e.g. "۲۵".
  final String stockCountLabel;

  /// e.g. "آستانه اعلان: ۵ عدد".
  final String lowStockThresholdLabel;
  final bool showLowStockWarning;
  final VoidCallback? onStockIncrement;
  final VoidCallback? onStockDecrement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return EditProductSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditProductSectionHeader(
            icon: Icons.price_change_outlined,
            title: 'قیمت‌گذاری و انبار',
            iconColor: colorScheme.primary,
            iconBackgroundColor: colorScheme.primaryContainer,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorScheme.tertiary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    profitMarginLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const Gap(4),
                  Icon(
                    Icons.trending_up_rounded,
                    size: 14,
                    color: colorScheme.tertiary,
                  ),
                ],
              ),
            ),
          ),
          const Gap(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: EditProductTextField(
                  label: 'قیمت فروش مصوب',
                  controller: sellingPriceController,
                  suffixText: 'تومان',
                  keyboardType: TextInputType.number,
                  isBoldValue: true,
                ),
              ),
              const Gap(12),
              Expanded(
                child: EditProductTextField(
                  label: 'قیمت خرید و تمام‌شده',
                  controller: purchasePriceController,
                  suffixText: 'تومان',
                  keyboardType: TextInputType.number,
                  isBoldValue: true,
                ),
              ),
            ],
          ),
          const Gap(14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 18,
                  color: colorScheme.primary,
                ),
                const Gap(8),
                Expanded(
                  child: Text(
                    'موجودی فعلی در انبار',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                _StepperButton(
                  icon: Icons.add_rounded,
                  onTap: onStockIncrement,
                ),
                SizedBox(
                  width: 44,
                  child: Text(
                    stockCountLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                _StepperButton(
                  icon: Icons.remove_rounded,
                  onTap: onStockDecrement,
                ),
              ],
            ),
          ),
          const Gap(12),
          Row(
            children: [
              if (showLowStockWarning) ...[
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: ProductWarningColors.of(context),
                ),
                const Gap(6),
                Expanded(
                  child: Text(
                    'هشدار کسری موجودی',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ProductWarningColors.of(context),
                    ),
                  ),
                ),
                const Gap(8),
              ] else
                const Spacer(),
              Text(
                lowStockThresholdLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Icon(icon, size: 16, color: colorScheme.onSurface),
      ),
    );
  }
}
