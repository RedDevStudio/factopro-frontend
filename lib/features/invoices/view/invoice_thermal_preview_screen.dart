import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_receipt_action_button.dart';
import 'package:factopro/features/invoices/widgets/invoice_receipt_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_thermal_receipt_paper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// UI-only "پیش‌نمایش فیش حرارتی" screen: previews how [receipt] prints on
/// the connected thermal printer, with paper width and optional receipt
/// parts switchable. Nothing is sent to a printer yet.
class InvoiceThermalPreviewScreen extends StatefulWidget {
  const InvoiceThermalPreviewScreen({super.key, this.receipt});

  /// Defaults to [invoiceReceiptMock] when opened without one.
  final InvoiceReceiptData? receipt;

  @override
  State<InvoiceThermalPreviewScreen> createState() =>
      _InvoiceThermalPreviewScreenState();
}

class _InvoiceThermalPreviewScreenState
    extends State<InvoiceThermalPreviewScreen> {
  InvoiceThermalPaperWidth _paperWidth = InvoiceThermalPaperWidth.mm80;
  bool _showBarcode = true;
  bool _showLogo = true;
  bool _showReturnFooter = true;

  void _close() {
    if (context.canPop()) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final receipt = widget.receipt ?? invoiceReceiptMock;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _Header(
                subtitle: '${_shortBranch(receipt)} • ${receipt.storeName}',
                onBackTap: _close,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _PaperWidthSelector(
                            selected: _paperWidth,
                            onSelected: (width) =>
                                setState(() => _paperWidth = width),
                          ),
                          const Gap(12),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 4,
                            children: [
                              _OptionCheckbox(
                                label: 'بارکد فیش',
                                value: _showBarcode,
                                onChanged: (value) =>
                                    setState(() => _showBarcode = value),
                              ),
                              _OptionCheckbox(
                                label: 'لوگوی فروشگاه',
                                value: _showLogo,
                                onChanged: (value) =>
                                    setState(() => _showLogo = value),
                              ),
                              _OptionCheckbox(
                                label: 'پاورقی مرجوعی',
                                value: _showReturnFooter,
                                onChanged: (value) =>
                                    setState(() => _showReturnFooter = value),
                              ),
                            ],
                          ),
                          const Gap(16),
                          // Scales the roll down on phones narrower than it.
                          Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: InvoiceThermalReceiptPaper(
                                receipt: receipt,
                                paperWidth: _paperWidth,
                                showLogo: _showLogo,
                                showBarcode: _showBarcode,
                                showReturnFooter: _showReturnFooter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const _BottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  /// "شعبه مرکزی - صندوق شماره ۴" -> "صندوق شماره ۴".
  static String _shortBranch(InvoiceReceiptData receipt) =>
      receipt.branchLabel.split(' - ').last;
}

/// Back arrow, title and subtitle on the start (right) side; the connected
/// printer pill on the end (left) side.
class _Header extends StatelessWidget {
  const _Header({required this.subtitle, required this.onBackTap});

  final String subtitle;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onBackTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'پیش‌نمایش فیش حرارتی',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.tertiary.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(5),
                Icon(
                  Icons.print_outlined,
                  size: 14,
                  color: colorScheme.onTertiaryContainer,
                ),
                const Gap(4),
                Text(
                  'SRP-330 (BT)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Two-segment 80mm / 58mm paper roll switch.
class _PaperWidthSelector extends StatelessWidget {
  const _PaperWidthSelector({required this.selected, required this.onSelected});

  final InvoiceThermalPaperWidth selected;
  final ValueChanged<InvoiceThermalPaperWidth> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.outline.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          for (final width in InvoiceThermalPaperWidth.values)
            Expanded(
              child: _PaperWidthSegment(
                width: width,
                selected: width == selected,
                onTap: () => onSelected(width),
              ),
            ),
        ],
      ),
    );
  }
}

class _PaperWidthSegment extends StatelessWidget {
  const _PaperWidthSegment({
    required this.width,
    required this.selected,
    required this.onTap,
  });

  final InvoiceThermalPaperWidth width;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? colorScheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.12),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected
                  ? Icons.receipt_long_rounded
                  : Icons.insert_drive_file_outlined,
              size: 16,
              color: selected
                  ? colorScheme.tertiary
                  : colorScheme.onSurfaceVariant,
            ),
            const Gap(6),
            Flexible(
              child: Text(
                width.label,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected
                      ? colorScheme.onSurface
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCheckbox extends StatelessWidget {
  const _OptionCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: value,
                onChanged: (value) => onChanged(value ?? false),
                activeColor: colorScheme.tertiary,
                checkColor: colorScheme.onTertiary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const Gap(6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Print button plus SMS / PDF / print settings shortcuts.
class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        14,
        16,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline)),
      ),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InvoiceReceiptActionButton(
                icon: Icons.print_outlined,
                label: 'چاپ فیش حرارتی (پرینت فوری)',
                height: 54,
                backgroundColor: colorScheme.tertiary,
                foregroundColor: isDark
                    ? colorScheme.onSurface
                    : colorScheme.onTertiary,
                borderColor: colorScheme.tertiary,
              ),
              const Gap(10),
              Row(
                children: [
                  for (final (index, (icon, label)) in const [
                    (Icons.sms_outlined, 'پیامک فیش'),
                    (Icons.download_outlined, 'دانلود PDF'),
                    (Icons.settings_outlined, 'تنظیمات چاپ'),
                  ].indexed) ...[
                    if (index > 0) const Gap(8),
                    Expanded(
                      child: InvoiceReceiptActionButton(
                        icon: icon,
                        label: label,
                        height: 44,
                        backgroundColor: colorScheme.outlineVariant,
                        foregroundColor: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
