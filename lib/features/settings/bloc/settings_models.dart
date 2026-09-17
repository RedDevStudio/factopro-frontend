import 'package:flutter/material.dart';

enum AppDisplayMode {
  system,
  dark,
  light;

  String get label => switch (this) {
    AppDisplayMode.system => 'سیستم',
    AppDisplayMode.dark => 'تاریک',
    AppDisplayMode.light => 'روشن',
  };

  IconData get icon => switch (this) {
    AppDisplayMode.system => Icons.desktop_windows_outlined,
    AppDisplayMode.dark => Icons.dark_mode_outlined,
    AppDisplayMode.light => Icons.light_mode_outlined,
  };
}

enum AppFontFamily {
  iranYekan,
  vazirmatn,
  sahel,
  shabnam;

  String get label => switch (this) {
    AppFontFamily.iranYekan => 'ایران‌یکان',
    AppFontFamily.vazirmatn => 'وزیرمتن (پیش‌فرض)',
    AppFontFamily.sahel => 'ساحل',
    AppFontFamily.shabnam => 'شبنم',
  };
}

enum AppFontSize {
  small,
  medium,
  large,
  extraLarge;

  String get label => switch (this) {
    AppFontSize.small => 'کوچک',
    AppFontSize.medium => 'معمولی',
    AppFontSize.large => 'بزرگ',
    AppFontSize.extraLarge => 'خیلی‌بزرگ',
  };
}

enum SubscriptionPlan {
  free,
  pro,
  gold;

  String get title => switch (this) {
    SubscriptionPlan.free => 'پایه (معمولی)',
    SubscriptionPlan.pro => 'نقره‌ای حرفه‌ای (Pro)',
    SubscriptionPlan.gold => 'تجارت (Gold)',
  };

  String get subtitle => switch (this) {
    SubscriptionPlan.free => 'رایگان',
    SubscriptionPlan.pro => 'انبار + پوز بانکی',
    SubscriptionPlan.gold => 'نامحدود',
  };

  String get badge => switch (this) {
    SubscriptionPlan.free => '۵۰ فاکتور در ماه',
    SubscriptionPlan.pro => 'نقره‌ای',
    SubscriptionPlan.gold => 'هوش مصنوعی',
  };

  IconData get icon => switch (this) {
    SubscriptionPlan.free => Icons.person_outline,
    SubscriptionPlan.pro => Icons.workspace_premium_outlined,
    SubscriptionPlan.gold => Icons.storefront_outlined,
  };
}

enum PrinterPaperWidth {
  mm58,
  mm80;

  String get label => switch (this) {
    PrinterPaperWidth.mm58 => '۵۸ میلی‌متر',
    PrinterPaperWidth.mm80 => '۸۰ میلی‌متر',
  };
}
