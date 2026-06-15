import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 9: Player and position highlighting demonstration.
class HighlightingScreen extends StatefulWidget {
  /// Creates the screen.
  const HighlightingScreen({super.key});

  @override
  State<HighlightingScreen> createState() => _HighlightingScreenState();
}

class _HighlightingScreenState extends State<HighlightingScreen> {
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
      appBar: AppBar(title: const Text('9. Highlighting')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerTap: (p) => _controller.highlightPlayer(p.id),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    final players = _controller.getPlayersOnField();
                    if (players.isNotEmpty) {
                      _controller.highlightPlayer(players.first.id);
                    }
                  },
                  child: const Text('Highlight First'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    final players = _controller.getPlayersOnField();
                    _controller.highlightPlayers(
                      players.take(3).map((p) => p.id).toList(),
                    );
                  },
                  child: const Text('Highlight 3'),
                ),
                OutlinedButton(
                  onPressed: _controller.clearHighlights,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
