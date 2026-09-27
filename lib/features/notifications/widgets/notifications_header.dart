import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Pinned top bar of the notifications screen: back arrow and "اعلان‌ها"
/// title on the start (right) side, store avatar on the end (left) side.
/// Expects an RTL [Directionality] ancestor.
class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key, this.onBackTap, this.onAvatarTap});

  final VoidCallback? onBackTap;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackTap,
            icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          ),
          const Gap(4),
          Text(
            'اعلان‌ها',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onAvatarTap,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outline, width: 2),
              ),
              child: Icon(
                Icons.storefront_outlined,
                size: 20,
                color: notificationBrandColor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
