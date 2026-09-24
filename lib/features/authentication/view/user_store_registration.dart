import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/custom_text_field.dart';
import 'package:factopro/features/authentication/widgets/logo_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UserStoreRegistration extends StatelessWidget {
  const UserStoreRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.outlineVariant,
      appBar: AppBar(
        backgroundColor: context.colorScheme.outlineVariant,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _CircleIconButton(icon: Icons.help_outline, onTap: () {}),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _CircleIconButton(
              icon: Icons.chevron_right,
              onTap: () {},
            ),
          ),
        ],
        title: Column(
          children: [
            Text(
              'راه‌اندازی فروشگاه',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            const Gap(2),
            Text(
              'مرحله ۱ از ۲ • اطلاعات عمومی',
              style: TextStyle(
                fontSize: 12,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
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
                      suffixIcon: Icons.store,
                      isRequired: true,
                    ),
                    const Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'نام و نام خانوادگی مدیر',
                      hintText: 'مثلاً: محمد حسینی',
                      suffixIcon: Icons.person,
                      isRequired: true,
                    ),
                    const Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'شماره فروشگاه / همراه',
                      hintText: '۰۲۱-۸۸۸۸۰۰۰۰ یا ۰۹۱۲xxxxxxx',
                      suffixIcon: Icons.phone,
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
                            controller: TextEditingController(),
                            title: 'شهر / شهرستان',
                            hintText: 'مثال: تهران',
                            isRequired: true,
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: TextEditingController(
                              text: 'تهران',
                            ),
                            title: 'استان',
                            hintText: 'استان',
                            suffixIcon: Icons.keyboard_arrow_down,
                            isRequired: true,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'آدرس دقیق فروشگاه',
                      hintText: 'خیابان اصلی، کوچه، پلاک، طبقه یا واحد تجاری',
                      suffixIcon: Icons.place,
                      isRequired: true,
                      maxLines: 3,
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '۱۰ رقمی و بدون خط تیره',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'کد پستی',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
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
                      suffixIcon: Icons.email_outlined,
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
            child: Column(
              children: [
                PrimaryButton(
                  onTap: () {
                    context.goNamed(AppRoute.dashboard.name);
                  },
                  labelText: 'ثبت و راه‌اندازی فروشگاه',
                  icon: Icons.arrow_back,
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
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.surface,
          border: Border.all(color: context.colorScheme.outline),
        ),
        child: Icon(icon, size: 20, color: context.colorScheme.onSurface),
      ),
    );
  }
}
