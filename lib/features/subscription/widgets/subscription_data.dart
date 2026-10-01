import 'package:flutter/material.dart';

/// Visual tier of a plan card; drives its icon tint, price color and
/// background.
enum SubscriptionPlanTier { basic, pro, gold }

/// A single included-feature line of a plan card.
class SubscriptionFeatureData {
  const SubscriptionFeatureData(this.label, {this.isHighlighted = false});

  final String label;

  /// Emphasized (bold, accent-colored) headline feature.
  final bool isHighlighted;
}

/// Static, UI-only representation of a subscription plan card.
class SubscriptionPlanData {
  const SubscriptionPlanData({
    required this.tier,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.features,
    required this.ctaLabel,
    this.selectedCtaLabel,
    this.priceValue,
    this.originalPriceValue,
    this.priceUnitLabel = 'تومان / ماه',
    this.tagLabel,
    this.recommendationLabel,
    this.isCurrent = false,
  });

  final SubscriptionPlanTier tier;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<SubscriptionFeatureData> features;

  /// Button label while the plan is not selected, e.g. "انتخاب طرح حرفه‌ای".
  /// For the [isCurrent] plan this is the "طرح فعلی ..." label.
  final String ctaLabel;

  /// Button label once the plan is selected, e.g.
  /// "طرح انتخاب شده: تجارت هوشمند".
  final String? selectedCtaLabel;

  /// e.g. "۲۹۰,۰۰۰". Null for free plans, which show [tagLabel] instead.
  final String? priceValue;

  /// Struck-through price shown above [priceValue].
  final String? originalPriceValue;
  final String priceUnitLabel;

  /// Small pill shown in place of the price, e.g. "رایگان".
  final String? tagLabel;

  /// Badge shown at the top of the card, e.g. "پیشنهاد ویژه اصناف و شرکت‌ها".
  final String? recommendationLabel;

  /// The user's active plan; it can't be selected for upgrade.
  final bool isCurrent;
}

/// One option of the billing-period segmented selector.
class SubscriptionBillingPeriodData {
  const SubscriptionBillingPeriodData({
    required this.label,
    required this.caption,
    this.isDiscounted = false,
  });

  /// e.g. "۶ ماهه".
  final String label;

  /// e.g. "۱۵٪ تخفیف" or "تعرفه عادی".
  final String caption;

  /// Discount captions are shown in the success color.
  final bool isDiscounted;
}

/// A payment gateway tile.
class SubscriptionGatewayData {
  const SubscriptionGatewayData({required this.name, required this.caption});

  final String name;
  final String caption;
}

/// A line of the final invoice summary.
class SubscriptionInvoiceLineData {
  const SubscriptionInvoiceLineData({
    required this.label,
    required this.value,
    this.icon,
    this.isDiscount = false,
  });

  final String label;

  /// Formatted amount including the currency, e.g. "۵,۸۸۰,۰۰۰ تومان".
  final String value;
  final IconData? icon;

  /// Discount lines are shown in the success color.
  final bool isDiscount;
}
