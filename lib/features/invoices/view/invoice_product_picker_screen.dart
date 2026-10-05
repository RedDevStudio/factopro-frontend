import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_product_picker_bottom_bar.dart';
import 'package:factopro/features/invoices/widgets/invoice_product_picker_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_product_picker_category_chips.dart';
import 'package:factopro/features/invoices/widgets/invoice_product_picker_header.dart';
import 'package:factopro/features/invoices/widgets/invoice_product_picker_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// "انتخاب کالا" screen opened from the issue invoice form. Starts from the
/// invoice's current [initialItems] and pops with the edited list when saved;
/// going back discards the changes.
class InvoiceProductPickerScreen extends StatefulWidget {
  const InvoiceProductPickerScreen({super.key, this.initialItems = const []});

  final List<InvoiceIssueItemData> initialItems;

  @override
  State<InvoiceProductPickerScreen> createState() =>
      _InvoiceProductPickerScreenState();
}

class _InvoiceProductPickerScreenState
    extends State<InvoiceProductPickerScreen> {
  static const _catalog = invoiceIssueMockCatalog;

  late final TextEditingController _searchController;
  late final List<String> _categories;

  /// Selected lines keyed by product code, in the order they were added.
  late final Map<String, InvoiceIssueItemData> _selection;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()
      ..addListener(() => setState(() {}));
    _categories = {for (final product in _catalog) product.categoryLabel}
        .toList();
    _selection = {
      for (final item in widget.initialItems) item.product.code: item,
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<InvoiceIssueProductData> get _visibleProducts {
    final query = _searchController.text.trim().toLowerCase();
    return [
      for (final product in _catalog)
        if ((_selectedCategory == null ||
                product.categoryLabel == _selectedCategory) &&
            (query.isEmpty ||
                product.name.toLowerCase().contains(query) ||
                product.code.toLowerCase().contains(query)))
          product,
    ];
  }

  int get _total => _selection.values.fold(0, (sum, item) => sum + item.total);

  void _setQuantity(InvoiceIssueProductData product, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _selection.remove(product.code);
      } else {
        _selection[product.code] = InvoiceIssueItemData(
          product: product,
          quantity: quantity,
        );
      }
    });
  }

  void _close() {
    if (context.canPop()) context.pop();
  }

  void _save() => context.pop(_selection.values.toList());

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final products = _visibleProducts;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InvoiceProductPickerHeader(
                          selectedCount: _selection.length,
                          onBackTap: _close,
                        ),
                        const Gap(14),
                        InvoiceProductPickerSearchField(
                          controller: _searchController,
                        ),
                        const Gap(14),
                        InvoiceProductPickerCategoryChips(
                          categories: _categories,
                          selected: _selectedCategory,
                          onSelected: (category) =>
                              setState(() => _selectedCategory = category),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(color: colorScheme.outline, height: 1),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: products.isEmpty
                        ? _buildEmptyResult(context)
                        : ListView.separated(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.all(16),
                            itemCount: products.length,
                            separatorBuilder: (_, _) => const Gap(14),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              final quantity =
                                  _selection[product.code]?.quantity ?? 0;

                              return InvoiceProductPickerCard(
                                key: ValueKey(product.code),
                                product: product,
                                quantity: quantity,
                                onAddTap: () => _setQuantity(product, 1),
                                onIncrement: () =>
                                    _setQuantity(product, quantity + 1),
                                onDecrement: quantity <= 1
                                    ? null
                                    : () => _setQuantity(product, quantity - 1),
                                onRemoveTap: () => _setQuantity(product, 0),
                              );
                            },
                          ),
                  ),
                ),
              ),
              InvoiceProductPickerBottomBar(
                selectedCount: _selection.length,
                total: _total,
                onSaveTap: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyResult(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        'کالایی با این مشخصات یافت نشد',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
