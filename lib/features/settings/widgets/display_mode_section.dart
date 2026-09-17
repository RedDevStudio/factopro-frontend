import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:factopro/features/settings/widgets/settings_option_chip.dart';
import 'package:factopro/features/settings/widgets/settings_section_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DisplayModeSection extends StatelessWidget {
  const DisplayModeSection({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  final AppDisplayMode selectedMode;
  final ValueChanged<AppDisplayMode> onModeSelected;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'شخصی‌سازی و رنگ قالب',
      icon: Icons.palette_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'حالت نمایش نرم‌افزار',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Gap(10),
          Row(
            children: AppDisplayMode.values.reversed
                .map(
                  (mode) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SettingsOptionChip(
                        label: mode.label,
                        icon: mode.icon,
                        selected: mode == selectedMode,
                        onTap: () => onModeSelected(mode),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
