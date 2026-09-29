import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardDrawerFooter extends StatelessWidget {
  const DashboardDrawerFooter({super.key, this.onLogout});

  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final captionStyle = TextStyle(
      fontSize: 10,
      color: colorScheme.onSurfaceVariant,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        border: Border(top: BorderSide(color: colorScheme.outline)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onLogout,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? colorScheme.errorContainer
                    : colorScheme.errorContainer.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.error.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'خروج از حساب کاربری فعلی',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.error,
                    ),
                  ),
                  const Gap(8),
                  Icon(
                    Icons.logout_rounded,
                    size: 16,
                    color: colorScheme.error,
                  ),
                ],
              ),
            ),
          ),
          const Gap(12),
          Row(
            children: [
              Text('اعتماد پرو - نسخه ۲.۴', style: captionStyle),
              const Spacer(),
              Text('سیستم حسابداری فروشگاهی', style: captionStyle),
            ],
          ),
        ],
      ),
    );
  }
}
