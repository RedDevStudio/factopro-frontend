import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_card.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:factopro/features/notifications/widgets/notifications_category_chips.dart';
import 'package:factopro/features/notifications/widgets/notifications_header.dart';
import 'package:factopro/features/notifications/widgets/notifications_settings_card.dart';
import 'package:factopro/features/notifications/widgets/notifications_sync_status_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationCategoryData _selectedCategory;

  /// UI-only: hides every unread dot after "همه خوانده شد" is tapped.
  bool _allRead = false;

  static const _categories = [
    NotificationCategoryData(label: 'همه', count: '۱۴'),
    NotificationCategoryData(
      label: 'مالی و تراکنش‌ها',
      count: '۵',
      tone: NotificationTone.success,
    ),
    NotificationCategoryData(
      label: 'انبار و موجودی',
      count: '۴',
      tone: NotificationTone.warning,
    ),
    NotificationCategoryData(
      label: 'مشتریان و سیستم',
      count: '۵',
      tone: NotificationTone.info,
    ),
  ];

  static const _notifications = [
    NotificationCardData(
      title: 'پرداخت موفق فاکتور',
      timeLabel: '۱۰ دقیقه پیش',
      icon: Icons.point_of_sale_rounded,
      tone: NotificationTone.success,
      isUnread: true,
      tag: NotificationTagData(label: 'تسویه آنی شاپرک', tone: NotificationTone.success),
      body: [
        NotificationBodySegment('مبلغ '),
        NotificationBodySegment('۵,۲۰۰,۰۰۰ تومان', emphasis: NotificationEmphasis.bold),
        NotificationBodySegment(
          ' بابت فاکتور ۱۰۲۸ از طریق پایانه کارت‌خوان با شناسه پیگیری ۹۸۳۴۰۱ '
          'با موفقیت به حساب تجاری واریز گردید.',
        ),
      ],
      footer: NotificationDocumentFooterData(
        documentLabel: 'شماره سند:',
        documentNumber: 'INV-1028',
        action: NotificationActionData(
          label: 'مشاهده فاکتور',
          icon: Icons.arrow_forward,
          iconAtEnd: true,
        ),
      ),
    ),
    NotificationCardData(
      title: 'سررسید نسیه فاکتور گذشته',
      timeLabel: '۱ ساعت پیش',
      icon: Icons.warning_rounded,
      tone: NotificationTone.danger,
      isUnread: true,
      isHighlighted: true,
      tag: NotificationTagData(label: '۳ روز تاخیر', tone: NotificationTone.danger),
      body: [
        NotificationBodySegment('موعد پرداخت فاکتور ۱۰۲۶ مشتری محترم '),
        NotificationBodySegment('«آقای حسینی»', emphasis: NotificationEmphasis.bold),
        NotificationBodySegment(' به مبلغ '),
        NotificationBodySegment('۲,۴۰۰,۰۰۰ تومان', emphasis: NotificationEmphasis.accent),
        NotificationBodySegment(' در تاریخ ۲۸ اردیبهشت به پایان رسیده است.'),
      ],
      footer: NotificationActionsFooterData(
        actions: [
          NotificationActionData(
            label: 'ارسال یادآوری پیامکی',
            icon: Icons.sms_outlined,
            tone: NotificationTone.danger,
          ),
          NotificationActionData(
            label: 'تماس مستقیم',
            icon: Icons.call_outlined,
            style: NotificationActionStyle.tonal,
          ),
        ],
      ),
    ),
    NotificationCardData(
      title: 'هشدار کسری موجودی کالا',
      timeLabel: '۳ ساعت پیش',
      icon: Icons.inventory_2_rounded,
      tone: NotificationTone.warning,
      isUnread: true,
      isHighlighted: true,
      tag: NotificationTagData(label: 'بحرانی', tone: NotificationTone.warning),
      body: [
        NotificationBodySegment('موجودی کالا '),
        NotificationBodySegment(
          '«بسته دان قهوه روبوستا ۱ کیلوگرمی»',
          emphasis: NotificationEmphasis.bold,
        ),
        NotificationBodySegment(' به '),
        NotificationBodySegment('۳ عدد', emphasis: NotificationEmphasis.accent),
        NotificationBodySegment(
          ' رسیده است که کمتر از نقطه سفارش تعریف‌شده (۵ عدد) می‌باشد.',
        ),
      ],
      footer: NotificationStockFooterData(
        stockLabel: '۳ از ۱۰ سقف قفسه',
        stockRatio: 0.3,
        action: NotificationActionData(
          label: 'سفارش مجدد به تامین‌کننده',
          icon: Icons.local_shipping_outlined,
          style: NotificationActionStyle.tonal,
          tone: NotificationTone.warning,
        ),
      ),
    ),
    NotificationCardData(
      title: 'نزدیک شدن به تاریخ انقضا',
      timeLabel: 'دیروز',
      icon: Icons.timer_outlined,
      tone: NotificationTone.info,
      tag: NotificationTagData(label: 'کد کالا: PRD-104'),
      body: [
        NotificationBodySegment('تعداد ۱۸ عدد از کالای '),
        NotificationBodySegment(
          '«شیر پاستوریزه کم‌چرب پاک»',
          emphasis: NotificationEmphasis.bold,
        ),
        NotificationBodySegment(
          ' تا ۳ روز دیگر منقضی می‌شوند. پیشنهاد سیستم اعمال تخفیف فروش فوری است.',
        ),
      ],
      footer: NotificationActionsFooterData(
        actions: [
          NotificationActionData(
            label: 'اعمال تخفیف هوشمند ۲۵٪ روی صندوق',
            icon: Icons.percent_rounded,
          ),
        ],
      ),
    ),
    NotificationCardData(
      title: 'پایان همگام‌سازی ابری امن',
      timeLabel: '۲ روز پیش',
      icon: Icons.verified_user_rounded,
      tone: NotificationTone.success,
      tag: NotificationTagData(label: 'رمزنگاری شده', tone: NotificationTone.success),
      body: [
        NotificationBodySegment('تعداد '),
        NotificationBodySegment(
          '۲۴ فاکتور صادر شده در حالت آفلاین',
          emphasis: NotificationEmphasis.bold,
        ),
        NotificationBodySegment(
          ' با موفقیت روی سرور مرکزی اعتماد پرو بارگذاری و نسخه پشتیبان ذخیره شد.',
        ),
      ],
    ),
    NotificationCardData(
      title: 'ثبت مشتری همکار جدید',
      timeLabel: '۳ روز پیش',
      icon: Icons.person_add_alt_1_rounded,
      tone: NotificationTone.info,
      tag: NotificationTagData(label: 'مشتری عمده'),
      body: [
        NotificationBodySegment('مشتری حقوقی جدید با عنوان تجاری '),
        NotificationBodySegment('«سوپرمارکت ساحل»', emphasis: NotificationEmphasis.bold),
        NotificationBodySegment(
          ' با شماره همراه ۰۹۱۲۳۴۵۶۷۸۹ به باشگاه مشتریان اضافه گردید.',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              NotificationsHeader(
                onBackTap: () {
                  if (context.canPop()) context.pop();
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NotificationsSyncStatusCard(
                            title: 'پایش همگام‌سازی لحظه‌ای',
                            statusLabel: 'آنلاین',
                            subtitle: 'اتصال به درگاه بانکی شاپرک و سرور مرکزی برقرار است',
                            onMarkAllReadTap: () => setState(() => _allRead = true),
                          ),
                          const Gap(14),
                          NotificationsCategoryChips(
                            categories: _categories,
                            selected: _selectedCategory,
                            onSelected: (category) =>
                                setState(() => _selectedCategory = category),
                          ),
                          const Gap(14),
                          for (final notification in _notifications) ...[
                            NotificationCard(
                              notification: notification,
                              markedAsRead: _allRead,
                            ),
                            const Gap(12),
                          ],
                          const Gap(12),
                          const NotificationsSettingsCard(),
                          const Gap(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
