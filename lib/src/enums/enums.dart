/// Enumerations used throughout the flutter_soccer_lineup package.
library;

/// The direction the field is rendered — bottom-to-top or top-to-bottom.
enum FieldDirection {
  /// The home team attacks from bottom to top.
  bottomToTop,

  /// The home team attacks from top to bottom.
  topToBottom,
}

/// The visual style preset for the football field background.
enum FieldStyle {
  /// Classic green grass field.
  grass,

  /// Alternating dark/light stripe grass field.
  darkGrass,

  /// Blueprint / tactical-board style (blue tones).
  blueprint,

  /// Chalkboard style (dark with chalk-like lines).
  chalkboard,

  /// Provide a fully custom painter.
  custom,

  /// Use a custom image as the field background.
  image,
}

/// How drag-and-drop interaction behaves.
enum DragDropMode {
  /// Drag and drop is fully disabled.
  disabled,

  /// Dragging a player onto another player swaps their positions.
  swapPlayers,

  /// Players can be dragged to any position on the field freely.
  freeMove,
}

/// Player selection mode.
enum SelectionMode {
  /// Selection is disabled.
  none,

  /// Only one player can be selected at a time.
  single,

  /// Multiple players can be selected simultaneously.
  multiple,
}

/// The built-in player widget styles.
enum PlayerWidgetType {
  /// Round avatar circle with player info.
  circle,

  /// Football shirt / jersey shape.
  shirt,

  /// Photo avatar with player info.
  avatar,

  /// Card-style player widget.
  card,

  /// Fully custom — uses the [playerBuilder] callback.
  custom,
}

/// The animation style for player transitions.
enum AnimationType {
  /// No animation.
  none,

  /// Cross-fade animation.
  fade,

  /// Scale-in / scale-out animation.
  scale,

  /// Slide animation.
  slide,

  /// Animated position transition on the field.
  position,

  /// Custom animation via an [AnimatedWidget] builder.
  custom,
}

/// The layout style for the bench area.
enum BenchLayout {
  /// Players displayed in a horizontal row.
  horizontal,

  /// Players displayed in a vertical column.
  vertical,

  /// Players displayed in a grid.
  grid,

  /// Custom layout using the bench builder.
  custom,
}

/// The highlight style applied to players or positions on the field.
enum HighlightType {
  /// Highlight a single player.
  player,

  /// Highlight a field position.
  position,

  /// Highlight an area on the field.
  area,

  /// Draw a path between players or positions.
  path,
}
