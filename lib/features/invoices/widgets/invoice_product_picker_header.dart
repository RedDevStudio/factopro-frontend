import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:flutter/material.dart';

/// Top of the product picker: back button on the start (right) side, the
/// centered "انتخاب کالا" title and subtitle, and the basket button with the
/// selected-items badge on the end (left) side. Expects an RTL
/// [Directionality] ancestor.
class InvoiceProductPickerHeader extends StatelessWidget {
  const InvoiceProductPickerHeader({
    super.key,
    required this.selectedCount,
    this.onBackTap,
    this.onBasketTap,
  });

  final int selectedCount;
  final VoidCallback? onBackTap;
  final VoidCallback? onBasketTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        _CircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          iconSize: 18,
          onTap: onBackTap,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'انتخاب کالا',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'افزودن خدمات و اقلام به فاکتور',
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _CircleButton(
              icon: Icons.shopping_bag_outlined,
              iconSize: 20,
              onTap: onBasketTap,
            ),
            if (selectedCount > 0)
              PositionedDirectional(
                top: -3,
                end: -3,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 18),
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    selectedCount.toPersianDigits(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onError,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.iconSize, this.onTap});

  final IconData icon;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.outline),
        ),
        child: Icon(icon, size: iconSize, color: colorScheme.onSurface),
      ),
    );
  }
}
