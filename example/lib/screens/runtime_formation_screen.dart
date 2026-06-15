import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

/// Screen 17: Runtime formation creation demonstration.
class RuntimeFormationScreen extends StatefulWidget {
  /// Creates the screen.
  const RuntimeFormationScreen({super.key});

  @override
  State<RuntimeFormationScreen> createState() =>
      _RuntimeFormationScreenState();
}

class _RuntimeFormationScreenState extends State<RuntimeFormationScreen> {
  late final SoccerLineupController _controller;
  late SoccerFormation _customFormation;

  @override
  void initState() {
    super.initState();
    _customFormation = _buildCustomFormation();
    _controller = SoccerLineupController();
    _applyFormation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  SoccerFormation _buildCustomFormation() {
    // Create a 3-3-3-1 formation at runtime
    return const SoccerFormation(
      id: 'custom-3331',
      name: '3-3-3-1 (Custom)',
      positions: [
        PlayerPosition(
            id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
        PlayerPosition(
            id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 70, y: 76)),
        PlayerPosition(
            id: 'CB', label: 'CB', coordinate: FieldCoordinate(x: 50, y: 76)),
        PlayerPosition(
            id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 30, y: 76)),
        PlayerPosition(
            id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 70, y: 58)),
        PlayerPosition(
            id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 58)),
        PlayerPosition(
            id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 30, y: 58)),
        PlayerPosition(
            id: 'AM_R', label: 'AM', coordinate: FieldCoordinate(x: 70, y: 38)),
        PlayerPosition(
            id: 'AM', label: 'AM', coordinate: FieldCoordinate(x: 50, y: 38)),
        PlayerPosition(
            id: 'AM_L', label: 'AM', coordinate: FieldCoordinate(x: 30, y: 38)),
        PlayerPosition(
            id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 14)),
      ],
    );
  }

  void _applyFormation() {
    final players = List.generate(
      _customFormation.positions.length,
      (i) => SoccerPlayer(
        id: 'p_$i',
        name: 'Player ${i + 1}',
        shirtNumber: i + 1,
        coordinate: _customFormation.positions[i].coordinate,
      ),
    );
    _controller.setTeam(
      SoccerTeam(id: 'custom_team', name: 'Custom Team', players: players),
    );
    _controller.changeFormation(_customFormation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('17. Runtime Formation')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: Text(
              'Formation "${_customFormation.name}" created at runtime.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
            ),
          ),
        ],
      ),
    );
  }
}
