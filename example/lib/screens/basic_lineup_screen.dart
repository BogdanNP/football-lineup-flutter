import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 1: Basic lineup demonstration.
class BasicLineupScreen extends StatefulWidget {
  /// Creates the screen.
  const BasicLineupScreen({super.key});

  @override
  State<BasicLineupScreen> createState() => _BasicLineupScreenState();
}

class _BasicLineupScreenState extends State<BasicLineupScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('1. Basic Lineup')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
            ),
          ),
          Expanded(
            child: BenchPlayersView(
              players: _controller.getBenchPlayers(),
              theme: SoccerLineupThemeData.fromContext(context),
            ),
          ),
        ],
      ),
    );
  }
}
