import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/invoices/widgets/invoice_amount_text.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/invoices/widgets/invoice_scanner_item_card.dart';
import 'package:factopro/features/invoices/widgets/invoice_scanner_viewfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// "اسکنر بارکد" screen opened from the issue invoice form and the product
/// picker. The live camera detects barcodes and shows the scanned code;
/// codes matching the mock catalog (or typed via "ورود دستی بارکد") are added
/// to the list. Pops with the scanned lines when confirmed; cancelling or
/// going back discards them.
class InvoiceBarcodeScannerScreen extends StatefulWidget {
  const InvoiceBarcodeScannerScreen({super.key});

  @override
  State<InvoiceBarcodeScannerScreen> createState() =>
      _InvoiceBarcodeScannerScreenState();
}

class _InvoiceBarcodeScannerScreenState
    extends State<InvoiceBarcodeScannerScreen> {
  static const _catalog = invoiceIssueMockCatalog;

  /// The camera area is always dark, whatever the app theme.
  static const _cameraBackground = Color(0xFF0B1220);
  static const _overlayColor = Color(0xCC111827);
  static const _laserColor = Color(0xFFF43F5E);

  /// The same barcode is ignored for this long, so holding a product in
  /// front of the camera doesn't add it again on every frame.
  static const _rescanCooldown = Duration(seconds: 2);

  final _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  /// Scanned lines keyed by product code, in the order first scanned.
  final Map<String, InvoiceIssueItemData> _items = {};
  String? _lastScannedCode;

  /// Raw value of the latest detected barcode, shown in the success toast
  /// even when it doesn't match a catalog product.
  String? _lastBarcode;
  DateTime _lastBarcodeAt = DateTime(0);
  bool _soundOn = true;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  int get _total => _items.values.fold(0, (sum, item) => sum + item.total);

  void _onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.firstOrNull?.rawValue;
    if (barcode == null || barcode.isEmpty) return;

    final now = DateTime.now();
    if (barcode == _lastBarcode &&
        now.difference(_lastBarcodeAt) < _rescanCooldown) {
      return;
    }
    _lastBarcodeAt = now;
    if (_soundOn) HapticFeedback.mediumImpact();

    setState(() => _lastBarcode = barcode);
    final product = _findProduct(barcode);
    if (product != null) _addProduct(product);
  }

  InvoiceIssueProductData? _findProduct(String barcode) {
    final digits = barcode.parseLocalizedInt()?.toString();
    return _catalog.where((product) => product.barcode == digits).firstOrNull;
  }

  void _addProduct(InvoiceIssueProductData product) {
    setState(() {
      final existing = _items[product.code];
      _items[product.code] = existing == null
          ? InvoiceIssueItemData(product: product, quantity: 1)
          : existing.copyWith(quantity: existing.quantity + 1);
      _lastScannedCode = product.code;
    });
  }

  void _setQuantity(String code, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _items.remove(code);
        if (_lastScannedCode == code) _lastScannedCode = null;
      } else {
        _items[code] = _items[code]!.copyWith(quantity: quantity);
      }
    });
  }

  void _clear() => setState(() {
    _items.clear();
    _lastScannedCode = null;
  });

  Future<void> _enterBarcodeManually() async {
    final barcode = await showDialog<String>(
      context: context,
      builder: (context) => const _ManualBarcodeDialog(),
    );
    if (barcode == null || !mounted) return;

    final product = _findProduct(barcode);
    if (product == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('کالایی با این بارکد یافت نشد')),
      );
      return;
    }
    setState(() => _lastBarcode = product.barcode);
    _addProduct(product);
  }

  /// Opens the product picker with the scanned lines; its result replaces
  /// them, just like it does for the invoice. The camera is paused meanwhile.
  Future<void> _searchWarehouse() async {
    await _scannerController.stop();
    if (!mounted) return;
    final items = await context.pushNamed<List<InvoiceIssueItemData>>(
      AppRoute.invoiceProductPicker.name,
      extra: _items.values.toList(),
    );
    if (!mounted) return;
    await _scannerController.start();
    if (items == null || !mounted) return;
    setState(() {
      _items
        ..clear()
        ..addAll({for (final item in items) item.product.code: item});
      if (!_items.containsKey(_lastScannedCode)) _lastScannedCode = null;
    });
  }

  void _close() {
    if (context.canPop()) context.pop();
  }

  void _confirm() => context.pop(_items.values.toList());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _cameraBackground,
        body: Column(
          children: [
            Expanded(flex: 11, child: _buildCameraArea(context)),
            Expanded(flex: 10, child: _buildScannedSheet(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraArea(BuildContext context) {
    final colorScheme = context.colorScheme;
    final lastBarcode = _lastBarcode;

    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _scannerController,
          onDetect: _onDetect,
          placeholderBuilder: (_) => const ColoredBox(color: _cameraBackground),
          errorBuilder: (context, error) => _CameraErrorView(error: error),
        ),
        // Darkens the top and bottom of the preview so the controls stay
        // readable over a bright camera image.
        const IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x99000000),
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0x99000000),
                ],
                stops: [0, 0.25, 0.7, 1],
              ),
            ),
          ),
        ),
        _buildCameraOverlay(context, colorScheme, lastBarcode),
      ],
    );
  }

  Widget _buildCameraOverlay(
    BuildContext context,
    ColorScheme colorScheme,
    String? lastBarcode,
  ) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          children: [
            Row(
              children: [
                _CameraIconButton(
                  icon: Icons.arrow_forward_rounded,
                  onTap: _close,
                ),
                Expanded(
                  child: Center(
                    child: _OverlayPill(
                      leading: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      label: 'بارکدخوان فعال (زنده)',
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _scannerController,
                  builder: (context, state, _) {
                    final torchOn = state.torchState == TorchState.on;
                    return _CameraIconButton(
                      icon: torchOn
                          ? Icons.flashlight_on_rounded
                          : Icons.flashlight_off_rounded,
                      highlighted: torchOn,
                      onTap: state.torchState == TorchState.unavailable
                          ? null
                          : _scannerController.toggleTorch,
                    );
                  },
                ),
                const Gap(8),
                _CameraIconButton(
                  icon: _soundOn
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded,
                  onTap: () => setState(() => _soundOn = !_soundOn),
                ),
              ],
            ),
            const Spacer(),
            _OverlayPill(
              leading: Icon(
                Icons.qr_code_scanner_rounded,
                size: 16,
                color: colorScheme.primary,
              ),
              label: 'بارکد یا کد QR کالا را در کادر قرار دهید',
            ),
            const Gap(16),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                InvoiceScannerViewfinder(
                  cornerColor: colorScheme.primary,
                  laserColor: _laserColor,
                ),
                if (lastBarcode != null)
                  Positioned(
                    bottom: -14,
                    child: _ScanSuccessToast(
                      barcode: lastBarcode,
                      color: colorScheme.tertiary,
                    ),
                  ),
              ],
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: _OverlayButton(
                    icon: Icons.keyboard_alt_outlined,
                    iconColor: colorScheme.primary,
                    label: 'ورود دستی بارکد',
                    onTap: _enterBarcodeManually,
                  ),
                ),
                const Gap(10),
                Flexible(
                  child: _OverlayButton(
                    icon: Icons.search_rounded,
                    iconColor: const Color(0xFFF59E0B),
                    label: 'جستجو در انبار',
                    onTap: _searchWarehouse,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedSheet(BuildContext context) {
    final colorScheme = context.colorScheme;
    final items = _items.values.toList();

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              const Gap(10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                    ),
                    const Gap(8),
                    Flexible(
                      child: Text(
                        'اقلام اسکن‌شده به فاکتور',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${items.length.toPersianDigits()} قلم کالا',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (items.isNotEmpty)
                      InkWell(
                        onTap: _clear,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.delete_sweep_outlined,
                                size: 16,
                                color: colorScheme.error,
                              ),
                              const Gap(4),
                              Text(
                                'پاک کردن',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'هنوز کالایی اسکن نشده است.\nبارکد کالا را در کادر قرار دهید.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.8,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const Gap(10),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final code = item.product.code;
                          return InvoiceScannerItemCard(
                            key: ValueKey(code),
                            item: item,
                            isNew: code == _lastScannedCode,
                            onIncrement: () =>
                                _setQuantity(code, item.quantity + 1),
                            onDecrement: item.quantity <= 1
                                ? null
                                : () => _setQuantity(code, item.quantity - 1),
                            onDeleteTap: () => _setQuantity(code, 0),
                          );
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  10,
                  16,
                  12 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(color: colorScheme.outline, height: 1),
                    const Gap(10),
                    Row(
                      children: [
                        Text(
                          'مجموع اقلام اسکن‌شده:',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        InvoiceAmountText(
                          value: _total.toPersianAmount(),
                          fontSize: 18,
                        ),
                      ],
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            onTap: _confirm,
                            labelText: 'ثبت و بازگشت به فاکتور',
                            labelFontSize: 15,
                            icon: Icons.check_circle_outline_rounded,
                            backgroundColor: colorScheme.tertiary,
                            labelTextColor: colorScheme.onTertiary,
                            borderColor: colorScheme.tertiary,
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: 86,
                          child: PrimaryButton(
                            onTap: _close,
                            labelText: 'انصراف',
                            labelFontSize: 14,
                            backgroundColor: colorScheme.outlineVariant,
                            labelTextColor: colorScheme.onSurface,
                            borderColor: colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shown in place of the camera preview when it can't start, e.g. when the
/// camera permission was denied.
class _CameraErrorView extends StatelessWidget {
  const _CameraErrorView({required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    final message = switch (error.errorCode) {
      MobileScannerErrorCode.permissionDenied => 'دسترسی به دوربین داده نشده است.\nاز تنظیمات گوشی اجازه دوربین را فعال کنید.',
      MobileScannerErrorCode.unsupported =>
        'این دستگاه از اسکن با دوربین پشتیبانی نمی‌کند.',
      _ => 'راه‌اندازی دوربین با خطا مواجه شد.',
    };

    return ColoredBox(
      color: _InvoiceBarcodeScannerScreenState._cameraBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.no_photography_outlined,
                size: 36,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              const Gap(10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.8,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Round translucent button on the camera overlay (back, flash, sound).
class _CameraIconButton extends StatelessWidget {
  const _CameraIconButton({
    required this.icon,
    required this.onTap,
    this.highlighted = false,
  });

  final IconData icon;

  /// Null disables the button (e.g. no torch available).
  final VoidCallback? onTap;
  final bool highlighted;

  static const _highlightColor = Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: highlighted
              ? _highlightColor.withValues(alpha: 0.25)
              : _InvoiceBarcodeScannerScreenState._overlayColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: highlighted
                ? _highlightColor
                : Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: highlighted ? _highlightColor : Colors.white,
        ),
      ),
    );
  }
}

/// Translucent rounded label on the camera overlay.
class _OverlayPill extends StatelessWidget {
  const _OverlayPill({required this.leading, required this.label});

  final Widget leading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _InvoiceBarcodeScannerScreenState._overlayColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const Gap(8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Translucent action button under the scan frame.
class _OverlayButton extends StatelessWidget {
  const _OverlayButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _InvoiceBarcodeScannerScreenState._overlayColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const Gap(6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Green "کد ... اسکن شد!" confirmation shown under the scan frame.
class _ScanSuccessToast extends StatelessWidget {
  const _ScanSuccessToast({required this.barcode, required this.color});

  final String barcode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final persianBarcode = barcode.replaceAllMapped(
      RegExp(r'\d'),
      (match) => int.parse(match[0]!).toPersianDigits(),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 12),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, size: 14, color: Colors.white),
          const Gap(6),
          Text(
            'کد $persianBarcode اسکن شد!',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks for a barcode typed by hand; pops with the entered text.
class _ManualBarcodeDialog extends StatefulWidget {
  const _ManualBarcodeDialog();

  @override
  State<_ManualBarcodeDialog> createState() => _ManualBarcodeDialogState();
}

class _ManualBarcodeDialogState extends State<_ManualBarcodeDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text('ورود دستی بارکد', style: TextStyle(fontSize: 16)),
        content: TextField(
          controller: _controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(hintText: 'مثلا 6260192847102'),
          onSubmitted: (_) => _submit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('انصراف'),
          ),
          FilledButton(onPressed: _submit, child: const Text('افزودن')),
        ],
      ),
    );
  }
}
