import 'package:flutter/foundation.dart';

import 'field_coordinate.dart';

/// Represents a single soccer/football player.
///
/// Players carry all display and identity information. A player on the bench
/// has a `null` [coordinate]; players on the field have a non-null coordinate.
@immutable
class SoccerPlayer {
  /// Creates a [SoccerPlayer].
  const SoccerPlayer({
    required this.id,
    required this.name,
    this.imageUrl,
    this.shirtNumber,
    this.coordinate,
    this.isBench = false,
    this.isHighlighted = false,
    this.isSelected = false,
    this.metadata = const {},
  });

  /// Unique identifier for this player.
  final String id;

  /// Display name of the player.
  final String name;

  /// Optional URL to the player's image/photo.
  final String? imageUrl;

  /// Optional shirt/jersey number.
  final int? shirtNumber;

  /// The player's normalized position on the field.
  ///
  /// `null` when the player is on the bench.
  final FieldCoordinate? coordinate;

  /// Whether this player is currently on the bench (not on the field).
  final bool isBench;

  /// Whether this player is currently highlighted.
  final bool isHighlighted;

  /// Whether this player is currently selected.
  final bool isSelected;

  /// Arbitrary key-value metadata for consumer-defined properties
  /// (e.g. position label, rating, nationality, etc.).
  final Map<String, dynamic> metadata;

  /// Returns `true` if the player is actively placed on the field.
  bool get isOnField => !isBench && coordinate != null;

  /// Returns a new [SoccerPlayer] with the given fields replaced.
  SoccerPlayer copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? shirtNumber,
    FieldCoordinate? coordinate,
    bool? isBench,
    bool? isHighlighted,
    bool? isSelected,
    Map<String, dynamic>? metadata,
    bool clearCoordinate = false,
    bool clearImageUrl = false,
    bool clearShirtNumber = false,
  }) =>
      SoccerPlayer(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: clearImageUrl ? null : (imageUrl ?? this.imageUrl),
        shirtNumber:
            clearShirtNumber ? null : (shirtNumber ?? this.shirtNumber),
        coordinate: clearCoordinate ? null : (coordinate ?? this.coordinate),
        isBench: isBench ?? this.isBench,
        isHighlighted: isHighlighted ?? this.isHighlighted,
        isSelected: isSelected ?? this.isSelected,
        metadata: metadata ?? this.metadata,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoccerPlayer &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'SoccerPlayer(id: $id, name: $name, shirtNumber: $shirtNumber, '
      'isBench: $isBench, coordinate: $coordinate)';
}
