import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 12: Swap mode demonstration.
class SwapModeScreen extends StatefulWidget {
  /// Creates the screen.
  const SwapModeScreen({super.key});

  @override
  State<SwapModeScreen> createState() => _SwapModeScreenState();
}

class _SwapModeScreenState extends State<SwapModeScreen> {
  late final SoccerLineupController _controller;
  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController(
      initialState:
          const LineupState(dragDropMode: DragDropMode.swapPlayers),
    );
    _controller.setTeam(SampleData.homeTeam(SoccerFormations.f442));
    _controller.changeFormation(SoccerFormations.f442);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('12. Swap Mode')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerSwap: (a, b) {
                setState(() => _log.insert(0, '↔ ${a.name} ↔ ${b.name}'));
              },
            ),
          ),
          Container(
            height: 120,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _log.length,
              itemBuilder: (_, i) => Text(
                _log[i],
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
