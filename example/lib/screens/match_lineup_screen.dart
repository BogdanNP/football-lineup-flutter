import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 5: Full match lineup (home vs opponent).
class MatchLineupScreen extends StatefulWidget {
  /// Creates the screen.
  const MatchLineupScreen({super.key});

  @override
  State<MatchLineupScreen> createState() => _MatchLineupScreenState();
}

class _MatchLineupScreenState extends State<MatchLineupScreen> {
  late final SoccerLineupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController();
    _controller.setTeam(SampleData.homeTeam(SoccerFormations.f433));
    _controller.setOpponentTeam(SampleData.opponentTeam(SoccerFormations.f442));
    _controller.changeFormation(SoccerFormations.f433);
    _controller.changeOpponentFormation(SoccerFormations.f442);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('5. Match Lineup')),
      body: MatchLineupView(
        controller: _controller,
        theme: SoccerLineupThemeData.fromContext(context),
        onPlayerTap: (player, isOpponent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${isOpponent ? "Opponent" : "Home"}: ${player.name}',
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
