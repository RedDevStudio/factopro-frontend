import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The row above the filter chips: calendar/grid quick actions plus the
/// invoice search field.
class InvoicesToolbar extends StatelessWidget {
  const InvoicesToolbar({
    super.key,
    this.searchController,
    this.onCalendarTap,
    this.onGridTap,
  });

  final TextEditingController? searchController;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onGridTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        _ToolbarIconButton(icon: Icons.calendar_month_outlined, onTap: onCalendarTap),
        const Gap(8),
        _ToolbarIconButton(icon: Icons.grid_view_rounded, onTap: onGridTap),
        const Gap(8),
        Expanded(
          child: TextField(
            controller: searchController,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'جستجوی نام مشتری، شماره فاکتور...',
              hintStyle: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
              suffixIcon: Icon(Icons.search, size: 20, color: colorScheme.onSurfaceVariant),
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
      ],
    );
  }
}

class _ToolbarIconButton extends StatelessWidget {
  const _ToolbarIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
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
        child: Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
