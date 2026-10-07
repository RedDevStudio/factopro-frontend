import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Soft blurred glows behind the onboarding content: an [accent] glow at the
/// top end, a success-green glow on the start side and an indigo glow at the
/// bottom.
class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key, required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final strength = isDark ? 0.22 : 0.12;

    return Stack(
      children: [
        PositionedDirectional(
          top: -140,
          start: -60,
          child: _Glow(size: 360, color: accent.withValues(alpha: strength)),
        ),
        PositionedDirectional(
          top: 260,
          end: -180,
          child: _Glow(
            size: 360,
            color: colorScheme.tertiary.withValues(alpha: strength * 0.7),
          ),
        ),
        PositionedDirectional(
          bottom: -160,
          start: -40,
          child: _Glow(
            size: 380,
            color: colorScheme.secondary.withValues(alpha: strength * 0.6),
          ),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}
