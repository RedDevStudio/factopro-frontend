import 'dart:ui';

import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Shows the "راهنمای ثبت مشخصات فروشگاه" popup over a blurred backdrop.
Future<void> showStoreRegistrationGuideDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: context.colorScheme.scrim,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: const StoreRegistrationGuideDialog(),
    ),
  );
}

class StoreRegistrationGuideDialog extends StatelessWidget {
  const StoreRegistrationGuideDialog({super.key});

  static const _tips = [
    'اطلاعات ثبت شده در این بخش جهت درج روی فیش‌های چاپی، سربرگ فاکتور رسمی و ارسال پیامک به مشتریان استفاده می‌شود.',
    'لوگو یا نشان‌واره فروشگاه شما روی پیش‌فاکتورها و نسخه PDF ارسالی قرار خواهد گرفت.',
    'امکان ویرایش تمامی این اطلاعات در آینده از بخش تنظیمات نرم‌افزار وجود دارد.',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorScheme.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    // The question mark must not be mirrored by RTL.
                    child: Icon(
                      Icons.help_outline,
                      size: 20,
                      color: colorScheme.primary,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      'راهنمای ثبت مشخصات فروشگاه',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Divider(height: 1, color: colorScheme.outline),
              const Gap(16),
              for (final tip in _tips) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        tip,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.8,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
              ],
              const Gap(8),
              PrimaryButton(
                onTap: () => Navigator.of(context).pop(),
                labelText: 'متوجه شدم',
                labelFontSize: 15,
                backgroundColor: colorScheme.primary,
                borderColor: colorScheme.primary,
                labelTextColor: colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
