part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.displayMode = AppDisplayMode.system,
    this.fontFamily = AppFontFamily.vazirmatn,
    this.fontSize = AppFontSize.medium,
    this.subscriptionPlan = SubscriptionPlan.gold,
    this.paperWidth = PrinterPaperWidth.mm80,
    this.subscriptionDaysLeft = 74,
    this.subscriptionTotalDays = 90,
    this.defaultVatPercent = 9,
    this.printerConnected = true,
    this.printerModel = 'Bixolon SRP-330',
    this.autoBackupEnabled = true,
    this.lastBackupLabel = 'امروز ساعت ۱۱:۳۰',
  });

  final AppDisplayMode displayMode;
  final AppFontFamily fontFamily;
  final AppFontSize fontSize;
  final SubscriptionPlan subscriptionPlan;
  final PrinterPaperWidth paperWidth;
  final int subscriptionDaysLeft;
  final int subscriptionTotalDays;
  final int defaultVatPercent;
  final bool printerConnected;
  final String printerModel;
  final bool autoBackupEnabled;
  final String lastBackupLabel;

  double get subscriptionProgress =>
      subscriptionTotalDays == 0 ? 0 : subscriptionDaysLeft / subscriptionTotalDays;

  SettingsState copyWith({
    AppDisplayMode? displayMode,
    AppFontFamily? fontFamily,
    AppFontSize? fontSize,
    SubscriptionPlan? subscriptionPlan,
    PrinterPaperWidth? paperWidth,
  }) {
    return SettingsState(
      displayMode: displayMode ?? this.displayMode,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      paperWidth: paperWidth ?? this.paperWidth,
      subscriptionDaysLeft: subscriptionDaysLeft,
      subscriptionTotalDays: subscriptionTotalDays,
      defaultVatPercent: defaultVatPercent,
      printerConnected: printerConnected,
      printerModel: printerModel,
      autoBackupEnabled: autoBackupEnabled,
      lastBackupLabel: lastBackupLabel,
    );
  }

  @override
  List<Object?> get props => [
    displayMode,
    fontFamily,
    fontSize,
    subscriptionPlan,
    paperWidth,
    subscriptionDaysLeft,
    subscriptionTotalDays,
    defaultVatPercent,
    printerConnected,
    printerModel,
    autoBackupEnabled,
    lastBackupLabel,
  ];
}
