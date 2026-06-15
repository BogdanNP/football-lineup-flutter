import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 3: Drag and drop demonstration.
class DragDropScreen extends StatefulWidget {
  /// Creates the screen.
  const DragDropScreen({super.key});

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  late final SoccerLineupController _controller;
  DragDropMode _mode = DragDropMode.swapPlayers;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController(
      initialState: LineupState(dragDropMode: _mode),
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
      appBar: AppBar(title: const Text('3. Drag & Drop')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SegmentedButton<DragDropMode>(
              segments: const [
                ButtonSegment(
                    value: DragDropMode.disabled, label: Text('Disabled')),
                ButtonSegment(
                    value: DragDropMode.swapPlayers, label: Text('Swap')),
                ButtonSegment(
                    value: DragDropMode.freeMove, label: Text('Free')),
              ],
              selected: {_mode},
              onSelectionChanged: (s) {
                setState(() => _mode = s.first);
                _controller.setDragDropMode(s.first);
              },
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerSwap: (a, b) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Swapped: ${a.name} ↔ ${b.name}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
