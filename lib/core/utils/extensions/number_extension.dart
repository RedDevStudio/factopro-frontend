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
  /// Replaces Latin and Arabic-Indic digits with Persian ones,
  /// e.g. `'PRD-12'` -> `'PRD-۱۲'`.
  String toPersianDigits() => replaceAllMapped(RegExp('[0-9٠-٩]'), (match) {
    final code = match[0]!.codeUnitAt(0);
    return PersianNumberExtension._persianDigits[code >= 0x0660
        ? code - 0x0660
        : code - 0x30];
  });

  /// Replaces Persian and Arabic-Indic digits with Latin ones,
  /// e.g. `'۱۲۳'` -> `'123'`.
  String toLatinDigits() => replaceAllMapped(RegExp('[۰-۹٠-٩]'), (match) {
    final code = match[0]!.codeUnitAt(0);
    return '${code >= 0x06F0 ? code - 0x06F0 : code - 0x0660}';
  });

  /// Parses user-typed digits (Persian, Arabic or Latin), ignoring
  /// separators and any other characters, e.g. `'۱۰۰,۰۰۰'` -> `100000`.
  /// Returns null when there are no digits.
  int? parseLocalizedInt() =>
      int.tryParse(toLatinDigits().replaceAll(RegExp(r'\D'), ''));
}
