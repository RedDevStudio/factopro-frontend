import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Closing "تضمین اصالت کالا و انطباق استاندارد" card with a green shield
/// badge on the end (left) side. Expects an RTL [Directionality] ancestor.
class EditProductAuthenticityCard extends StatelessWidget {
  const EditProductAuthenticityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return EditProductSectionCard(
      color: colorScheme.outlineVariant,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'تضمین اصالت کالا و انطباق استاندارد',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const Gap(12),
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.tertiary.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.verified_user_rounded,
              size: 22,
              color: colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
