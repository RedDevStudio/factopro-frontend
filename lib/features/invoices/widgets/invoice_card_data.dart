import 'package:flutter/material.dart';

/// Payment status of an invoice, drives badge/icon/banner colors across the
/// invoice card.
enum InvoiceStatus {
  paid,
  pendingPayment,
  overdue;

  String get badgeLabel => switch (this) {
    InvoiceStatus.paid => 'پرداخت شده',
    InvoiceStatus.pendingPayment => 'در انتظار پرداخت',
    InvoiceStatus.overdue => 'سررسید گذشته',
  };

  IconData get icon => switch (this) {
    InvoiceStatus.paid => Icons.check_circle,
    InvoiceStatus.pendingPayment => Icons.watch_later_rounded,
    InvoiceStatus.overdue => Icons.error_rounded,
  };
}

/// Visual weight of an action button on an [InvoiceCardData].
enum InvoiceActionStyle { link, outlined, filled }

class InvoiceActionButtonData {
  const InvoiceActionButtonData({
    required this.label,
    required this.icon,
    required this.style,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final InvoiceActionStyle style;
  final VoidCallback? onTap;
}

/// Static, UI-only representation of a single invoice list card.
class InvoiceCardData {
  const InvoiceCardData({
    required this.customerName,
    required this.invoiceNumber,
    required this.time,
    required this.date,
    required this.status,
    required this.amountLabel,
    required this.amountValue,
    required this.itemsDescription,
    this.customerNote,
    this.secondaryDescription,
    this.statusBannerLabel,
    this.statusBannerIcon,
    this.actions = const [],
  });

  final String customerName;
  final String? customerNote;
  final String invoiceNumber;
  final String time;
  final String date;
  final InvoiceStatus status;
  final String amountLabel;
  final String amountValue;
  final String itemsDescription;
  final String? secondaryDescription;

  /// When set, a full-width colored banner repeating the status is shown.
  final String? statusBannerLabel;
  final IconData? statusBannerIcon;

  final List<InvoiceActionButtonData> actions;
}

/// A single option in the status filter chips row.
class InvoiceFilterData {
  const InvoiceFilterData({
    required this.label,
    required this.count,
    this.status,
  });

  final String label;
  final String count;

  /// Null represents the "همه" (all) filter.
  final InvoiceStatus? status;
}
