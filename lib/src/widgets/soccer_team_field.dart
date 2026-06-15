import 'package:flutter/material.dart';

import '../controllers/soccer_lineup_controller.dart';
import '../enums/enums.dart';
import '../models/field_coordinate.dart';
import '../models/soccer_player.dart';
import '../models/soccer_team.dart';
import '../painters/field_painter.dart';
import '../themes/soccer_lineup_theme_data.dart';
import '../utils/coordinate_utils.dart';
import 'player_widget.dart';

/// A widget that renders a soccer team on a field.
///
/// [SoccerTeamField] draws the football-field background and positions each
/// player at their normalised [FieldCoordinate].
///
/// Provide a [controller] to drive state changes, or supply [team] and
/// [formation] directly for a stateless render.
///
/// All interaction callbacks are optional. No default behaviour is imposed.
///
/// Example:
/// ```dart
/// SoccerTeamField(
///   controller: controller,
///   theme: SoccerLineupThemeData.fromContext(context),
///   onPlayerTap: (player) => print('Tapped: ${player.name}'),
/// )
/// ```
class SoccerTeamField extends StatelessWidget {
  /// Creates a [SoccerTeamField] driven by a [SoccerLineupController].
  const SoccerTeamField({
    super.key,
    required this.controller,
    required this.theme,
    this.playerWidgetType = PlayerWidgetType.circle,
    this.fieldDirection = FieldDirection.bottomToTop,
    this.onPlayerTap,
    this.onPlayerDoubleTap,
    this.onPlayerLongPress,
    this.onPlayerSecondaryTap,
    this.onPlayerHover,
    this.onPlayerDragStarted,
    this.onPlayerDragUpdate,
    this.onPlayerDropped,
    this.onPlayerSwap,
    this.onPlayerPositionChanged,
    this.playerBuilder,
    this.fieldBuilder,
  });

  /// The controller that drives the lineup state.
  final SoccerLineupController controller;

  /// Theme data.
  final SoccerLineupThemeData theme;

  /// Player widget style.
  final PlayerWidgetType playerWidgetType;

  /// The direction the field is rendered.
  final FieldDirection fieldDirection;

  /// Called when a player is tapped.
  final void Function(SoccerPlayer player)? onPlayerTap;

  /// Called when a player is double-tapped.
  final void Function(SoccerPlayer player)? onPlayerDoubleTap;

  /// Called when a player is long-pressed.
  final void Function(SoccerPlayer player)? onPlayerLongPress;

  /// Called when a player receives a secondary (right-click) tap.
  final void Function(SoccerPlayer player)? onPlayerSecondaryTap;

  /// Called when the pointer enters or exits a player widget.
  final void Function(SoccerPlayer player, bool hovering)? onPlayerHover;

  /// Called when a player drag starts.
  final void Function(SoccerPlayer player)? onPlayerDragStarted;

  /// Called continuously while a player is being dragged.
  final void Function(SoccerPlayer player, FieldCoordinate coordinate)?
      onPlayerDragUpdate;

  /// Called when a player is dropped onto the field.
  final void Function(SoccerPlayer player, FieldCoordinate coordinate)?
      onPlayerDropped;

  /// Called when a player is swapped with another player.
  final void Function(SoccerPlayer playerA, SoccerPlayer playerB)?
      onPlayerSwap;

  /// Called when a player's position changes (end of drag).
  final void Function(SoccerPlayer player, FieldCoordinate coordinate)?
      onPlayerPositionChanged;

  /// Optional custom builder for individual player widgets.
  final Widget Function(
    BuildContext context,
    SoccerPlayer player,
    SoccerLineupThemeData theme,
  )? playerBuilder;

  /// Optional custom builder for the field background.
  final Widget Function(
    BuildContext context,
    SoccerLineupThemeData theme,
    Widget child,
  )? fieldBuilder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => _buildField(context),
    );
  }

  Widget _buildField(BuildContext context) {
    final state = controller.state;
    final team = state.team;
    final themeData =
        theme.fieldPrimaryColor != null ? theme : SoccerLineupThemeData.fromContext(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : width * 1.5;

        final fieldWidget = _FieldWithPlayers(
          width: width,
          height: height,
          theme: themeData,
          team: team,
          fieldDirection: fieldDirection,
          dragDropMode: state.dragDropMode,
          playerWidgetType: playerWidgetType,
          onPlayerTap: onPlayerTap,
          onPlayerDoubleTap: onPlayerDoubleTap,
          onPlayerLongPress: onPlayerLongPress,
          onPlayerSecondaryTap: onPlayerSecondaryTap,
          onPlayerHover: onPlayerHover,
          onPlayerDragStarted: onPlayerDragStarted,
          onPlayerDragUpdate: onPlayerDragUpdate,
          onPlayerDropped: (player, coord) {
            if (state.dragDropMode == DragDropMode.freeMove) {
              controller.movePlayer(player.id, coord);
            }
            onPlayerDropped?.call(player, coord);
          },
          onPlayerSwap: (a, b) {
            if (state.dragDropMode == DragDropMode.swapPlayers) {
              controller.swapPlayers(a.id, b.id);
            }
            onPlayerSwap?.call(a, b);
          },
          onPlayerPositionChanged: onPlayerPositionChanged,
          playerBuilder: playerBuilder,
        );

        if (fieldBuilder != null) {
          return fieldBuilder!(context, themeData, fieldWidget);
        }

        return fieldWidget;
      },
    );
  }
}

// ── Internal field+players widget ─────────────────────────────────────────────

