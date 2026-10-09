import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/auth_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum AuthNoticeTone { success, warning }

/// Tinted, bordered message box, e.g. the green SMS-invoice note and the
/// amber offline-login caution.
class AuthNoticeCard extends StatelessWidget {
  const AuthNoticeCard({
    super.key,
    required this.text,
    required this.tone,
    this.icon,
  });

  final String text;
  final AuthNoticeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final (background, border, foreground, accent) = switch (tone) {
      AuthNoticeTone.success => (
        colorScheme.tertiary.withValues(alpha: isDark ? 0.08 : 0.06),
        colorScheme.tertiary.withValues(alpha: 0.25),
        colorScheme.onTertiaryContainer,
        colorScheme.tertiary,
      ),
      AuthNoticeTone.warning => (
        AuthWarningColors.containerOf(context),
        AuthWarningColors.borderOf(context),
        AuthWarningColors.onContainerOf(context),
        AuthWarningColors.of(context),
      ),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: accent),
            const Gap(8),
          ],
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, height: 1.8, color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
