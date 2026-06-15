import 'dart:math' as math;

import '../models/field_coordinate.dart';
import '../models/soccer_player.dart';

/// Utility functions for working with field coordinates and players.
abstract final class CoordinateUtils {
  /// Returns the vertical mirror of [coordinate] (`y` becomes `100 - y`).
  ///
  /// Used to render opponent-team players on the opposite half of the field.
  static FieldCoordinate mirrorCoordinate(FieldCoordinate coordinate) =>
      coordinate.mirrored;

  /// Returns the Euclidean distance between two [FieldCoordinate] values.
  ///
  /// The distance is in normalised field units (0–100).
  static double distanceBetweenCoordinates(
    FieldCoordinate a,
    FieldCoordinate b,
  ) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    return math.sqrt(dx * dx + dy * dy);
  }

  /// Returns the coordinate in [candidates] that is nearest to [target].
  ///
  /// Returns `null` if [candidates] is empty.
  static FieldCoordinate? nearestCoordinate(
    FieldCoordinate target,
    List<FieldCoordinate> candidates,
  ) {
    if (candidates.isEmpty) return null;
    return candidates.reduce(
      (a, b) => distanceBetweenCoordinates(target, a) <=
              distanceBetweenCoordinates(target, b)
          ? a
          : b,
    );
  }

  /// Returns the player in [players] whose field coordinate is nearest to
  /// [target], or `null` if no on-field players exist.
  static SoccerPlayer? nearestPlayer(
    FieldCoordinate target,
    List<SoccerPlayer> players,
  ) {
    final fieldPlayers = players.where((p) => p.coordinate != null).toList();
    if (fieldPlayers.isEmpty) return null;
    return fieldPlayers.reduce(
      (a, b) =>
          distanceBetweenCoordinates(target, a.coordinate!) <=
                  distanceBetweenCoordinates(target, b.coordinate!)
              ? a
              : b,
    );
  }

  /// Returns all players from [players] that are currently on the field.
  static List<SoccerPlayer> playersOnField(List<SoccerPlayer> players) =>
      players.where((p) => p.isOnField).toList();

  /// Returns all players from [players] that are on the bench.
  static List<SoccerPlayer> benchPlayers(List<SoccerPlayer> players) =>
      players.where((p) => p.isBench).toList();

  /// Returns the player with [id] from [players], or `null` if not found.
  static SoccerPlayer? playerById(
    String id,
    List<SoccerPlayer> players,
  ) {
    final matches = players.where((p) => p.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  /// Converts a normalised [coordinate] to a pixel [Offset] within a
  /// field of the given [width] and [height].
  static ({double dx, double dy}) toPixelOffset(
    FieldCoordinate coordinate,
    double width,
    double height,
  ) =>
      (
        dx: coordinate.x / 100.0 * width,
        dy: coordinate.y / 100.0 * height,
      );

  /// Converts a pixel position ([dx], [dy]) within a field of [width] ×
  /// [height] to a normalised [FieldCoordinate].
  ///
  /// The resulting coordinate is clamped to the range `[0, 100]`.
  static FieldCoordinate fromPixelOffset(
    double dx,
    double dy,
    double width,
    double height,
  ) {
    return FieldCoordinate(
      x: (dx / width * 100.0).clamp(0.0, 100.0),
      y: (dy / height * 100.0).clamp(0.0, 100.0),
    );
  }
}
