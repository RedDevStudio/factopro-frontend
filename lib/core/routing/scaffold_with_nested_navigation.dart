import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigationBar extends StatelessWidget {
  const ScaffoldWithNestedNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  /// Branch index of the dashboard tab in the shell route.
  static const _dashboardBranchIndex = 3;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provided here (not in DashboardScreen) so the dashboard drawer, which
    // lives on this Scaffold to cover the bottom nav bar, can read it too.
    return BlocProvider(
      create: (_) => DashboardBloc(),
      child: Scaffold(
        body: navigationShell,
        drawerScrimColor: context.colorScheme.scrim,
        endDrawer: navigationShell.currentIndex == _dashboardBranchIndex
            ? BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) => DashboardDrawer(
                  managerName: state.managerName,
                  managerRole: state.managerRole,
                  managerInitials: state.managerInitials,
                  stores: state.stores,
                  links: state.drawerLinks,
                ),
              )
            : null,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          destinations: [
            NavigationDestination(icon: Icon(Icons.settings), label: 'تنظیمات'),
            NavigationDestination(
              icon: Icon(Icons.receipt_long),
              label: 'فاکتورها',
            ),
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              label: 'محصولات',
            ),
            NavigationDestination(
              icon: Icon(Icons.dashboard),
              label: 'داشبورد',
            ),
          ],
        ),
      ),
    );
  }
}
