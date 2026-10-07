import 'package:flutter/material.dart';

/// Decorative 1D barcode drawn from [data]. Bar widths are derived from the
/// characters so the same value always renders the same pattern; it is not
/// a scannable symbology.
class InvoiceBarcode extends StatelessWidget {
  const InvoiceBarcode({
    super.key,
    required this.data,
    required this.color,
    this.height = 56,
  });

  final String data;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _BarcodePainter(data: data, color: color),
      ),
    );
  }
}

class _BarcodePainter extends CustomPainter {
  const _BarcodePainter({required this.data, required this.color});

  final String data;
  final Color color;

  /// Alternating bar/space widths in modules: guard, data, guard.
  List<int> get _modules {
    final modules = <int>[1, 1, 1];
    for (final unit in data.codeUnits) {
      modules
        ..add(1 + unit % 3)
        ..add(1 + (unit ~/ 3) % 2)
        ..add(1 + (unit ~/ 7) % 3)
        ..add(1 + (unit ~/ 5) % 2);
    }
    // Keep bar/space alternation intact before the closing guard.
    if (modules.length.isEven) modules.add(1);
    return modules..addAll([1, 1, 1]);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final modules = _modules;
    final totalModules = modules.fold(0, (sum, width) => sum + width);
    final moduleWidth = size.width / totalModules;
    final paint = Paint()..color = color;

    var x = 0.0;
    for (final (index, width) in modules.indexed) {
      final barWidth = width * moduleWidth;
      if (index.isEven) {
        canvas.drawRect(Rect.fromLTWH(x, 0, barWidth, size.height), paint);
      }
      x += barWidth;
    }
  }

  @override
  bool shouldRepaint(_BarcodePainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.color != color;
}
