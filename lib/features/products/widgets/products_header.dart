import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Top header of the products screen: a barcode-scan shortcut on the left,
/// the "محصولات" title/subtitle, and the profile avatar on the right.
class ProductsHeader extends StatelessWidget {
  const ProductsHeader({
    super.key,
    required this.subtitle,
    this.onScanTap,
    this.onAvatarTap,
  });

  final String subtitle;
  final VoidCallback? onScanTap;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onScanTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(
              Icons.center_focus_strong_outlined,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'محصولات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const Gap(4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        const Gap(12),
        InkWell(
          onTap: onAvatarTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: colorScheme.secondary, shape: BoxShape.circle),
            child: Icon(Icons.person_outline, size: 22, color: colorScheme.onSecondary),
          ),
        ),
      ],
    );
  }
}
