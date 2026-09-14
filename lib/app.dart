import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: kColorScheme),
      darkTheme: ThemeData(colorScheme: kDarkColorScheme),
      routerConfig: router,
    );
  }
}
