import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light(Color accentColor) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: accentColor,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData dark(Color accentColor) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: accentColor,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}