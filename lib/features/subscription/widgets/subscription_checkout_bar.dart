import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Money-back guarantee and instant-invoice reassurances shown under the
/// invoice summary. Expects an RTL [Directionality] ancestor.
class SubscriptionTrustRow extends StatelessWidget {
  const SubscriptionTrustRow({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    Widget item(IconData icon, Color iconColor, String label) => Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const Gap(4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        item(
          Icons.verified_user_outlined,
          colorScheme.tertiary,
          'ضمانت بازگشت وجه تا ۷ روز',
        ),
        item(
          Icons.receipt_long_outlined,
          SubscriptionColors.accentOf(context),
          'صدور آنی فاکتور رسمی',
        ),
      ],
    );
  }
}

/// Pinned bottom area holding the "تایید و ورود به درگاه پرداخت شاپرک"
/// button.
class SubscriptionCheckoutBar extends StatelessWidget {
  const SubscriptionCheckoutBar({super.key, this.onPayTap});

  final VoidCallback? onPayTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        10,
        20,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      color: colorScheme.outlineVariant,
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.tertiary.withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: PrimaryButton(
              onTap: onPayTap ?? () {},
              labelText: 'تایید و ورود به درگاه پرداخت شاپرک',
              labelFontSize: 16,
              icon: Icons.lock_outline_rounded,
              backgroundColor: colorScheme.tertiary,
              labelTextColor: colorScheme.onTertiary,
              borderColor: colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
