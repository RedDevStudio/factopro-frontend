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
    this.managerName = 'علیرضا محمدی',
    this.managerRole = 'مدیر ارشد فروشگاه',
    this.managerInitials = 'ع‌م',
    this.stores = const [
      DashboardStore(
        name: 'هایپرمارکت ساحل',
        branchLabel: 'شعبه مرکزی',
        icon: Icons.apartment_rounded,
        isSelected: true,
      ),
      DashboardStore(
        name: 'سوپرمارکت پارس',
        branchLabel: 'شعبه غرب',
        icon: Icons.home_outlined,
      ),
      DashboardStore(
        name: 'فروشگاه آریا',
        branchLabel: 'شعبه بازار',
        icon: Icons.local_mall_outlined,
      ),
    ],
    this.drawerLinks = const [
      DashboardDrawerLink(
        icon: Icons.description_outlined,
        label: 'صدور فاکتور سریع',
        accentColor: DashboardAccentColor.primary,
      ),
      DashboardDrawerLink(
        icon: Icons.view_in_ar_outlined,
        label: 'انبار و موجودی کالاها',
        accentColor: DashboardAccentColor.secondary,
        badgeLabel: 'نیاز به سفارش',
        route: AppRoute.products,
      ),
      DashboardDrawerLink(
        icon: Icons.people_alt_outlined,
        label: 'حساب مشتریان و دفتر نسیه',
        accentColor: DashboardAccentColor.violet,
      ),
      DashboardDrawerLink(
        icon: Icons.bar_chart_rounded,
        label: 'گزارشات سود و تراکنش‌های روزانه',
        accentColor: DashboardAccentColor.tertiary,
      ),
      DashboardDrawerLink(
        icon: Icons.receipt_long_outlined,
        label: 'بستن صندوق و کارت‌خوان پوز',
        accentColor: DashboardAccentColor.tertiary,
      ),
      DashboardDrawerLink(
        icon: Icons.settings_outlined,
        label: 'تنظیمات برنامه و قالب',
        accentColor: DashboardAccentColor.neutral,
        route: AppRoute.settings,
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
  final String managerName;
  final String managerRole;
  final String managerInitials;
  final List<DashboardStore> stores;
  final List<DashboardDrawerLink> drawerLinks;

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
      managerName: managerName,
      managerRole: managerRole,
      managerInitials: managerInitials,
      stores: stores,
      drawerLinks: drawerLinks,
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
    managerName,
    managerRole,
    managerInitials,
    stores,
    drawerLinks,
  ];
}