class _FieldWithPlayers extends StatelessWidget {
  const _FieldWithPlayers({
    required this.width,
    required this.height,
    required this.theme,
    required this.fieldDirection,
    required this.dragDropMode,
    required this.playerWidgetType,
    this.team,
    this.onPlayerTap,
    this.onPlayerDoubleTap,
    this.onPlayerLongPress,
    this.onPlayerSecondaryTap,
    this.onPlayerHover,
    this.onPlayerDragStarted,
    this.onPlayerDragUpdate,
    this.onPlayerDropped,
    this.onPlayerSwap,
    this.onPlayerPositionChanged,
    this.playerBuilder,
  });

  final double width;
  final double height;
  final SoccerLineupThemeData theme;
  final SoccerTeam? team;
  final FieldDirection fieldDirection;
  final DragDropMode dragDropMode;
  final PlayerWidgetType playerWidgetType;
  final void Function(SoccerPlayer)? onPlayerTap;
  final void Function(SoccerPlayer)? onPlayerDoubleTap;
  final void Function(SoccerPlayer)? onPlayerLongPress;
  final void Function(SoccerPlayer)? onPlayerSecondaryTap;
  final void Function(SoccerPlayer, bool)? onPlayerHover;
  final void Function(SoccerPlayer)? onPlayerDragStarted;
  final void Function(SoccerPlayer, FieldCoordinate)? onPlayerDragUpdate;
  final void Function(SoccerPlayer, FieldCoordinate)? onPlayerDropped;
  final void Function(SoccerPlayer, SoccerPlayer)? onPlayerSwap;
  final void Function(SoccerPlayer, FieldCoordinate)? onPlayerPositionChanged;
  final Widget Function(BuildContext, SoccerPlayer, SoccerLineupThemeData)?
      playerBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // Field background
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theme.fieldBorderRadius),
              child: _buildBackground(),
            ),
          ),
          // Players
          if (team != null)
            ...team!.fieldPlayers.map(
              (player) => _buildPositionedPlayer(player, context),
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

  Widget _buildPositionedPlayer(SoccerPlayer player, BuildContext context) {
    final coord = _transformCoordinate(player.coordinate!);
    final pixel = CoordinateUtils.toPixelOffset(coord, width, height);
    final radius = theme.playerRadius;

    final playerWidget = _buildPlayerWidget(player, context);

    if (dragDropMode == DragDropMode.disabled) {
      return Positioned(
        left: pixel.dx - radius,
        top: pixel.dy - radius,
        child: playerWidget,
      );
    }

    // Drag-enabled
    return Positioned(
      left: pixel.dx - radius,
      top: pixel.dy - radius,
      child: _DraggablePlayer(
        player: player,
        theme: theme,
        dragDropMode: dragDropMode,
        onDragStarted: onPlayerDragStarted,
        onDragUpdate: onPlayerDragUpdate,
        onDropped: (coord) => onPlayerDropped?.call(player, coord),
        onSwap: onPlayerSwap,
        fieldWidth: width,
        fieldHeight: height,
        child: playerWidget,
      ),
    );
  }

  Widget _buildPlayerWidget(SoccerPlayer player, BuildContext context) {
    return PlayerWidget(
      player: player,
      theme: theme,
      type: playerBuilder != null ? PlayerWidgetType.custom : playerWidgetType,
      onTap: () => onPlayerTap?.call(player),
      onDoubleTap: () => onPlayerDoubleTap?.call(player),
      onLongPress: () => onPlayerLongPress?.call(player),
      onSecondaryTap: () => onPlayerSecondaryTap?.call(player),
      onHover: (hovering) => onPlayerHover?.call(player, hovering),
      playerBuilder: playerBuilder,
    );
  }

  FieldCoordinate _transformCoordinate(FieldCoordinate coord) {
    if (fieldDirection == FieldDirection.topToBottom) {
      return coord.mirrored;
    }
    return coord;
  }
}

// ── Draggable player wrapper ───────────────────────────────────────────────────

class _DraggablePlayer extends StatelessWidget {
  const _DraggablePlayer({
    required this.player,
    required this.theme,
    required this.dragDropMode,
    required this.fieldWidth,
    required this.fieldHeight,
    required this.child,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDropped,
    this.onSwap,
  });

  final SoccerPlayer player;
  final SoccerLineupThemeData theme;
  final DragDropMode dragDropMode;
  final double fieldWidth;
  final double fieldHeight;
  final Widget child;
  final void Function(SoccerPlayer)? onDragStarted;
  final void Function(SoccerPlayer, FieldCoordinate)? onDragUpdate;
  final void Function(FieldCoordinate)? onDropped;
  final void Function(SoccerPlayer, SoccerPlayer)? onSwap;

  @override
  Widget build(BuildContext context) {
    return Draggable<SoccerPlayer>(
      data: player,
      onDragStarted: () => onDragStarted?.call(player),
      onDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final local = box.globalToLocal(details.globalPosition);
        final coord = CoordinateUtils.fromPixelOffset(
          local.dx,
          local.dy,
          fieldWidth,
          fieldHeight,
        );
        onDragUpdate?.call(player, coord);
      },
      feedback: Transform.scale(
        scale: theme.dragFeedbackScale,
        child: Material(color: Colors.transparent, child: child),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: child),
      child: DragTarget<SoccerPlayer>(
        onAcceptWithDetails: (details) {
          if (dragDropMode == DragDropMode.swapPlayers) {
            onSwap?.call(details.data, player);
          }
        },
        builder: (context, candidateData, rejectedData) {
          final isTarget = candidateData.isNotEmpty;
          return Container(
            decoration: isTarget
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.dragTargetColor ??
                        Colors.white.withAlpha(50),
                  )
                : null,
            child: child,
          );
        },
      ),
    );
  }
}
