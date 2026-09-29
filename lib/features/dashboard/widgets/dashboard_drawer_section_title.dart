import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class DashboardDrawerSectionTitle extends StatelessWidget {
  const DashboardDrawerSectionTitle({
    super.key,
    required this.title,
    this.trailing,
  });

  final String title;

  /// Optional widget shown on the opposite (left) side of the title.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ?trailing,
        const Spacer(),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
