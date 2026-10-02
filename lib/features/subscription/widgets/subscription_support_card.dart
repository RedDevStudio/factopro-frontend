import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_action_button.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "مغایرت یا سوالی در پرداخت‌ها دارید؟" help card with phone and live-chat
/// buttons. Expects an RTL [Directionality] ancestor.
class SubscriptionSupportCard extends StatelessWidget {
  const SubscriptionSupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.support_agent_rounded,
                  size: 22,
                  color: SubscriptionColors.onAccentOf(context),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مغایرت یا سوالی در پرداخت‌ها دارید؟',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'تیم امور مالی اعتماد پرو به صورت ۲۴ ساعته پاسخگوی شماست.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(14),
          const Row(
            children: [
              Expanded(
                child: SubscriptionActionButton(
                  label: 'تماس تلفنی',
                  icon: Icons.phone_outlined,
                  style: SubscriptionActionButtonStyle.surface,
                  height: 40,
                ),
              ),
              Gap(10),
              Expanded(
                child: SubscriptionActionButton(
                  label: 'گفتگوی آنلاین ۲۴/۷',
                  icon: Icons.chat_outlined,
                  style: SubscriptionActionButtonStyle.surface,
                  height: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
