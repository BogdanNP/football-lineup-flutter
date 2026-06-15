import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 19 & 20: Light / dark theme demonstration.
class LightDarkThemeScreen extends StatefulWidget {
  /// Creates the screen.
  const LightDarkThemeScreen({super.key, required this.isDark});

  /// Whether to display the dark-theme demo.
  final bool isDark;

  @override
  State<LightDarkThemeScreen> createState() => _LightDarkThemeScreenState();
}

class _LightDarkThemeScreenState extends State<LightDarkThemeScreen> {
  late final SoccerLineupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController();
    _controller.setTeam(SampleData.homeTeam(SoccerFormations.f433));
    _controller.changeFormation(SoccerFormations.f433);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.isDark
        ? ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green,
            brightness: Brightness.dark,
          )
        : ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green,
            brightness: Brightness.light,
          );

    return Theme(
      data: theme,
      child: Builder(
        builder: (innerCtx) => Scaffold(
          appBar: AppBar(
            title: Text(widget.isDark ? '20. Dark Theme' : '19. Light Theme'),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: SoccerTeamField(
                  controller: _controller,
                  theme: SoccerLineupThemeData.fromContext(innerCtx),
                ),
              ),
              Expanded(
                child: BenchPlayersView(
                  players: _controller.getBenchPlayers(),
                  theme: SoccerLineupThemeData.fromContext(innerCtx),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
