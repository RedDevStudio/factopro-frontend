import 'dart:async';

import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:flutter/material.dart';

/// Rebuilds every second with the time left from [duration] down to zero.
/// Give it a new [Key] to restart the countdown.
class CountdownBuilder extends StatefulWidget {
  const CountdownBuilder({
    super.key,
    required this.duration,
    required this.builder,
  });

  final Duration duration;
  final Widget Function(BuildContext context, Duration remaining) builder;

  /// e.g. `Duration(seconds: 105)` -> `'۰۱:۴۵'`.
  static String format(Duration remaining) {
    String twoDigits(int value) =>
        value.toPersianDigits().padLeft(2, 0.toPersianDigits());
    return '${twoDigits(remaining.inMinutes)}:'
        '${twoDigits(remaining.inSeconds % 60)}';
  }

  @override
  State<CountdownBuilder> createState() => _CountdownBuilderState();
}

class _CountdownBuilderState extends State<CountdownBuilder> {
  late Duration _remaining = widget.duration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _remaining -= const Duration(seconds: 1));
      if (_remaining <= Duration.zero) timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _remaining);
}
