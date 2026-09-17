import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SubscriptionPromoCard extends StatelessWidget {
  const SubscriptionPromoCard({
    super.key,
    required this.daysLeft,
    required this.progress,
    this.onRenewPressed,
    this.onPaymentHistoryPressed,
  });

  final int daysLeft;
  final double progress;
  final VoidCallback? onRenewPressed;
  final VoidCallback? onPaymentHistoryPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ویژه',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onTertiary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'طرح طلایی حرفه‌ای (Gold Pro)',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondary,
                ),
              ),
              const Gap(6),
              Icon(Icons.star, size: 18, color: colorScheme.onSecondary),
            ],
          ),
          const Gap(10),
          Text(
            'دسترسی نامحدود به صدور فاکتور، گزارشات پیشرفته و ماژول انبارداری هوشمند',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: colorScheme.onSecondary),
          ),
          const Gap(16),
          Row(
            children: [
              Text(
                '$daysLeft روز تا تمدید',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondary,
                ),
              ),
              const Spacer(),
              Text(
                'اعتبار باقی‌مانده اشتراک:',
                style: TextStyle(fontSize: 12, color: colorScheme.onSecondary),
              ),
            ],
          ),
          const Gap(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress.clamp(0, 1),
              minHeight: 6,
              backgroundColor: colorScheme.onSecondary.withValues(alpha: 0.2),
              color: colorScheme.tertiary,
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: _PromoActionButton(
                  label: 'سوابق پرداخت',
                  backgroundColor: colorScheme.secondary,
                  foregroundColor: colorScheme.onSecondary,
                  borderColor: colorScheme.onSecondary.withValues(alpha: 0.4),
                  onTap: onPaymentHistoryPressed ?? () {},
                ),
              ),
              const Gap(10),
              Expanded(
                child: _PromoActionButton(
                  label: 'تمدید یا ارتقا اشتراک',
                  backgroundColor: colorScheme.tertiary,
                  foregroundColor: colorScheme.onTertiary,
                  borderColor: colorScheme.tertiary,
                  icon: Icons.arrow_upward,
                  onTap: onRenewPressed ?? () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromoActionButton extends StatelessWidget {
  const _PromoActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.onTap,
    this.icon,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: foregroundColor),
              const Gap(4),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: foregroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
