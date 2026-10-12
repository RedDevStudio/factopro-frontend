import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_barcode.dart';
import 'package:factopro/features/invoices/widgets/invoice_dashed_line.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_receipt_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A thermal printer roll rendering of [receipt]: always black on white,
/// whatever the app theme, like real receipt paper. Optional parts follow the
/// preview toggles. Expects an RTL [Directionality] ancestor.
class InvoiceThermalReceiptPaper extends StatelessWidget {
  const InvoiceThermalReceiptPaper({
    super.key,
    required this.receipt,
    required this.paperWidth,
    this.showLogo = true,
    this.showBarcode = true,
    this.showReturnFooter = true,
  });

  final InvoiceReceiptData receipt;
  final InvoiceThermalPaperWidth paperWidth;
  final bool showLogo;
  final bool showBarcode;
  final bool showReturnFooter;

  static const _ink = Color(0xFF111111);
  static const _muted = Color(0xFF6B7280);
  static const _success = Color(0xFF059669);

  @override
  Widget build(BuildContext context) {
    // Narrow rolls print with a slightly smaller font.
    final scale = paperWidth == InvoiceThermalPaperWidth.mm58 ? 0.88 : 1.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: paperWidth.previewWidth,
      padding: EdgeInsets.fromLTRB(16 * scale, 20, 16 * scale, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 11 * scale, color: _ink, height: 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showLogo) ...[
              Center(
                child: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _ink, width: 2),
                  ),
                  child: const Icon(
                    Icons.storefront_outlined,
                    size: 24,
                    color: _ink,
                  ),
                ),
              ),
              const Gap(10),
            ],
            Text(
              receipt.storeName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              receipt.branchLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'تلفن پشتیبانی: ${receipt.supportPhone}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10 * scale, color: _muted),
            ),
            const Gap(10),
            const InvoiceDashedLine(color: _ink),
            const Gap(10),
            _row('شماره فاکتور:', receipt.invoiceNumber, ltr: true, bold: true),
            _row(
              'تاریخ و زمان:',
              '${receipt.dateLabel} • ${receipt.timeLabel}',
            ),
            _row('صندوق‌دار:', receipt.cashierName),
            _row('خریدار:', receipt.buyerLabel),
            const Gap(8),
            const Divider(color: _ink, height: 1, thickness: 0.6),
            const Gap(6),
            DefaultTextStyle.merge(
              style: TextStyle(fontSize: 10 * scale, color: _muted),
              child: const Row(
                children: [
                  Expanded(child: Text('شرح کالا')),
                  Expanded(
                    child: Text('تعداد × فی', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('مبلغ (تومان)', textAlign: TextAlign.end),
                  ),
                ],
              ),
            ),
            const Gap(4),
            const Divider(color: _ink, height: 1, thickness: 0.6),
            for (final item in receipt.items)
              _ItemLines(item: item, scale: scale),
            const Gap(8),
            const InvoiceDashedLine(color: _ink, thickness: 2, dashLength: 7),
            const Gap(10),
            _row(
              'جمع اقلام (${receipt.items.length.toPersianDigits()} قلم):',
              '${receipt.subtotal.toPersianAmount()} تومان',
              bold: true,
            ),
            if (receipt.discount > 0)
              _row(
                '${receipt.discountLabel}:',
                '${receipt.discount.toPersianAmount()}- تومان',
                bold: true,
                color: _success,
              ),
            _row(
              'هزینه بسته‌بندی و تحویل:',
              receipt.deliveryFee == 0
                  ? 'رایگان'
                  : '${receipt.deliveryFee.toPersianAmount()} تومان',
              bold: true,
            ),
            _row(
              'مالیات بر ارزش افزوده (٪${receipt.vatPercent.toPersianDigits()}):',
              'محاسبه‌شده در قیمت',
            ),
            const Gap(8),
            const Divider(color: _ink, height: 1, thickness: 2),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'مبلغ نهایی قابل پرداخت:',
                    style: TextStyle(
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  receipt.total.toPersianAmount(),
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Gap(4),
                Text('تومان', style: TextStyle(fontSize: 9 * scale)),
              ],
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFD1D5DB)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.credit_card, size: 14, color: _ink),
                      const Gap(4),
                      Expanded(
                        child: Text(
                          'درگاه پوز ${receipt.paymentProvider} (متصل)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        'موفق',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _success,
                        ),
                      ),
                      const Gap(2),
                      const Icon(Icons.check, size: 14, color: _success),
                    ],
                  ),
                  const Gap(4),
                  _row(
                    'کد پیگیری تراکنش:',
                    receipt.trackingCode,
                    ltr: true,
                    bold: true,
                    small: true,
                  ),
                  _row(
                    'شماره مرجع بانکی (RRN):',
                    receipt.bankReference,
                    ltr: true,
                    bold: true,
                    small: true,
                  ),
                ],
              ),
            ),
            if (showBarcode) ...[
              const Gap(14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: InvoiceBarcode(
                  data: receipt.receiptCode,
                  color: _ink,
                  height: 44,
                ),
              ),
              const Gap(4),
              Text(
                receipt.receiptCode,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 10 * scale, letterSpacing: 1.5),
              ),
            ],
            if (showReturnFooter) ...[
              const Gap(12),
              const InvoiceDashedLine(color: _muted),
              const Gap(10),
              const Text(
                'از خرید و اعتماد شما صمیمانه متشکریم',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'کالای خریداری‌شده تا ۲۴ ساعت با ارائه این فیش قابل تعویض می‌باشد.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9.5 * scale, color: _muted),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool ltr = false,
    bool bold = false,
    bool small = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color ?? (small ? _muted : null),
                fontWeight: color != null ? FontWeight.bold : null,
                fontSize: small ? 10 : null,
              ),
            ),
          ),
          const Gap(8),
          Flexible(
            child: Text(
              value,
              textDirection: ltr ? TextDirection.ltr : null,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : null,
                color: color,
                fontSize: small ? 10.5 : null,
                fontFamily: ltr ? 'monospace' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Name, "quantity × unit price" and line total of one item, with its
/// warehouse code in small print.
class _ItemLines extends StatelessWidget {
  const _ItemLines({required this.item, required this.scale});

  final InvoiceIssueItemData item;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    const muted = InvoiceThermalReceiptPaper._muted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(8),
              Text(
                item.total.toPersianAmount(),
                style: TextStyle(
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${item.quantity.toPersianDigits()} ${product.unitLabel} × ${product.unitPrice.toPersianAmount()} تومان',
                  style: TextStyle(fontSize: 10 * scale, color: muted),
                ),
              ),
              Text(
                'کد: ${product.code}',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 9 * scale, color: muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
