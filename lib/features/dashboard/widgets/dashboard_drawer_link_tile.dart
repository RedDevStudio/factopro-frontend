import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_accent_colors.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_tag.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardDrawerLinkTile extends StatelessWidget {
  const DashboardDrawerLinkTile({super.key, required this.link, this.onTap});

  final DashboardDrawerLink link;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final (iconColor, iconBackground) = link.accentColor.resolve(context);
    final badgeLabel = link.badgeLabel;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: Row(
          children: [
            if (badgeLabel != null)
              DashboardDrawerTag(
                label: badgeLabel,
                bold: true,
                textColor: DashboardWarningColors.of(context),
                backgroundColor: DashboardWarningColors.containerOf(context),
                borderColor: DashboardWarningColors.of(context)
                    .withValues(alpha: 0.3),
              )
            else
              Icon(
                Icons.chevron_left_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            const Gap(8),
            Expanded(
              child: Text(
                link.label,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const Gap(12),
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(link.icon, size: 18, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}
