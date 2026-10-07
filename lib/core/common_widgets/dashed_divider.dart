import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Horizontal dashed line that fills the available width.
class DashedDivider extends StatelessWidget {
  const DashedDivider({
    super.key,
    this.color,
    this.thickness = 1.5,
    this.dashLength = 6,
    this.gapLength = 4,
  });

  /// Defaults to [ColorScheme.outline].
  final Color? color;
  final double thickness;
  final double dashLength;
  final double gapLength;

  @override
  Widget build(BuildContext context) {
    final dashColor = color ?? context.colorScheme.outline;

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = (constraints.maxWidth / (dashLength + gapLength))
            .floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(
              width: dashLength,
              height: thickness,
              color: dashColor,
            ),
          ),
        );
      },
    );
  }
}

/// Dashed separator with half-circle notches cut into both card edges, as on
/// a tear-off receipt. [notchColor] should match the background behind the
/// card.
class ReceiptTearLine extends StatelessWidget {
  const ReceiptTearLine({
    super.key,
    this.notchColor,
    this.lineColor,
    this.notchSize = 20,
  });

  /// Defaults to [ColorScheme.outlineVariant].
  final Color? notchColor;

  /// Defaults to [ColorScheme.outline].
  final Color? lineColor;
  final double notchSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    Widget notch() => Container(
      width: notchSize,
      height: notchSize,
      decoration: BoxDecoration(
        color: notchColor ?? colorScheme.outlineVariant,
        shape: BoxShape.circle,
      ),
    );

    return SizedBox(
      height: notchSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DashedDivider(color: lineColor),
          ),
          PositionedDirectional(start: -notchSize / 2 - 1, child: notch()),
          PositionedDirectional(end: -notchSize / 2 - 1, child: notch()),
        ],
      ),
    );
  }
}
