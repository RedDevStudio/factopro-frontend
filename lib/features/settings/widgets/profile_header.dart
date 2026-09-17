import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/widgets/settings_nav_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.storeName,
    required this.phoneNumber,
    this.onEditPressed,
    this.onEditBusinessInfoPressed,
  });

  final String name;
  final String storeName;
  final String phoneNumber;
  final VoidCallback? onEditPressed;
  final VoidCallback? onEditBusinessInfoPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: colorScheme.outlineVariant,
                    child: Icon(
                      Icons.person,
                      size: 34,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    left: -2,
                    child: InkWell(
                      onTap: onEditPressed,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: colorScheme.surface, width: 2),
                        ),
                        child: Icon(Icons.edit, size: 12, color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 8, color: colorScheme.tertiary),
                              const Gap(4),
                              Text(
                                'فعال',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(6),
                    Text(
                      storeName,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                        ),
                        const Gap(4),
                        Icon(Icons.phone, size: 14, color: colorScheme.onSurfaceVariant),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          SettingsNavRow(
            label: 'ویرایش اطلاعات و مشخصات کسب‌وکار',
            icon: Icons.storefront_outlined,
            outlined: true,
            onTap: onEditBusinessInfoPressed,
          ),
        ],
      ),
    );
  }
}
