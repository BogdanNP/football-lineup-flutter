import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

import '../widgets/sample_data.dart';

/// Full-flow demonstration screen combining:
/// - Formation customization for both teams
/// - Player details on tap
/// - Toggle between free movement and formation-locked UI
/// - Bench players with substitution (benching)
/// - Home and opponent team display
/// - Export coordinates
class FullFlowScreen extends StatefulWidget {
  /// Creates the screen.
  const FullFlowScreen({super.key});

  @override
  State<FullFlowScreen> createState() => _FullFlowScreenState();
}

class _FullFlowScreenState extends State<FullFlowScreen> {
  late final SoccerLineupController _controller;

  SoccerFormation _homeFormation = SoccerFormations.f433;
  SoccerFormation _opponentFormation = SoccerFormations.f442;
  bool _freeMovement = false;
  bool _showingOpponentBench = false;
  SoccerPlayer? _selectedForSub;

  @override
  void initState() {
    super.initState();
    _controller = SoccerLineupController(
      initialState: const LineupState(dragDropMode: DragDropMode.disabled),
    );
    _initTeams();
  }

  void _initTeams() {
    _controller.setTeam(SampleData.homeTeam(_homeFormation));
    _controller.setOpponentTeam(SampleData.opponentTeam(_opponentFormation));
    _controller.changeFormation(_homeFormation);
    _controller.changeOpponentFormation(_opponentFormation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHomeFormationChanged(SoccerFormation formation) {
    setState(() {
      _homeFormation = formation;
      _selectedForSub = null;
    });
    _controller.setTeam(SampleData.homeTeam(formation));
    _controller.changeFormation(formation);
  }

  void _onOpponentFormationChanged(SoccerFormation formation) {
    setState(() {
      _opponentFormation = formation;
      _selectedForSub = null;
    });
    _controller.setOpponentTeam(SampleData.opponentTeam(formation));
    _controller.changeOpponentFormation(formation);
  }

  void _toggleMovementMode() {
    setState(() => _freeMovement = !_freeMovement);
    _controller.setDragDropMode(
      _freeMovement ? DragDropMode.freeMove : DragDropMode.disabled,
    );
  }

  void _onPlayerTap(SoccerPlayer player, bool isOpponent) {
    // If substitution is in progress and bench player is tapped, perform sub
    if (_selectedForSub != null && player.isBench) {
      _performSubstitution(player);
      return;
    }

    // Show player detail bottom sheet
    _showPlayerDetails(player, isOpponent);
  }

  void _showPlayerDetails(SoccerPlayer player, bool isOpponent) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => _PlayerDetailSheet(
        player: player,
        isOpponent: isOpponent,
        onBench: player.isBench
            ? null
            : () {
                Navigator.pop(context);
                _benchPlayer(player);
              },
      ),
    );
  }

  void _benchPlayer(SoccerPlayer player) {
    _controller.moveToBench(player.id);
    setState(() {});
  }

