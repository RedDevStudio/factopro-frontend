import 'package:factopro/app.dart';
import 'package:factopro/features/settings/bloc/settings_bloc.dart';
import 'package:factopro/features/settings/bloc/settings_models.dart';
import 'package:factopro/features/settings/data/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SettingsRepository> _repository([
  Map<String, Object> values = const {},
]) async {
  SharedPreferences.setMockInitialValues(values);
  return SettingsRepository(await SharedPreferences.getInstance());
}

ThemeMode? _themeMode(WidgetTester tester) =>
    tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode;

void main() {
  group('SettingsRepository', () {
    test('defaults to system when nothing is saved', () async {
      final repository = await _repository();
      expect(repository.loadDisplayMode(), AppDisplayMode.system);
    });

    test('falls back to system for an unknown stored value', () async {
      final repository = await _repository({'settings.display_mode': 'sepia'});
      expect(repository.loadDisplayMode(), AppDisplayMode.system);
    });

    test('round-trips every display mode', () async {
      final repository = await _repository();
      for (final mode in AppDisplayMode.values) {
        await repository.saveDisplayMode(mode);
        expect(repository.loadDisplayMode(), mode);
      }
    });
  });

  group('MyApp theme mode', () {
    testWidgets('restores the saved preference on start', (tester) async {
      final repository = await _repository({'settings.display_mode': 'dark'});
      await tester.pumpWidget(MyApp(settingsRepository: repository));

      expect(_themeMode(tester), ThemeMode.dark);
    });

    testWidgets('switches the global theme immediately and persists it', (
      tester,
    ) async {
      final repository = await _repository();
      await tester.pumpWidget(MyApp(settingsRepository: repository));
      expect(_themeMode(tester), ThemeMode.system);

      final bloc = BlocProvider.of<SettingsBloc>(
        tester.element(find.byType(MaterialApp)),
      );

      for (final (mode, themeMode) in [
        (AppDisplayMode.light, ThemeMode.light),
        (AppDisplayMode.dark, ThemeMode.dark),
        (AppDisplayMode.system, ThemeMode.system),
      ]) {
        bloc.add(SettingsDisplayModeChanged(mode));
        await tester.pumpAndSettle();
        expect(_themeMode(tester), themeMode);
        expect(repository.loadDisplayMode(), mode);
      }
    });

    testWidgets('system mode follows the platform brightness', (tester) async {
      final repository = await _repository();
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      await tester.pumpWidget(MyApp(settingsRepository: repository));
      final context = tester.element(find.byType(Navigator).first);
      expect(Theme.of(context).brightness, Brightness.dark);

      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.byType(Navigator).first)).brightness,
        Brightness.light,
      );
    });
  });
}
