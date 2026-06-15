import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 11: Free movement mode demonstration.
class FreeMovementScreen extends StatefulWidget {
  /// Creates the screen.
  const FreeMovementScreen({super.key});

  @override
  State<FreeMovementScreen> createState() => _FreeMovementScreenState();
}

class _FreeMovementScreenState extends State<FreeMovementScreen> {
  late final SoccerLineupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController(
      initialState: const LineupState(dragDropMode: DragDropMode.freeMove),
    );
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
      appBar: AppBar(
        title: const Text('11. Free Movement'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset',
            onPressed: () {
              _controller.setTeam(SampleData.homeTeam(SoccerFormations.f433));
              _controller.changeFormation(SoccerFormations.f433);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: const Text(
              'Drag players anywhere on the field.',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerPositionChanged: (p, coord) =>
                  debugPrint('${p.name} moved to $coord'),
            ),
          ),
        ],
      ),
    );
  }
}