  void _selectForSubstitution(SoccerPlayer fieldPlayer) {
    setState(() => _selectedForSub = fieldPlayer);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected ${fieldPlayer.name} — tap a bench player to substitute.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _performSubstitution(SoccerPlayer benchPlayer) {
    if (_selectedForSub == null) return;
    _controller.substitutePlayer(
      fieldPlayerId: _selectedForSub!.id,
      benchPlayerId: benchPlayer.id,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${benchPlayer.name} replaces ${_selectedForSub!.name}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    setState(() => _selectedForSub = null);
  }

  void _exportCoordinates() {
    final state = _controller.state;
    final homeCoords = <Map<String, dynamic>>[];
    final opponentCoords = <Map<String, dynamic>>[];

    if (state.team != null) {
      for (final p in state.team!.fieldPlayers) {
        homeCoords.add({
          'id': p.id,
          'name': p.name,
          'shirtNumber': p.shirtNumber,
          'x': p.coordinate!.x,
          'y': p.coordinate!.y,
        });
      }
    }
    if (state.opponentTeam != null) {
      for (final p in state.opponentTeam!.fieldPlayers) {
        opponentCoords.add({
          'id': p.id,
          'name': p.name,
          'shirtNumber': p.shirtNumber,
          'x': p.coordinate!.x,
          'y': p.coordinate!.y,
        });
      }
    }

    final export = const JsonEncoder.withIndent('  ').convert({
      'homeTeam': {
        'formation': _homeFormation.name,
        'players': homeCoords,
      },
      'opponentTeam': {
        'formation': _opponentFormation.name,
        'players': opponentCoords,
      },
    });

    Clipboard.setData(ClipboardData(text: export));

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exported Coordinates'),
        content: SingleChildScrollView(
          child: SelectableText(
            export,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = SoccerLineupThemeData.fromContext(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Flow Demo'),
        actions: [
          IconButton(
            icon: Icon(_freeMovement ? Icons.lock_open : Icons.lock),
            tooltip: _freeMovement ? 'Free movement ON' : 'Formation locked',
            onPressed: _toggleMovementMode,
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Export coordinates',
            onPressed: _exportCoordinates,
          ),
        ],
      ),
      body: Column(
        children: [
          // Formation selectors
          _buildFormationBar(context),
          // Match field
          Expanded(
            child: MatchLineupView(
              controller: _controller,
              theme: theme,
              onPlayerTap: _onPlayerTap,
              onPlayerLongPress: (player, isOpponent) {
                if (!isOpponent && player.isOnField) {
                  _selectForSubstitution(player);
                }
              },
            ),
          ),
          // Substitution hint
          if (_selectedForSub != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                'Substituting: ${_selectedForSub!.name} — tap a bench player below',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
                ),
              ),
            ),
          // Bench section
          _buildBenchSection(context, theme),
        ],
      ),
    );
  }

  Widget _buildFormationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Row(
        children: [
          Expanded(
            child: _FormationDropdown(
              label: 'Home',
              value: _homeFormation,
              onChanged: _onHomeFormationChanged,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _FormationDropdown(
              label: 'Opponent',
              value: _opponentFormation,
              onChanged: _onOpponentFormationChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchSection(BuildContext context, SoccerLineupThemeData theme) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final homeBench = _controller.getBenchPlayers();
        final opponentBench = _controller.state.opponentTeam?.benchPlayers ?? [];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Toggle home/opponent bench
            Container(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    'Bench',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                        value: false,
                        label: Text('Home (${homeBench.length})'),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text('Opp (${opponentBench.length})'),
                      ),
                    ],
                    selected: {_showingOpponentBench},
                    onSelectionChanged: (v) =>
                        setState(() => _showingOpponentBench = v.first),
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              child: BenchPlayersView(
                players:
                    _showingOpponentBench ? opponentBench : homeBench,
                theme: theme,
                onPlayerTap: (player) => _onPlayerTap(player, _showingOpponentBench),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Dropdown to select a formation.
class _FormationDropdown extends StatelessWidget {
  const _FormationDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final SoccerFormation value;
  final ValueChanged<SoccerFormation> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        border: const OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.id,
          isDense: true,
          isExpanded: true,
          items: SoccerFormations.all
              .map(
                (f) => DropdownMenuItem(value: f.id, child: Text(f.name)),
              )
              .toList(),
          onChanged: (id) {
            if (id == null) return;
            final formation = SoccerFormations.all.firstWhere((f) => f.id == id);
            onChanged(formation);
          },
        ),
      ),
    );
  }
}

/// Bottom sheet showing player details.
class _PlayerDetailSheet extends StatelessWidget {
  const _PlayerDetailSheet({
    required this.player,
    required this.isOpponent,
    this.onBench,
  });

  final SoccerPlayer player;
  final bool isOpponent;
  final VoidCallback? onBench;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: isOpponent
                    ? Colors.red.shade100
                    : Colors.green.shade100,
                child: Text(
                  '${player.shirtNumber ?? '-'}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isOpponent ? Colors.red.shade800 : Colors.green.shade800,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      isOpponent ? 'Opponent' : 'Home Team',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (player.coordinate != null) ...[
            Text(
              'Position: (${player.coordinate!.x.toStringAsFixed(1)}, '
              '${player.coordinate!.y.toStringAsFixed(1)})',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
          ],
          Text(
            player.isBench ? 'Status: On Bench' : 'Status: On Field',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (onBench != null) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onBench,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Move to Bench'),
            ),
          ],
        ],
      ),
    );
  }
}
