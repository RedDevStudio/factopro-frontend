import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Rounded surface used for every block of the subscription screen.
class SubscriptionSectionCard extends StatelessWidget {
  const SubscriptionSectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.gradient,
    this.isElevated = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  /// Replaces the plain surface fill (used by the recommended plan).
  final Gradient? gradient;

  /// Stronger shadow for the selected plan card.
  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? colorScheme.surface : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(
              alpha: isElevated ? 0.14 : 0.05,
            ),
            blurRadius: isElevated ? 20 : 10,
            offset: Offset(0, isElevated ? 6 : 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
