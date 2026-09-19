import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The footer area of the invoices screen: excel/tax export row plus the
/// prominent "صدور فاکتور جدید" (issue new invoice) button.
class InvoicesBottomBar extends StatelessWidget {
  const InvoicesBottomBar({super.key, this.onExportTap, this.onNewInvoiceTap});

  final VoidCallback? onExportTap;
  final VoidCallback? onNewInvoiceTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onExportTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Row(
              children: [
                Icon(Icons.download_outlined, size: 16, color: colorScheme.primary),
                const Gap(6),
                Text(
                  'دانلود خروجی',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  'خروجی گزارشات اکسل و مالیات',
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        const Gap(12),
        PrimaryButton(
          onTap: onNewInvoiceTap ?? () {},
          labelText: 'صدور فاکتور جدید',
          icon: Icons.add,
          backgroundColor: isDark ? colorScheme.primary : colorScheme.secondary,
          labelTextColor: isDark ? colorScheme.onPrimary : colorScheme.onSecondary,
          borderColor: isDark ? colorScheme.primary : colorScheme.secondary,
        ),
      ],
    );
  }
}
