import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/custom_text_field.dart';
import 'package:factopro/features/authentication/widgets/logo_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
        ],
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "راه‌اندازی فروشگاه",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'مرحله ۱ از ۲ • اطلاعات عمومی',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
        leading: Icon(Icons.info_rounded),
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
                      boxRadius: 60,
                    ),
                    Gap(10),
                    Text(
                      "افزودن نشان‌واره یا نماد فروشگاه",
                      style: TextStyle(fontSize: 16),
                    ),
                    Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: "نام فروشگاه",
                      hintText: "مثلاً: فروشگاه آریا یا هایپرمارکت پارس",
                      suffixIcon: Icons.store,
                      validator: (value) {},
                    ),
                    Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'نام و نام خانوادگی مدیر ',
                      hintText: 'مثلاً: محمد حسینی',
                      suffixIcon: Icons.person,
                      validator: (value) {},
                    ),
                    Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'شماره فروشگاه / همراه',
                      hintText: '۰۲۱-۸۸۸۸۰۰۰۰ یا ۰۹۱۲xxxxxxx',
                      suffixIcon: Icons.phone,
                      validator: (value) {},
                    ),
                    Gap(16),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: TextEditingController(),
                            title: 'استان',
                            hintText: 'تهران',
                            suffixIcon: Icons.phone,
                            validator: (value) {},
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: TextEditingController(),
                            title: 'شهر / شهرستان',
                            hintText: 'مثال: تهران',
                            suffixIcon: Icons.phone,
                            validator: (value) {},
                          ),
                        ),
                      ],
                    ),
                    Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'آدرس دقیق فروشگاه',
                      hintText: 'خیابان اصلی، کوچه، پلاک، طبقه یا واحد تجاری',
                      suffixIcon: Icons.place,
                      validator: (value) {},
                    ),
                    Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'کد پستی',
                      hintText: '1234567890',
                      suffixIcon: Icons.email,
                      validator: (value) {},
                    ),
                    Gap(16),
                    CustomTextField(
                      controller: TextEditingController(),
                      title: 'دسته‌بندی و صنف فروشگاه',
                      hintText: 'سوپرمارکت و مواد غذایی',
                      suffixIcon: Icons.email,
                      validator: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12, right: 20, left: 20, bottom: 20),
            child: Column(
              children: [
                PrimaryButton(
                  onTap: () {
                    context.goNamed(AppRoute.dashboard.name);
                  },
                  labelText: "ثبت و راه‌اندازی فروشگاه",
                  icon: Icons.arrow_back,
                ),
                Text("با ثبت فروشگاه، قوانین و حریم خصوصی سامانه را میپذیرید۔"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
