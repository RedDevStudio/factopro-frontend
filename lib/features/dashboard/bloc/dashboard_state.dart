part of 'dashboard_bloc.dart';

final class DashboardState extends Equatable {
  const DashboardState({
    this.selectedNavItem = DashboardNavItem.dashboard,
    this.dateLabel = 'امروز ۲۴ آبان ۱۴۰۳',
    this.todaySalesAmount = '۱۴,۸۵۰,۰۰۰',
    this.salesGrowthLabel = '۱۴٪+ رشد',
    this.averageInvoiceAmount = '۶۷۵,۰۰۰',
    this.invoiceCount = '۲۲',
    this.receivablesAmount = '۳,۴۰۰,۰۰۰',
    this.quickAccessActions = const [
      QuickAccessAction(
        icon: Icons.point_of_sale_outlined,
        label: 'بستن صندوق',
        accentColor: DashboardAccentColor.tertiary,
      ),
      QuickAccessAction(
        icon: Icons.payments_outlined,
        label: 'دریافت نسیه',
        accentColor: DashboardAccentColor.warning,
      ),
      QuickAccessAction(
        icon: Icons.person_add_alt_outlined,
        label: 'ثبت مشتری',
        accentColor: DashboardAccentColor.secondary,
      ),
      QuickAccessAction(
        icon: Icons.inventory_2_outlined,
        label: 'تعریف کالا',
        accentColor: DashboardAccentColor.primary,
      ),
    ],
    this.recentInvoices = const [
      DashboardInvoice(
        customerName: 'فروشگاه آلفا',
        invoiceNumber: '۱۰۲۸۴',
        date: '۱۴۰۲/۰۸/۱۵',
        amount: '۵,۲۰۰,۰۰۰',
        note: 'کارتخوان • ساعت ۱۴:۳۰',
        status: InvoiceStatus.paid,
      ),
      DashboardInvoice(
        customerName: 'آقای محمدی',
        invoiceNumber: '۱۰۲۷۴',
        date: '۱۴۰۲/۰۸/۱۴',
        amount: '۱,۱۵۰,۰۰۰',
        note: 'حواله پایا • ساعت ۱۱:۱۵',
        status: InvoiceStatus.pendingPayment,
      ),
      DashboardInvoice(
        customerName: 'سوپرمارکت ساحل',
        invoiceNumber: '۱۰۲۶۴',
        date: '۱۴۰۲/۰۸/۱۴',
        amount: '۲,۴۰۰,۰۰۰',
        note: '۳ روز تاخیر',
        status: InvoiceStatus.overdue,
      ),
    ],
  });

  final DashboardNavItem selectedNavItem;
  final String dateLabel;
  final String todaySalesAmount;
  final String salesGrowthLabel;
  final String averageInvoiceAmount;
  final String invoiceCount;
  final String receivablesAmount;
  final List<QuickAccessAction> quickAccessActions;
  final List<DashboardInvoice> recentInvoices;

  DashboardState copyWith({DashboardNavItem? selectedNavItem}) {
    return DashboardState(
      selectedNavItem: selectedNavItem ?? this.selectedNavItem,
      dateLabel: dateLabel,
      todaySalesAmount: todaySalesAmount,
      salesGrowthLabel: salesGrowthLabel,
      averageInvoiceAmount: averageInvoiceAmount,
      invoiceCount: invoiceCount,
      receivablesAmount: receivablesAmount,
      quickAccessActions: quickAccessActions,
      recentInvoices: recentInvoices,
    );
  }

  @override
  List<Object?> get props => [
    selectedNavItem,
    dateLabel,
    todaySalesAmount,
    salesGrowthLabel,
    averageInvoiceAmount,
    invoiceCount,
    receivablesAmount,
    quickAccessActions,
    recentInvoices,
  ];
}
