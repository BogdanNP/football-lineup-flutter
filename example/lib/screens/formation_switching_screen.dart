import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 2: Formation switching demonstration.
class FormationSwitchingScreen extends StatefulWidget {
  /// Creates the screen.
  const FormationSwitchingScreen({super.key});

  @override
  State<FormationSwitchingScreen> createState() =>
      _FormationSwitchingScreenState();
}

class _FormationSwitchingScreenState extends State<FormationSwitchingScreen> {
  late final SoccerLineupController _controller;
  SoccerFormation _current = SoccerFormations.f433;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController();
    _controller.setTeam(SampleData.homeTeam(_current));
    _controller.changeFormation(_current);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchFormation(SoccerFormation f) {
    setState(() => _current = f);
    _controller.setTeam(SampleData.homeTeam(f));
    _controller.changeFormation(f);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Formation Switching')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
            ),
          ),
          Container(
            height: 56,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              children: SoccerFormations.all
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(f.name),
                        selected: _current.id == f.id,
                        onSelected: (_) => _switchFormation(f),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
