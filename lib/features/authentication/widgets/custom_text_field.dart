import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.suffixIcon,
    required this.validator,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final IconData suffixIcon;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Gap(4),
        TextFormField(
          // focusNode: focusNode,
          controller: controller,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hintText,
            hintTextDirection: TextDirection.rtl,
            suffixIcon: Icon(suffixIcon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
