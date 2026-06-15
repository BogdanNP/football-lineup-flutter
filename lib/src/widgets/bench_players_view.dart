import 'package:flutter/material.dart';

import '../enums/enums.dart';
import '../models/soccer_player.dart';
import '../themes/soccer_lineup_theme_data.dart';
import 'player_widget.dart';

/// A widget that displays the bench players for a team.
///
/// Supports [BenchLayout.horizontal], [BenchLayout.vertical],
/// [BenchLayout.grid], and fully custom layouts via [benchBuilder].
///
/// Interaction callbacks ([onPlayerTap], [onPlayerDoubleTap],
/// [onPlayerLongPress]) are optional and impose no default behaviour.
///
/// Example:
/// ```dart
/// BenchPlayersView(
///   players: benchPlayers,
///   theme: SoccerLineupThemeData.fromContext(context),
///   layout: BenchLayout.horizontal,
///   onPlayerTap: (p) => print('Bench tap: ${p.name}'),
/// )
/// ```
class BenchPlayersView extends StatelessWidget {
  /// Creates a [BenchPlayersView].
  const BenchPlayersView({
    super.key,
    required this.players,
    required this.theme,
    this.layout = BenchLayout.horizontal,
    this.playerWidgetType = PlayerWidgetType.circle,
    this.gridCrossAxisCount = 4,
    this.onPlayerTap,
    this.onPlayerDoubleTap,
    this.onPlayerLongPress,
    this.onPlayerHover,
    this.playerBuilder,
    this.benchBuilder,
  });

  /// The list of bench players to display.
  final List<SoccerPlayer> players;

  /// Theme data.
  final SoccerLineupThemeData theme;

  /// The layout style to use for bench players.
  final BenchLayout layout;

  /// Player widget style.
  final PlayerWidgetType playerWidgetType;

  /// Number of columns when [layout] is [BenchLayout.grid].
  final int gridCrossAxisCount;

  /// Called when a bench player is tapped.
  final void Function(SoccerPlayer player)? onPlayerTap;

  /// Called when a bench player is double-tapped.
  final void Function(SoccerPlayer player)? onPlayerDoubleTap;

  /// Called when a bench player is long-pressed.
  final void Function(SoccerPlayer player)? onPlayerLongPress;

  /// Called when the pointer enters or exits a bench player widget.
  final void Function(SoccerPlayer player, bool hovering)? onPlayerHover;

  /// Optional custom builder for individual bench player widgets.
  final Widget Function(
    BuildContext context,
    SoccerPlayer player,
    SoccerLineupThemeData theme,
  )? playerBuilder;

  /// Optional fully custom builder for the entire bench area.
  ///
  /// When provided, all other layout options are ignored.
  final Widget Function(
    BuildContext context,
    List<SoccerPlayer> players,
    SoccerLineupThemeData theme,
  )? benchBuilder;

  @override
  Widget build(BuildContext context) {
    if (benchBuilder != null) {
      return benchBuilder!(context, players, theme);
    }

    final background = theme.benchBackgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHigh;

    final content = switch (layout) {
      BenchLayout.horizontal => _horizontalLayout(context),
      BenchLayout.vertical => _verticalLayout(context),
      BenchLayout.grid => _gridLayout(context),
      BenchLayout.custom => _horizontalLayout(context),
    };

    return Container(
      color: background,
      child: content,
    );
  }

  Widget _horizontalLayout(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(theme.benchItemSpacing),
      child: Row(
        children: players
            .map(
              (p) => Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: theme.benchItemSpacing / 2),
                child: _buildPlayerItem(p, context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _verticalLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.benchItemSpacing),
      child: Column(
        children: players
            .map(
              (p) => Padding(
                padding:
                    EdgeInsets.symmetric(vertical: theme.benchItemSpacing / 2),
                child: _buildPlayerItem(p, context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _gridLayout(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(theme.benchItemSpacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount,
        crossAxisSpacing: theme.benchItemSpacing,
        mainAxisSpacing: theme.benchItemSpacing,
      ),
      itemCount: players.length,
      itemBuilder: (ctx, i) => _buildPlayerItem(players[i], ctx),
    );
  }

  Widget _buildPlayerItem(SoccerPlayer player, BuildContext context) {
    if (playerBuilder != null) {
      return GestureDetector(
        onTap: () => onPlayerTap?.call(player),
        onDoubleTap: () => onPlayerDoubleTap?.call(player),
        onLongPress: () => onPlayerLongPress?.call(player),
        child: MouseRegion(
          onEnter: (_) => onPlayerHover?.call(player, true),
          onExit: (_) => onPlayerHover?.call(player, false),
          child: playerBuilder!(context, player, theme),
        ),
      );
    }
    return PlayerWidget(
      player: player,
      theme: theme,
      type: playerWidgetType,
      onTap: () => onPlayerTap?.call(player),
      onDoubleTap: () => onPlayerDoubleTap?.call(player),
      onLongPress: () => onPlayerLongPress?.call(player),
      onHover: (hovering) => onPlayerHover?.call(player, hovering),
    );
  }
}
