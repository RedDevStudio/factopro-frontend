import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:factopro/features/settings/widgets/settings_option_chip.dart';
import 'package:factopro/features/settings/widgets/settings_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InvoicePrinterSection extends StatelessWidget {
  const InvoicePrinterSection({
    super.key,
    required this.defaultVatPercent,
    required this.printerConnected,
    required this.printerModel,
    required this.selectedPaperWidth,
    required this.onPaperWidthSelected,
    required this.preprintNoteController,
  });

  final int defaultVatPercent;
  final bool printerConnected;
  final String printerModel;
  final PrinterPaperWidth selectedPaperWidth;
  final ValueChanged<PrinterPaperWidth> onPaperWidthSelected;
  final TextEditingController preprintNoteController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SettingsSectionCard(
      title: 'تنظیمات فاکتور و فیش‌پرینتر',
      icon: Icons.receipt_long_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$defaultVatPercent (٪ درصد)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'مالیات بر ارزش افزوده پیش‌فرض',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const Gap(16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    if (printerConnected)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'متصل',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Text(
                      'چاپگر حرارتی / دستگاه پوز',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Gap(6),
                    Icon(Icons.print_outlined, size: 16, color: colorScheme.primary),
                  ],
                ),
                const Gap(6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'بلوتوث متصل: $printerModel',
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                  ),
                ),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: SettingsOptionChip(
                        label: PrinterPaperWidth.mm58.label,
                        selected: selectedPaperWidth == PrinterPaperWidth.mm58,
                        onTap: () => onPaperWidthSelected(PrinterPaperWidth.mm58),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: SettingsOptionChip(
                        label: PrinterPaperWidth.mm80.label,
                        selected: selectedPaperWidth == PrinterPaperWidth.mm80,
                        onTap: () => onPaperWidthSelected(PrinterPaperWidth.mm80),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'عرض رول کاغذ:',
                      style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'متن پیش‌فرض پاورقی فاکتور',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Gap(8),
          TextField(
            controller: preprintNoteController,
            maxLines: 3,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurface),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
