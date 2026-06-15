import 'package:flutter/foundation.dart';

import 'player_position.dart';

/// Describes a soccer formation (e.g. 4-4-2, 4-3-3).
///
/// A [SoccerFormation] maps position identifiers to normalized field
/// coordinates. The list of [positions] must include the goalkeeper.
@immutable
class SoccerFormation {
  /// Creates a [SoccerFormation].
  const SoccerFormation({
    required this.id,
    required this.name,
    required this.positions,
  });

  /// Unique identifier (e.g. `'4-4-2'`).
  final String id;

  /// Human-readable name (e.g. `'4-4-2'`).
  final String name;

  /// Ordered list of player positions in this formation,
  /// starting with the goalkeeper.
  final List<PlayerPosition> positions;

  /// Returns the number of field players (including goalkeeper).
  int get playerCount => positions.length;

  /// Returns the position for the given [positionId], or `null` if not found.
  PlayerPosition? positionById(String positionId) {
    final matches = positions.where((p) => p.id == positionId);
    return matches.isEmpty ? null : matches.first;
  }

  /// Returns a new [SoccerFormation] with the given fields replaced.
  SoccerFormation copyWith({
    String? id,
    String? name,
    List<PlayerPosition>? positions,
  }) =>
      SoccerFormation(
        id: id ?? this.id,
        name: name ?? this.name,
        positions: positions ?? this.positions,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoccerFormation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'SoccerFormation(id: $id, name: $name, positions: ${positions.length})';
}
