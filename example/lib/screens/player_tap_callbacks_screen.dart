import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 8: Player tap callbacks demonstration.
class PlayerTapCallbacksScreen extends StatefulWidget {
  /// Creates the screen.
  const PlayerTapCallbacksScreen({super.key});

  @override
  State<PlayerTapCallbacksScreen> createState() =>
      _PlayerTapCallbacksScreenState();
}

class _PlayerTapCallbacksScreenState extends State<PlayerTapCallbacksScreen> {
  late final SoccerLineupController _controller;
  String _lastEvent = 'Interact with a player';

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

  void _log(String event) => setState(() => _lastEvent = event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('8. Player Tap Callbacks')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: Row(
              children: [
                const Icon(Icons.touch_app, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _lastEvent,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerTap: (p) => _log('Tap: ${p.name}'),
              onPlayerDoubleTap: (p) => _log('Double tap: ${p.name}'),
              onPlayerLongPress: (p) => _log('Long press: ${p.name}'),
              onPlayerSecondaryTap: (p) => _log('Secondary tap: ${p.name}'),
              onPlayerHover: (p, h) =>
                  _log(h ? 'Hover enter: ${p.name}' : 'Hover exit: ${p.name}'),
            ),
          ),
        ],
      ),
    );
  }
}
