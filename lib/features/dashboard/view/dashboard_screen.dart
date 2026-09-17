import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_bottom_nav_bar.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_header.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_stats_row.dart';
import 'package:factopro/features/dashboard/widgets/quick_access_section.dart';
import 'package:factopro/features/dashboard/widgets/recent_invoices_section.dart';
import 'package:factopro/features/dashboard/widgets/sales_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final bloc = context.read<DashboardBloc>();

        return Scaffold(
          backgroundColor: colorScheme.outlineVariant,
          bottomNavigationBar: DashboardBottomNavBar(
            selectedItem: state.selectedNavItem,
            onItemSelected: (item) => bloc.add(DashboardNavItemSelected(item)),
          ),
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DashboardHeader(dateLabel: state.dateLabel),
                      const Gap(16),
                      PrimaryButton(
                        onTap: () {},
                        labelText: 'صدور فاکتور جدید',
                        icon: Icons.add,
                        backgroundColor: isDark ? colorScheme.primary : colorScheme.secondary,
                        labelTextColor: isDark ? colorScheme.onPrimary : colorScheme.onSecondary,
                        borderColor: isDark ? colorScheme.primary : colorScheme.secondary,
                      ),
                      const Gap(16),
                      SalesSummaryCard(
                        totalAmount: state.todaySalesAmount,
                        growthLabel: state.salesGrowthLabel,
                        averageInvoiceAmount: state.averageInvoiceAmount,
                      ),
                      const Gap(12),
                      DashboardStatsRow(
                        invoiceCount: state.invoiceCount,
                        receivablesAmount: state.receivablesAmount,
                      ),
                      const Gap(20),
                      QuickAccessSection(actions: state.quickAccessActions),
                      const Gap(20),
                      RecentInvoicesSection(invoices: state.recentInvoices),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
