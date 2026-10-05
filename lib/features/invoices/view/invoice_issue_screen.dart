import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_add_item_row.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_bottom_bar.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_charges_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_customer_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_header.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_item_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_phone_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only "صدور فاکتور" form. Items, delivery fee and discount are kept in
/// local state so the total updates live; nothing is submitted.
class InvoiceIssueScreen extends StatefulWidget {
  const InvoiceIssueScreen({super.key});

  @override
  State<InvoiceIssueScreen> createState() => _InvoiceIssueScreenState();
}

class _InvoiceIssueScreenState extends State<InvoiceIssueScreen> {
  late final TextEditingController _phoneController;
  late final TextEditingController _deliveryFeeController;
  late final TextEditingController _discountController;

  late List<InvoiceIssueItemData> _items;
  InvoiceIssueDiscountMethod _discountMethod =
      InvoiceIssueDiscountMethod.amount;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: '۰۹۱۲۳۴۵۶۷۸۹');
    _deliveryFeeController = TextEditingController(text: '۰')
      ..addListener(_onAmountChanged);
    _discountController = TextEditingController()
      ..addListener(_onAmountChanged);
    _items = [
      InvoiceIssueItemData(product: invoiceIssueMockCatalog[1], quantity: 3),
      InvoiceIssueItemData(product: invoiceIssueMockCatalog[0], quantity: 1),
    ];
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _deliveryFeeController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() => setState(() {});

  int get _total {
    final subtotal = _items.fold(0, (sum, item) => sum + item.total);
    final deliveryFee = _deliveryFeeController.text.parseLocalizedInt() ?? 0;
    final discountValue = _discountController.text.parseLocalizedInt() ?? 0;
    final discount = switch (_discountMethod) {
      InvoiceIssueDiscountMethod.code => 0,
      InvoiceIssueDiscountMethod.percent =>
        subtotal * discountValue.clamp(0, 100) ~/ 100,
      InvoiceIssueDiscountMethod.amount => discountValue,
    };
    final total = subtotal + deliveryFee - discount;
    return total < 0 ? 0 : total;
  }

  void _updateQuantity(int index, int quantity) {
    setState(() => _items[index] = _items[index].copyWith(quantity: quantity));
  }

  void _removeItem(int index) => setState(() => _items.removeAt(index));

  void _changeDiscountMethod(InvoiceIssueDiscountMethod method) {
    if (method == _discountMethod) return;
    setState(() => _discountMethod = method);
    _discountController.clear();
  }

  Future<void> _openProductPicker() async {
    final items = await context.pushNamed<List<InvoiceIssueItemData>>(
      AppRoute.invoiceProductPicker.name,
      extra: List<InvoiceIssueItemData>.of(_items),
    );
    if (items != null && mounted) setState(() => _items = items);
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
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InvoiceIssueHeader(storeName: 'فروشگاه یاس'),
                          const Gap(20),
                          const InvoiceIssueCustomerCard(
                            name: 'مشتری نقدی',
                            caption: 'بدون شماره تماس ثبت شده',
                          ),
                          const Gap(14),
                          InvoiceIssuePhoneCard(controller: _phoneController),
                          const Gap(22),
                          Text(
                            'لیست کالاها',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const Gap(12),
                          for (final (index, item) in _items.indexed) ...[
                            InvoiceIssueItemCard(
                              key: ValueKey(item.product.code),
                              item: item,
                              onIncrement: () =>
                                  _updateQuantity(index, item.quantity + 1),
                              onDecrement: item.quantity <= 1
                                  ? null
                                  : () => _updateQuantity(
                                      index,
                                      item.quantity - 1,
                                    ),
                              onDeleteTap: () => _removeItem(index),
                            ),
                            const Gap(14),
                          ],
                          InvoiceIssueAddItemRow(onAddTap: _openProductPicker),
                          const Gap(20),
                          InvoiceIssueChargesCard(
                            deliveryFeeController: _deliveryFeeController,
                            discountController: _discountController,
                            discountMethod: _discountMethod,
                            onDiscountMethodChanged: _changeDiscountMethod,
                          ),
                          const Gap(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InvoiceIssueBottomBar(totalLabel: _total.toPersianAmount()),
            ],
          ),
        ),
      ),
    );
  }
}
