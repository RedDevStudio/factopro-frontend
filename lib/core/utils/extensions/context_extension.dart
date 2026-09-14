import 'package:flutter/material.dart';

extension ContextExtention on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
