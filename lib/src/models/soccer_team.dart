import 'package:flutter/foundation.dart';

import 'soccer_player.dart';

/// Represents a soccer team with its players.
///
/// A [SoccerTeam] holds both field players and bench players.
@immutable
class SoccerTeam {
  /// Creates a [SoccerTeam].
  const SoccerTeam({
    required this.id,
    required this.name,
    required this.players,
    this.logoUrl,
    this.primaryColor,
    this.secondaryColor,
    this.metadata = const {},
  });

  /// Unique identifier for this team.
  final String id;

  /// Display name of the team.
  final String name;

  /// All players in this team (both field and bench).
  final List<SoccerPlayer> players;

  /// Optional URL to the team's logo image.
  final String? logoUrl;

  /// Optional primary team colour (as a hex string, e.g. `'#FF0000'`).
  final String? primaryColor;

  /// Optional secondary team colour (as a hex string).
  final String? secondaryColor;

  /// Arbitrary key-value metadata for consumer-defined properties.
  final Map<String, dynamic> metadata;

  /// Returns only players currently on the field.
  List<SoccerPlayer> get fieldPlayers =>
      players.where((p) => p.isOnField).toList();

  /// Returns only players currently on the bench.
  List<SoccerPlayer> get benchPlayers =>
      players.where((p) => p.isBench).toList();

  /// Returns a new [SoccerTeam] with the given fields replaced.
  SoccerTeam copyWith({
    String? id,
    String? name,
    List<SoccerPlayer>? players,
    String? logoUrl,
    String? primaryColor,
    String? secondaryColor,
    Map<String, dynamic>? metadata,
  }) =>
      SoccerTeam(
        id: id ?? this.id,
        name: name ?? this.name,
        players: players ?? this.players,
        logoUrl: logoUrl ?? this.logoUrl,
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        metadata: metadata ?? this.metadata,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoccerTeam &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'SoccerTeam(id: $id, name: $name, players: ${players.length})';
}
