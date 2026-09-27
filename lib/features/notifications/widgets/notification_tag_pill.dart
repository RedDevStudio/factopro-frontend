import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';

/// The small rounded tag under a notification title (e.g. "بحرانی",
/// "۳ روز تاخیر", "کد کالا: PRD-104").
class NotificationTagPill extends StatelessWidget {
  const NotificationTagPill({super.key, required this.tag});

  final NotificationTagData tag;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (background, foreground, border) = switch (tag.tone) {
      null => (colorScheme.outlineVariant, colorScheme.onSurfaceVariant, colorScheme.outline),
      final tone => () {
        final (accent, container, onContainer) = notificationToneColors(context, tone);
        return (container, onContainer, accent.withValues(alpha: 0.25));
      }(),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Text(
        tag.label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: foreground),
      ),
    );
  }
}
