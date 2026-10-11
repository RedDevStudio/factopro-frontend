import 'package:equatable/equatable.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:factopro/features/settings/data/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

/// App-wide settings state. Provided above `MaterialApp` so that
/// [SettingsState.displayMode] drives the global theme.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepository repository})
    : _repository = repository,
      super(SettingsState(displayMode: repository.loadDisplayMode())) {
    on<SettingsDisplayModeChanged>(_onDisplayModeChanged);
    on<SettingsFontFamilyChanged>(_onFontFamilyChanged);
    on<SettingsFontSizeChanged>(_onFontSizeChanged);
    on<SettingsSubscriptionPlanSelected>(_onSubscriptionPlanSelected);
    on<SettingsPrinterPaperWidthChanged>(_onPrinterPaperWidthChanged);
  }

  final SettingsRepository _repository;

  Future<void> _onDisplayModeChanged(
    SettingsDisplayModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    if (event.displayMode == state.displayMode) return;
    emit(state.copyWith(displayMode: event.displayMode));
    await _repository.saveDisplayMode(event.displayMode);
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
