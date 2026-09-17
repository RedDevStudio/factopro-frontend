import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:factopro/features/settings/widgets/settings_option_chip.dart';
import 'package:factopro/features/settings/widgets/settings_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FontSettingsSection extends StatelessWidget {
  const FontSettingsSection({
    super.key,
    required this.selectedFontFamily,
    required this.selectedFontSize,
    required this.onFontFamilySelected,
    required this.onFontSizeSelected,
  });

  final AppFontFamily selectedFontFamily;
  final AppFontSize selectedFontSize;
  final ValueChanged<AppFontFamily> onFontFamilySelected;
  final ValueChanged<AppFontSize> onFontSizeSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SettingsSectionCard(
      title: 'تنظیمات قلم و اندازه متن',
      icon: Icons.text_fields,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Label('نوع قلم نرم‌افزار'),
          const Gap(10),
          _Grid2x2(
            children: AppFontFamily.values.reversed
                .map(
                  (font) => SettingsOptionChip(
                    label: font.label,
                    selected: font == selectedFontFamily,
                    onTap: () => onFontFamilySelected(font),
                  ),
                )
                .toList(),
          ),
          const Gap(16),
          Row(
            children: [
              Text(
                'استاندارد (٪۱۰۰)',
                style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              _Label('مقیاس اندازه قلم'),
            ],
          ),
          const Gap(10),
          Row(
            children: AppFontSize.values.reversed
                .map(
                  (size) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SettingsOptionChip(
                        label: size.label,
                        selected: size == selectedFontSize,
                        onTap: () => onFontSizeSelected(size),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const Gap(16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  'فاکتور صادر شد ۱,۲۵۰,۰۰۰ تومان',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
                const Spacer(),
                Text(
                  'پیش‌نمایش صدور فاکتور:',
                  style: TextStyle(fontSize: 12, color: colorScheme.onTertiaryContainer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _Grid2x2 extends StatelessWidget {
  const _Grid2x2({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: children[0])),
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: children[1])),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: children[2])),
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: children[3])),
          ],
        ),
      ],
    );
  }
}
