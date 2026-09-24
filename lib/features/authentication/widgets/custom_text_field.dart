import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.isRequired = false,
    this.readOnly = false,
    this.showLabel = true,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final IconData? suffixIcon;
  final bool isRequired;
  final bool readOnly;
  final bool showLabel;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isRequired) ...[
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.error,
                  ),
                ),
                const Gap(4),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const Gap(8),
        ],
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(color: context.colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colorScheme.surface,
            hintText: hintText,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: context.colorScheme.onSurfaceVariant)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
