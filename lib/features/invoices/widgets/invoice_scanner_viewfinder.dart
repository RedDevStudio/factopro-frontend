import 'package:flutter/material.dart';

/// The scan frame drawn over the camera: four rounded corner brackets, a
/// faint dashed outline, a small center target and a red laser line.
class InvoiceScannerViewfinder extends StatelessWidget {
  const InvoiceScannerViewfinder({
    super.key,
    required this.cornerColor,
    required this.laserColor,
    this.width = 260,
    this.height = 210,
  });

  final Color cornerColor;
  final Color laserColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _ViewfinderPainter(
          cornerColor: cornerColor,
          laserColor: laserColor,
        ),
        child: Center(
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  const _ViewfinderPainter({
    required this.cornerColor,
    required this.laserColor,
  });

  final Color cornerColor;
  final Color laserColor;

  static const _cornerLength = 34.0;
  static const _cornerRadius = 14.0;
  static const _strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_strokeWidth / 2);

    // Faint dashed outline between the corners.
    final outlinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final outline = Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(_cornerRadius)),
      );
    for (final metric in outline.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 10) {
        canvas.drawPath(metric.extractPath(d, d + 5), outlinePaint);
      }
    }

    // Corner brackets.
    final cornerPaint = Paint()
      ..color = cornerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    const r = _cornerRadius;
    const l = _cornerLength;
    final corners = [
      Path()
        ..moveTo(rect.left, rect.top + l)
        ..lineTo(rect.left, rect.top + r)
        ..arcToPoint(
          Offset(rect.left + r, rect.top),
          radius: const Radius.circular(r),
        )
        ..lineTo(rect.left + l, rect.top),
      Path()
        ..moveTo(rect.right - l, rect.top)
        ..lineTo(rect.right - r, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + r),
          radius: const Radius.circular(r),
        )
        ..lineTo(rect.right, rect.top + l),
      Path()
        ..moveTo(rect.right, rect.bottom - l)
        ..lineTo(rect.right, rect.bottom - r)
        ..arcToPoint(
          Offset(rect.right - r, rect.bottom),
          radius: const Radius.circular(r),
        )
        ..lineTo(rect.right - l, rect.bottom),
      Path()
        ..moveTo(rect.left + l, rect.bottom)
        ..lineTo(rect.left + r, rect.bottom)
        ..arcToPoint(
          Offset(rect.left, rect.bottom - r),
          radius: const Radius.circular(r),
        )
        ..lineTo(rect.left, rect.bottom - l),
    ];
    for (final corner in corners) {
      canvas.drawPath(corner, cornerPaint);
    }

    // Laser line with a bright dot in the middle.
    final centerY = size.height / 2;
    final laserPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          laserColor.withValues(alpha: 0),
          laserColor,
          laserColor.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, centerY - 1, size.width, 2))
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width * 0.12, centerY),
      Offset(size.width * 0.88, centerY),
      laserPaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, centerY),
      4,
      Paint()..color = laserColor,
    );
  }

  @override
  bool shouldRepaint(_ViewfinderPainter oldDelegate) =>
      oldDelegate.cornerColor != cornerColor ||
      oldDelegate.laserColor != laserColor;
}
