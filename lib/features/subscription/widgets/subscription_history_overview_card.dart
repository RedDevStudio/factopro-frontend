import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Accent-filled summary card at the top of the payment history: current plan
/// with its validity pill, total paid / renewal count stats, and the trust
/// note with the "گزارش جامع" export button. Expects an RTL [Directionality]
/// ancestor.
class SubscriptionHistoryOverviewCard extends StatelessWidget {
  const SubscriptionHistoryOverviewCard({
    super.key,
    required this.planName,
    required this.validUntilLabel,
    required this.totalPaid,
    required this.renewalCount,
    required this.renewalCaption,
    this.onReportTap,
  });

  /// e.g. "طلایی (Gold Pro)".
  final String planName;

  /// e.g. "فعال تا آبان ۱۴۰۴".
  final String validUntilLabel;

  /// e.g. "۸,۹۵۰,۰۰۰".
  final String totalPaid;

  /// e.g. "۴".
  final String renewalCount;

  /// e.g. "دوره متوالی".
  final String renewalCaption;
  final VoidCallback? onReportTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);
    final onAccent = SubscriptionColors.onAccentOf(context);
    final muted = onAccent.withValues(alpha: 0.75);
    final glass = onAccent.withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [accent, Color.lerp(accent, colorScheme.scrim, 0.35)!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: onAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 22,
                  color: onAccent,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'پلن جاری',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                    const Gap(2),
                    Text(
                      planName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: onAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      validUntilLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(18),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'مجموع پرداخت‌ها',
                    value: totalPaid,
                    unit: 'تومان',
                    background: glass,
                    foreground: onAccent,
                    muted: muted,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: _StatTile(
                    label: 'دوره‌های تمدید',
                    value: renewalCount,
                    unit: renewalCaption,
                    background: glass,
                    foreground: onAccent,
                    muted: muted,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Icon(Icons.verified_user_outlined, size: 15, color: muted),
              const Gap(5),
              Expanded(
                child: Text(
                  'تضمین رسمی شاپرک و درگاه امن بانکی',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: muted),
                ),
              ),
              const Gap(8),
              Material(
                color: onAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: onReportTap ?? () {},
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download_rounded, size: 15, color: onAccent),
                        const Gap(4),
                        Text(
                          'گزارش جامع',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: onAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Translucent tile: caption on top, large value with a trailing unit.
class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.unit,
    required this.background,
    required this.foreground,
    required this.muted,
  });

  final String label;
  final String value;
  final String unit;
  final Color background;
  final Color foreground;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: foreground.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: muted)),
          const Gap(8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: foreground,
                  ),
                ),
                TextSpan(
                  text: '  $unit',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
