import 'package:flutter/material.dart';

import '../controllers/soccer_lineup_controller.dart';
import '../enums/enums.dart';
import '../models/soccer_player.dart';
import '../models/soccer_team.dart';
import '../painters/field_painter.dart';
import '../themes/soccer_lineup_theme_data.dart';
import '../utils/coordinate_utils.dart';
import 'player_widget.dart';

/// A widget that renders a full match lineup with both teams on a single field.
///
/// The home team is rendered using their coordinates directly; the opponent
/// team's coordinates are vertically mirrored so they appear on the opposite
/// half. Both teams can be styled independently.
///
/// Provide a [controller] to drive state changes.
///
/// Example:
/// ```dart
/// MatchLineupView(
///   controller: controller,
///   theme: SoccerLineupThemeData.fromContext(context),
/// )
/// ```
class MatchLineupView extends StatelessWidget {
  /// Creates a [MatchLineupView].
  const MatchLineupView({
    super.key,
    required this.controller,
    required this.theme,
    this.playerWidgetType = PlayerWidgetType.circle,
    this.fieldDirection = FieldDirection.bottomToTop,
    this.mirrorOpponent = true,
    this.onPlayerTap,
    this.onPlayerDoubleTap,
    this.onPlayerLongPress,
    this.onPlayerHover,
    this.playerBuilder,
    this.opponentPlayerBuilder,
    this.fieldBuilder,
    this.teamHeaderBuilder,
  });

  /// Controller that drives the lineup state.
  final SoccerLineupController controller;

  /// Theme data.
  final SoccerLineupThemeData theme;

  /// Player widget style.
  final PlayerWidgetType playerWidgetType;

  /// Field render direction.
  final FieldDirection fieldDirection;

  /// Whether to vertically mirror the opponent's coordinates.
  ///
  /// Defaults to `true` so the opponent appears on the upper half.
  final bool mirrorOpponent;

  /// Called when any player is tapped.
  final void Function(SoccerPlayer player, bool isOpponent)? onPlayerTap;

  /// Called when any player is double-tapped.
  final void Function(SoccerPlayer player, bool isOpponent)? onPlayerDoubleTap;

  /// Called when any player is long-pressed.
  final void Function(SoccerPlayer player, bool isOpponent)? onPlayerLongPress;

  /// Called when the pointer enters or exits a player widget.
  final void Function(SoccerPlayer player, bool isOpponent, bool hovering)?
      onPlayerHover;

  /// Optional custom builder for home-team player widgets.
  final Widget Function(
    BuildContext context,
    SoccerPlayer player,
    SoccerLineupThemeData theme,
  )? playerBuilder;

  /// Optional custom builder for opponent-team player widgets.
  final Widget Function(
    BuildContext context,
    SoccerPlayer player,
    SoccerLineupThemeData theme,
  )? opponentPlayerBuilder;

  /// Optional custom builder for the field background.
  final Widget Function(
    BuildContext context,
    SoccerLineupThemeData theme,
    Widget child,
  )? fieldBuilder;

  /// Optional custom builder for team name headers.
  final Widget Function(
    BuildContext context,
    SoccerTeam team,
    bool isOpponent,
  )? teamHeaderBuilder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => _buildView(context),
    );
  }

  Widget _buildView(BuildContext context) {
    final state = controller.state;
    final themeData = theme.fieldPrimaryColor != null
        ? theme
        : SoccerLineupThemeData.fromContext(context);

    return Column(
      children: [
        if (state.opponentTeam != null && teamHeaderBuilder != null)
          teamHeaderBuilder!(context, state.opponentTeam!, true),
        if (state.opponentTeam != null && teamHeaderBuilder == null)
          _defaultTeamHeader(state.opponentTeam!, true, context),
        Expanded(
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              return _MatchField(
                width: w,
                height: h,
                theme: themeData,
                homeTeam: state.team,
                opponentTeam: state.opponentTeam,
                fieldDirection: fieldDirection,
                mirrorOpponent: mirrorOpponent,
                dragDropMode: state.dragDropMode,
                playerWidgetType: playerWidgetType,
                onPlayerTap: onPlayerTap,
                onPlayerDoubleTap: onPlayerDoubleTap,
                onPlayerLongPress: onPlayerLongPress,
                onPlayerHover: onPlayerHover,
                playerBuilder: playerBuilder,
                opponentPlayerBuilder: opponentPlayerBuilder,
              );
            },
          ),
        ),
        if (state.team != null && teamHeaderBuilder != null)
          teamHeaderBuilder!(context, state.team!, false),
        if (state.team != null && teamHeaderBuilder == null)
          _defaultTeamHeader(state.team!, false, context),
      ],
    );
  }

  Widget _defaultTeamHeader(
    SoccerTeam team,
    bool isOpponent,
    BuildContext context,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isOpponent ? cs.errorContainer : cs.primaryContainer,
      child: Text(
        team.name,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isOpponent ? cs.onErrorContainer : cs.onPrimaryContainer,
            ),
      ),
    );
  }
}

