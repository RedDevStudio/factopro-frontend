import 'package:flutter/material.dart';

/// Static, UI-only catalog product that can be added to an issued invoice.
/// Prices are in toman.
class InvoiceIssueProductData {
  const InvoiceIssueProductData({
    required this.code,
    required this.name,
    required this.categoryLabel,
    required this.unitPrice,
    required this.thumbnailIcon,
    this.originalUnitPrice,
    this.discountLabel,
    this.note,
  });

  /// Warehouse code, e.g. "FMR - 101". Also identifies the product.
  final String code;
  final String name;
  final String categoryLabel;
  final int unitPrice;
  final IconData thumbnailIcon;

  /// Struck-through price shown next to [unitPrice] when discounted.
  final int? originalUnitPrice;

  /// Corner ribbon text, e.g. "۱۵٪ تخفیف".
  final String? discountLabel;

  /// Short description shown in the picker while the product isn't added.
  final String? note;

  /// Per-unit saving compared to [originalUnitPrice].
  int get unitSaving =>
      originalUnitPrice == null ? 0 : originalUnitPrice! - unitPrice;
}

/// A product line on the invoice being issued.
class InvoiceIssueItemData {
  const InvoiceIssueItemData({required this.product, required this.quantity});

  final InvoiceIssueProductData product;
  final int quantity;

  int get total => product.unitPrice * quantity;

  InvoiceIssueItemData copyWith({int? quantity}) => InvoiceIssueItemData(
    product: product,
    quantity: quantity ?? this.quantity,
  );
}

/// How the invoice-level discount is entered. Declared in the order the
/// segments appear from the start (right) side.
enum InvoiceIssueDiscountMethod {
  code,
  percent,
  amount;

  String get label => switch (this) {
    InvoiceIssueDiscountMethod.code => 'کد تخفیف',
    InvoiceIssueDiscountMethod.percent => 'درصدی (%)',
    InvoiceIssueDiscountMethod.amount => 'مبلغی (تومان)',
  };

  String get fieldLabel => switch (this) {
    InvoiceIssueDiscountMethod.code => 'کد تخفیف مشتری:',
    InvoiceIssueDiscountMethod.percent => 'درصد کسر از فاکتور:',
    InvoiceIssueDiscountMethod.amount => 'مبلغ کسر از فاکتور:',
  };

  String get hintText => switch (this) {
    InvoiceIssueDiscountMethod.code => 'مثلا NOWRUZ',
    InvoiceIssueDiscountMethod.percent => 'مثلا ۱۰',
    InvoiceIssueDiscountMethod.amount => 'مثلا ۱۰۰,۰۰۰',
  };

  String? get unitLabel => switch (this) {
    InvoiceIssueDiscountMethod.code => null,
    InvoiceIssueDiscountMethod.percent => '%',
    InvoiceIssueDiscountMethod.amount => 'تومان',
  };
}

/// Mock catalog shared by the issue invoice and product picker screens.
const invoiceIssueMockCatalog = [
  InvoiceIssueProductData(
    code: 'FMR - 101',
    name: 'برنج طارم هاشمی ممتاز (۵ کیلویی)',
    categoryLabel: 'خواربار و برنج',
    unitPrice: 2200000,
    thumbnailIcon: Icons.rice_bowl_outlined,
  ),
  InvoiceIssueProductData(
    code: 'OIL - 204',
    name: 'روغن آفتابگردان ۱.۵ لیتری',
    categoryLabel: 'روغن و کنسرو',
    unitPrice: 500000,
    originalUnitPrice: 600000,
    discountLabel: '۱۵٪ تخفیف',
    thumbnailIcon: Icons.oil_barrel_outlined,
  ),
  InvoiceIssueProductData(
    code: 'TNA - 305',
    name: 'کنسرو تن ماهی در روغن زیتون',
    categoryLabel: 'روغن و کنسرو',
    unitPrice: 85000,
    thumbnailIcon: Icons.set_meal_outlined,
  ),
  InvoiceIssueProductData(
    code: 'PST - 402',
    name: 'ماکارونی رشته‌ای ۷۰۰ گرمی زر',
    categoryLabel: 'خواربار و برنج',
    unitPrice: 32000,
    originalUnitPrice: 38000,
    discountLabel: '۱۵٪ تخفیف',
    note: 'بسته‌بندی صادراتی زرماکارون',
    thumbnailIcon: Icons.ramen_dining_outlined,
  ),
  InvoiceIssueProductData(
    code: 'DRY - 118',
    name: 'شیر کم‌چرب ۱ لیتری',
    categoryLabel: 'لبنیات',
    unitPrice: 45000,
    note: 'پاستوریزه و هموژنیزه',
    thumbnailIcon: Icons.local_drink_outlined,
  ),
];
