import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:factopro/features/notifications/widgets/notification_card_footer.dart';
import 'package:factopro/features/notifications/widgets/notification_tag_pill.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A single notification in the list: tone-colored icon box, title, optional
/// tag, rich body text, relative time with an unread dot, and an optional
/// footer. Expects an RTL [Directionality] ancestor.
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    this.markedAsRead = false,
    this.onTap,
  });

  final NotificationCardData notification;

  /// Hides the unread dot regardless of [NotificationCardData.isUnread].
  final bool markedAsRead;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (accent, _, _) = notificationToneColors(context, notification.tone);
    final isHighlighted = notification.isHighlighted;
    final isDanger = notification.tone == NotificationTone.danger;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHighlighted
              ? Color.alphaBlend(accent.withValues(alpha: 0.04), colorScheme.surface)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHighlighted ? accent.withValues(alpha: 0.35) : colorScheme.outline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ToneIconBox(icon: notification.icon, tone: notification.tone),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDanger ? accent : colorScheme.onSurface,
                        ),
                      ),
                      if (notification.tag != null) ...[
                        const Gap(6),
                        NotificationTagPill(tag: notification.tag!),
                      ],
                      const Gap(8),
                      _NotificationBody(segments: notification.body, accent: accent),
                    ],
                  ),
                ),
                const Gap(8),
                _TimeLabel(
                  label: notification.timeLabel,
                  isUnread: notification.isUnread && !markedAsRead,
                  dotColor: isHighlighted ? accent : notificationBrandColor(context),
                ),
              ],
            ),
            if (notification.footer != null) ...[
              const Gap(16),
              NotificationCardFooter(footer: notification.footer!),
            ],
          ],
        ),
      ),
    );
  }
}

class _ToneIconBox extends StatelessWidget {
  const _ToneIconBox({required this.icon, required this.tone});

  final IconData icon;
  final NotificationTone tone;

  @override
  Widget build(BuildContext context) {
    final (accent, container, _) = notificationToneColors(context, tone);

    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Icon(icon, size: 22, color: accent),
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({required this.label, required this.isUnread, required this.dotColor});

  final String label;
  final bool isUnread;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              label,
              style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
            ),
          ),
          if (isUnread) ...[
            const Gap(6),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationBody extends StatelessWidget {
  const _NotificationBody({required this.segments, required this.accent});

  final List<NotificationBodySegment> segments;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Text.rich(
      TextSpan(
        children: [
          for (final segment in segments)
            TextSpan(
              text: segment.text,
              style: switch (segment.emphasis) {
                NotificationEmphasis.none => null,
                NotificationEmphasis.bold => TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                NotificationEmphasis.accent => TextStyle(
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              },
            ),
        ],
      ),
      style: TextStyle(fontSize: 13, height: 1.8, color: colorScheme.onSurfaceVariant),
    );
  }
}
