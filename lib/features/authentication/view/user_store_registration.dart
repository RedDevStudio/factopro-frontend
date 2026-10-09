import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/auth_app_bar.dart';
import 'package:factopro/features/authentication/widgets/custom_text_field.dart';
import 'package:factopro/features/authentication/widgets/logo_picker.dart';
import 'package:factopro/features/authentication/widgets/store_registration_guide_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UserStoreRegistration extends StatelessWidget {
  const UserStoreRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: context.colorScheme.outlineVariant,
        appBar: AuthAppBar(
          title: 'راه‌اندازی فروشگاه',
          subtitle: 'مرحله ۱ از ۲ • اطلاعات عمومی',
          backIcon: Icons.chevron_left,
          onHelpTap: () => showStoreRegistrationGuideDialog(context),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 20,
                    right: 20,
                    bottom: 32,
                  ),
                  child: Column(
                    children: [
                      LogoPicker(
                        onPickImage: (image) {},
                        source: ImageSource.gallery,
                        boxRadius: 56,
                      ),
                      const Gap(12),
                      Text(
                        'افزودن نشان‌واره یا نماد فروشگاه',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Gap(24),
                      CustomTextField(
                        controller: TextEditingController(),
                        title: 'نام فروشگاه',
                        hintText: 'مثلاً: فروشگاه آریا یا هایپرمارکت پارس',
                        icon: Icons.apartment,
                        isRequired: true,
                      ),
                      const Gap(16),
                      CustomTextField(
                        controller: TextEditingController(),
                        title: 'نام و نام خانوادگی مدیر',
                        hintText: 'مثلاً: محمد حسینی',
                        icon: Icons.person_outline,
                        isRequired: true,
                      ),
                      const Gap(16),
                      CustomTextField(
                        controller: TextEditingController(),
                        title: 'شماره فروشگاه / همراه',
                        hintText: '۰۲۱-۸۸۸۸۰۰۰۰ یا ۰۹۱۲xxxxxxx',
                        icon: Icons.phone_outlined,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                      ),
                      const Gap(16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: TextEditingController(text: 'تهران'),
                              title: 'استان',
                              hintText: 'استان',
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              isRequired: true,
                              readOnly: true,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              controller: TextEditingController(),
                              title: 'شهر / شهرستان',
                              hintText: 'مثال: تهران',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      CustomTextField(
                        controller: TextEditingController(),
                        title: 'آدرس دقیق فروشگاه',
                        hintText: 'خیابان اصلی، کوچه، پلاک، طبقه یا واحد تجاری',
                        icon: Icons.place_outlined,
                        isRequired: true,
                        maxLines: 3,
                      ),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'کد پستی',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '۱۰ رقمی و بدون خط تیره',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      CustomTextField(
                        controller: TextEditingController(),
                        title: 'کد پستی',
                        showLabel: false,
                        hintText: '1234567890',
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.number,
                      ),
                      const Gap(16),
                      CustomTextField(
                        controller: TextEditingController(),
                        title: 'دسته‌بندی و صنف فروشگاه',
                        hintText: 'سوپرمارکت و مواد غذایی',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12,
                right: 20,
                left: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                border: Border(
                  top: BorderSide(color: context.colorScheme.outline),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      onTap: () {
                        context.pushNamed(AppRoute.phoneVerification.name);
                      },
                      labelText: 'ثبت و راه‌اندازی فروشگاه',
                      // Points left in RTL, toward the next step.
                      icon: Icons.arrow_forward,
                      isIconAtEnd: true,
                      backgroundColor: context.colorScheme.primary,
                      borderColor: context.colorScheme.primary,
                      labelTextColor: context.colorScheme.onPrimary,
                    ),
                    const Gap(12),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        children: [
                          const TextSpan(text: 'با ثبت فروشگاه، '),
                          TextSpan(
                            text: 'قوانین و حریم خصوصی',
                            style: TextStyle(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' سامانه را می‌پذیرید.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
