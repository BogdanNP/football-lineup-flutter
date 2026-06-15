import 'package:flutter/material.dart';

import '../animations/animation_config.dart';
import '../enums/enums.dart';

/// Theme data for the soccer lineup package.
///
/// All visual properties are customisable. When a property is not specified,
/// it falls back to the ambient [Theme.of(context)] [ColorScheme] and
/// [TextTheme] provided by Material 3.
///
/// Use [SoccerLineupThemeData.fromContext] to derive a theme from the current
/// [BuildContext], or supply explicit values for full control.
class SoccerLineupThemeData {
  /// Creates a [SoccerLineupThemeData].
  const SoccerLineupThemeData({
    // Field
    this.fieldPrimaryColor,
    this.fieldSecondaryColor,
    this.fieldLineColor,
    this.fieldLineWidth = 1.5,
    this.fieldBorderRadius = 12.0,
    this.fieldStyle = FieldStyle.grass,
    this.fieldImage,

    // Player
    this.playerColor,
    this.playerTextStyle,
    this.playerRadius = 22.0,
    this.playerBorderColor,
    this.playerBorderWidth = 2.0,
    this.playerShadows,
    this.playerElevation = 2.0,

    // Selected player
    this.selectedPlayerColor,
    this.selectedPlayerBorderColor,
    this.selectedPlayerBorderWidth = 3.0,

    // Highlighted player
    this.highlightColor,
    this.highlightBorderColor,
    this.highlightBorderWidth = 3.0,
    this.highlightPulse = true,

    // Opponent player
    this.opponentPlayerColor,
    this.opponentPlayerTextStyle,
    this.opponentPlayerBorderColor,

    // Bench
    this.benchBackgroundColor,
    this.benchItemSpacing = 8.0,

    // Text
    this.playerNameStyle,
    this.shirtNumberStyle,
    this.positionLabelStyle,

    // Animation
    this.animationConfig = AnimationConfig.position,

    // Drag & Drop
    this.dragFeedbackScale = 1.2,
    this.dragTargetColor,
    this.dropIndicatorColor,
  });

  // ── Field ──────────────────────────────────────────────────────────────────

  /// Primary field colour (e.g. grass green).
  final Color? fieldPrimaryColor;

  /// Secondary field colour (e.g. alternating stripe colour).
  final Color? fieldSecondaryColor;

  /// Colour used for field lines (centre circle, penalty box, etc.).
  final Color? fieldLineColor;

  /// Width of field lines in logical pixels.
  final double fieldLineWidth;

  /// Border radius of the field widget.
  final double fieldBorderRadius;

  /// Visual style preset for the field.
  final FieldStyle fieldStyle;

  /// Custom image to use as the field background when
  /// [fieldStyle] is [FieldStyle.image].
  final ImageProvider? fieldImage;

  // ── Player ─────────────────────────────────────────────────────────────────

  /// Background colour of each player widget.
  final Color? playerColor;

  /// Text style used inside player widgets.
  final TextStyle? playerTextStyle;

  /// Radius of circular player widgets in logical pixels.
  final double playerRadius;

  /// Border colour of player widgets.
  final Color? playerBorderColor;

  /// Border width of player widgets.
  final double playerBorderWidth;

  /// Shadows applied to player widgets.
  final List<BoxShadow>? playerShadows;

  /// Elevation applied to player widgets.
  final double playerElevation;

  // ── Selected player ────────────────────────────────────────────────────────

  /// Background colour for selected players.
  final Color? selectedPlayerColor;

  /// Border colour for selected players.
  final Color? selectedPlayerBorderColor;

  /// Border width for selected players.
  final double selectedPlayerBorderWidth;

  // ── Highlighted player ─────────────────────────────────────────────────────

  /// Colour used when a player is highlighted.
  final Color? highlightColor;

  /// Border colour of highlighted players.
  final Color? highlightBorderColor;

  /// Border width of highlighted players.
  final double highlightBorderWidth;

  /// Whether highlighted players pulse with an animation.
  final bool highlightPulse;

  // ── Opponent player ────────────────────────────────────────────────────────

  /// Background colour for opponent-team player widgets.
  final Color? opponentPlayerColor;

  /// Text style for opponent-team player widgets.
  final TextStyle? opponentPlayerTextStyle;

  /// Border colour for opponent-team player widgets.
  final Color? opponentPlayerBorderColor;

  // ── Bench ──────────────────────────────────────────────────────────────────

  /// Background colour for the bench area.
  final Color? benchBackgroundColor;

  /// Spacing between bench player items.
  final double benchItemSpacing;

  // ── Text ───────────────────────────────────────────────────────────────────

  /// Text style for player names.
  final TextStyle? playerNameStyle;

  /// Text style for shirt numbers.
  final TextStyle? shirtNumberStyle;

  /// Text style for position labels.
  final TextStyle? positionLabelStyle;

  // ── Animation ──────────────────────────────────────────────────────────────

  /// Animation configuration for player movements and formation changes.
  final AnimationConfig animationConfig;

  // ── Drag & Drop ────────────────────────────────────────────────────────────

  /// Scale factor applied to the drag feedback widget.
  final double dragFeedbackScale;

  /// Colour of the drag target indicator.
  final Color? dragTargetColor;

  /// Colour of the drop-zone indicator.
  final Color? dropIndicatorColor;

