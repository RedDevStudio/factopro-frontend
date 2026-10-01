import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Row above the form: product status on the start (right) side, preview and
/// delete actions on the end (left) side. Expects an RTL [Directionality]
/// ancestor.
class EditProductStatusBar extends StatelessWidget {
  const EditProductStatusBar({
    super.key,
    required this.statusLabel,
    this.onPreviewTap,
    this.onDeleteTap,
  });

  final String statusLabel;
  final VoidCallback? onPreviewTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: colorScheme.tertiary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.tertiary.withValues(alpha: 0.35),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const Gap(8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'وضعیت کالا: ',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                TextSpan(
                  text: statusLabel,
                  style: TextStyle(color: colorScheme.tertiary),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const Gap(8),
        InkWell(
          onTap: onPreviewTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 16,
                  color: colorScheme.primary,
                ),
                const Gap(6),
                Text(
                  'پیش‌نمایش',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(8),
        InkWell(
          onTap: onDeleteTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorScheme.error.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.delete_outline,
              size: 18,
              color: colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
