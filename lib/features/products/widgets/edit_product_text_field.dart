import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Small bold label shown above each edit product form field.
class EditProductFieldLabel extends StatelessWidget {
  const EditProductFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}

/// Shared [InputDecoration] for the edit product form's text fields and
/// dropdowns. [accentColor], when given, tints the fill and border (used for
/// the highlighted "final price" field).
InputDecoration editProductInputDecoration(
  BuildContext context, {
  Widget? suffix,
  Color? accentColor,
}) {
  final colorScheme = context.colorScheme;
  final borderColor =
      accentColor?.withValues(alpha: 0.5) ?? colorScheme.outline;

  OutlineInputBorder border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor:
        accentColor?.withValues(alpha: 0.1) ?? colorScheme.outlineVariant,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    suffixIcon: suffix == null
        ? null
        : Padding(
            padding: const EdgeInsetsDirectional.only(start: 6, end: 12),
            child: suffix,
          ),
    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    border: border(borderColor),
    enabledBorder: border(borderColor),
    disabledBorder: border(borderColor),
    focusedBorder: border(accentColor ?? colorScheme.primary, 1.5),
  );
}

/// Labeled text field used throughout the edit product form. Expects an RTL
/// [Directionality] ancestor; the [suffixIcon]/[suffixText] sit at the end
/// (left) side of the field.
class EditProductTextField extends StatelessWidget {
  const EditProductTextField({
    super.key,
    required this.label,
    required this.controller,
    this.suffixIcon,
    this.suffixText,
    this.keyboardType,
    this.readOnly = false,
    this.isLtrValue = false,
    this.isBoldValue = false,
    this.accentColor,
    this.onTap,
  });

  final String label;
  final TextEditingController controller;
  final IconData? suffixIcon;

  /// Unit text such as "تومان" or "%", shown in place of [suffixIcon].
  final String? suffixText;
  final TextInputType? keyboardType;
  final bool readOnly;

  /// Codes, barcodes and batch numbers are typed left-to-right but stay
  /// aligned to the right like the rest of the form.
  final bool isLtrValue;
  final bool isBoldValue;
  final Color? accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final suffixColor = accentColor ?? colorScheme.onSurfaceVariant;

    Widget? suffix;
    if (suffixText != null) {
      suffix = Text(
        suffixText!,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: suffixColor,
        ),
      );
    } else if (suffixIcon != null) {
      suffix = Icon(suffixIcon, size: 18, color: suffixColor);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProductFieldLabel(label),
        const Gap(8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          textDirection: isLtrValue ? TextDirection.ltr : null,
          textAlign: isLtrValue ? TextAlign.right : TextAlign.start,
          style: TextStyle(
            fontSize: isBoldValue ? 14 : 13,
            fontWeight: isBoldValue ? FontWeight.bold : FontWeight.w600,
            color: accentColor ?? colorScheme.onSurface,
          ),
          decoration: editProductInputDecoration(
            context,
            suffix: suffix,
            accentColor: accentColor,
          ),
        ),
      ],
    );
  }
}
