import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 16: Custom builders demonstration.
class CustomBuildersScreen extends StatefulWidget {
  /// Creates the screen.
  const CustomBuildersScreen({super.key});

  @override
  State<CustomBuildersScreen> createState() => _CustomBuildersScreenState();
}

class _CustomBuildersScreenState extends State<CustomBuildersScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('16. Custom Builders')),
      body: SoccerTeamField(
        controller: _controller,
        theme: SoccerLineupThemeData.fromContext(context),
        playerBuilder: (context, player, theme) => _CustomPlayerWidget(
          player: player,
        ),
      ),
    );
  }
}

/// A bespoke player widget used in the custom-builders example.
class _CustomPlayerWidget extends StatelessWidget {
  const _CustomPlayerWidget({required this.player});
  final SoccerPlayer player;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [cs.primaryContainer, cs.primary],
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 6),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '${player.shirtNumber ?? '?'}',
            style: TextStyle(
              color: cs.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withAlpha(200),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            player.name.split(' ').last,
            style: TextStyle(fontSize: 8, color: cs.onPrimaryContainer),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
