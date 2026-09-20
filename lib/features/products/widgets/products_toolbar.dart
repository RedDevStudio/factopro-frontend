import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The search field (by name or barcode) plus the filter shortcut button.
class ProductsToolbar extends StatelessWidget {
  const ProductsToolbar({super.key, this.searchController, this.onFilterTap});

  final TextEditingController? searchController;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'جستجوی نام یا بارکد کالا...',
              hintStyle: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
              prefixIcon: Icon(Icons.search, size: 20, color: colorScheme.onSurfaceVariant),
              suffixIcon: Icon(
                Icons.qr_code_scanner_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
            ),
          ),
        ),
        const Gap(8),
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(Icons.tune_rounded, size: 20, color: colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
