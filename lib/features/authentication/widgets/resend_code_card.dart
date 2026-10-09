import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/countdown_builder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "ارسال مجدد کد پیامکی" card with the remaining-time chip. Tapping is only
/// possible once [remaining] reaches zero.
class ResendCodeCard extends StatelessWidget {
  const ResendCodeCard({
    super.key,
    required this.remaining,
    required this.onResend,
  });

  final Duration remaining;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final canResend = remaining <= Duration.zero;
    final chipStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
    );

    return Material(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline),
      ),
      child: InkWell(
        onTap: canResend ? onResend : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.timer_outlined,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ارسال مجدد کد پیامکی',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      'در صورت عدم دریافت کد',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: canResend
                    ? Text('ارسال مجدد', style: chipStyle)
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            CountdownBuilder.format(remaining),
                            style: chipStyle,
                          ),
                          const Gap(6),
                          Text(
                            'مانده',
                            style: chipStyle.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
