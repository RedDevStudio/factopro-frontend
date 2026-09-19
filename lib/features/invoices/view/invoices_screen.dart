import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoices_bottom_bar.dart';
import 'package:factopro/features/invoices/widgets/invoices_filter_chips.dart';
import 'package:factopro/features/invoices/widgets/invoices_header.dart';
import 'package:factopro/features/invoices/widgets/invoices_sales_report_card.dart';
import 'package:factopro/features/invoices/widgets/invoices_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  late final TextEditingController _searchController;
  late InvoiceFilterData _selectedFilter;

  static const _filters = [
    InvoiceFilterData(label: 'سررسید گذشته', count: '۳', status: InvoiceStatus.overdue),
    InvoiceFilterData(
      label: 'در انتظار پرداخت',
      count: '۵',
      status: InvoiceStatus.pendingPayment,
    ),
    InvoiceFilterData(label: 'تسویه شده', count: '۱۶', status: InvoiceStatus.paid),
    InvoiceFilterData(label: 'همه', count: '۲۴'),
  ];

  static final _invoices = [
    InvoiceCardData(
      customerName: 'شرکت توسعه نرم‌افزار آرمان',
      invoiceNumber: 'INV-402-1025',
      time: '۱۱:۴۵',
      date: '۱۴۰۲/۰۸/۲۴',
      status: InvoiceStatus.paid,
      amountLabel: 'مبلغ نهایی',
      amountValue: '۴,۹۵۰,۰۰۰',
      itemsDescription: '۳ قلم کالا (طراحی لوگو، هاست و...)',
      secondaryDescription: 'پیگیری: کارتخوان یوز • ۸۴۹۲۰',
      actions: [
        InvoiceActionButtonData(
          label: 'جزئیات',
          icon: Icons.chevron_left,
          style: InvoiceActionStyle.link,
        ),
        InvoiceActionButtonData(
          label: 'چاپ فیش',
          icon: Icons.print_outlined,
          style: InvoiceActionStyle.outlined,
        ),
        InvoiceActionButtonData(
          label: 'PDF / واتس‌اپ',
          icon: Icons.ios_share,
          style: InvoiceActionStyle.outlined,
        ),
      ],
    ),
    InvoiceCardData(
      customerName: 'علی رضایی',
      customerNote: '(مشتری همکار)',
      invoiceNumber: 'INV-402-1024',
      time: '۰۹:۱۵',
      date: '۱۴۰۲/۰۸/۲۴',
      status: InvoiceStatus.pendingPayment,
      amountLabel: 'مبلغ فاکتور',
      amountValue: '۲,۷۰۰,۰۰۰',
      itemsDescription: '۲ قلم کالا (سئو و مشاوره تخصصی)',
      statusBannerLabel: 'در انتظار پرداخت',
      statusBannerIcon: Icons.watch_later_rounded,
      actions: [
        InvoiceActionButtonData(
          label: 'ویرایش',
          icon: Icons.chevron_left,
          style: InvoiceActionStyle.link,
        ),
        InvoiceActionButtonData(
          label: 'ارسال یادآوری',
          icon: Icons.send_outlined,
          style: InvoiceActionStyle.outlined,
        ),
        InvoiceActionButtonData(
          label: 'ثبت تسویه',
          icon: Icons.check_circle_outline,
          style: InvoiceActionStyle.filled,
        ),
      ],
    ),
    InvoiceCardData(
      customerName: 'فروشگاه زنجیره‌ای پارس',
      invoiceNumber: 'INV-402-1018',
      time: '',
      date: '۱۴۰۲/۰۸/۲۰',
      status: InvoiceStatus.overdue,
      amountLabel: 'مبلغ معوق',
      amountValue: '۳,۵۰۰,۰۰۰',
      itemsDescription: '۵ قلم کالا',
      secondaryDescription: 'تماس: ۰۹۱۲۳۴۵۶۷۸۹',
      statusBannerLabel: 'سررسید گذشته (۴ روز)',
      statusBannerIcon: Icons.error_outline,
      actions: [
        InvoiceActionButtonData(
          label: 'ثبت دریافت',
          icon: Icons.chevron_left,
          style: InvoiceActionStyle.link,
        ),
        InvoiceActionButtonData(
          label: 'ارسال پیام محترمانه',
          icon: Icons.send_outlined,
          style: InvoiceActionStyle.outlined,
        ),
        InvoiceActionButtonData(
          label: 'پیگیری',
          icon: Icons.call_outlined,
          style: InvoiceActionStyle.filled,
        ),
      ],
    ),
    InvoiceCardData(
      customerName: 'مشتری نقدی',
      customerNote: '(حضوری)',
      invoiceNumber: 'INV-402-1015',
      time: '۱۸:۳۰',
      date: '۱۴۰۲/۰۸/۱۹',
      status: InvoiceStatus.paid,
      amountLabel: 'مبلغ نهایی',
      amountValue: '۵۲۰,۰۰۰',
      itemsDescription: '۱ قلم کالا (بسته دان قهوه رویوستا ۱ کیلوگرمی)',
      statusBannerLabel: 'پرداخت شده',
      statusBannerIcon: Icons.check_circle_outline,
      actions: [
        InvoiceActionButtonData(
          label: 'مشاهده فیش',
          icon: Icons.chevron_left,
          style: InvoiceActionStyle.link,
        ),
        InvoiceActionButtonData(
          label: 'چاپ مجدد',
          icon: Icons.print_outlined,
          style: InvoiceActionStyle.outlined,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedFilter = _filters.last;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.outlineVariant,
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
                  const InvoicesHeader(storeName: 'فروشگاه مرکزی • پایانه ۱'),
                  const Gap(16),
                  const InvoicesSalesReportCard(
                    dateLabel: 'گزارش فروش امروز (۲۴ آبان)',
                    issuedInvoicesLabel: '۱۸ فاکتور صادر شده',
                    receivablesLabel: 'مطالبات معوق / در انتظار',
                    receivablesAmount: '۳,۲۰۰,۰۰۰',
                    settledLabel: 'مجموع فروش تسویه شده',
                    settledAmount: '۱۴,۳۵۰,۰۰۰',
                  ),
                  const Gap(16),
                  InvoicesToolbar(searchController: _searchController),
                  const Gap(12),
                  InvoicesFilterChips(
                    filters: _filters,
                    selected: _selectedFilter,
                    onSelected: (filter) => setState(() => _selectedFilter = filter),
                  ),
                  const Gap(16),
                  for (final invoice in _invoices) ...[
                    InvoiceCard(invoice: invoice),
                    if (invoice != _invoices.last) const Gap(12),
                  ],
                  const Gap(20),
                  InvoicesBottomBar(),
                  const Gap(16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
