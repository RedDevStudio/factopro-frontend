import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvoicesHeader extends StatelessWidget {
  const InvoicesHeader({
    super.key,
    required this.storeName,
    this.onNotificationsTap,
    this.onFilterTap,
    this.onAvatarTap,
  });

  final String storeName;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconCircleButton(
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationsTap,
          showBadge: true,
        ),
        const Gap(10),
        _IconCircleButton(icon: Icons.filter_alt_outlined, onTap: onFilterTap),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'فاکتورها و فروش',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const Gap(4),
            Text(
              storeName,
              style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        const Gap(12),
        InkWell(
          onTap: onAvatarTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
            child: Text(
              'فا',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  const _IconCircleButton({required this.icon, this.onTap, this.showBadge = false});

  final IconData icon;
  final VoidCallback? onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(icon, size: 19, color: colorScheme.onSurfaceVariant),
          ),
          if (showBadge)
            Positioned(
              top: 3,
              left: 3,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: colorScheme.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.surface, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
