import 'package:flutter/material.dart';

import '../models/soccer_player.dart';
import '../themes/soccer_lineup_theme_data.dart';
import '../enums/enums.dart';

/// A widget that renders a single [SoccerPlayer] on the field.
///
/// Supports four built-in styles ([PlayerWidgetType.circle],
/// [PlayerWidgetType.shirt], [PlayerWidgetType.avatar],
/// [PlayerWidgetType.card]) and a fully custom [playerBuilder].
///
/// Interaction callbacks ([onTap], [onDoubleTap], [onLongPress],
/// [onSecondaryTap], [onHover]) are all optional; no default behaviour
/// is imposed.
class PlayerWidget extends StatelessWidget {
  /// Creates a [PlayerWidget].
  const PlayerWidget({
    super.key,
    required this.player,
    required this.theme,
    this.type = PlayerWidgetType.circle,
    this.isOpponent = false,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onSecondaryTap,
    this.onHover,
    this.playerBuilder,
  });

  /// The player to render.
  final SoccerPlayer player;

  /// The theme data.
  final SoccerLineupThemeData theme;

  /// The widget style to use.
  final PlayerWidgetType type;

  /// Whether this player is from the opponent team.
  final bool isOpponent;

  /// Called when the player is tapped.
  final VoidCallback? onTap;

  /// Called when the player is double-tapped.
  final VoidCallback? onDoubleTap;

  /// Called when the player is long-pressed.
  final VoidCallback? onLongPress;

  /// Called when the player receives a secondary (right-click) tap.
  final VoidCallback? onSecondaryTap;

  /// Called when the pointer enters or exits the player widget.
  final ValueChanged<bool>? onHover;

  /// Optional fully custom builder.
  ///
  /// When provided, replaces all built-in rendering.
  final Widget Function(BuildContext, SoccerPlayer, SoccerLineupThemeData)?
      playerBuilder;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _semanticLabel,
      button: onTap != null,
      child: MouseRegion(
        onEnter: (_) => onHover?.call(true),
        onExit: (_) => onHover?.call(false),
        child: GestureDetector(
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onSecondaryTap: onSecondaryTap,
          child: _buildBody(context),
        ),
      ),
    );
  }

  String get _semanticLabel {
    final number =
        player.shirtNumber != null ? '#${player.shirtNumber} ' : '';
    return '$number${player.name}${player.isBench ? " (bench)" : ""}';
  }

  Widget _buildBody(BuildContext context) {
    if (type == PlayerWidgetType.custom && playerBuilder != null) {
      return playerBuilder!(context, player, theme);
    }
    return switch (type) {
      PlayerWidgetType.circle => _CirclePlayer(
          player: player,
          theme: theme,
          isOpponent: isOpponent,
        ),
      PlayerWidgetType.shirt => _ShirtPlayer(
          player: player,
          theme: theme,
          isOpponent: isOpponent,
        ),
      PlayerWidgetType.avatar => _AvatarPlayer(
          player: player,
          theme: theme,
          isOpponent: isOpponent,
        ),
      PlayerWidgetType.card => _CardPlayer(
          player: player,
          theme: theme,
          isOpponent: isOpponent,
        ),
      PlayerWidgetType.custom => playerBuilder != null
          ? playerBuilder!(context, player, theme)
          : _CirclePlayer(
              player: player,
              theme: theme,
              isOpponent: isOpponent,
            ),
    };
  }
}

// ── Circle player ─────────────────────────────────────────────────────────────

class _CirclePlayer extends StatelessWidget {
  const _CirclePlayer({
    required this.player,
    required this.theme,
    required this.isOpponent,
  });

  final SoccerPlayer player;
  final SoccerLineupThemeData theme;
  final bool isOpponent;

