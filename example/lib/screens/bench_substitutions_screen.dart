import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 4: Bench substitutions demonstration.
class BenchSubstitutionsScreen extends StatefulWidget {
  /// Creates the screen.
  const BenchSubstitutionsScreen({super.key});

  @override
  State<BenchSubstitutionsScreen> createState() =>
      _BenchSubstitutionsScreenState();
}

class _BenchSubstitutionsScreenState extends State<BenchSubstitutionsScreen> {
  late final SoccerLineupController _controller;
  SoccerPlayer? _selectedFieldPlayer;

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

  void _onFieldPlayerTap(SoccerPlayer player) {
    setState(() => _selectedFieldPlayer = player);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: ${player.name}. Now tap a bench player to substitute.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onBenchPlayerTap(SoccerPlayer benchPlayer) {
    if (_selectedFieldPlayer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tap a field player first.'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    _controller.substitutePlayer(
      fieldPlayerId: _selectedFieldPlayer!.id,
      benchPlayerId: benchPlayer.id,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${benchPlayer.name} replaces ${_selectedFieldPlayer!.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
    setState(() => _selectedFieldPlayer = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Bench Substitutions')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              _selectedFieldPlayer != null
                  ? 'Substituting: ${_selectedFieldPlayer!.name} — tap a bench player'
                  : 'Tap a field player to select for substitution',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 3,
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context),
              onPlayerTap: _onFieldPlayerTap,
            ),
          ),
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => SizedBox(
              height: 100,
              child: BenchPlayersView(
                players: _controller.getBenchPlayers(),
                theme: SoccerLineupThemeData.fromContext(context),
                onPlayerTap: _onBenchPlayerTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
