import 'package:equatable/equatable.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsDisplayModeChanged>(_onDisplayModeChanged);
    on<SettingsFontFamilyChanged>(_onFontFamilyChanged);
    on<SettingsFontSizeChanged>(_onFontSizeChanged);
    on<SettingsSubscriptionPlanSelected>(_onSubscriptionPlanSelected);
    on<SettingsPrinterPaperWidthChanged>(_onPrinterPaperWidthChanged);
  }

  void _onDisplayModeChanged(
    SettingsDisplayModeChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(displayMode: event.displayMode));
  }

  void _onFontFamilyChanged(
    SettingsFontFamilyChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(fontFamily: event.fontFamily));
  }

  void _onFontSizeChanged(
    SettingsFontSizeChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(fontSize: event.fontSize));
  }

  void _onSubscriptionPlanSelected(
    SettingsSubscriptionPlanSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(subscriptionPlan: event.plan));
  }

  void _onPrinterPaperWidthChanged(
    SettingsPrinterPaperWidthChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(paperWidth: event.paperWidth));
  }
}
