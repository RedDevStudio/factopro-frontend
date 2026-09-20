import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/product_card_actions.dart';
import 'package:factopro/features/products/widgets/product_card_data.dart';
import 'package:factopro/features/products/widgets/product_info_banner.dart';
import 'package:factopro/features/products/widgets/product_price_block.dart';
import 'package:factopro/features/products/widgets/product_stock_pill.dart';
import 'package:factopro/features/products/widgets/product_thumbnail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isActive,
    this.onActiveChanged,
    this.onDeleteTap,
    this.onEditTap,
    this.onTap,
  });

  final ProductCardData product;
  final bool isActive;
  final ValueChanged<bool>? onActiveChanged;
  final VoidCallback? onDeleteTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CupertinoSwitch(
                  value: isActive,
                  activeTrackColor: colorScheme.tertiary,
                  onChanged: onActiveChanged,
                ),
                const Spacer(),
              ],
            ),
            const Gap(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductThumbnail(
                  icon: product.thumbnailIcon,
                  discountRibbonLabel: product.discountRibbonLabel,
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        product.name,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const Gap(4),
                      Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            product.categoryLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            '•',
                            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                          ),
                          Text(
                            'کد: ${product.code}',
                            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                      const Gap(8),
                      ProductStockPill(label: product.stockLabel, isLow: product.isLowStock),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ProductPriceBlock(
                  priceValue: product.priceValue,
                  originalPriceValue: product.originalPriceValue,
                  discountPercentLabel: product.discountPercentLabel,
                ),
                const Spacer(),
              ],
            ),
            const Gap(12),
            Divider(color: colorScheme.outlineVariant, height: 1),
            const Gap(10),
            Row(
              children: [
                ProductCardActions(onDeleteTap: onDeleteTap, onEditTap: onEditTap),
                const Spacer(),
                Flexible(
                  child: ProductInfoBanner(
                    label: product.infoLabel,
                    icon: product.infoIcon,
                    type: product.infoType,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
