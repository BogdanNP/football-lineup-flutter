import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 15: Controller API examples.
class ControllerApiScreen extends StatefulWidget {
  /// Creates the screen.
  const ControllerApiScreen({super.key});

  @override
  State<ControllerApiScreen> createState() => _ControllerApiScreenState();
}

class _ControllerApiScreenState extends State<ControllerApiScreen> {
  late final SoccerLineupController _controller;
  final List<String> _log = [];

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

  void _logAction(String action) => setState(() => _log.insert(0, action));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('15. Controller API')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _apiButton('Highlight First', () {
                  final p = _controller.getPlayersOnField();
                  if (p.isNotEmpty) {
                    _controller.highlightPlayer(p.first.id);
                    _logAction('highlightPlayer(${p.first.name})');
                  }
                }),
                _apiButton('Clear Highlights', () {
                  _controller.clearHighlights();
                  _logAction('clearHighlights()');
                }),
                _apiButton('Select First', () {
                  _controller.setSelectionMode(SelectionMode.single);
                  final p = _controller.getPlayersOnField();
                  if (p.isNotEmpty) {
                    _controller.selectPlayer(p.first.id);
                    _logAction('selectPlayer(${p.first.name})');
                  }
                }),
                _apiButton('Clear Selection', () {
                  _controller.clearSelection();
                  _logAction('clearSelection()');
                }),
                _apiButton('Swap 0↔1', () {
                  final p = _controller.getPlayersOnField();
                  if (p.length >= 2) {
                    _controller.swapPlayers(p[0].id, p[1].id);
                    _logAction('swapPlayers(${p[0].name}, ${p[1].name})');
                  }
                }),
                _apiButton('Change Formation', () {
                  _controller.changeFormation(SoccerFormations.f442);
                  _logAction('changeFormation(4-4-2)');
                }),
                _apiButton('Reset', () {
                  _controller.reset();
                  _logAction('reset()');
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _log.length,
              itemBuilder: (_, i) => Text(
                '• ${_log[i]}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiButton(String label, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: Text(label, style: const TextStyle(fontSize: 11)),
        ),
      );
}
