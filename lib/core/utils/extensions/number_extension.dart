extension PersianNumberExtension on int {
  static const _persianDigits = '۰۱۲۳۴۵۶۷۸۹';

  /// e.g. `25` -> `'۲۵'`.
  String toPersianDigits() => _localize(toString());

  /// Thousands-separated amount, e.g. `1500000` -> `'۱,۵۰۰,۰۰۰'`.
  String toPersianAmount() => _localize(
    toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ','),
  );

  static String _localize(String value) => value.replaceAllMapped(
    RegExp(r'\d'),
    (match) => _persianDigits[int.parse(match[0]!)],
  );
}

extension PersianStringNumberExtension on String {
  /// Parses user-typed digits (Persian, Arabic or Latin), ignoring
  /// separators and any other characters, e.g. `'۱۰۰,۰۰۰'` -> `100000`.
  /// Returns null when there are no digits.
  int? parseLocalizedInt() {
    final digits = replaceAllMapped(RegExp('[۰-۹٠-٩]'), (match) {
      final code = match[0]!.codeUnitAt(0);
      return '${code >= 0x06F0 ? code - 0x06F0 : code - 0x0660}';
    }).replaceAll(RegExp(r'\D'), '');
    return int.tryParse(digits);
  }
}
