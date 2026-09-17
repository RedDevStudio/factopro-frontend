import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_stat_mini_card.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_warning_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardStatsRow extends StatelessWidget {
  const DashboardStatsRow({
    super.key,
    required this.invoiceCount,
    required this.receivablesAmount,
  });

  final String invoiceCount;
  final String receivablesAmount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DashboardStatMiniCard(
              title: 'مطالبات / نسیه',
              icon: Icons.watch_later_outlined,
              iconColor: DashboardWarningColors.of(context),
              iconBackgroundColor: DashboardWarningColors.containerOf(context),
              value: receivablesAmount,
              unit: 'تومان',
              valueColor: DashboardWarningColors.of(context),
            ),
          ),
          const Gap(12),
          Expanded(
            child: DashboardStatMiniCard(
              title: 'تعداد فاکتورها',
              icon: Icons.description_outlined,
              iconColor: colorScheme.primary,
              iconBackgroundColor: colorScheme.primaryContainer,
              value: invoiceCount,
              unit: 'عدد',
            ),
          ),
        ],
      ),
    );
  }
}
