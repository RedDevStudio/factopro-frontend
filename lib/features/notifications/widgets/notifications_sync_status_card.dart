import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The "پایش همگام‌سازی لحظه‌ای" (live sync monitor) card at the top of the
/// notifications list, with the "همه خوانده شد" (mark all read) action.
class NotificationsSyncStatusCard extends StatelessWidget {
  const NotificationsSyncStatusCard({
    super.key,
    required this.title,
    required this.statusLabel,
    required this.subtitle,
    this.onMarkAllReadTap,
  });

  final String title;
  final String statusLabel;
  final String subtitle;
  final VoidCallback? onMarkAllReadTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Color.alphaBlend(colorScheme.tertiary.withValues(alpha: 0.06), colorScheme.surface)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? colorScheme.tertiary.withValues(alpha: 0.5) : colorScheme.outline,
        ),
      ),
      child: Row(
        children: [
          _SyncIcon(),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const Gap(6),
                    Icon(Icons.circle, size: 6, color: colorScheme.tertiary),
                    const Gap(4),
                    Text(
                      statusLabel,
                      style: TextStyle(fontSize: 11, color: colorScheme.tertiary),
                    ),
                  ],
                ),
                const Gap(2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const Gap(8),
          _MarkAllReadButton(onTap: onMarkAllReadTap),
        ],
      ),
    );
  }
}

class _SyncIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.cloud_done_rounded, size: 20, color: colorScheme.tertiary),
        ),
        PositionedDirectional(
          top: -3,
          start: -3,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _MarkAllReadButton extends StatelessWidget {
  const _MarkAllReadButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final foreground = isDark ? colorScheme.onSurface : colorScheme.onPrimaryContainer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? colorScheme.onSurfaceVariant.withValues(alpha: 0.3) : colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'همه خوانده شد',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: foreground),
            ),
            const Gap(4),
            Icon(Icons.done_all_rounded, size: 15, color: foreground),
          ],
        ),
      ),
    );
  }
}
