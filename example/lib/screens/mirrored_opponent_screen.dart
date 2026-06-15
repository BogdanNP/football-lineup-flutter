import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 18: Mirrored opponent field demonstration.
class MirroredOpponentScreen extends StatefulWidget {
  /// Creates the screen.
  const MirroredOpponentScreen({super.key});

  @override
  State<MirroredOpponentScreen> createState() =>
      _MirroredOpponentScreenState();
}

class _MirroredOpponentScreenState extends State<MirroredOpponentScreen> {
  late final SoccerLineupController _controller;
  bool _mirror = true;

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
      appBar: AppBar(title: const Text('18. Mirrored Opponent')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Mirror opponent coordinates'),
            value: _mirror,
            onChanged: (v) => setState(() => _mirror = v),
          ),
          Expanded(
            child: MatchLineupView(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              mirrorOpponent: _mirror,
            ),
          ),
        ],
      ),
    );
  }
}
