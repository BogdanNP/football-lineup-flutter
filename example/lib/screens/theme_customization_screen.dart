import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 7: Theme customization demonstration.
class ThemeCustomizationScreen extends StatefulWidget {
  /// Creates the screen.
  const ThemeCustomizationScreen({super.key});

  @override
  State<ThemeCustomizationScreen> createState() =>
      _ThemeCustomizationScreenState();
}

class _ThemeCustomizationScreenState extends State<ThemeCustomizationScreen> {
  late final SoccerLineupController _controller;
  FieldStyle _fieldStyle = FieldStyle.grass;

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

  SoccerLineupThemeData _buildTheme(BuildContext context) {
    return switch (_fieldStyle) {
      FieldStyle.grass => SoccerLineupThemeData.fromContext(context),
      FieldStyle.darkGrass => SoccerLineupThemeData.fromContext(context)
          .copyWith(fieldStyle: FieldStyle.darkGrass),
      FieldStyle.blueprint => SoccerLineupThemeData(
          fieldStyle: FieldStyle.blueprint,
          fieldPrimaryColor: const Color(0xFF0A3D62),
          fieldLineColor: const Color(0xFF60A3D9),
          playerColor: const Color(0xFF60A3D9),
          playerBorderColor: Colors.white,
        ),
      FieldStyle.chalkboard => SoccerLineupThemeData(
          fieldStyle: FieldStyle.chalkboard,
          fieldPrimaryColor: const Color(0xFF1A2226),
          fieldLineColor: Colors.white70,
          playerColor: Colors.white30,
          playerBorderColor: Colors.white,
        ),
      _ => SoccerLineupThemeData.fromContext(context),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('7. Theme Customization')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: SegmentedButton<FieldStyle>(
              segments: [
                FieldStyle.grass,
                FieldStyle.darkGrass,
                FieldStyle.blueprint,
                FieldStyle.chalkboard,
              ]
                  .map(
                    (s) => ButtonSegment(
                      value: s,
                      label: Text(s.name, style: const TextStyle(fontSize: 11)),
                    ),
                  )
                  .toList(),
              selected: {_fieldStyle},
              onSelectionChanged: (s) => setState(() => _fieldStyle = s.first),
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: _buildTheme(context),
            ),
          ),
        ],
      ),
    );
  }
}
