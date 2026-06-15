import 'package:flutter/foundation.dart';

import '../enums/enums.dart';
import 'soccer_player.dart';
import 'soccer_team.dart';
import 'soccer_formation.dart';

/// Represents the complete state of a soccer lineup view.
///
/// [LineupState] is an immutable snapshot that can be used to drive rendering
/// or serialised for persistence.
@immutable
class LineupState {
  /// Creates a [LineupState].
  const LineupState({
    this.team,
    this.opponentTeam,
    this.formation,
    this.opponentFormation,
    this.fieldDirection = FieldDirection.bottomToTop,
    this.dragDropMode = DragDropMode.disabled,
    this.selectionMode = SelectionMode.none,
    this.selectedPlayerIds = const [],
    this.highlightedPlayerIds = const [],
    this.metadata = const {},
  });

  /// The primary (home) team.
  final SoccerTeam? team;

  /// The opposing team, if displaying a match lineup.
  final SoccerTeam? opponentTeam;

  /// The formation for the primary team.
  final SoccerFormation? formation;

  /// The formation for the opponent team.
  final SoccerFormation? opponentFormation;

  /// The direction in which the field is rendered.
  final FieldDirection fieldDirection;

  /// Current drag-and-drop interaction mode.
  final DragDropMode dragDropMode;

  /// Current player selection mode.
  final SelectionMode selectionMode;

  /// IDs of currently selected players.
  final List<String> selectedPlayerIds;

  /// IDs of currently highlighted players.
  final List<String> highlightedPlayerIds;

  /// Arbitrary metadata.
  final Map<String, dynamic> metadata;

  /// Returns a [SoccerPlayer] by ID from either team, or `null`.
  SoccerPlayer? playerById(String id) {
    final allPlayers = [
      ...?team?.players,
      ...?opponentTeam?.players,
    ];
    final matches = allPlayers.where((p) => p.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  /// Returns a copy with the given fields replaced.
  LineupState copyWith({
    SoccerTeam? team,
    SoccerTeam? opponentTeam,
    SoccerFormation? formation,
    SoccerFormation? opponentFormation,
    FieldDirection? fieldDirection,
    DragDropMode? dragDropMode,
    SelectionMode? selectionMode,
    List<String>? selectedPlayerIds,
    List<String>? highlightedPlayerIds,
    Map<String, dynamic>? metadata,
    bool clearOpponentTeam = false,
    bool clearFormation = false,
    bool clearOpponentFormation = false,
  }) =>
      LineupState(
        team: team ?? this.team,
        opponentTeam:
            clearOpponentTeam ? null : (opponentTeam ?? this.opponentTeam),
        formation: clearFormation ? null : (formation ?? this.formation),
        opponentFormation: clearOpponentFormation
            ? null
            : (opponentFormation ?? this.opponentFormation),
        fieldDirection: fieldDirection ?? this.fieldDirection,
        dragDropMode: dragDropMode ?? this.dragDropMode,
        selectionMode: selectionMode ?? this.selectionMode,
        selectedPlayerIds: selectedPlayerIds ?? this.selectedPlayerIds,
        highlightedPlayerIds: highlightedPlayerIds ?? this.highlightedPlayerIds,
        metadata: metadata ?? this.metadata,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineupState &&
          runtimeType == other.runtimeType &&
          team == other.team &&
          opponentTeam == other.opponentTeam &&
          formation == other.formation &&
          opponentFormation == other.opponentFormation &&
          fieldDirection == other.fieldDirection &&
          dragDropMode == other.dragDropMode &&
          selectionMode == other.selectionMode;

  @override
  int get hashCode => Object.hash(
        team,
        opponentTeam,
        formation,
        opponentFormation,
        fieldDirection,
        dragDropMode,
        selectionMode,
      );

  @override
  String toString() => 'LineupState(team: ${team?.name}, '
      'opponent: ${opponentTeam?.name}, '
      'formation: ${formation?.name}, '
      'direction: $fieldDirection, '
      'dragDrop: $dragDropMode, '
      'selection: $selectionMode)';
}
