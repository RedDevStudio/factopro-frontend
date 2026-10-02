import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Visual weight of a [SubscriptionActionButton].
enum SubscriptionActionButtonStyle {
  /// Accent fill, e.g. "مشاهده فاکتور" of the latest transaction.
  filled,

  /// Light primary-container fill, e.g. "دانلود PDF فیش".
  tonal,

  /// Surface fill, e.g. the support card's "تماس تلفنی".
  surface,
}

/// Compact icon + label button used across the receipt and payment history
/// screens. Expects an RTL [Directionality] ancestor.
class SubscriptionActionButton extends StatelessWidget {
  const SubscriptionActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.style = SubscriptionActionButtonStyle.tonal,
    this.height = 44,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final SubscriptionActionButtonStyle style;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);
    final (background, foreground) = switch (style) {
      SubscriptionActionButtonStyle.filled => (
        accent,
        SubscriptionColors.onAccentOf(context),
      ),
      SubscriptionActionButtonStyle.tonal => (
        colorScheme.primary.withValues(alpha: 0.12),
        accent,
      ),
      SubscriptionActionButtonStyle.surface => (colorScheme.surface, accent),
    };

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: foreground),
                const Gap(6),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: foreground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
