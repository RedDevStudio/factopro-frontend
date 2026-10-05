import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Selected customer row: avatar and name/caption on the start (right) side,
/// the "ویرایش" link on the end (left) side. Expects an RTL [Directionality]
/// ancestor.
class InvoiceIssueCustomerCard extends StatelessWidget {
  const InvoiceIssueCustomerCard({
    super.key,
    required this.name,
    required this.caption,
    this.onEditTap,
  });

  final String name;

  /// e.g. "بدون شماره تماس ثبت شده".
  final String caption;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return EditProductSectionCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_rounded,
              size: 22,
              color: colorScheme.primary,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(4),
                Text(
                  caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          InkWell(
            onTap: onEditTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Text(
                'ویرایش',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
