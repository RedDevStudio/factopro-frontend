import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A bold amount followed by a smaller muted "تومان" unit. Expects an RTL
/// [Directionality] ancestor so the unit sits on the end (left) side.
class InvoiceAmountText extends StatelessWidget {
  const InvoiceAmountText({
    super.key,
    required this.value,
    this.fontSize = 14,
    this.unitFontSize = 11,
    this.color,
  });

  /// Pre-formatted amount, e.g. "۱,۵۰۰,۰۰۰".
  final String value;
  final double fontSize;
  final double unitFontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color ?? colorScheme.onSurface,
          ),
        ),
        const Gap(4),
        Text(
          'تومان',
          style: TextStyle(
            fontSize: unitFontSize,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
