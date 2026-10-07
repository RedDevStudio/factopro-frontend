import 'dart:math' as math;

import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_badge.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_colors.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_page_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Illustration of an onboarding page: a floating feature card over a tinted
/// halo, with two badges overlapping opposite corners of the card. Expects an
/// RTL [Directionality] ancestor.
class OnboardingFeatureCard extends StatelessWidget {
  const OnboardingFeatureCard({super.key, required this.page});

  final OnboardingPageData page;

  static const _cardWidth = 240.0;
  static const _haloSize = 256.0;

  @override
  Widget build(BuildContext context) {
    final isMirrored = page.areBadgesMirrored;
    final topBadge = OnboardingBadge(badge: page.topBadge, accent: page.accent);
    final bottomBadge = OnboardingBadge(
      badge: page.bottomBadge,
      accent: page.accent,
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: OverflowBox(
            minWidth: _haloSize,
            minHeight: _haloSize,
            maxWidth: _haloSize,
            maxHeight: _haloSize,
            child: _Halo(
              color: OnboardingColors.accentOf(
                context,
                page.haloAccent ?? page.accent,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: SizedBox(
            width: _cardWidth,
            child: _Card(page: page),
          ),
        ),
        PositionedDirectional(
          top: 0,
          start: isMirrored ? 12 : null,
          end: isMirrored ? null : 12,
          child: topBadge,
        ),
        PositionedDirectional(
          bottom: 0,
          start: isMirrored ? null : 12,
          end: isMirrored ? 12 : null,
          child: bottomBadge,
        ),
      ],
    );
  }
}

class _Halo extends StatelessWidget {
  const _Halo({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.colorScheme.brightness == Brightness.dark;

    return Container(
      width: OnboardingFeatureCard._haloSize,
      height: OnboardingFeatureCard._haloSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: isDark ? 0.14 : 0.06),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomPaint(
          painter: _DashedCirclePainter(color: color.withValues(alpha: 0.25)),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  const _DashedCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const dashCount = 48;
    const sweep = math.pi * 2 / dashCount;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rect = Offset.zero & size;
    for (var i = 0; i < dashCount; i++) {
      canvas.drawArc(rect, i * sweep, sweep * 0.5, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _Card extends StatelessWidget {
  const _Card({required this.page});

  final OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: OnboardingColors.cardOf(context),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: isDark ? 0.4 : 0.1),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HeroTile(icon: page.heroIcon, accent: page.accent),
          const Gap(14),
          Text(
            page.cardTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const Gap(4),
          Text(
            page.cardSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: page.isCardSubtitleHighlighted
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: page.isCardSubtitleHighlighted
                  ? colorScheme.tertiary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(16),
          _InfoRow(row: page.infoRow, accent: page.accent),
        ],
      ),
    );
  }
}

class _HeroTile extends StatelessWidget {
  const _HeroTile({required this.icon, required this.accent});

  final IconData icon;
  final OnboardingAccent accent;

  @override
  Widget build(BuildContext context) {
    final color = OnboardingColors.accentOf(context, accent);
    final isTonal = OnboardingColors.isHeroTonal(context, accent);

    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isTonal ? color.withValues(alpha: 0.08) : null,
        gradient: isTonal
            ? null
            : OnboardingColors.heroGradientOf(context, accent),
        borderRadius: BorderRadius.circular(18),
        border: isTonal
            ? Border.all(color: color.withValues(alpha: 0.2))
            : null,
        boxShadow: isTonal
            ? null
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Icon(
        icon,
        size: 30,
        color: isTonal ? color : OnboardingColors.onAccentOf(context, accent),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.row, required this.accent});

  final OnboardingInfoRowData row;
  final OnboardingAccent accent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final isWarning = row.tone == OnboardingTone.warning;

    final (background, border) = switch (row.tone) {
      OnboardingTone.warning => (
        OnboardingColors.warningContainerOf(context),
        OnboardingColors.warningBorderOf(context),
      ),
      OnboardingTone.info when !isDark => (
        colorScheme.primaryContainer,
        colorScheme.primary.withValues(alpha: 0.2),
      ),
      _ => (colorScheme.outlineVariant, colorScheme.outline),
    };

    final label = Text(
      row.label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: isWarning ? FontWeight.bold : FontWeight.normal,
        color: isWarning
            ? OnboardingColors.onWarningContainerOf(context)
            : colorScheme.onSurfaceVariant,
      ),
    );
    final value = row.value;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisAlignment: row.isSpread || isWarning
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          if (row.showDot) ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(6),
          ],
          if (row.icon case final icon?) ...[
            Icon(
              icon,
              size: 15,
              color: OnboardingColors.toneOf(context, row.tone, accent),
            ),
            const Gap(6),
          ],
          if (row.isSpread) Expanded(child: label) else Flexible(child: label),
          if (value != null) ...[
            if (!row.isSpread) const Gap(6),
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: row.isValueSuccess
                    ? colorScheme.tertiary
                    : colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
