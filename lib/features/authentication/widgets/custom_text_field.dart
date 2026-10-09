import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Labeled outlined input used across the authentication screens. Expects an
/// RTL [Directionality] ancestor, so the label and [icon] sit on the start
/// (right) side and [trailing] on the end (left) side.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.icon,
    this.trailing,
    this.isRequired = false,
    this.readOnly = false,
    this.showLabel = true,
    this.maxLines = 1,
    this.keyboardType,
    this.textDirection = TextDirection.rtl,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final IconData? icon;

  /// Widget placed inside the field on the end side, e.g. a "send code"
  /// button.
  final Widget? trailing;
  final bool isRequired;
  final bool readOnly;
  final bool showLabel;
  final int maxLines;
  final TextInputType? keyboardType;

  /// Direction of the typed text; use [TextDirection.ltr] for numbers.
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              if (isRequired) ...[
                const Gap(4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.error,
                  ),
                ),
              ],
            ],
          ),
          const Gap(8),
        ],
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textDirection: textDirection,
          textAlign: TextAlign.start,
          style: TextStyle(color: context.colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colorScheme.surface,
            hintText: hintText,
            hintTextDirection: textDirection,
            hintStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
            prefixIcon: icon != null
                ? Icon(icon, color: context.colorScheme.onSurfaceVariant)
                : null,
            suffixIcon: trailing != null
                ? Padding(padding: const EdgeInsets.all(6), child: trailing)
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
