import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Product search box: search icon on the start (right) side, barcode scan
/// shortcut on the end (left) side. Expects an RTL [Directionality] ancestor.
class InvoiceProductPickerSearchField extends StatelessWidget {
  const InvoiceProductPickerSearchField({
    super.key,
    required this.controller,
    this.onScanTap,
  });

  final TextEditingController controller;
  final VoidCallback? onScanTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'جستجوی کالا، کد، یا بارکد...',
        hintStyle: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 22,
          color: colorScheme.onSurfaceVariant,
        ),
        suffixIcon: IconButton(
          onPressed: onScanTap,
          icon: Icon(
            Icons.qr_code_scanner_rounded,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border(colorScheme.outline),
        enabledBorder: border(colorScheme.outline),
        focusedBorder: border(colorScheme.primary, 1.5),
      ),
    );
  }
}
