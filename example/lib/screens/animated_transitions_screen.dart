import 'package:flutter/material.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Screen 10: Animated formation transitions.
class AnimatedTransitionsScreen extends StatefulWidget {
  /// Creates the screen.
  const AnimatedTransitionsScreen({super.key});

  @override
  State<AnimatedTransitionsScreen> createState() =>
      _AnimatedTransitionsScreenState();
}

class _AnimatedTransitionsScreenState
    extends State<AnimatedTransitionsScreen> {
  late final SoccerLineupController _controller;
  final List<SoccerFormation> _formations = [
    SoccerFormations.f433,
    SoccerFormations.f442,
    SoccerFormations.f4231,
    SoccerFormations.f352,
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController();
    _controller.setTeam(SampleData.homeTeam(_formations[0]));
    _controller.changeFormation(_formations[0]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    final nextIndex = (_currentIndex + 1) % _formations.length;
    setState(() => _currentIndex = nextIndex);
    _controller.setTeam(SampleData.homeTeam(_formations[nextIndex]));
    _controller.changeFormation(_formations[nextIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('10. Animated Transitions')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Formation: ${_formations[_currentIndex].name}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: SoccerTeamField(
              controller: _controller,
              theme: SoccerLineupThemeData.fromContext(context).copyWith(
                animationConfig: AnimationConfig.position,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: FilledButton.icon(
              onPressed: _next,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next Formation'),
            ),
          ),
        ],
      ),
    );
  }
}
