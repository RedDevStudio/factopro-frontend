import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/theme/app_color_scheme.dart';
import 'package:factopro/features/settings/bloc/settings_bloc.dart';
import 'package:factopro/features/settings/data/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_fonts/persian_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsRepository});

  final SettingsRepository settingsRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(repository: settingsRepository),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) =>
            previous.displayMode != current.displayMode,
        builder: (context, state) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: kColorScheme,
            textTheme: PersianFonts.vazirTextTheme,
          ),
          darkTheme: ThemeData(
            colorScheme: kDarkColorScheme,
            textTheme: PersianFonts.vazirTextTheme,
          ),
          themeMode: state.displayMode.themeMode,
          routerConfig: router,
        ),
      ),
    );
  }
}
