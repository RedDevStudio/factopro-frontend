import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/features/subscription/widgets/subscription_active_plan_card.dart';
import 'package:factopro/features/subscription/widgets/subscription_billing_period_selector.dart';
import 'package:factopro/features/subscription/widgets/subscription_checkout_bar.dart';
import 'package:factopro/features/subscription/widgets/subscription_coupon_card.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_gateway_section.dart';
import 'package:factopro/features/subscription/widgets/subscription_invoice_summary_card.dart';
import 'package:factopro/features/subscription/widgets/subscription_page_layout.dart';
import 'package:factopro/features/subscription/widgets/subscription_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only "ارتقا و تمدید اشتراک" (upgrade & renew subscription) screen.
/// Billing period, plan and gateway selections are local; plans, prices and
/// the invoice summary are static mock data.
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  static const _periods = [
    SubscriptionBillingPeriodData(label: '۳ ماهه', caption: 'تعرفه عادی'),
    SubscriptionBillingPeriodData(
      label: '۶ ماهه',
      caption: '۱۵٪ تخفیف',
      isDiscounted: true,
    ),
    SubscriptionBillingPeriodData(
      label: 'یک‌ساله',
      caption: '۳۰٪ تخفیف ویژه',
      isDiscounted: true,
    ),
  ];

  static const _plans = [
    SubscriptionPlanData(
      tier: SubscriptionPlanTier.basic,
      title: 'طرح پایه (رایگان)',
      subtitle: 'مناسب کسب‌وکارهای نوپا و تازه‌تاسیس',
      icon: Icons.layers_outlined,
      tagLabel: 'رایگان',
      isCurrent: true,
      ctaLabel: 'طرح فعلی پایه',
      features: [
        SubscriptionFeatureData('صدور تا ۵۰ فاکتور ماهانه'),
        SubscriptionFeatureData('ثبت ساده کالاها و مشتریان'),
        SubscriptionFeatureData('پشتیبانی تیکتی اداری (۲۴ ساعته)'),
      ],
    ),
    SubscriptionPlanData(
      tier: SubscriptionPlanTier.pro,
      title: 'پلن حرفه‌ای (Pro)',
      subtitle: 'ویژه فروشگاه‌ها و بازاریان پرفروش',
      icon: Icons.speed_rounded,
      priceValue: '۲۹۰,۰۰۰',
      originalPriceValue: '۳۹۰,۰۰۰',
      ctaLabel: 'انتخاب طرح حرفه‌ای',
      selectedCtaLabel: 'طرح انتخاب شده: حرفه‌ای',
      features: [
        SubscriptionFeatureData('صدور تا ۵۰۰ فاکتور رسمی و غیررسمی'),
        SubscriptionFeatureData('اتصال مستقیم به دستگاه کارتخوان (POS)'),
        SubscriptionFeatureData('سیستم انبارداری و هشدار کسری کالا'),
        SubscriptionFeatureData('گزارش‌گیری جامع اکسل و تحلیل هفتگی سود'),
      ],
    ),
    SubscriptionPlanData(
      tier: SubscriptionPlanTier.gold,
      title: 'تجارت هوشمند (Gold Pro)',
      subtitle: 'نهایت قدرت مدیریت نقدینگی و هوش مصنوعی',
      icon: Icons.auto_awesome_rounded,
      priceValue: '۴۹۰,۰۰۰',
      originalPriceValue: '۶۵۰,۰۰۰',
      recommendationLabel: 'پیشنهاد ویژه اصناف و شرکت‌ها',
      ctaLabel: 'انتخاب طرح تجارت هوشمند',
      selectedCtaLabel: 'طرح انتخاب شده: تجارت هوشمند',
      features: [
        SubscriptionFeatureData(
          'فاکتور نامحدود و بدون سقف ماهانه',
          isHighlighted: true,
        ),
        SubscriptionFeatureData(
          'دستیار هوشمند اعتماد: تحلیل روزانه سود و زیان',
        ),
        SubscriptionFeatureData('یادآوری خودکار پیامکی مطالبات و فاکتور نسیه'),
        SubscriptionFeatureData(
          'اتصال همزمان ۵ حسابدار و صندوق‌دار (چند کاربره)',
        ),
        SubscriptionFeatureData('پشتیبانی اختصاصی VIP تلفنی به صورت ۲۴/۷'),
      ],
    ),
  ];

  static const _gateways = [
    SubscriptionGatewayData(
      name: 'زرین‌پال و شتاب',
      caption: 'تسویه لحظه‌ای شاپرک',
    ),
    SubscriptionGatewayData(
      name: 'بانک ملت (به‌پرداخت)',
      caption: 'درگاه مستقیم کارت',
    ),
    SubscriptionGatewayData(
      name: 'سداد (بانک ملی)',
      caption: 'بدون کارمزد مازاد',
    ),
    SubscriptionGatewayData(name: 'سپ (بانک سامان)', caption: 'سریع و پایدار'),
  ];

  static const _invoiceLines = [
    SubscriptionInvoiceLineData(
      label: 'مبلغ پلن تجارت هوشمند (۱۲ ماهه)',
      value: '۵,۸۸۰,۰۰۰ تومان',
    ),
    SubscriptionInvoiceLineData(
      label: 'تخفیف دوره یک‌ساله (۳۰٪)',
      value: '-۱,۷۶۴,۰۰۰ تومان',
      icon: Icons.percent_rounded,
      isDiscount: true,
    ),
    SubscriptionInvoiceLineData(
      label: 'تخفیف کوپن NOWRUZ (۱۵٪)',
      value: '-۶۱۷,۴۰۰ تومان',
      icon: Icons.redeem_rounded,
      isDiscount: true,
    ),
    SubscriptionInvoiceLineData(
      label: 'مالیات بر ارزش افزوده و عوارض (۹٪)',
      value: '۳۱۴,۸۷۴ تومان',
    ),
  ];

  late final TextEditingController _couponController;

  int _selectedPeriodIndex = 2;
  int _selectedPlanIndex = 2;
  int _selectedGatewayIndex = 0;

  @override
  void initState() {
    super.initState();
    _couponController = TextEditingController(text: 'NOWRUZ');
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubscriptionPageLayout(
      title: 'ارتقا و تمدید اشتراک',
      bottomBar: SubscriptionCheckoutBar(
        onPayTap: () =>
            context.pushNamed(AppRoute.subscriptionPaymentSuccess.name),
      ),
      children: [
        SubscriptionActivePlanCard(
          planName: 'نسخه آزمایشی پرو',
          remainingLabel: '۷۴ روز باقی‌مانده',
          onTap: () =>
              context.pushNamed(AppRoute.subscriptionPaymentHistory.name),
        ),
        const Gap(24),
        SubscriptionBillingPeriodSelector(
          periods: _periods,
          selectedIndex: _selectedPeriodIndex,
          onSelected: (index) => setState(() => _selectedPeriodIndex = index),
        ),
        const Gap(24),
        for (var i = 0; i < _plans.length; i++) ...[
          SubscriptionPlanCard(
            plan: _plans[i],
            isSelected: i == _selectedPlanIndex,
            onSelect: _plans[i].isCurrent
                ? null
                : () => setState(() => _selectedPlanIndex = i),
          ),
          const Gap(16),
        ],
        const Gap(8),
        SubscriptionCouponCard(
          controller: _couponController,
          successMessage: 'کد تخفیف نوروز با موفقیت ۱۵٪ کسر گردید.',
        ),
        const Gap(24),
        SubscriptionGatewaySection(
          gateways: _gateways,
          selectedIndex: _selectedGatewayIndex,
          onSelected: (index) => setState(() => _selectedGatewayIndex = index),
        ),
        const Gap(24),
        const SubscriptionInvoiceSummaryCard(
          lines: _invoiceLines,
          totalValue: '۳,۸۱۲,۴۷۴',
          renewalNote: 'تمدید خودکار فعال نمی‌باشد',
        ),
        const Gap(20),
        const SubscriptionTrustRow(),
        const Gap(8),
      ],
    );
  }
}
