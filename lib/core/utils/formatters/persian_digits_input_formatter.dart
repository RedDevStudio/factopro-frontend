import 'package:flutter/services.dart';

import 'package:factopro/core/utils/extensions/number_extension.dart';

/// Shows every digit the user types (Latin or Arabic-Indic) as a Persian
/// digit. Each digit maps to exactly one character, so the selection stays
/// valid as-is.
class PersianDigitsInputFormatter extends TextInputFormatter {
  const PersianDigitsInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.toPersianDigits();
    return text == newValue.text ? newValue : newValue.copyWith(text: text);
  }
}
