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

/// A label/value row of the electronic payment receipt.
class SubscriptionReceiptDetailData {
  const SubscriptionReceiptDetailData({
    required this.icon,
    required this.label,
    required this.value,
    this.isHighlighted = false,
    this.isCopyable = false,
    this.isLtr = false,
  });

  final IconData icon;
  final String label;
  final String value;

  /// Codes and card numbers that read left-to-right.
  final bool isLtr;

  /// Shown in the success color, e.g. the new period's validity.
  final bool isHighlighted;

  /// Shows a copy icon next to the value, e.g. the Shaparak tracking code.
  final bool isCopyable;
}

/// A feature card of the "امکانات ویژه آنلاک‌شده" section.
class SubscriptionUnlockedFeatureData {
  const SubscriptionUnlockedFeatureData({
    required this.icon,
    required this.title,
    required this.description,
    this.badgeLabel,
    this.isGift = false,
  });

  final IconData icon;
  final String title;
  final String description;

  /// Small pill after the title, e.g. "هدیه تمدید".
  final String? badgeLabel;

  /// Gift features use the amber icon tile.
  final bool isGift;
}

/// Outcome of a subscription payment.
enum SubscriptionTransactionStatus { successful, failed }

/// A card of the subscription payment history list.
class SubscriptionTransactionData {
  const SubscriptionTransactionData({
    required this.title,
    required this.dateLabel,
    required this.timeLabel,
    required this.amount,
    required this.status,
    this.gatewayName,
    this.gatewayIcon = Icons.credit_card_rounded,
    this.trackingCode,
    this.failureReason,
    this.failureBadgeLabel,
    this.failureNote,
    this.hasPdfReceipt = false,
  });

  final String title;

  /// e.g. "۲۴ آبان ۱۴۰۳".
  final String dateLabel;

  /// e.g. "ساعت ۱۴:۳۵".
  final String timeLabel;

  /// e.g. "۴,۸۵۰,۰۰۰".
  final String amount;
  final SubscriptionTransactionStatus status;

  final String? gatewayName;
  final IconData gatewayIcon;
  final String? trackingCode;

  /// e.g. "عدم پاسخ بانک (برگشت خورده)".
  final String? failureReason;

  /// e.g. "برگشت به حساب مبدا".
  final String? failureBadgeLabel;

  /// e.g. "مبلغ ظرف ۲۴ تا ۷۲ ساعت عودت شده است".
  final String? failureNote;

  /// The latest payment offers a PDF receipt next to a filled
  /// "مشاهده فاکتور" button.
  final bool hasPdfReceipt;

  bool get isSuccessful => status == SubscriptionTransactionStatus.successful;
}
