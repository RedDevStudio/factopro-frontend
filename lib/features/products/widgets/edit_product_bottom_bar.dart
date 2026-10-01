import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Fixed bottom bar of the edit product screen: "انصراف" (cancel) on the
/// start (right) side, the wider "ذخیره تغییرات محصول" (save) button on the
/// end (left) side. Expects an RTL [Directionality] ancestor.
class EditProductBottomBar extends StatelessWidget {
  const EditProductBottomBar({super.key, this.onCancelTap, this.onSaveTap});

  final VoidCallback? onCancelTap;
  final VoidCallback? onSaveTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline)),
      ),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onTap: onCancelTap ?? () {},
                  labelText: 'انصراف',
                  labelFontSize: 14,
                  backgroundColor: colorScheme.primaryContainer,
                  labelTextColor: isDark
                      ? colorScheme.onSurface
                      : colorScheme.primary,
                  borderColor: isDark
                      ? colorScheme.outline
                      : colorScheme.primaryContainer,
                ),
              ),
              const Gap(12),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  onTap: onSaveTap ?? () {},
                  labelText: 'ذخیره تغییرات محصول',
                  labelFontSize: 14,
                  icon: Icons.save_as_outlined,
                  backgroundColor: isDark
                      ? colorScheme.primary
                      : colorScheme.secondary,
                  labelTextColor: isDark
                      ? colorScheme.onPrimary
                      : colorScheme.onSecondary,
                  borderColor: isDark
                      ? colorScheme.primary
                      : colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