// ── Internal match field ───────────────────────────────────────────────────────

class _MatchField extends StatelessWidget {
  const _MatchField({
    required this.width,
    required this.height,
    required this.theme,
    required this.fieldDirection,
    required this.mirrorOpponent,
    required this.dragDropMode,
    required this.playerWidgetType,
    this.homeTeam,
    this.opponentTeam,
    this.onPlayerTap,
    this.onPlayerDoubleTap,
    this.onPlayerLongPress,
    this.onPlayerHover,
    this.playerBuilder,
    this.opponentPlayerBuilder,
  });

  final double width;
  final double height;
  final SoccerLineupThemeData theme;
  final SoccerTeam? homeTeam;
  final SoccerTeam? opponentTeam;
  final FieldDirection fieldDirection;
  final bool mirrorOpponent;
  final DragDropMode dragDropMode;
  final PlayerWidgetType playerWidgetType;
  final void Function(SoccerPlayer, bool)? onPlayerTap;
  final void Function(SoccerPlayer, bool)? onPlayerDoubleTap;
  final void Function(SoccerPlayer, bool)? onPlayerLongPress;
  final void Function(SoccerPlayer, bool, bool)? onPlayerHover;
  final Widget Function(BuildContext, SoccerPlayer, SoccerLineupThemeData)?
      playerBuilder;
  final Widget Function(BuildContext, SoccerPlayer, SoccerLineupThemeData)?
      opponentPlayerBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theme.fieldBorderRadius),
              child: _buildBackground(),
            ),
          ),
          // Home team
          if (homeTeam != null)
            ...homeTeam!.fieldPlayers.map(
              (p) => _positionedPlayer(p, false, context),
            ),
          // Opponent team
          if (opponentTeam != null)
            ...opponentTeam!.fieldPlayers.map(
              (p) => _positionedPlayer(p, true, context),
            ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    if (theme.fieldStyle == FieldStyle.image && theme.fieldImage != null) {
      return Image(image: theme.fieldImage!, fit: BoxFit.cover);
    }
    return CustomPaint(
      painter: FieldPainter(theme: theme),
      size: Size(width, height),
    );
  }

  Widget _positionedPlayer(
    SoccerPlayer player,
    bool isOpponent,
    BuildContext context,
  ) {
    var coord = player.coordinate!;
    if (isOpponent && mirrorOpponent) coord = coord.mirrored;
    if (fieldDirection == FieldDirection.topToBottom) coord = coord.mirrored;

    final pixel = CoordinateUtils.toPixelOffset(coord, width, height);
    final radius = theme.playerRadius;

    final builder = isOpponent ? opponentPlayerBuilder : playerBuilder;

    final widget = PlayerWidget(
      player: player,
      theme: theme,
      type:
          builder != null ? PlayerWidgetType.custom : playerWidgetType,
      isOpponent: isOpponent,
      onTap: () => onPlayerTap?.call(player, isOpponent),
      onDoubleTap: () => onPlayerDoubleTap?.call(player, isOpponent),
      onLongPress: () => onPlayerLongPress?.call(player, isOpponent),
      onHover: (h) => onPlayerHover?.call(player, isOpponent, h),
      playerBuilder: builder,
    );

    return Positioned(
      left: pixel.dx - radius,
      top: pixel.dy - radius,
      child: widget,
    );
  }
}
