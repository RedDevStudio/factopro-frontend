import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/product_card.dart';
import 'package:factopro/features/products/widgets/product_card_data.dart';
import 'package:factopro/features/products/widgets/products_bottom_bar.dart';
import 'package:factopro/features/products/widgets/products_category_chips.dart';
import 'package:factopro/features/products/widgets/products_header.dart';
import 'package:factopro/features/products/widgets/products_stats_row.dart';
import 'package:factopro/features/products/widgets/products_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final TextEditingController _searchController;
  late ProductCategoryData _selectedCategory;
  late List<bool> _activeStates;

  static const _categories = [
    ProductCategoryData(label: 'همه', count: '۲۴'),
    ProductCategoryData(label: 'خواربار و غلات'),
    ProductCategoryData(label: 'روغن و چربی‌ها'),
    ProductCategoryData(label: 'کنسرو و آماده'),
  ];

  static const _products = [
    ProductCardData(
      name: 'روغن آفتابگردان 1.5 لیتری بهار',
      categoryLabel: 'روغن و چربی‌ها',
      code: 'PRD-101',
      thumbnailIcon: Icons.oil_barrel_outlined,
      stockLabel: 'موجودی: ۱۲ عدد',
      isLowStock: false,
      priceValue: '۱,۵۰۰,۰۰۰',
      infoLabel: 'گارانتی اصالت و سلامت فیزیکی',
      infoIcon: Icons.verified_user_outlined,
      infoType: ProductInfoType.neutral,
    ),
    ProductCardData(
      name: 'برنج طارم هاشمی ۵ کیلویی',
      categoryLabel: 'خواربار و غلات',
      code: 'PRD-204',
      thumbnailIcon: Icons.rice_bowl_outlined,
      stockLabel: 'موجودی: ۶ عدد',
      isLowStock: true,
      priceValue: '۲,۱۲۰,۰۰۰',
      originalPriceValue: '۲,۵۰۰,۰۰۰',
      discountPercentLabel: '۱۵٪',
      discountRibbonLabel: 'تخفیف',
      infoLabel: 'انقضا: ۱۴۰۴/۰۴/۰۸ (۸ ماه مانده)',
      infoIcon: Icons.calendar_month_outlined,
      infoType: ProductInfoType.warning,
    ),
    ProductCardData(
      name: 'کنسرو تن ماهی در روغن زیتون',
      categoryLabel: 'کنسرو و آماده',
      code: 'PRD-302',
      thumbnailIcon: Icons.set_meal_outlined,
      stockLabel: 'موجودی: ۴۵ عدد',
      isLowStock: false,
      priceValue: '۸۵,۰۰۰',
      infoLabel: 'تخفیف زمان‌دار: تا فردا ۲۳:۵۹',
      infoIcon: Icons.access_time_rounded,
      infoType: ProductInfoType.warning,
    ),
    ProductCardData(
      name: 'ماکارونی فرمی ۵۰۰ گرمی زر',
      categoryLabel: 'غلات و ماکارونی',
      code: 'PRD-405',
      thumbnailIcon: Icons.ramen_dining_outlined,
      stockLabel: 'موجودی: ۳۰ عدد',
      isLowStock: false,
      priceValue: '۳۲,۰۰۰',
      infoLabel: 'کالای پرفروش و تازه',
      infoIcon: Icons.check_circle_outline,
      infoType: ProductInfoType.success,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedCategory = _categories.first;
    _activeStates = List.filled(_products.length, true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.outlineVariant,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ProductsHeader(subtitle: 'مدیریت موجودی سوپرمارکت'),
                  const Gap(16),
                  ProductsToolbar(searchController: _searchController),
                  const Gap(12),
                  ProductsCategoryChips(
                    categories: _categories,
                    selected: _selectedCategory,
                    onSelected: (category) => setState(() => _selectedCategory = category),
                  ),
                  const Gap(12),
                  const ProductsStatsRow(
                    totalLabel: 'کل کالاها: ۲۴ عدد',
                    lowStockLabel: 'موجودی کم: ۳ مورد',
                    activeDiscountsLabel: 'تخفیف فعال: ۵ مورد',
                  ),
                  const Gap(16),
                  for (var i = 0; i < _products.length; i++) ...[
                    ProductCard(
                      product: _products[i],
                      isActive: _activeStates[i],
                      onActiveChanged: (value) => setState(() => _activeStates[i] = value),
                    ),
                    if (i != _products.length - 1) const Gap(12),
                  ],
                  const Gap(20),
                  const ProductsBottomBar(),
                  const Gap(16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
