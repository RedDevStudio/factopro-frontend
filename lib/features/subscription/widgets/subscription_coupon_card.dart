import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "کد تخفیف یا معرف" card: code field on the start (right) side, apply
/// button on the end (left) side and an optional success message. Expects an
/// RTL [Directionality] ancestor.
class SubscriptionCouponCard extends StatelessWidget {
  const SubscriptionCouponCard({
    super.key,
    required this.controller,
    this.successMessage,
    this.onApplyTap,
  });

  final TextEditingController controller;

  /// e.g. "کد تخفیف نوروز با موفقیت ۱۵٪ کسر گردید."
  final String? successMessage;
  final VoidCallback? onApplyTap;

  static const _fieldHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final fillColor = colorScheme.primary.withValues(alpha: 0.08);
    final message = successMessage;

    return SubscriptionSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer_outlined,
                size: 18,
                color: SubscriptionColors.accentOf(context),
              ),
              const Gap(6),
              Text(
                'کد تخفیف یا معرف',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: _fieldHeight,
                  child: TextField(
                    controller: controller,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: PrimaryButton(
                  onTap: onApplyTap ?? () {},
                  labelText: 'اعمال مجدد',
                  labelFontSize: 14,
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.16),
                  labelTextColor: colorScheme.onSurface,
                  borderColor: Colors.transparent,
                ),
              ),
            ],
          ),
          if (message != null) ...[
            const Gap(12),
            Row(
              children: [
                Icon(
                  Icons.celebration_outlined,
                  size: 16,
                  color: colorScheme.tertiary,
                ),
                const Gap(6),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
