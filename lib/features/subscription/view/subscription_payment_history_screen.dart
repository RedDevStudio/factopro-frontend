import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/features/subscription/widgets/subscription_data.dart';
import 'package:factopro/features/subscription/widgets/subscription_history_filter_bar.dart';
import 'package:factopro/features/subscription/widgets/subscription_history_overview_card.dart';
import 'package:factopro/features/subscription/widgets/subscription_page_layout.dart';
import 'package:factopro/features/subscription/widgets/subscription_support_card.dart';
import 'package:factopro/features/subscription/widgets/subscription_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only "سوابق پرداخت اشتراک‌ها" (subscription payment history) screen.
/// The filter is local state; transactions are static mock data.
class SubscriptionPaymentHistoryScreen extends StatefulWidget {
  const SubscriptionPaymentHistoryScreen({super.key});

  @override
  State<SubscriptionPaymentHistoryScreen> createState() =>
      _SubscriptionPaymentHistoryScreenState();
}

class _SubscriptionPaymentHistoryScreenState
    extends State<SubscriptionPaymentHistoryScreen> {
  static const _transactions = [
    SubscriptionTransactionData(
      title: 'تمدید سالانه پلن طلایی (Gold Pro)',
      dateLabel: '۲۴ آبان ۱۴۰۳',
      timeLabel: 'ساعت ۱۴:۳۵',
      amount: '۴,۸۵۰,۰۰۰',
      status: SubscriptionTransactionStatus.successful,
      gatewayName: 'درگاه سامان (شاپرک)',
      gatewayIcon: Icons.account_balance_outlined,
      trackingCode: 'TR-98421045',
      hasPdfReceipt: true,
    ),
    SubscriptionTransactionData(
      title: 'ارتقا ۶ ماهه به پلن طلایی',
      dateLabel: '۱۵ اردیبهشت ۱۴۰۳',
      timeLabel: 'ساعت ۱۱:۲۰',
      amount: '۲,۶۵۰,۰۰۰',
      status: SubscriptionTransactionStatus.successful,
      gatewayName: 'پرداخت اینترنتی به پرداخت ملت',
      trackingCode: 'TR-74125890',
    ),
    SubscriptionTransactionData(
      title: 'تلاش برای تمدید ۳ ماهه پلن نقره‌ای',
      dateLabel: '۱۴ اردیبهشت ۱۴۰۳',
      timeLabel: 'ساعت ۱۸:۱۰',
      amount: '۷۸۰,۰۰۰',
      status: SubscriptionTransactionStatus.failed,
      failureReason: 'عدم پاسخ بانک (برگشت خورده)',
      failureBadgeLabel: 'برگشت به حساب مبدا',
      failureNote: 'مبلغ ظرف ۲۴ تا ۷۲ ساعت عودت شده است',
    ),
    SubscriptionTransactionData(
      title: 'خرید اولیه اشتراک ۶ ماهه نقره‌ای (Pro)',
      dateLabel: '۲۰ آبان ۱۴۰۲',
      timeLabel: 'ساعت ۱۰:۱۵',
      amount: '۱,۴۵۰,۰۰۰',
      status: SubscriptionTransactionStatus.successful,
      gatewayName: 'درگاه پرداخت بانک پارسیان',
      trackingCode: 'TR-50148922',
    ),
  ];

  SubscriptionHistoryFilter _filter = SubscriptionHistoryFilter.all;

  bool _matches(SubscriptionTransactionData transaction) => switch (_filter) {
    SubscriptionHistoryFilter.all => true,
    SubscriptionHistoryFilter.successful => transaction.isSuccessful,
    SubscriptionHistoryFilter.failed => !transaction.isSuccessful,
  };

  @override
  Widget build(BuildContext context) {
    final successfulCount = _transactions.where((t) => t.isSuccessful).length;
    final visible = _transactions.where(_matches).toList();

    return SubscriptionPageLayout(
      title: 'سوابق پرداخت اشتراک‌ها',
      children: [
        const SubscriptionHistoryOverviewCard(
          planName: 'طلایی (Gold Pro)',
          validUntilLabel: 'فعال تا آبان ۱۴۰۴',
          totalPaid: '۸,۹۵۰,۰۰۰',
          renewalCount: '۴',
          renewalCaption: 'دوره متوالی',
        ),
        const Gap(20),
        SubscriptionHistoryFilterBar(
          counts: {
            SubscriptionHistoryFilter.all: _transactions.length,
            SubscriptionHistoryFilter.successful: successfulCount,
            SubscriptionHistoryFilter.failed:
                _transactions.length - successfulCount,
          },
          selected: _filter,
          onSelected: (filter) => setState(() => _filter = filter),
        ),
        const Gap(16),
        for (final transaction in visible) ...[
          SubscriptionTransactionCard(
            transaction: transaction,
            onViewInvoiceTap: () =>
                context.pushNamed(AppRoute.subscriptionPaymentSuccess.name),
          ),
          const Gap(14),
        ],
        const Gap(14),
        const SubscriptionSupportCard(),
        const Gap(8),
      ],
    );
  }
}
