import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_barcode.dart';
import 'package:factopro/features/invoices/widgets/invoice_dashed_line.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_receipt_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The digital receipt card of the final invoice screen: store band, invoice
/// details, item lines, totals, payment details and barcode, finished with
/// ticket notches and a zig-zag bottom edge. [pageColor] is the background
/// behind the card, used to cut the notches. Expects an RTL
/// [Directionality] ancestor.
class InvoiceFinalReceiptCard extends StatelessWidget {
  const InvoiceFinalReceiptCard({
    super.key,
    required this.receipt,
    required this.pageColor,
  });

  final InvoiceReceiptData receipt;
  final Color pageColor;

  static const _radius = 18.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(_radius),
            ),
            border: Border(
              top: BorderSide(color: colorScheme.outline),
              left: BorderSide(color: colorScheme.outline),
              right: BorderSide(color: colorScheme.outline),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StoreBand(receipt: receipt),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: _DetailsGrid(receipt: receipt),
              ),
              _divider(colorScheme),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _ItemsTable(items: receipt.items),
              ),
              _divider(colorScheme),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: _Totals(receipt: receipt),
              ),
              Divider(color: colorScheme.outline, height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _PaymentDetails(receipt: receipt),
              ),
            ],
          ),
        ),
        InvoiceZigzagEdge(color: colorScheme.surface),
      ],
    );
  }

  Widget _divider(ColorScheme colorScheme) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InvoiceTicketDivider(
      lineColor: colorScheme.outline,
      notchColor: pageColor,
    ),
  );
}

class _StoreBand extends StatelessWidget {
  const _StoreBand({required this.receipt});

