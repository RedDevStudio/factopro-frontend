import 'package:equatable/equatable.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:flutter/material.dart';

enum DashboardNavItem {
  settings,
  invoices,
  products,
  dashboard;

  String get label => switch (this) {
    DashboardNavItem.settings => 'تنظیمات',
    DashboardNavItem.invoices => 'فاکتورها',
    DashboardNavItem.products => 'محصولات',
    DashboardNavItem.dashboard => 'داشبورد',
  };

  IconData get icon => switch (this) {
    DashboardNavItem.settings => Icons.settings_outlined,
    DashboardNavItem.invoices => Icons.receipt_long_outlined,
    DashboardNavItem.products => Icons.inventory_2_outlined,
    DashboardNavItem.dashboard => Icons.grid_view_rounded,
  };
}

enum InvoiceStatus {
  paid,
  pendingPayment,
  overdue;

  String get label => switch (this) {
    InvoiceStatus.paid => 'پرداخت شده',
    InvoiceStatus.pendingPayment => 'در انتظار پرداخت',
    InvoiceStatus.overdue => 'معوق (سررسید گذشته)',
  };
}

/// Semantic accent roles resolved to actual [Color]s at the widget layer so
/// that quick-access items stay theme-reactive across light/dark mode.
enum DashboardAccentColor {
  primary,
  secondary,
  tertiary,
  warning,
  violet,
  neutral,
}

final class QuickAccessAction extends Equatable {
  const QuickAccessAction({
    required this.icon,
    required this.label,
    required this.accentColor,
  });

  final IconData icon;
  final String label;
  final DashboardAccentColor accentColor;

  @override
  List<Object?> get props => [icon, label, accentColor];
}

final class DashboardInvoice extends Equatable {
  const DashboardInvoice({
    required this.customerName,
    required this.invoiceNumber,
    required this.date,
    required this.amount,
    required this.note,
    required this.status,
  });

  final String customerName;
  final String invoiceNumber;
  final String date;
  final String amount;
  final String note;
  final InvoiceStatus status;

  @override
  List<Object?> get props => [
    customerName,
    invoiceNumber,
    date,
    amount,
    note,
    status,
  ];
}

final class DashboardStore extends Equatable {
  const DashboardStore({
    required this.name,
    required this.branchLabel,
    required this.icon,
    this.isSelected = false,
  });

  final String name;
  final String branchLabel;
  final IconData icon;
  final bool isSelected;

  @override
  List<Object?> get props => [name, branchLabel, icon, isSelected];
}

final class DashboardDrawerLink extends Equatable {
  const DashboardDrawerLink({
    required this.icon,
    required this.label,
    required this.accentColor,
    this.badgeLabel,
    this.route,
  });

  final IconData icon;
  final String label;
  final DashboardAccentColor accentColor;

  /// Replaces the trailing chevron with a warning badge when set.
  final String? badgeLabel;

  /// Existing route this link opens; `null` for destinations not built yet.
  final AppRoute? route;

  @override
  List<Object?> get props => [icon, label, accentColor, badgeLabel, route];
}
