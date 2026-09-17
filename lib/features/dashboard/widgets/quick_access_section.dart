import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/quick_access_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({
    super.key,
    required this.actions,
    this.onActionTap,
  });

  final List<QuickAccessAction> actions;
  final ValueChanged<QuickAccessAction>? onActionTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              'دسترسی سریع',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const Gap(6),
            Icon(Icons.grid_view_rounded, size: 16, color: colorScheme.onSurfaceVariant),
          ],
        ),
        const Gap(12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final action in actions) ...[
                Expanded(
                  child: QuickAccessItem(
                    action: action,
                    onTap: onActionTap == null ? null : () => onActionTap!(action),
                  ),
                ),
                if (action != actions.last) const Gap(10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
