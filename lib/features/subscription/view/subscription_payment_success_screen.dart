import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/features/subscription/widgets/subscription_action_button.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_page_layout.dart';
import 'package:factopro/features/subscription/widgets/subscription_receipt_card.dart';
import 'package:factopro/features/subscription/widgets/subscription_success_hero.dart';
import 'package:factopro/features/subscription/widgets/subscription_unlocked_features_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only "پرداخت موفق و رسید اشتراک" (payment success & subscription
/// receipt) screen shown after checkout. Receipt values are static mock data.
class SubscriptionPaymentSuccessScreen extends StatelessWidget {
  const SubscriptionPaymentSuccessScreen({super.key});

  static const _receiptDetails = [
    SubscriptionReceiptDetailData(
      icon: Icons.tag_rounded,
      label: 'کد پیگیری شاپرک',
      value: 'TR-98421045',
      isCopyable: true,
      isLtr: true,
    ),
    SubscriptionReceiptDetailData(
      icon: Icons.tag_rounded,
      label: 'شماره ارجاع بانکی (RRN)',
      value: '884712093512',
      isLtr: true,
    ),
    SubscriptionReceiptDetailData(
      icon: Icons.calendar_today_outlined,
      label: 'زمان تراکنش',
      value: '۲۴ آبان ۱۴۰۳ - ساعت ۱۴:۳۵',
    ),
    SubscriptionReceiptDetailData(
      icon: Icons.account_balance_outlined,
      label: 'درگاه بانکی',
      value: 'سامان کیش (شبکه شاپرک)',
    ),
    SubscriptionReceiptDetailData(
      icon: Icons.credit_card_rounded,
      label: 'کارت واریزکننده',
      value: '۶۰۳۷-۹۹**-****-۲۱۸۴',
      isLtr: true,
    ),
    SubscriptionReceiptDetailData(
      icon: Icons.history_rounded,
      label: 'اعتبار دوره جدید',
      value: '۲۴ آبان ۱۴۰۳ تا ۱۴۰۴ (۳۶۵ روز)',
      isHighlighted: true,
    ),
  ];

  static const _unlockedFeatures = [
    SubscriptionUnlockedFeatureData(
      icon: Icons.all_inclusive_rounded,
      title: 'صدور فاکتور نامحدود',
      description: 'حذف تمام سقف‌های ماهانه و اتصال مستقیم به سامانه مودیان',
    ),
    SubscriptionUnlockedFeatureData(
      icon: Icons.psychology_outlined,
      title: 'هوش مصنوعی و انبارداری هوشمند',
      description: 'تحلیل خودکار سود و زیان، پیش‌بینی کسری موجودی کالا',
    ),
    SubscriptionUnlockedFeatureData(
      icon: Icons.sms_outlined,
      title: '۵۰۰ پیامک یادآوری نسیه',
      description: 'ارسال خودکار لینک پرداخت و صورتحساب به بدهکاران',
      badgeLabel: 'هدیه تمدید',
      isGift: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final accent = SubscriptionColors.accentOf(context);

    return SubscriptionPageLayout(
      title: 'پرداخت موفق و رسید اشتراک',
      children: [
        const SubscriptionSuccessHero(
          planPrefix: 'اشتراک طلایی (',
          planLabel: 'Gold Pro',
          planSuffix: ') شما به مدت ۱ سال با موفقیت فعال و تمدید گردید.',
        ),
        const Gap(24),
        const SubscriptionReceiptCard(
          issuerName: "اعتماد پرو (E'temad Pro)",
          totalValue: '۴,۸۵۰,۰۰۰',
          details: _receiptDetails,
        ),
        const Gap(28),
        const SubscriptionUnlockedFeaturesSection(features: _unlockedFeatures),
        const Gap(24),
        PrimaryButton(
          onTap: () => context.goNamed(AppRoute.dashboard.name),
          labelText: 'بازگشت به پیشخوان فروشگاه',
          labelFontSize: 15,
          icon: Icons.storefront_outlined,
          backgroundColor: accent,
          labelTextColor: SubscriptionColors.onAccentOf(context),
          borderColor: accent,
        ),
        const Gap(12),
        const Row(
          children: [
            Expanded(
              child: SubscriptionActionButton(
                label: 'دانلود PDF فیش',
                icon: Icons.picture_as_pdf_outlined,
                height: 48,
              ),
            ),
            Gap(12),
            Expanded(
              child: SubscriptionActionButton(
                label: 'اشتراک‌گذاری رسید',
                icon: Icons.share_outlined,
                height: 48,
              ),
            ),
          ],
        ),
        const Gap(8),
      ],
    );
  }
}
