import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Icon + label button of the final invoice and thermal receipt action
/// rows. Defaults to a bordered surface button with an accent label.
class InvoiceReceiptActionButton extends StatelessWidget {
  const InvoiceReceiptActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.height = 52,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  /// Defaults to [ColorScheme.surface].
  final Color? backgroundColor;

  /// Icon and label color. Defaults to the brand accent.
  final Color? foregroundColor;

  /// Defaults to [ColorScheme.outline].
  final Color? borderColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final foreground =
        foregroundColor ??
        (isDark ? colorScheme.onSurface : colorScheme.secondary);

    return Material(
      color: backgroundColor ?? colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor ?? colorScheme.outline),
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 19, color: foreground),
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
