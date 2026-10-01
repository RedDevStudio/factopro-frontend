import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:factopro/features/products/widgets/product_warning_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// How the timed discount amount is entered.
enum EditProductDiscountType { amount, percent }

/// "تخفیف هوشمند زمان‌دار" card: enable switch, amount/percent toggle,
/// discount value, resulting final price, campaign dates and the countdown
/// banner. The body is dimmed and non-interactive while disabled. Expects an
/// RTL [Directionality] ancestor.
class EditProductDiscountSection extends StatelessWidget {
  const EditProductDiscountSection({
    super.key,
    required this.isEnabled,
    required this.discountType,
    required this.discountValueController,
    required this.finalPriceController,
    required this.startDateController,
    required this.endDateController,
    required this.countdownLabel,
    this.onEnabledChanged,
    this.onDiscountTypeChanged,
  });

  final bool isEnabled;
  final EditProductDiscountType discountType;
  final TextEditingController discountValueController;
  final TextEditingController finalPriceController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  /// e.g. "۱۲ روز و ۸ ساعت مانده".
  final String countdownLabel;
  final ValueChanged<bool>? onEnabledChanged;
  final ValueChanged<EditProductDiscountType>? onDiscountTypeChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final warningColor = ProductWarningColors.of(context);
    final isPercent = discountType == EditProductDiscountType.percent;

    return EditProductSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditProductSectionHeader(
            icon: Icons.timer_outlined,
            title: 'تخفیف هوشمند زمان‌دار',
            subtitle: 'اعمال بازه انقضای خودکار تخفیف',
            iconColor: warningColor,
            iconBackgroundColor: ProductWarningColors.containerOf(context),
            trailing: CupertinoSwitch(
              value: isEnabled,
              activeTrackColor: colorScheme.tertiary,
              onChanged: onEnabledChanged,
            ),
          ),
          const Gap(16),
          IgnorePointer(
            ignoring: !isEnabled,
            child: AnimatedOpacity(
              opacity: isEnabled ? 1 : 0.45,
              duration: const Duration(milliseconds: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DiscountTypeToggle(
                    selected: discountType,
                    onChanged: onDiscountTypeChanged,
                  ),
                  const Gap(16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: EditProductTextField(
                          label: isPercent ? 'درصد اعمالی' : 'مبلغ اعمالی',
                          controller: discountValueController,
                          suffixText: isPercent ? '%' : 'تومان',
                          keyboardType: TextInputType.number,
                          isBoldValue: true,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: EditProductTextField(
                          label: 'قیمت نهایی پس از کسر',
                          controller: finalPriceController,
                          suffixText: 'تومان',
                          readOnly: true,
                          isBoldValue: true,
                          accentColor: colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: EditProductTextField(
                          label: 'شروع جشنواره',
                          controller: startDateController,
                          suffixIcon: Icons.calendar_month_outlined,
                          readOnly: true,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: EditProductTextField(
                          label: 'پایان تخفیف',
                          controller: endDateController,
                          suffixIcon: Icons.calendar_month_outlined,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ProductWarningColors.containerOf(context)
                          .withValues(alpha: isDark ? 0.35 : 1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: warningColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history_toggle_off_rounded,
                          size: 18,
                          color: warningColor,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            'شمارش معکوس اتمام اعتبار تخفیف:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ProductWarningColors.onContainerOf(
                                context,
                              ),
                            ),
                          ),
                        ),
                        const Gap(8),
                        Flexible(
                          child: Text(
                            countdownLabel,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? warningColor
                                  : ProductWarningColors.onContainerOf(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Segmented "مبلغی (تومان)" / "درصدی (٪)" switch.
class _DiscountTypeToggle extends StatelessWidget {
  const _DiscountTypeToggle({required this.selected, this.onChanged});

  final EditProductDiscountType selected;
  final ValueChanged<EditProductDiscountType>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    Widget option(EditProductDiscountType type, String label) {
      final isSelected = type == selected;

      return Expanded(
        child: GestureDetector(
          onTap: onChanged == null ? null : () => onChanged!(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 9),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark ? colorScheme.primary : colorScheme.surface)
                  : colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
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
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (isDark ? colorScheme.onPrimary : colorScheme.primary)
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
          option(EditProductDiscountType.amount, 'مبلغی (تومان)'),
          option(EditProductDiscountType.percent, 'درصدی (٪)'),
        ],
      ),
    );
  }
}
