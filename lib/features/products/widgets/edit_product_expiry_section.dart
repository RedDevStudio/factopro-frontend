import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_dropdown.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "تاریخ انقضا و سری ساخت" card: enable switch, expiry date, batch/lot
/// number and the "warn before expiry" dropdown. The body is dimmed and
/// non-interactive while disabled. Expects an RTL [Directionality] ancestor.
class EditProductExpirySection extends StatelessWidget {
  const EditProductExpirySection({
    super.key,
    required this.isEnabled,
    required this.expiryDateController,
    required this.batchNumberController,
    required this.warningOptions,
    required this.selectedWarningOption,
    this.onEnabledChanged,
    this.onWarningOptionChanged,
  });

  final bool isEnabled;
  final TextEditingController expiryDateController;
  final TextEditingController batchNumberController;
  final List<String> warningOptions;
  final String selectedWarningOption;
  final ValueChanged<bool>? onEnabledChanged;
  final ValueChanged<String>? onWarningOptionChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return EditProductSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditProductSectionHeader(
            icon: Icons.verified_user_outlined,
            title: 'تاریخ انقضا و سری ساخت',
            subtitle: 'کنترل سلامت و چرخه انبارداری',
            iconColor: colorScheme.primary,
            iconBackgroundColor: colorScheme.primaryContainer,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: EditProductTextField(
                          label: 'تاریخ انقضا',
                          controller: expiryDateController,
                          suffixIcon: Icons.access_time_rounded,
                          readOnly: true,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: EditProductTextField(
                          label: 'سری ساخت (\u2066Batch / Lot\u2069)',
                          controller: batchNumberController,
                          suffixIcon: Icons.qr_code_2_rounded,
                          isLtrValue: true,
                          isBoldValue: true,
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  EditProductDropdown(
                    label: 'ارسال هشدار پیش از رسیدن تاریخ انقضا',
                    value: selectedWarningOption,
                    options: warningOptions,
                    leadingIcon: Icons.notifications_active_outlined,
                    leadingIconColor: colorScheme.tertiary,
                    onChanged: (option) => onWarningOptionChanged?.call(option),
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
