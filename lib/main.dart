import 'package:factopro/app.dart';
import 'package:factopro/features/settings/data/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  runApp(MyApp(settingsRepository: SettingsRepository(preferences)));
}