  @override
  Widget build(BuildContext context) {
    final radius = theme.playerRadius;
    final bg = _backgroundColor;
    final border = _borderColor;
    final borderWidth = player.isSelected
        ? theme.selectedPlayerBorderWidth
        : player.isHighlighted
            ? theme.highlightBorderWidth
            : theme.playerBorderWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            border: Border.all(color: border, width: borderWidth),
            boxShadow: theme.playerShadows ??
                [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: theme.playerElevation * 2,
                    offset: const Offset(0, 2),
                  ),
                ],
          ),
          alignment: Alignment.center,
          child: Text(
            player.shirtNumber?.toString() ?? '',
            style: (isOpponent
                    ? theme.opponentPlayerTextStyle
                    : theme.shirtNumberStyle) ??
                TextStyle(
                  color: Colors.white,
                  fontSize: radius * 0.7,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: radius * 2.8,
          child: Text(
            player.name,
            style: (isOpponent
                    ? theme.opponentPlayerTextStyle
                    : theme.playerNameStyle) ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color get _backgroundColor {
    if (player.isSelected) return theme.selectedPlayerColor ?? Colors.amber;
    if (player.isHighlighted) return theme.highlightColor ?? Colors.yellow;
    return isOpponent
        ? (theme.opponentPlayerColor ?? Colors.red.shade700)
        : (theme.playerColor ?? Colors.blue.shade700);
  }

  Color get _borderColor {
    if (player.isSelected) {
      return theme.selectedPlayerBorderColor ?? Colors.amber.shade300;
    }
    if (player.isHighlighted) {
      return theme.highlightBorderColor ?? Colors.yellow.shade300;
    }
    return isOpponent
        ? (theme.opponentPlayerBorderColor ?? Colors.red.shade300)
        : (theme.playerBorderColor ?? Colors.blue.shade300);
  }
}

// ── Shirt player ──────────────────────────────────────────────────────────────

class _ShirtPlayer extends StatelessWidget {
  const _ShirtPlayer({
    required this.player,
    required this.theme,
    required this.isOpponent,
  });

  final SoccerPlayer player;
  final SoccerLineupThemeData theme;
  final bool isOpponent;

  @override
  Widget build(BuildContext context) {
    final radius = theme.playerRadius;
    final bg = isOpponent
        ? (theme.opponentPlayerColor ?? Colors.red.shade700)
        : (theme.playerColor ?? Colors.blue.shade700);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: radius * 2.2,
          height: radius * 2.4,
          child: CustomPaint(
            painter: _ShirtPainter(
              color: bg,
              borderColor: player.isSelected
                  ? (theme.selectedPlayerBorderColor ?? Colors.amber.shade300)
                  : (isOpponent
                      ? (theme.opponentPlayerBorderColor ??
                          Colors.red.shade300)
                      : (theme.playerBorderColor ?? Colors.blue.shade300)),
              borderWidth: player.isSelected
                  ? theme.selectedPlayerBorderWidth
                  : theme.playerBorderWidth,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: radius * 0.4),
                child: Text(
                  player.shirtNumber?.toString() ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: radius * 0.65,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: radius * 2.8,
          child: Text(
            player.name,
            style: (isOpponent
                    ? theme.opponentPlayerTextStyle
                    : theme.playerNameStyle) ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ShirtPainter extends CustomPainter {
  const _ShirtPainter({
    required this.color,
    required this.borderColor,
    required this.borderWidth,
  });

  final Color color;
  final Color borderColor;
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final w = size.width;
    final h = size.height;

    // Simple shirt shape
    final path = Path()
      ..moveTo(w * 0.25, 0)
      ..lineTo(0, h * 0.25)
      ..lineTo(w * 0.18, h * 0.35)
      ..lineTo(w * 0.18, h)
      ..lineTo(w * 0.82, h)
      ..lineTo(w * 0.82, h * 0.35)
      ..lineTo(w, h * 0.25)
      ..lineTo(w * 0.75, 0)
      // collar
      ..quadraticBezierTo(w * 0.65, h * 0.18, w * 0.5, h * 0.18)
      ..quadraticBezierTo(w * 0.35, h * 0.18, w * 0.25, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _ShirtPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderWidth != borderWidth;
}

// ── Avatar player ─────────────────────────────────────────────────────────────

class _AvatarPlayer extends StatelessWidget {
  const _AvatarPlayer({
    required this.player,
    required this.theme,
    required this.isOpponent,
  });

  final SoccerPlayer player;
  final SoccerLineupThemeData theme;
  final bool isOpponent;

  @override
  Widget build(BuildContext context) {
    final radius = theme.playerRadius;
    final bg = isOpponent
        ? (theme.opponentPlayerColor ?? Colors.red.shade700)
        : (theme.playerColor ?? Colors.blue.shade700);
    final border = player.isSelected
        ? (theme.selectedPlayerBorderColor ?? Colors.amber.shade300)
        : (isOpponent
            ? (theme.opponentPlayerBorderColor ?? Colors.red.shade300)
            : (theme.playerBorderColor ?? Colors.blue.shade300));
    final borderWidth = player.isSelected
        ? theme.selectedPlayerBorderWidth
        : theme.playerBorderWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            border: Border.all(color: border, width: borderWidth),
            boxShadow: theme.playerShadows ??
                [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: theme.playerElevation * 2,
                    offset: const Offset(0, 2),
                  ),
                ],
          ),
          child: ClipOval(
            child: player.imageUrl != null
                ? Image.network(
                    player.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _fallbackAvatar(bg, radius),
                  )
                : _fallbackAvatar(bg, radius),
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: radius * 2.8,
          child: Text(
            player.name,
            style: (isOpponent
                    ? theme.opponentPlayerTextStyle
                    : theme.playerNameStyle) ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _fallbackAvatar(Color bg, double radius) {
    return Center(
      child: Text(
        player.shirtNumber?.toString() ??
            (player.name.isNotEmpty ? player.name[0].toUpperCase() : '?'),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.65,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ── Card player ───────────────────────────────────────────────────────────────

class _CardPlayer extends StatelessWidget {
  const _CardPlayer({
    required this.player,
    required this.theme,
    required this.isOpponent,
  });

  final SoccerPlayer player;
  final SoccerLineupThemeData theme;
  final bool isOpponent;

  @override
  Widget build(BuildContext context) {
    final radius = theme.playerRadius;
    final bg = isOpponent
        ? (theme.opponentPlayerColor ?? Colors.red.shade700)
        : (theme.playerColor ?? Colors.blue.shade700);
    final border = player.isSelected
        ? (theme.selectedPlayerBorderColor ?? Colors.amber.shade300)
        : (isOpponent
            ? (theme.opponentPlayerBorderColor ?? Colors.red.shade300)
            : (theme.playerBorderColor ?? Colors.blue.shade300));
    final borderWidth = player.isSelected
        ? theme.selectedPlayerBorderWidth
        : theme.playerBorderWidth;

    return Container(
      width: radius * 2.8,
      padding: EdgeInsets.symmetric(
        horizontal: radius * 0.3,
        vertical: radius * 0.2,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border, width: borderWidth),
        boxShadow: theme.playerShadows ??
            [
              BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: theme.playerElevation * 2,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (player.shirtNumber != null)
            Text(
              '${player.shirtNumber}',
              style: (isOpponent
                      ? theme.opponentPlayerTextStyle
                      : theme.shirtNumberStyle) ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: radius * 0.6,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          Text(
            player.name,
            style: (isOpponent
                    ? theme.opponentPlayerTextStyle
                    : theme.playerNameStyle) ??
                TextStyle(
                  color: Colors.white,
                  fontSize: radius * 0.42,
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
