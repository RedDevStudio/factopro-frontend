import 'dart:math' as math;

import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/dashboard/bloc/dashboard_models.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_add_store_button.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_footer.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_header.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_link_tile.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_section_title.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_store_tile.dart';
import 'package:factopro/features/dashboard/widgets/dashboard_drawer_tag.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Side menu of the dashboard, shown as the [Scaffold.endDrawer] so it slides
/// in from the right (RTL start edge).
class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    super.key,
    required this.managerName,
    required this.managerRole,
    required this.managerInitials,
    required this.stores,
    required this.links,
  });

  final String managerName;
  final String managerRole;
  final String managerInitials;
  final List<DashboardStore> stores;
  final List<DashboardDrawerLink> links;

  static const _radius = Radius.circular(24);

  void _close(BuildContext context) => Scaffold.of(context).closeEndDrawer();

  void _openLink(BuildContext context, DashboardDrawerLink link) {
    final route = link.route;
    _close(context);
    if (route != null) context.goNamed(route.name);
  }

  void _openStoreRegistration(BuildContext context) {
    _close(context);
    context.pushNamed(AppRoute.userStoreRegistration.name);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Drawer(
      width: math.min(336, screenWidth * 0.86),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: _radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardDrawerHeader(
              name: managerName,
              role: managerRole,
              initials: managerInitials,
              onClose: () => _close(context),
            ),
            Divider(height: 1, thickness: 1, color: colorScheme.outline),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                children: [
                  DashboardDrawerSectionTitle(
                    title: 'فروشگاه‌های من',
                    trailing: DashboardDrawerTag(
                      label: '${_toPersianDigits(stores.length)} شعبه',
                    ),
                  ),
                  const Gap(10),
                  for (final store in stores) ...[
                    DashboardDrawerStoreTile(store: store),
                    const Gap(8),
                  ],
                  DashboardDrawerAddStoreButton(
                    onTap: () => _openStoreRegistration(context),
                  ),
                  const Gap(16),
                  Divider(height: 1, thickness: 1, color: colorScheme.outline),
                  const Gap(20),
                  const DashboardDrawerSectionTitle(title: 'دسترسی سریع'),
                  const Gap(8),
                  for (final link in links)
                    DashboardDrawerLinkTile(
                      link: link,
                      onTap: () => _openLink(context, link),
                    ),
                ],
              ),
            ),
            DashboardDrawerFooter(onLogout: () => _close(context)),
          ],
        ),
      ),
    );
  }
}

String _toPersianDigits(int value) {
  const digits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  return value
      .toString()
      .split('')
      .map((char) => digits[int.parse(char)])
      .join();
}
