import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
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

/// UI-only product form, used both to add and to edit a product.
///
/// When opened from a product card, the card's [product] pre-fills the fields
/// it has (name, category, code, price) and the rest is static mock data.
/// Without a [product] the form starts empty for adding a new one. Saving pops
/// the resulting [ProductCardData]. With [readOnly] the form only shows the
/// product's details: nothing can be changed and there is no save bar.
class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, this.product, this.readOnly = false});

  final ProductCardData? product;

  /// Shows the product without letting the user change anything.
  final bool readOnly;

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

  /// Matches a Jalali date such as "۱۴۰۴/۰۴/۰۸".
  static final _expiryDatePattern = RegExp(r'[۰-۹]{4}/[۰-۹]{2}/[۰-۹]{2}');

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

  late int _stockCount;
  late bool _isDiscountEnabled;
  EditProductDiscountType _discountType = EditProductDiscountType.percent;
  late bool _isExpiryEnabled;

  bool get _isNew => widget.product == null;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    final isNew = product == null;

    _nameController = TextEditingController(text: product?.name);
    _codeController = TextEditingController(text: product?.code);
    _barcodeController = TextEditingController(
      text: isNew ? null : '۶۲۶۰۱۹۲۸۴۷۱۹',
    );
    _sellingPriceController = TextEditingController(
      text: product?.originalPriceValue ?? product?.priceValue,
    );
    _purchasePriceController = TextEditingController(
      text: isNew ? null : '۴۲۰,۰۰۰',
    );
    final isDiscounted = product?.originalPriceValue != null;
    _discountValueController = TextEditingController(
      text: product?.discountPercentLabel?.replaceAll('٪', ''),
    );
    _finalPriceController = TextEditingController(
      text: isDiscounted ? product!.priceValue : null,
    );
    _discountStartController = TextEditingController(
      text: isNew ? null : '۱۴۰۳/۰۸/۰۱',
    );
    _discountEndController = TextEditingController(
      text: isNew ? null : '۱۴۰۳/۰۸/۱۵',
    );
    final expiryDate = product == null
        ? null
        : _expiryDatePattern.firstMatch(product.infoLabel)?[0];
    _expiryDateController = TextEditingController(text: expiryDate);
    _batchNumberController = TextEditingController(
      text: isNew ? null : 'LOT - ۸۸۴۲',
    );

    _stockCount = product?.stockLabel.parseLocalizedInt() ?? (isNew ? 0 : 25);
    _isDiscountEnabled = isDiscounted;
    _isExpiryEnabled = expiryDate != null;

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

  /// e.g. "۳۵٪ حاشیه سود", or "—" until both prices are entered.
  String get _profitMarginLabel {
    final selling = _sellingPriceController.text.parseLocalizedInt();
    final purchase = _purchasePriceController.text.parseLocalizedInt();
    if (selling == null || purchase == null || purchase == 0) {
      return '— حاشیه سود';
    }
    final margin = ((selling - purchase) * 100 / purchase).round();
    return '${margin.toPersianDigits()}٪ حاشیه سود';
  }

  void _save() {
    final name = _nameController.text.trim();
    final sellingPrice = _sellingPriceController.text.parseLocalizedInt();
    if (name.isEmpty || sellingPrice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('نام محصول و قیمت فروش را وارد کنید')),
      );
      return;
    }

    final product = widget.product;
    final code = _codeController.text.trim();
    final finalPrice = _finalPriceController.text.parseLocalizedInt();
    final discountValue = _discountValueController.text.parseLocalizedInt();
    final isDiscounted =
        _isDiscountEnabled && finalPrice != null && finalPrice < sellingPrice;
    final expiryDate = _expiryDateController.text.trim();
    final hasExpiry = _isExpiryEnabled && expiryDate.isNotEmpty;

    context.pop(
      ProductCardData(
        name: name,
        categoryLabel: _selectedCategory,
        code: code.isEmpty
            ? 'PRD-${DateTime.now().millisecondsSinceEpoch % 1000}'
                  .toPersianDigits()
            : code,
        thumbnailIcon: product?.thumbnailIcon ?? Icons.inventory_2_outlined,
        stockLabel: 'موجودی: ${_stockCount.toPersianDigits()} عدد',
        isLowStock: _stockCount <= _lowStockThreshold,
        priceValue: (isDiscounted ? finalPrice : sellingPrice)
            .toPersianAmount(),
        originalPriceValue: isDiscounted
            ? sellingPrice.toPersianAmount()
            : null,
        discountPercentLabel:
            isDiscounted &&
                _discountType == EditProductDiscountType.percent &&
                discountValue != null
            ? '${discountValue.toPersianDigits()}٪'
            : null,
        discountRibbonLabel: isDiscounted ? 'تخفیف' : null,
        infoLabel: hasExpiry
            ? 'انقضا: $expiryDate'
            : product?.infoLabel ?? 'کالای جدید',
        infoIcon: hasExpiry
            ? Icons.calendar_month_outlined
            : product?.infoIcon ?? Icons.fiber_new_outlined,
        infoType: hasExpiry
            ? ProductInfoType.warning
            : product?.infoType ?? ProductInfoType.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: SafeArea(
          // Without the bottom bar, keep the form clear of the system inset.
          bottom: widget.readOnly,
          child: Column(
            children: [
              EditProductHeader(
                title: widget.readOnly
                    ? 'جزئیات محصول'
                    : _isNew
                    ? 'افزودن محصول جدید'
                    : 'فرم محصول',
                onBackTap: _close,
              ),
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
                      // Blocks taps on every field and control while the
                      // scroll view itself still scrolls.
                      child: IgnorePointer(
                        ignoring: widget.readOnly,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const EditProductStatusBar(
                              statusLabel: 'فعال در انبار',
                            ),
                            const Gap(16),
                            _buildGeneralInfoSection(),
                            const Gap(16),
                            ListenableBuilder(
                              listenable: Listenable.merge([
                                _sellingPriceController,
                                _purchasePriceController,
                              ]),
                              builder: (context, _) => EditProductPricingSection(
                                sellingPriceController: _sellingPriceController,
                                purchasePriceController:
                                    _purchasePriceController,
                                profitMarginLabel: _profitMarginLabel,
                                stockCountLabel: _toPersianDigits(_stockCount),
                                lowStockThresholdLabel:
                                    'آستانه اعلان: ${_toPersianDigits(_lowStockThreshold)} عدد',
                                onStockIncrement: () =>
                                    setState(() => _stockCount++),
                                onStockDecrement: _stockCount == 0
                                    ? null
                                    : () => setState(() => _stockCount--),
                              ),
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
                              onWarningOptionChanged: (option) => setState(
                                () => _selectedExpiryWarning = option,
                              ),
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
              ),
              if (!widget.readOnly)
                EditProductBottomBar(
                  saveLabel: _isNew ? 'ثبت محصول جدید' : 'ذخیره تغییرات محصول',
                  onCancelTap: _close,
                  onSaveTap: _save,
                ),
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
            hintText: 'مثلا برنج طارم هاشمی ۵ کیلویی',
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
                  hintText: 'خودکار',
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
                  hintText: '۶۲۶...',
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
