import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The "تنظیمات اعلان‌ها و پیامک‌ها" navigation card at the bottom of the
/// notifications list. Expects an RTL [Directionality] ancestor.
class NotificationsSettingsCard extends StatelessWidget {
  const NotificationsSettingsCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: notificationBrandColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.tune_rounded, size: 22, color: colorScheme.onPrimary),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تنظیمات اعلان‌ها و پیامک‌ها',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'شخصی‌سازی هشدارهای صوتی، پیامک به بدهکاران و گزارش روزانه',
                    style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Icon(Icons.chevron_right, size: 24, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
