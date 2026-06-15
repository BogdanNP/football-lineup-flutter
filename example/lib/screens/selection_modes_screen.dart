import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 14: Selection modes demonstration.
class SelectionModesScreen extends StatefulWidget {
  /// Creates the screen.
  const SelectionModesScreen({super.key});

  @override
  State<SelectionModesScreen> createState() => _SelectionModesScreenState();
}

class _SelectionModesScreenState extends State<SelectionModesScreen> {
  late final SoccerLineupController _controller;
  SelectionMode _mode = SelectionMode.single;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController(
      initialState: LineupState(selectionMode: _mode),
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
      appBar: AppBar(title: const Text('14. Selection Modes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SegmentedButton<SelectionMode>(
              segments: SelectionMode.values
                  .map(
                    (m) =>
                        ButtonSegment(value: m, label: Text(m.name)),
                  )
                  .toList(),
              selected: {_mode},
              onSelectionChanged: (s) {
                setState(() => _mode = s.first);
                _controller.setSelectionMode(s.first);
              },
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerTap: (p) {
                _controller.selectPlayer(p.id);
              },
            ),
          ),
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final selected = _controller.state.selectedPlayerIds;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  selected.isEmpty
                      ? 'No players selected'
                      : 'Selected: ${selected.join(', ')}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
