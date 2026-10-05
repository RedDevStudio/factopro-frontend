import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_amount_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Fixed bottom bar of the product picker: selected item count and total on
/// one row, then the "ذخیره و بازگشت به فاکتور" button. Expects an RTL
/// [Directionality] ancestor.
class InvoiceProductPickerBottomBar extends StatelessWidget {
  const InvoiceProductPickerBottomBar({
    super.key,
    required this.selectedCount,
    required this.total,
    this.onSaveTap,
  });

  final int selectedCount;
  final int total;
  final VoidCallback? onSaveTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final accent = isDark ? colorScheme.primary : colorScheme.secondary;
    final onAccent = isDark ? colorScheme.onPrimary : colorScheme.onSecondary;

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
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(6),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'انتخاب شده: ',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          TextSpan(
                            text: '${selectedCount.toPersianDigits()} قلم کالا',
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
                  ),
                  const Spacer(),
                  Text(
                    'مبلغ کل:',
                    style: TextStyle(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(6),
                  InvoiceAmountText(
                    value: total.toPersianAmount(),
                    fontSize: 16,
                  ),
                ],
              ),
              const Gap(12),
              PrimaryButton(
                onTap: onSaveTap ?? () {},
                labelText: 'ذخیره و بازگشت به فاکتور',
                labelFontSize: 15,
                icon: Icons.check_rounded,
                isIconAtEnd: true,
                backgroundColor: accent,
                labelTextColor: onAccent,
                borderColor: accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
