import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:edu_apply/core/l10n/app_localizations.dart';
import 'package:edu_apply/core/router/app_router.dart';
import 'package:edu_apply/core/theme/app_bar_theme.dart';

import 'package:edu_apply/core/theme/input_decoration_theme.dart';

import 'package:edu_apply/core/theme/text_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.initRouter(),
      locale: const Locale("en"),
      theme: FlexThemeData.light(
        scheme: FlexScheme.cyanM3,
        textTheme: lightTextTheme,
        fontFamily: 'Poppins',
      ).copyWith(
        appBarTheme: appBarTheme,
        inputDecorationTheme: inputDecorationThemeLight,
      ),
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
    );
  }
}
