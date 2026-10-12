import 'package:flutter/material.dart';

/// Horizontal dashed rule used on receipts.
class InvoiceDashedLine extends StatelessWidget {
  const InvoiceDashedLine({
    super.key,
    required this.color,
    this.thickness = 1,
    this.dashLength = 5,
    this.gapLength = 4,
  });

  final Color color;
  final double thickness;
  final double dashLength;
  final double gapLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thickness,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color,
          dashLength: dashLength,
          gapLength: gapLength,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter({
    required this.color,
    required this.dashLength,
    required this.gapLength,
  });

  final Color color;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var x = 0.0; x < size.width; x += dashLength + gapLength) {
      canvas.drawRect(
        Rect.fromLTWH(x, 0, (size.width - x).clamp(0, dashLength), size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dashLength != dashLength ||
      oldDelegate.gapLength != gapLength;
}

/// Ticket "tear" line: a dashed rule with a half-circle notch cut into each
/// side of the card. [notchColor] should match the background behind the
/// card so the notches read as holes. The circles are centered on the
/// divider's edges, so the card must not clip its children horizontally.
class InvoiceTicketDivider extends StatelessWidget {
  const InvoiceTicketDivider({
    super.key,
    required this.lineColor,
    required this.notchColor,
    this.notchRadius = 8,
  });

  final Color lineColor;
  final Color notchColor;
  final double notchRadius;

  @override
  Widget build(BuildContext context) {
    final diameter = notchRadius * 2;
    final notch = Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(color: notchColor, shape: BoxShape.circle),
    );

    return SizedBox(
      height: diameter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: notchRadius + 6),
            child: InvoiceDashedLine(color: lineColor),
          ),
          Positioned(left: -notchRadius, child: notch),
          Positioned(right: -notchRadius, child: notch),
        ],
      ),
    );
  }
}

/// Zig-zag torn-paper edge drawn below a receipt, filled with [color].
class InvoiceZigzagEdge extends StatelessWidget {
  const InvoiceZigzagEdge({
    super.key,
    required this.color,
    this.toothWidth = 12,
    this.height = 6,
  });

  final Color color;
  final double toothWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _ZigzagPainter(color: color, toothWidth: toothWidth),
      ),
    );
  }
}

class _ZigzagPainter extends CustomPainter {
  const _ZigzagPainter({required this.color, required this.toothWidth});

  final Color color;
  final double toothWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final teeth = (size.width / toothWidth).ceil();
    final step = size.width / teeth;
    final path = Path()..moveTo(0, 0);
    for (var i = 0; i < teeth; i++) {
      path
        ..lineTo(step * i + step / 2, size.height)
        ..lineTo(step * (i + 1), 0);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_ZigzagPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.toothWidth != toothWidth;
}
