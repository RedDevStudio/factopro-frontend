import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Low-emphasis full-width outlined button under the primary action, e.g.
/// "قبلا ثبت نام کرده‌اید؟ ورود به حساب".
class OnboardingSecondaryButton extends StatelessWidget {
  const OnboardingSecondaryButton({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: colorScheme.outline),
    );

    return Material(
      color: isDark
          ? colorScheme.primaryContainer.withValues(alpha: 0.4)
          : colorScheme.outlineVariant,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: SizedBox(
          height: 44,
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
