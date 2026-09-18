import 'package:factopro/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigationBar extends StatelessWidget {
  const ScaffoldWithNestedNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
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
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'داشبورد'),
        ],
      ),
    );
  }
}
