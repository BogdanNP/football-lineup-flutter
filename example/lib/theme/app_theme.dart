import 'package:flutter/material.dart';

/// Application theme for the soccer lineup example.
abstract final class AppTheme {
  /// Material 3 light theme.
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.light,
      );

  /// Material 3 dark theme.
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      );
}
