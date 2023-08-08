import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff17aac1),
        primary: const Color(0xff117689),
        secondary: const Color(0xff4b9439),
        tertiary: Colors.teal[50],
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.teal[50],
      ),
    );
  }
}
