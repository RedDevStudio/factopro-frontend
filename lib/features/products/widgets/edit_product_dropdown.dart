import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/products/widgets/edit_product_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Labeled dropdown styled like [EditProductTextField]. When [leadingIcon] is
/// given it is drawn right after the selected value (e.g. the bell next to
/// the expiry warning option). Expects an RTL [Directionality] ancestor.
class EditProductDropdown extends StatelessWidget {
  const EditProductDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.leadingIcon,
    this.leadingIconColor,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final IconData? leadingIcon;
  final Color? leadingIconColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    Widget valueText(String option, {bool selected = false}) {
      final text = Text(
        option,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13,
          fontWeight: selected ? FontWeight.bold : FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      );
      if (!selected || leadingIcon == null) return text;

      return Row(
        children: [
          Flexible(child: text),
          const Gap(8),
          Icon(
            leadingIcon,
            size: 18,
            color: leadingIconColor ?? colorScheme.primary,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProductFieldLabel(label),
        const Gap(8),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
          dropdownColor: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          decoration: editProductInputDecoration(context),
          selectedItemBuilder: (context) => [
            for (final option in options) valueText(option, selected: true),
          ],
          items: [
            for (final option in options)
              DropdownMenuItem(value: option, child: valueText(option)),
          ],
          onChanged: (option) {
            if (option != null) onChanged(option);
          },
        ),
      ],
    );
  }
}
