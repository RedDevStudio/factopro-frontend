import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_authenticity_card.dart';
import 'package:factopro/features/products/widgets/edit_product_bottom_bar.dart';
import 'package:factopro/features/products/widgets/edit_product_discount_section.dart';
import 'package:factopro/features/products/widgets/edit_product_dropdown.dart';
import 'package:factopro/features/products/widgets/edit_product_expiry_section.dart';
import 'package:factopro/features/products/widgets/edit_product_header.dart';
import 'package:factopro/features/products/widgets/edit_product_image_picker.dart';
import 'package:factopro/features/products/widgets/edit_product_pricing_section.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/edit_product_status_bar.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:factopro/features/products/widgets/product_card_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only product edit form. When opened from a product card, the card's
/// [product] pre-fills the fields it has (name, category, code, price); the
/// rest is static mock data.
class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, this.product});

  final ProductCardData? product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  static const _categories = [
    'مواد مصرفی و خوراکی',
    'خواربار و غلات',
    'روغن و چربی‌ها',
    'کنسرو و آماده',
    'غلات و ماکارونی',
  ];

  static const _expiryWarningOptions = [
    '۷ روز مانده به انقضا',
    '۱۵ روز مانده به انقضا',
    '۳۰ روز مانده به انقضا (پیشنهاد سیستم)',
  ];

  static const _lowStockThreshold = 5;

  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _sellingPriceController;
  late final TextEditingController _purchasePriceController;
  late final TextEditingController _discountValueController;
  late final TextEditingController _finalPriceController;
  late final TextEditingController _discountStartController;
  late final TextEditingController _discountEndController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _batchNumberController;

  late final List<String> _categoryOptions;
  late String _selectedCategory;
  String _selectedExpiryWarning = _expiryWarningOptions.last;

  int _stockCount = 25;
  bool _isDiscountEnabled = true;
  EditProductDiscountType _discountType = EditProductDiscountType.percent;
  bool _isExpiryEnabled = true;

  @override
  void initState() {
    super.initState();
    final product = widget.product;

    _nameController = TextEditingController(
      text: product?.name ?? 'بسته دان قهوه اسپرسو روبوستا ۱ کیلوگرمی',
    );
    _codeController = TextEditingController(text: product?.code ?? 'PRD-204');
    _barcodeController = TextEditingController(text: '626019284719');
    _sellingPriceController = TextEditingController(
      text: product?.priceValue ?? '۶۵۰,۰۰۰',
    );
    _purchasePriceController = TextEditingController(text: '۴۲۰,۰۰۰');
    _discountValueController = TextEditingController(text: '۲۰');
    _finalPriceController = TextEditingController(text: '۵۲۰,۰۰۰');
    _discountStartController = TextEditingController(text: '۱۴۰۳/۰۸/۰۱');
    _discountEndController = TextEditingController(text: '۱۴۰۳/۰۸/۱۵');
    _expiryDateController = TextEditingController(text: '۱۴۰۳/۱۱/۳۰');
    _batchNumberController = TextEditingController(text: 'LOT - 8842');

    final productCategory = product?.categoryLabel;
    _categoryOptions = [
      ..._categories,
      if (productCategory != null && !_categories.contains(productCategory))
        productCategory,
    ];
    _selectedCategory = productCategory ?? _categories.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _barcodeController.dispose();
    _sellingPriceController.dispose();
    _purchasePriceController.dispose();
    _discountValueController.dispose();
    _finalPriceController.dispose();
    _discountStartController.dispose();
    _discountEndController.dispose();
    _expiryDateController.dispose();
    _batchNumberController.dispose();
    super.dispose();
  }

  void _close() {
    if (context.canPop()) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              EditProductHeader(onBackTap: _close),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const EditProductStatusBar(
                            statusLabel: 'فعال در انبار',
                          ),
                          const Gap(16),
                          _buildGeneralInfoSection(),
                          const Gap(16),
                          EditProductPricingSection(
                            sellingPriceController: _sellingPriceController,
                            purchasePriceController: _purchasePriceController,
                            profitMarginLabel: '۳۵٪ حاشیه سود',
                            stockCountLabel: _toPersianDigits(_stockCount),
                            lowStockThresholdLabel:
                                'آستانه اعلان: ${_toPersianDigits(_lowStockThreshold)} عدد',
                            onStockIncrement: () =>
                                setState(() => _stockCount++),
                            onStockDecrement: _stockCount == 0
                                ? null
                                : () => setState(() => _stockCount--),
                          ),
                          const Gap(16),
                          EditProductDiscountSection(
                            isEnabled: _isDiscountEnabled,
                            discountType: _discountType,
                            discountValueController: _discountValueController,
                            finalPriceController: _finalPriceController,
                            startDateController: _discountStartController,
                            endDateController: _discountEndController,
                            countdownLabel: '۱۲ روز و ۸ ساعت مانده',
                            onEnabledChanged: (value) =>
                                setState(() => _isDiscountEnabled = value),
                            onDiscountTypeChanged: (type) =>
                                setState(() => _discountType = type),
                          ),
                          const Gap(16),
                          EditProductExpirySection(
                            isEnabled: _isExpiryEnabled,
                            expiryDateController: _expiryDateController,
                            batchNumberController: _batchNumberController,
                            warningOptions: _expiryWarningOptions,
                            selectedWarningOption: _selectedExpiryWarning,
                            onEnabledChanged: (value) =>
                                setState(() => _isExpiryEnabled = value),
                            onWarningOptionChanged: (option) =>
                                setState(() => _selectedExpiryWarning = option),
                          ),
                          const Gap(16),
                          const EditProductAuthenticityCard(),
                          const Gap(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              EditProductBottomBar(onCancelTap: _close),
            ],
          ),
        ),
      ),
    );
  }

  /// Image, name, category, warehouse code and barcode.
  Widget _buildGeneralInfoSection() {
    return EditProductSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditProductImagePicker(
            placeholderIcon:
                widget.product?.thumbnailIcon ?? Icons.coffee_outlined,
          ),
          const Gap(18),
          EditProductTextField(
            label: 'نام محصول',
            controller: _nameController,
            suffixIcon: Icons.edit_note_rounded,
          ),
          const Gap(14),
          EditProductDropdown(
            label: 'دسته‌بندی',
            value: _selectedCategory,
            options: _categoryOptions,
            onChanged: (category) =>
                setState(() => _selectedCategory = category),
          ),
          const Gap(14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: EditProductTextField(
                  label: 'کد انبار داری',
                  controller: _codeController,
                  suffixIcon: Icons.tag_rounded,
                  isLtrValue: true,
                  isBoldValue: true,
                ),
              ),
              const Gap(12),
              Expanded(
                child: EditProductTextField(
                  label: 'بارکد بین‌المللی',
                  controller: _barcodeController,
                  suffixIcon: Icons.qr_code_2_rounded,
                  keyboardType: TextInputType.number,
                  isLtrValue: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _toPersianDigits(int value) {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return value
        .toString()
        .split('')
        .map((digit) => persianDigits[int.parse(digit)])
        .join();
  }
}