  final InvoiceReceiptData receipt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final background = isDark
        ? Color.alphaBlend(
            colorScheme.primary.withValues(alpha: 0.35),
            colorScheme.surface,
          )
        : colorScheme.secondary;
    const foreground = Colors.white;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(InvoiceFinalReceiptCard._radius - 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: foreground.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: foreground.withValues(alpha: 0.25)),
            ),
            child: const Icon(
              Icons.storefront_outlined,
              size: 22,
              color: foreground,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receipt.storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: foreground,
                  ),
                ),
                const Gap(2),
                Text(
                  receipt.branchLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: foreground.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isDark
                  ? colorScheme.primary
                  : foreground.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'رسمی',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsGrid extends StatelessWidget {
  const _DetailsGrid({required this.receipt});

  final InvoiceReceiptData receipt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Detail(
                label: 'شماره فاکتور:',
                value: receipt.invoiceNumber,
                valueColor: isDark
                    ? colorScheme.primary
                    : colorScheme.secondary,
                valueSize: 16,
                ltrValue: true,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _Detail(
                label: 'تاریخ و ساعت:',
                value: '${receipt.dateLabel} • ${receipt.timeLabel}',
              ),
            ),
          ],
        ),
        const Gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Detail(label: 'صندوق‌دار:', value: receipt.cashierName),
            ),
            const Gap(12),
            Expanded(
              child: _Detail(label: 'نام خریدار:', value: receipt.buyerLabel),
            ),
          ],
        ),
      ],
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueSize = 13,
    this.ltrValue = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final double valueSize;

  /// Latin values such as invoice numbers keep their left-to-right order.
  final bool ltrValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
        ),
        const Gap(4),
        Text(
          value,
          textDirection: ltrValue ? TextDirection.ltr : null,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: valueSize,
            fontWeight: FontWeight.bold,
            color: valueColor ?? colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ItemsTable extends StatelessWidget {
  const _ItemsTable({required this.items});

  final List<InvoiceIssueItemData> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final headerStyle = TextStyle(
      fontSize: 11,
      color: colorScheme.onSurfaceVariant,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(4),
        Row(
          children: [
            Expanded(child: Text('شرح اقلام و کالاها', style: headerStyle)),
            Text('مبلغ کل (تومان)', style: headerStyle),
          ],
        ),
        const Gap(8),
        for (final (index, item) in items.indexed) ...[
          if (index > 0) Divider(color: colorScheme.outline, height: 1),
          _ItemRow(item: item),
        ],
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.item});

  final InvoiceIssueItemData item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final product = item.product;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(
              product.thumbnailIcon,
              size: 22,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item.quantity.toPersianDigits()} ${product.unitLabel}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    const Gap(6),
                    Flexible(
                      child: Text(
                        '× ${product.unitPrice.toPersianAmount()} تومان',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(10),
          Text(
            item.total.toPersianAmount(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.receipt});

  final InvoiceReceiptData receipt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final labelStyle = TextStyle(
      fontSize: 12,
      color: colorScheme.onSurfaceVariant,
    );
    final valueStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    );
    final success = colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TotalRow(
          label: Text('جمع اقلام (قبل از تخفیف):', style: labelStyle),
          value: Text(
            '${receipt.subtotal.toPersianAmount()} تومان',
            style: valueStyle,
          ),
        ),
        if (receipt.discount > 0)
          _TotalRow(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_offer_outlined, size: 14, color: success),
                const Gap(4),
                Flexible(
                  child: Text(
                    '${receipt.discountLabel}:',
                    style: labelStyle.copyWith(
                      color: success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            value: Text(
              '${receipt.discount.toPersianAmount()}- تومان',
              style: valueStyle.copyWith(color: success),
            ),
          ),
        _TotalRow(
          label: Text('هزینه بسته‌بندی و تحویل:', style: labelStyle),
          value: receipt.deliveryFee == 0
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'رایگان (۰ تومان)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                )
              : Text(
                  '${receipt.deliveryFee.toPersianAmount()} تومان',
                  style: valueStyle,
                ),
        ),
        _TotalRow(
          label: Text(
            'مالیات بر ارزش افزوده (٪${receipt.vatPercent.toPersianDigits()}):',
            style: labelStyle,
          ),
          value: Text('محاسبه‌شده در قیمت', style: labelStyle),
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark
                ? success.withValues(alpha: 0.06)
                : colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark
                  ? success.withValues(alpha: 0.4)
                  : colorScheme.primary.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مبلغ نهایی پرداخت‌شده:',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Gap(4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: receipt.total.toPersianAmount(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: isDark ? success : colorScheme.secondary,
                            ),
                          ),
                          TextSpan(
                            text: ' تومان',
                            style: TextStyle(
                              fontSize: 11,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDark ? success.withValues(alpha: 0.15) : success,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.done_all_rounded,
                  size: 20,
                  color: isDark ? success : colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.label, required this.value});

  final Widget label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: label,
            ),
          ),
          const Gap(8),
          value,
        ],
      ),
    );
  }
}

class _PaymentDetails extends StatelessWidget {
  const _PaymentDetails({required this.receipt});

  final InvoiceReceiptData receipt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final labelStyle = TextStyle(
      fontSize: 11,
      color: colorScheme.onSurfaceVariant,
    );
    final valueStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    );

    Widget row(Widget label, String value, {bool ltr = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: label,
            ),
          ),
          const Gap(8),
          Text(
            value,
            textDirection: ltr ? TextDirection.ltr : null,
            style: valueStyle,
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark
                ? colorScheme.outlineVariant
                : colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            children: [
              row(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.point_of_sale_outlined,
                      size: 14,
                      color: colorScheme.primary,
                    ),
                    const Gap(4),
                    Text('درگاه پرداخت:', style: labelStyle),
                  ],
                ),
                'دستگاه پوز متصل (${receipt.paymentProvider})',
              ),
              row(
                Text('کد پیگیری تراکنش:', style: labelStyle),
                receipt.trackingCode,
                ltr: true,
              ),
              row(
                Text('شماره مرجع بانکی (RRN):', style: labelStyle),
                receipt.bankReference,
                ltr: true,
              ),
            ],
          ),
        ),
        const Gap(14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            // Dark bars on a light box in both themes, like a printed barcode.
            color: isDark ? Colors.white : colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InvoiceBarcode(
            data: receipt.receiptCode,
            color: const Color(0xFF0F172A),
            height: 52,
          ),
        ),
        const Gap(6),
        Text(
          receipt.receiptCode,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.5,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