  /// Creates a [SoccerLineupThemeData] derived from the given [BuildContext].
  ///
  /// All colours fall back to [Theme.of(context).colorScheme] values so the
  /// lineup blends seamlessly with Material 3.
  factory SoccerLineupThemeData.fromContext(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SoccerLineupThemeData(
      fieldPrimaryColor: const Color(0xFF2D8653),
      fieldSecondaryColor: const Color(0xFF267847),
      fieldLineColor: Colors.white.withAlpha(200),
      playerColor: cs.primary,
      playerTextStyle: tt.labelSmall?.copyWith(color: cs.onPrimary),
      playerBorderColor: cs.primaryContainer,
      selectedPlayerColor: cs.tertiary,
      selectedPlayerBorderColor: cs.tertiaryContainer,
      highlightColor: cs.secondary,
      highlightBorderColor: cs.secondaryContainer,
      opponentPlayerColor: cs.error,
      opponentPlayerTextStyle: tt.labelSmall?.copyWith(color: cs.onError),
      opponentPlayerBorderColor: cs.errorContainer,
      benchBackgroundColor: cs.surfaceContainerHigh,
      playerNameStyle: tt.labelSmall?.copyWith(color: cs.onPrimary),
      shirtNumberStyle: tt.labelMedium?.copyWith(
        color: cs.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      positionLabelStyle: tt.labelSmall?.copyWith(color: cs.onPrimary),
      dragTargetColor: cs.secondary.withAlpha(80),
      dropIndicatorColor: cs.secondary,
    );
  }

  /// Returns a copy with the given fields replaced.
  SoccerLineupThemeData copyWith({
    Color? fieldPrimaryColor,
    Color? fieldSecondaryColor,
    Color? fieldLineColor,
    double? fieldLineWidth,
    double? fieldBorderRadius,
    FieldStyle? fieldStyle,
    ImageProvider? fieldImage,
    Color? playerColor,
    TextStyle? playerTextStyle,
    double? playerRadius,
    Color? playerBorderColor,
    double? playerBorderWidth,
    List<BoxShadow>? playerShadows,
    double? playerElevation,
    Color? selectedPlayerColor,
    Color? selectedPlayerBorderColor,
    double? selectedPlayerBorderWidth,
    Color? highlightColor,
    Color? highlightBorderColor,
    double? highlightBorderWidth,
    bool? highlightPulse,
    Color? opponentPlayerColor,
    TextStyle? opponentPlayerTextStyle,
    Color? opponentPlayerBorderColor,
    Color? benchBackgroundColor,
    double? benchItemSpacing,
    TextStyle? playerNameStyle,
    TextStyle? shirtNumberStyle,
    TextStyle? positionLabelStyle,
    AnimationConfig? animationConfig,
    double? dragFeedbackScale,
    Color? dragTargetColor,
    Color? dropIndicatorColor,
  }) =>
      SoccerLineupThemeData(
        fieldPrimaryColor: fieldPrimaryColor ?? this.fieldPrimaryColor,
        fieldSecondaryColor: fieldSecondaryColor ?? this.fieldSecondaryColor,
        fieldLineColor: fieldLineColor ?? this.fieldLineColor,
        fieldLineWidth: fieldLineWidth ?? this.fieldLineWidth,
        fieldBorderRadius: fieldBorderRadius ?? this.fieldBorderRadius,
        fieldStyle: fieldStyle ?? this.fieldStyle,
        fieldImage: fieldImage ?? this.fieldImage,
        playerColor: playerColor ?? this.playerColor,
        playerTextStyle: playerTextStyle ?? this.playerTextStyle,
        playerRadius: playerRadius ?? this.playerRadius,
        playerBorderColor: playerBorderColor ?? this.playerBorderColor,
        playerBorderWidth: playerBorderWidth ?? this.playerBorderWidth,
        playerShadows: playerShadows ?? this.playerShadows,
        playerElevation: playerElevation ?? this.playerElevation,
        selectedPlayerColor: selectedPlayerColor ?? this.selectedPlayerColor,
        selectedPlayerBorderColor:
            selectedPlayerBorderColor ?? this.selectedPlayerBorderColor,
        selectedPlayerBorderWidth:
            selectedPlayerBorderWidth ?? this.selectedPlayerBorderWidth,
        highlightColor: highlightColor ?? this.highlightColor,
        highlightBorderColor: highlightBorderColor ?? this.highlightBorderColor,
        highlightBorderWidth: highlightBorderWidth ?? this.highlightBorderWidth,
        highlightPulse: highlightPulse ?? this.highlightPulse,
        opponentPlayerColor: opponentPlayerColor ?? this.opponentPlayerColor,
        opponentPlayerTextStyle:
            opponentPlayerTextStyle ?? this.opponentPlayerTextStyle,
        opponentPlayerBorderColor:
            opponentPlayerBorderColor ?? this.opponentPlayerBorderColor,
        benchBackgroundColor: benchBackgroundColor ?? this.benchBackgroundColor,
        benchItemSpacing: benchItemSpacing ?? this.benchItemSpacing,
        playerNameStyle: playerNameStyle ?? this.playerNameStyle,
        shirtNumberStyle: shirtNumberStyle ?? this.shirtNumberStyle,
        positionLabelStyle: positionLabelStyle ?? this.positionLabelStyle,
        animationConfig: animationConfig ?? this.animationConfig,
        dragFeedbackScale: dragFeedbackScale ?? this.dragFeedbackScale,
        dragTargetColor: dragTargetColor ?? this.dragTargetColor,
        dropIndicatorColor: dropIndicatorColor ?? this.dropIndicatorColor,
      );
}
