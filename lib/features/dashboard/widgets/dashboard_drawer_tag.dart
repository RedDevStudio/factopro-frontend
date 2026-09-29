import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Small bordered label used in the drawer (branch names, store count,
/// stock warnings).
class DashboardDrawerTag extends StatelessWidget {
  const DashboardDrawerTag({
    super.key,
    required this.label,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.bold = false,
  });

  final String label;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDark ? colorScheme.surface : colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor ?? colorScheme.outline),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          color: textColor ?? colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
