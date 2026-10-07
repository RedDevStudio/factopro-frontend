import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';

/// Static, UI-only snapshot of an issued invoice, shared by the final
/// invoice ("فاکتور نهایی") and thermal receipt preview screens. Amounts are
/// in toman.
class InvoiceReceiptData {
  const InvoiceReceiptData({
    required this.storeName,
    required this.branchLabel,
    required this.supportPhone,
    required this.invoiceNumber,
    required this.dateLabel,
    required this.timeLabel,
    required this.cashierName,
    required this.buyerName,
    required this.buyerPhone,
    required this.items,
    required this.paymentProvider,
    required this.trackingCode,
    required this.bankReference,
    required this.receiptCode,
    this.discount = 0,
    this.discountLabel = 'تخفیف مشتری وفادار',
    this.deliveryFee = 0,
    this.vatPercent = 9,
    this.status = InvoiceStatus.paid,
  });

  /// e.g. "هایپرمارکت پارس (اعتماد)".
  final String storeName;

  /// e.g. "شعبه مرکزی - صندوق شماره ۴".
  final String branchLabel;
  final String supportPhone;

  /// Latin invoice number, e.g. "INV-1402-892".
  final String invoiceNumber;

  /// e.g. "۲۴ آبان ۱۴۰۲".
  final String dateLabel;

  /// e.g. "۱۴:۳۵".
  final String timeLabel;
  final String cashierName;
  final String buyerName;
  final String? buyerPhone;
  final List<InvoiceIssueItemData> items;

  /// Bank behind the connected card reader, e.g. "به‌پرداخت ملت".
  final String paymentProvider;

  /// Latin transaction tracking code, e.g. "TR-98241047".
  final String trackingCode;

  /// Masked bank reference number (RRN).
  final String bankReference;

  /// Latin value encoded in the receipt barcode.
  final String receiptCode;
  final int discount;
  final String discountLabel;

  /// Packaging and delivery fee; zero is shown as free.
  final int deliveryFee;

  /// Value added tax rate, already included in item prices.
  final int vatPercent;
  final InvoiceStatus status;

  int get subtotal => items.fold(0, (sum, item) => sum + item.total);

  int get total {
    final total = subtotal + deliveryFee - discount;
    return total < 0 ? 0 : total;
  }

  /// e.g. "مشتری نقدی (۰۹۱۲۳۴۵۶۷۸۹)".
  String get buyerLabel =>
      buyerPhone == null || buyerPhone!.isEmpty
          ? buyerName
          : '$buyerName ($buyerPhone)';

  InvoiceReceiptData copyWith({InvoiceStatus? status}) => InvoiceReceiptData(
    storeName: storeName,
    branchLabel: branchLabel,
    supportPhone: supportPhone,
    invoiceNumber: invoiceNumber,
    dateLabel: dateLabel,
    timeLabel: timeLabel,
    cashierName: cashierName,
    buyerName: buyerName,
    buyerPhone: buyerPhone,
    items: items,
    paymentProvider: paymentProvider,
    trackingCode: trackingCode,
    bankReference: bankReference,
    receiptCode: receiptCode,
    discount: discount,
    discountLabel: discountLabel,
    deliveryFee: deliveryFee,
    vatPercent: vatPercent,
    status: status ?? this.status,
  );

  /// Mock receipt for the lines and charges entered on the issue invoice
  /// form; store, cashier and payment details are static.
  factory InvoiceReceiptData.mock({
    required List<InvoiceIssueItemData> items,
    int discount = 0,
    int deliveryFee = 0,
    String? buyerPhone,
  }) => InvoiceReceiptData(
    storeName: 'هایپرمارکت پارس (اعتماد)',
    branchLabel: 'شعبه مرکزی - صندوق شماره ۴',
    supportPhone: '۰۲۱-۸۸۸۸۴۴۲۲',
    invoiceNumber: 'INV-1402-892',
    dateLabel: '۲۴ آبان ۱۴۰۲',
    timeLabel: '۱۴:۳۵',
    cashierName: 'محمد حسینی',
    buyerName: 'مشتری نقدی',
    buyerPhone: buyerPhone,
    items: items,
    paymentProvider: 'به‌پرداخت ملت',
    trackingCode: 'TR-98241047',
    bankReference: '۹۹۲۱***۶۱۰۴',
    receiptCode: '14020824-892-3700',
    discount: discount,
    deliveryFee: deliveryFee,
  );
}

/// Receipt shown when a screen is opened without one, matching the designs.
final invoiceReceiptMock = InvoiceReceiptData.mock(
  items: [
    InvoiceIssueItemData(product: invoiceIssueMockCatalog[1], quantity: 3),
    InvoiceIssueItemData(product: invoiceIssueMockCatalog[0], quantity: 1),
    InvoiceIssueItemData(product: invoiceIssueMockCatalog[2], quantity: 2),
  ],
  discount: 170000,
  buyerPhone: '۰۹۱۲۳۴۵۶۷۸۹',
);

/// Paper roll widths supported by the thermal receipt preview.
enum InvoiceThermalPaperWidth {
  mm80,
  mm58;

  String get label => switch (this) {
    InvoiceThermalPaperWidth.mm80 => '۸۰ میلی‌متر (استاندارد فروشگاه)',
    InvoiceThermalPaperWidth.mm58 => '۵۸ میلی‌متر (جیبی)',
  };

  /// Preview paper width in logical pixels.
  double get previewWidth => switch (this) {
    InvoiceThermalPaperWidth.mm80 => 340,
    InvoiceThermalPaperWidth.mm58 => 250,
  };
}
