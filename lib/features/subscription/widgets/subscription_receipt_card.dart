import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Ticket-shaped "رسید رسمی الکترونیکی" card: issuer header with the
/// "تراکنش معتبر" pill, the paid total, a notched dashed tear line, the
/// transaction [details] and the tax-registration footer. Expects an RTL
/// [Directionality] ancestor.
class SubscriptionReceiptCard extends StatelessWidget {
  const SubscriptionReceiptCard({
    super.key,
    required this.issuerName,
    required this.totalValue,
    required this.details,
  });

  /// e.g. "اعتماد پرو (E'temad Pro)".
  final String issuerName;

  /// e.g. "۴,۸۵۰,۰۰۰".
  final String totalValue;
  final List<SubscriptionReceiptDetailData> details;

  static const _radius = Radius.circular(20);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = SubscriptionColors.accentOf(context);
    final tint = colorScheme.primary.withValues(alpha: 0.08);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.all(_radius),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: const BorderRadius.vertical(top: _radius),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    size: 20,
                    color: SubscriptionColors.onAccentOf(context),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رسید رسمی الکترونیکی',
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        issuerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                const _ValidPill(),
              ],
            ),
          ),
          const Gap(18),
          Text(
            'مبلغ کل پرداخت‌شده',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
          const Gap(6),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: totalValue,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const TextSpan(
                  text: ' تومان',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: accent),
          ),
          const Gap(14),
          const _TearLine(),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                for (final detail in details) ...[
                  _DetailRow(detail: detail),
                  const Gap(14),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: const BorderRadius.vertical(bottom: _radius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gpp_good_rounded, size: 16, color: accent),
                const Gap(6),
                Flexible(
                  child: Text(
                    'تراکنش رمزنگاری‌شده و ثبت نهایی در سامانه مالیاتی',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Green "تراکنش معتبر" pill.
class _ValidPill extends StatelessWidget {
  const _ValidPill();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_rounded,
            size: 13,
            color: colorScheme.onTertiaryContainer,
          ),
          const Gap(4),
          Text(
            'تراکنش معتبر',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashed separator with half-circle notches cut into both card edges.
class _TearLine extends StatelessWidget {
  const _TearLine();

  static const _notch = 20.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    Widget notch() => Container(
      width: _notch,
      height: _notch,
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        shape: BoxShape.circle,
      ),
    );

    return SizedBox(
      height: _notch,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const dash = 6.0;
                const gap = 4.0;
                final count = (constraints.maxWidth / (dash + gap)).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    count,
                    (_) => Container(
                      width: dash,
                      height: 1.5,
                      color: colorScheme.outline,
                    ),
                  ),
                );
              },
            ),
          ),
          PositionedDirectional(start: -_notch / 2 - 1, child: notch()),
          PositionedDirectional(end: -_notch / 2 - 1, child: notch()),
        ],
      ),
    );
  }
}

/// Icon + label on the start (right) side, value on the end (left) side.
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.detail});

  final SubscriptionReceiptDetailData detail;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Icon(detail.icon, size: 17, color: colorScheme.onSurfaceVariant),
        const Gap(6),
        Text(
          detail.label,
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
        const Gap(8),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (detail.isCopyable) ...[
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                      Icons.copy_rounded,
                      size: 15,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Gap(6),
              ],
              Flexible(
                child: Text(
                  detail.value,
                  textAlign: TextAlign.end,
                  textDirection: detail.isLtr ? TextDirection.ltr : null,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: detail.isHighlighted
                        ? colorScheme.tertiary
                        : colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
