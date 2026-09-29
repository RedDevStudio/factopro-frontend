import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardDrawerHeader extends StatelessWidget {
  const DashboardDrawerHeader({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    this.onClose,
  });

  final String name;
  final String role;
  final String initials;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final accentColor = isDark ? colorScheme.primary : colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? colorScheme.outline
                      : colorScheme.outlineVariant,
                ),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.circle, size: 6, color: accentColor),
                    const Gap(6),
                    Flexible(
                      child: Text(
                        role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(12),
          _Avatar(initials: initials),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [colorScheme.primary, colorScheme.inversePrimary]
                  : [colorScheme.primary, colorScheme.secondary],
            ),
          ),
          child: Text(
            initials,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          left: -2,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
