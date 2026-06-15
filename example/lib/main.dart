import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

/// Entry point for the flutter_soccer_lineup example application.
///
/// This app demonstrates all features of the package through 20 dedicated
/// screens covering formations, drag-and-drop, substitutions, themes,
/// callbacks, highlighting, selection, custom builders, and more.
void main() => runApp(const SoccerLineupExampleApp());

/// The root [MaterialApp] for the example.
class SoccerLineupExampleApp extends StatefulWidget {
  /// Creates the app.
  const SoccerLineupExampleApp({super.key});

  @override
  State<SoccerLineupExampleApp> createState() => _SoccerLineupExampleAppState();
}

class _SoccerLineupExampleAppState extends State<SoccerLineupExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer Lineup Demo',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(onToggleTheme: _toggleTheme),
    );
  }
}
