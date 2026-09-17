import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/settings/bloc/settings_bloc.dart';
import 'package:factopro/features/settings/widgets/display_mode_section.dart';
import 'package:factopro/features/settings/widgets/font_settings_section.dart';
import 'package:factopro/features/settings/widgets/invoice_printer_section.dart';
import 'package:factopro/features/settings/widgets/profile_header.dart';
import 'package:factopro/features/settings/widgets/subscription_plan_selector.dart';
import 'package:factopro/features/settings/widgets/subscription_promo_card.dart';
import 'package:factopro/features/settings/widgets/support_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatefulWidget {
  const _SettingsView();

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  late final TextEditingController _preprintNoteController;

  @override
  void initState() {
    super.initState();
    _preprintNoteController = TextEditingController(
      text: 'از خرید و اعتماد شما سپاسگزاریم. کالای فروخته شده تا ۷ روز در '
          'صورت باز نشدن پلمپ قابل تعویض می‌باشد.',
    );
  }

  @override
  void dispose() {
    _preprintNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.outlineVariant,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(30),
            child: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              child: Icon(Icons.history, color: colorScheme.primary),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'پروفایل و تنظیمات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final bloc = context.read<SettingsBloc>();

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ProfileHeader(
                    name: 'علیرضا محمدی',
                    storeName: 'فروشگاه آنلاین آرمان - شعبه مرکزی',
                    phoneNumber: '۰۹۱۲۳۴۵۶۷۸۹',
                  ),
                  const Gap(20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'طرح و سطح اشتراک حساب',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const Gap(6),
                        Icon(Icons.star_border, size: 18, color: colorScheme.onSurfaceVariant),
                        const Spacer(),
                        Text(
                          '۳ پلن اختصاصی',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  SubscriptionPlanSelector(
                    selectedPlan: state.subscriptionPlan,
                    onPlanSelected: (plan) =>
                        bloc.add(SettingsSubscriptionPlanSelected(plan)),
                  ),
                  const Gap(12),
                  SubscriptionPromoCard(
                    daysLeft: state.subscriptionDaysLeft,
                    progress: state.subscriptionProgress,
                  ),
                  const Gap(16),
                  DisplayModeSection(
                    selectedMode: state.displayMode,
                    onModeSelected: (mode) =>
                        bloc.add(SettingsDisplayModeChanged(mode)),
                  ),
                  const Gap(16),
                  FontSettingsSection(
                    selectedFontFamily: state.fontFamily,
                    selectedFontSize: state.fontSize,
                    onFontFamilySelected: (font) =>
                        bloc.add(SettingsFontFamilyChanged(font)),
                    onFontSizeSelected: (size) =>
                        bloc.add(SettingsFontSizeChanged(size)),
                  ),
                  const Gap(16),
                  InvoicePrinterSection(
                    defaultVatPercent: state.defaultVatPercent,
                    printerConnected: state.printerConnected,
                    printerModel: state.printerModel,
                    selectedPaperWidth: state.paperWidth,
                    onPaperWidthSelected: (width) =>
                        bloc.add(SettingsPrinterPaperWidthChanged(width)),
                    preprintNoteController: _preprintNoteController,
                  ),
                  const Gap(16),
                  SupportSection(
                    autoBackupEnabled: state.autoBackupEnabled,
                    lastBackupLabel: state.lastBackupLabel,
                  ),
                  const Gap(16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
