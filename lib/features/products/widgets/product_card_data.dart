import 'package:flutter/material.dart';

/// Which accent a [ProductCardData.infoLabel] banner should use.
enum ProductInfoType { neutral, warning, success }

/// Static, UI-only representation of a single product list card.
class ProductCardData {
  const ProductCardData({
    required this.name,
    required this.categoryLabel,
    required this.code,
    required this.thumbnailIcon,
    required this.stockLabel,
    required this.isLowStock,
    required this.priceValue,
    required this.infoLabel,
    required this.infoIcon,
    required this.infoType,
    this.originalPriceValue,
    this.discountPercentLabel,
    this.discountRibbonLabel,
  });

  final String name;
  final String categoryLabel;
  final String code;
  final IconData thumbnailIcon;

  final String stockLabel;
  final bool isLowStock;

  final String priceValue;

  /// Struck-through price shown above [priceValue] when the item is
  /// discounted.
  final String? originalPriceValue;

  /// e.g. "۱۵٪", shown next to [originalPriceValue].
  final String? discountPercentLabel;

  /// e.g. "تخفیف", shown as a ribbon over the thumbnail when discounted.
  final String? discountRibbonLabel;

  final String infoLabel;
  final IconData infoIcon;
  final ProductInfoType infoType;
}

/// A single option in the category filter chips row.
class ProductCategoryData {
  const ProductCategoryData({required this.label, this.count});

  final String label;

  /// Shown next to the label, e.g. "همه (۲۴)". Null for plain category chips.
  final String? count;
}
