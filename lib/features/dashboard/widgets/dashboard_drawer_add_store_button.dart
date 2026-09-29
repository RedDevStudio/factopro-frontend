import 'dart:ui';

import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardDrawerAddStoreButton extends StatelessWidget {
  const DashboardDrawerAddStoreButton({super.key, this.onTap});

  final VoidCallback? onTap;

  static const _radius = 12.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final accentColor = isDark ? colorScheme.primary : colorScheme.secondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_radius),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: accentColor.withValues(alpha: 0.45),
          radius: _radius,
        ),
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: isDark
                ? colorScheme.primary.withValues(alpha: 0.08)
                : colorScheme.primaryContainer.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ثبت فروشگاه جدید',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              const Gap(6),
              Icon(Icons.add_rounded, size: 18, color: accentColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const _dashLength = 4.0;
  static const _gapLength = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          (Offset.zero & size).deflate(0.5),
          Radius.circular(radius),
        ),
      );

    for (final PathMetric metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + _dashLength),
          paint,
        );
        distance += _dashLength + _gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
