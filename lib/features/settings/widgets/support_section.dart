import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/widgets/settings_nav_row.dart';
import 'package:factopro/features/settings/widgets/settings_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({
    super.key,
    required this.autoBackupEnabled,
    required this.lastBackupLabel,
    this.onOnlineSupportPressed,
    this.onCallSupportPressed,
    this.onLogoutPressed,
  });

  final bool autoBackupEnabled;
  final String lastBackupLabel;
  final VoidCallback? onOnlineSupportPressed;
  final VoidCallback? onCallSupportPressed;
  final VoidCallback? onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsSectionCard(
          title: 'پشتیبان‌گیری و پشتیبانی',
          icon: Icons.cloud_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    if (autoBackupEnabled)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.bolt, size: 12, color: colorScheme.primary),
                            const Gap(2),
                            Text(
                              'پشتیبان آنی',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'پشتیبان‌گیری ابری خودکار',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          'آخرین همگام‌سازی: $lastBackupLabel',
                          style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Icon(Icons.cloud_done_outlined, size: 18, color: colorScheme.primary),
                  ],
                ),
              ),
              const Gap(12),
              SettingsNavRow(
                label: 'ارتباط با پشتیبانی آنلاین (۲۴/۷)',
                icon: Icons.chat_bubble_outline,
                onTap: onOnlineSupportPressed,
              ),
              Divider(color: colorScheme.outlineVariant, height: 1),
              SettingsNavRow(
                label: 'تماس با مرکز امداد فاکتور: ۰۲۱-۸۸۸۸۰۰۱',
                icon: Icons.call_outlined,
                onTap: onCallSupportPressed,
              ),
            ],
          ),
        ),
        const Gap(16),
        PrimaryButton(
          onTap: onLogoutPressed ?? () {},
          labelText: 'خروج از حساب کاربری',
          backgroundColor: colorScheme.errorContainer,
          labelTextColor: colorScheme.error,
          borderColor: colorScheme.errorContainer,
          icon: Icons.logout,
        ),
        const Gap(16),
        Center(
          child: Text(
            "نسخه نرم‌افزار (E'temad Pro) ۲.۴.۰",
            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
