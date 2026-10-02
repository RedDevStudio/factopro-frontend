import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Glowing success check, "پرداخت با موفقیت انجام شد!" headline and the
/// activation message with the highlighted [planLabel], over a scatter of
/// confetti dots.
class SubscriptionSuccessHero extends StatelessWidget {
  const SubscriptionSuccessHero({
    super.key,
    required this.planPrefix,
    required this.planLabel,
    required this.planSuffix,
  });

  /// Text before the highlighted plan, e.g. "اشتراک طلایی (".
  final String planPrefix;

  /// e.g. "Gold Pro".
  final String planLabel;

  /// Text after the highlighted plan.
  final String planSuffix;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Stack(
      children: [
        const Positioned.fill(child: _Confetti()),
        Column(
          children: [
            const Gap(8),
            Container(
              width: 104,
              height: 104,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.tertiaryContainer,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.tertiary.withValues(alpha: 0.35),
                    blurRadius: 28,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                width: 68,
                height: 68,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.onTertiaryContainer,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 36,
                  color: colorScheme.tertiaryContainer,
                ),
              ),
            ),
            const Gap(18),
            Text(
              'پرداخت با موفقیت انجام شد!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: colorScheme.onSurface,
              ),
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: planPrefix),
                    TextSpan(
                      text: planLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    TextSpan(text: planSuffix),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Faint decorative confetti dots behind the hero.
class _Confetti extends StatelessWidget {
  const _Confetti();

  // (horizontal fraction, vertical fraction, size, rotation in quarter turns)
  static const _pieces = [
    (0.08, 0.05, 6.0, 0),
    (0.22, 0.38, 5.0, 1),
    (0.30, 0.02, 4.0, 0),
    (0.12, 0.62, 5.0, 1),
    (0.70, 0.08, 5.0, 1),
    (0.86, 0.30, 6.0, 0),
    (0.78, 0.55, 4.0, 1),
    (0.94, 0.04, 4.0, 0),
    (0.58, 0.30, 4.0, 0),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final colors = [
      colorScheme.primary,
      colorScheme.tertiary,
      SubscriptionColors.goldOf(context),
    ];

    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            for (var i = 0; i < _pieces.length; i++)
              Positioned(
                left: constraints.maxWidth * _pieces[i].$1,
                top: constraints.maxHeight * _pieces[i].$2,
                child: RotatedBox(
                  quarterTurns: _pieces[i].$4,
                  child: Container(
                    width: _pieces[i].$3,
                    height: _pieces[i].$3 * 1.6,
                    decoration: BoxDecoration(
                      color: colors[i % colors.length].withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
