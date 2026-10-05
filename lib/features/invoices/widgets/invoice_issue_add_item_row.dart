import 'dart:ui';

import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Dashed "افزودن کالا به فاکتور" button on the start (right) side and the
/// compact "بارکد" scan button on the end (left) side. Expects an RTL
/// [Directionality] ancestor.
class InvoiceIssueAddItemRow extends StatelessWidget {
  const InvoiceIssueAddItemRow({super.key, this.onAddTap, this.onBarcodeTap});

  final VoidCallback? onAddTap;
  final VoidCallback? onBarcodeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DashedActionButton(
            icon: Icons.add_circle_outline_rounded,
            label: 'افزودن کالا به فاکتور',
            onTap: onAddTap,
          ),
        ),
        const Gap(12),
        _DashedActionButton(
          icon: Icons.qr_code_scanner_rounded,
          label: 'بارکد',
          onTap: onBarcodeTap,
        ),
      ],
    );
  }
}

class _DashedActionButton extends StatelessWidget {
  const _DashedActionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  static const _radius = 14.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_radius),
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: colorScheme.primary.withValues(alpha: isDark ? 0.45 : 0.55),
          radius: _radius,
        ),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isDark
                ? colorScheme.primary.withValues(alpha: 0.08)
                : colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              const Gap(6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Paints a dashed rounded-rectangle outline around its child.
class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const _strokeWidth = 1.5;
  static const _dashLength = 6.0;
  static const _gapLength = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final rect = (Offset.zero & size).deflate(_strokeWidth / 2);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

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
  bool shouldRepaint(_DashedRRectPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
