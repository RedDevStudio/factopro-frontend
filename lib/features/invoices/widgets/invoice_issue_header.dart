import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Top of the issue invoice screen: "صدور فاکتور" title on the start (right)
/// side, the store avatar and name on the end (left) side. Expects an RTL
/// [Directionality] ancestor.
class InvoiceIssueHeader extends StatelessWidget {
  const InvoiceIssueHeader({
    super.key,
    required this.storeName,
    this.onStoreTap,
  });

  final String storeName;
  final VoidCallback? onStoreTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Text(
            'صدور فاکتور',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        InkWell(
          onTap: onStoreTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDark
                      ? colorScheme.primaryContainer
                      : colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 24,
                  color: isDark ? colorScheme.primary : colorScheme.onSecondary,
                ),
              ),
              const Gap(4),
              Text(
                storeName,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
