import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 13: Custom field background styles.
class CustomFieldScreen extends StatefulWidget {
  /// Creates the screen.
  const CustomFieldScreen({super.key});

  @override
  State<CustomFieldScreen> createState() => _CustomFieldScreenState();
}

class _CustomFieldScreenState extends State<CustomFieldScreen> {
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
    final gradientTheme = SoccerLineupThemeData(
      fieldStyle: FieldStyle.custom,
      fieldPrimaryColor: Colors.deepPurple,
      fieldLineColor: Colors.purpleAccent,
      playerColor: Colors.amber,
      playerBorderColor: Colors.amberAccent,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('13. Custom Field Background')),
      body: Column(
        children: [
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: gradientTheme,
              fieldBuilder: (context, theme, child) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
