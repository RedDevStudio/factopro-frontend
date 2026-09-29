import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_accent_colors.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_tag.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardDrawerStoreTile extends StatelessWidget {
  const DashboardDrawerStoreTile({super.key, required this.store, this.onTap});

  final DashboardStore store;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final accentColor = isDark ? colorScheme.primary : colorScheme.secondary;
    final selected = store.isSelected;

    final (iconColor, iconBackground) = selected
        ? (colorScheme.onPrimary, accentColor)
        : DashboardAccentColor.neutral.resolve(context);

    final Color backgroundColor;
    final Color borderColor;
    if (selected) {
      backgroundColor = isDark
          ? colorScheme.primary.withValues(alpha: 0.12)
          : colorScheme.primaryContainer;
      borderColor = accentColor.withValues(alpha: isDark ? 1 : 0.8);
    } else {
      backgroundColor = isDark
          ? colorScheme.outlineVariant
          : colorScheme.surface;
      borderColor = isDark ? colorScheme.outline : colorScheme.surface;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: selected ? 12 : 10,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            if (selected)
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 15,
                  color: colorScheme.onPrimary,
                ),
              )
            else
              DashboardDrawerTag(label: store.branchLabel),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    store.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (selected) ...[
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            '${store.branchLabel} (فعال)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.tertiary,
                            ),
                          ),
                        ),
                        const Gap(4),
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: colorScheme.tertiary,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Gap(12),
            Container(
              width: selected ? 32 : 28,
              height: selected ? 32 : 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                store.icon,
                size: selected ? 18 : 16,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
