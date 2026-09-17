import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuickAccessItem extends StatelessWidget {
  const QuickAccessItem({super.key, required this.action, this.onTap});

  final QuickAccessAction action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (iconColor, backgroundColor) = switch (action.accentColor) {
      DashboardAccentColor.primary => (colorScheme.primary, colorScheme.primaryContainer),
      DashboardAccentColor.secondary => (colorScheme.secondary, colorScheme.secondaryContainer),
      DashboardAccentColor.tertiary => (colorScheme.tertiary, colorScheme.tertiaryContainer),
      DashboardAccentColor.warning => (
        DashboardWarningColors.of(context),
        DashboardWarningColors.containerOf(context),
      ),
    };

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(action.icon, size: 20, color: iconColor),
            ),
            const Gap(8),
            Text(
              action.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
