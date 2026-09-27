import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A compact action button rendered inside a notification card. Its look
/// adapts to [NotificationActionData.style].
class NotificationActionButton extends StatelessWidget {
  const NotificationActionButton({super.key, required this.data});

  final NotificationActionData data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final toneAccent = data.tone == null ? null : notificationToneColors(context, data.tone!).$1;

    final (Color background, Color foreground, Color? border) = switch (data.style) {
      NotificationActionStyle.filled => (
        toneAccent ?? notificationBrandColor(context),
        colorScheme.onPrimary,
        null,
      ),
      NotificationActionStyle.tonal when isDark => (
        colorScheme.surface,
        toneAccent ?? colorScheme.onSurface,
        colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
      ),
      NotificationActionStyle.tonal => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        colorScheme.primary.withValues(alpha: 0.12),
      ),
    };

    final icon = Icon(data.icon, size: 17, color: foreground);
    final label = Flexible(
      child: Text(
        data.label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: foreground),
      ),
    );

    return InkWell(
      onTap: data.onTap ?? () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          border: border == null ? null : Border.all(color: border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: data.iconAtEnd
              ? [label, const Gap(6), icon]
              : [icon, const Gap(6), label],
        ),
      ),
    );
  }
}
