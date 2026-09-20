import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The "افزودن محصول جدید" (add new product) button at the bottom of the
/// products screen.
class ProductsBottomBar extends StatelessWidget {
  const ProductsBottomBar({super.key, this.onAddProductTap});

  final VoidCallback? onAddProductTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return PrimaryButton(
      onTap: onAddProductTap ?? () {},
      labelText: 'افزودن محصول جدید',
      icon: Icons.add,
      backgroundColor: isDark ? colorScheme.primary : colorScheme.secondary,
      labelTextColor: isDark ? colorScheme.onPrimary : colorScheme.onSecondary,
      borderColor: isDark ? colorScheme.primary : colorScheme.secondary,
    );
  }
}
