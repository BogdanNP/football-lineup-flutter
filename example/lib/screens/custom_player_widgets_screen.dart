import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 6: Custom player widgets demonstration.
class CustomPlayerWidgetsScreen extends StatefulWidget {
  /// Creates the screen.
  const CustomPlayerWidgetsScreen({super.key});

  @override
  State<CustomPlayerWidgetsScreen> createState() =>
      _CustomPlayerWidgetsScreenState();
}

class _CustomPlayerWidgetsScreenState
    extends State<CustomPlayerWidgetsScreen> {
  late final SoccerLineupController _controller;
  PlayerWidgetType _type = PlayerWidgetType.circle;

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
      appBar: AppBar(title: const Text('6. Custom Player Widgets')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton<PlayerWidgetType>(
              value: _type,
              items: PlayerWidgetType.values
                  .where((t) => t != PlayerWidgetType.custom)
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text(t.name),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _type = v!),
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              playerWidgetType: _type,
            ),
          ),
        ],
      ),
    );
  }
}
