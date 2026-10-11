import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists user preferences on the device.
class SettingsRepository {
  const SettingsRepository(this._preferences);

  static const _displayModeKey = 'settings.display_mode';

  final SharedPreferences _preferences;

  /// Returns the saved display mode, or [AppDisplayMode.system] when none
  /// was saved (or the stored value is no longer recognized).
  AppDisplayMode loadDisplayMode() {
    final stored = _preferences.getString(_displayModeKey);
    return AppDisplayMode.values.firstWhere(
      (mode) => mode.name == stored,
      orElse: () => AppDisplayMode.system,
    );
  }

  Future<void> saveDisplayMode(AppDisplayMode mode) =>
      _preferences.setString(_displayModeKey, mode.name);
}
