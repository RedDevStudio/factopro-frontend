import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_card_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_final_receipt_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_receipt_action_button.dart';
import 'package:factopro/features/invoices/widgets/invoice_receipt_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_status_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only "فاکتور نهایی" screen shown after an invoice is issued: the
/// digital receipt plus print, PDF, share, SMS and new-invoice actions. The
/// payment status can be switched from the status pill; nothing is saved.
class InvoiceFinalScreen extends StatefulWidget {
  const InvoiceFinalScreen({super.key, this.receipt});

  /// Defaults to [invoiceReceiptMock] when opened without one.
  final InvoiceReceiptData? receipt;

  @override
  State<InvoiceFinalScreen> createState() => _InvoiceFinalScreenState();
}

class _InvoiceFinalScreenState extends State<InvoiceFinalScreen> {
  late InvoiceReceiptData _receipt;

  @override
  void initState() {
    super.initState();
    _receipt = widget.receipt ?? invoiceReceiptMock;
  }

  void _close() {
    if (context.canPop()) context.pop();
  }

  void _openThermalPreview() =>
      context.pushNamed(AppRoute.invoiceThermalPreview.name, extra: _receipt);

  /// Replaces this screen with an empty issue invoice form.
  void _issueNewInvoice() =>
      context.pushReplacementNamed(AppRoute.invoiceIssue.name);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final pageColor = colorScheme.outlineVariant;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: pageColor,
        body: SafeArea(
          child: Column(
            children: [
              _Header(onBackTap: _close),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              _StatusMenu(
                                status: _receipt.status,
                                onChanged: (status) => setState(
                                  () => _receipt = _receipt.copyWith(
                                    status: status,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              _CircleIconButton(
                                icon: Icons.share_outlined,
                                onTap: () {},
                              ),
                              const Gap(8),
                              _CircleIconButton(
                                icon: Icons.picture_as_pdf_outlined,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const Gap(12),
                          InvoiceFinalReceiptCard(
                            receipt: _receipt,
                            pageColor: pageColor,
                          ),
                          const Gap(16),
                          Text(
                            'از خرید و اعتماد شما صمیمانه متشکریم • کالای خریداری‌شده تا ۲۴ ساعت با ارائه این رسید قابل تعویض می‌باشد.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.8,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Gap(20),
                          InvoiceReceiptActionButton(
                            icon: Icons.print_outlined,
                            label: 'چاپ فیش حرارتی (پرینتر صندوق)',
                            height: 56,
                            backgroundColor: colorScheme.tertiary,
                            foregroundColor: isDark
                                ? colorScheme.onSurface
                                : colorScheme.onTertiary,
                            borderColor: colorScheme.tertiary,
                            onTap: _openThermalPreview,
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: InvoiceReceiptActionButton(
                                  icon: Icons.download_outlined,
                                  label: 'دانلود فایل فاکتور (PDF)',
                                  foregroundColor: isDark
                                      ? null
                                      : colorScheme.secondary,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: InvoiceReceiptActionButton(
                                  icon: Icons.share_outlined,
                                  label: 'اشتراک‌گذاری فاکتور',
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: InvoiceReceiptActionButton(
                                  icon: Icons.sms_outlined,
                                  label: 'ارسال پیامک فیش',
                                  backgroundColor: isDark
                                      ? colorScheme.outlineVariant
                                      : colorScheme.primaryContainer,
                                  foregroundColor: isDark
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.secondary,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: InvoiceReceiptActionButton(
                                  icon: Icons.add_shopping_cart_rounded,
                                  label: 'ثبت فاکتور جدید',
                                  backgroundColor: isDark
                                      ? colorScheme.primary
                                      : colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                  borderColor: isDark
                                      ? colorScheme.primary
                                      : colorScheme.secondary,
                                  onTap: _issueNewInvoice,
                                ),
                              ),
                            ],
                          ),
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

/// Back arrow and "فاکتور نهایی" title on the start (right) side, store
/// badge on the end (left) side.
class _Header extends StatelessWidget {
  const _Header({required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackTap,
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: Text(
              'فاکتور نهایی',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDark
                  ? colorScheme.primary.withValues(alpha: 0.2)
                  : colorScheme.secondary,
              shape: BoxShape.circle,
              border: isDark
                  ? Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.5),
                    )
                  : null,
            ),
            child: Icon(
              Icons.storefront_outlined,
              size: 20,
              color: isDark ? colorScheme.primary : colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// "وضعیت: ..." pill that opens a menu to switch the payment status.
class _StatusMenu extends StatelessWidget {
  const _StatusMenu({required this.status, required this.onChanged});

  final InvoiceStatus status;
  final ValueChanged<InvoiceStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    final (accent, container, onContainer) = invoiceStatusColors(
      context,
      status,
    );

    return PopupMenuButton<InvoiceStatus>(
      initialValue: status,
      onSelected: onChanged,
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        for (final option in InvoiceStatus.values)
          PopupMenuItem(
            value: option,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Icon(
                    option.icon,
                    size: 16,
                    color: invoiceStatusColors(context, option).$1,
                  ),
                  const Gap(8),
                  Text(option.badgeLabel, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: container,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(status.icon, size: 16, color: accent),
            const Gap(5),
            Text(
              'وضعیت: ${status.badgeLabel}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: onContainer,
              ),
            ),
            const Gap(4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: onContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.outline),
        ),
        child: Icon(icon, size: 18, color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
