part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class SettingsDisplayModeChanged extends SettingsEvent {
  const SettingsDisplayModeChanged(this.displayMode);

  final AppDisplayMode displayMode;

  @override
  List<Object?> get props => [displayMode];
}

final class SettingsFontFamilyChanged extends SettingsEvent {
  const SettingsFontFamilyChanged(this.fontFamily);

  final AppFontFamily fontFamily;

  @override
  List<Object?> get props => [fontFamily];
}

final class SettingsFontSizeChanged extends SettingsEvent {
  const SettingsFontSizeChanged(this.fontSize);

  final AppFontSize fontSize;

  @override
  List<Object?> get props => [fontSize];
}

final class SettingsSubscriptionPlanSelected extends SettingsEvent {
  const SettingsSubscriptionPlanSelected(this.plan);

  final SubscriptionPlan plan;

  @override
  List<Object?> get props => [plan];
}

final class SettingsPrinterPaperWidthChanged extends SettingsEvent {
  const SettingsPrinterPaperWidthChanged(this.paperWidth);

  final PrinterPaperWidth paperWidth;

  @override
  List<Object?> get props => [paperWidth];
}
