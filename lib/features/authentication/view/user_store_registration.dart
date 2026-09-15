import 'package:factopro/features/authentication/widgets/custom_text_field.dart';
import 'package:factopro/features/authentication/widgets/logo_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
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
                    hintText:'مثال: تهران',
                    suffixIcon: Icons.phone,
                    validator: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
