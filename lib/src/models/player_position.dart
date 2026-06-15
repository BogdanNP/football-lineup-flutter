import 'package:flutter/foundation.dart';

import 'field_coordinate.dart';

/// Defines a single player position within a formation.
///
/// A [PlayerPosition] maps a logical identifier (e.g. `'CB_L'`) to a
/// normalized [FieldCoordinate].
@immutable
class PlayerPosition {
  /// Creates a [PlayerPosition].
  const PlayerPosition({
    required this.id,
    required this.coordinate,
    this.label,
  });

  /// Unique identifier for this position within the formation
  /// (e.g. `'GK'`, `'CB_L'`, `'ST_R'`).
  final String id;

  /// Normalized coordinate on the field.
  final FieldCoordinate coordinate;

  /// Optional human-readable label (e.g. `'GK'`, `'CB'`, `'ST'`).
  final String? label;

  /// Returns a new [PlayerPosition] with the given fields replaced.
  PlayerPosition copyWith({
    String? id,
    FieldCoordinate? coordinate,
    String? label,
  }) =>
      PlayerPosition(
        id: id ?? this.id,
        coordinate: coordinate ?? this.coordinate,
        label: label ?? this.label,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerPosition &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'PlayerPosition(id: $id, coordinate: $coordinate, label: $label)';
}
