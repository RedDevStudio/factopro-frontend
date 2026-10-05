import 'package:factopro/features/products/widgets/edit_product_section_card.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:flutter/material.dart';

/// "شماره تماس مشتری" card with the phone input. Expects an RTL
/// [Directionality] ancestor.
class InvoiceIssuePhoneCard extends StatelessWidget {
  const InvoiceIssuePhoneCard({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return EditProductSectionCard(
      child: EditProductTextField(
        label: 'شماره تماس مشتری',
        controller: controller,
        hintText: '۰۹۱۲۳۴۵۶۷۸۹',
        suffixIcon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        isLtrValue: true,
        isBoldValue: true,
      ),
    );
  }
}
