import 'package:flutter/foundation.dart';

import '../enums/enums.dart';
import '../models/field_coordinate.dart';
import '../models/lineup_state.dart';
import '../models/soccer_formation.dart';
import '../models/soccer_player.dart';
import '../models/soccer_team.dart';
import '../utils/coordinate_utils.dart';

/// Controls the state of a soccer lineup view.
///
/// [SoccerLineupController] extends [ChangeNotifier] so it can be used
/// directly with [ListenableBuilder] or [AnimatedBuilder].
///
/// All mutating methods update [state] and call [notifyListeners].
///
/// ```dart
/// final controller = SoccerLineupController();
///
/// controller.setTeam(myTeam);
/// controller.changeFormation(SoccerFormations.f433);
/// ```
class SoccerLineupController extends ChangeNotifier {
  /// Creates a [SoccerLineupController] with an optional initial [state].
  SoccerLineupController({LineupState? initialState})
      : _state = initialState ?? const LineupState();

  LineupState _state;

  /// The current immutable state snapshot.
  LineupState get state => _state;

  // ── Team management ────────────────────────────────────────────────────────

  /// Replaces the primary team.
  void setTeam(SoccerTeam team) {
    _state = _state.copyWith(team: team);
    notifyListeners();
  }

  /// Replaces the opponent team.
  void setOpponentTeam(SoccerTeam team) {
    _state = _state.copyWith(opponentTeam: team);
    notifyListeners();
  }

  /// Clears the opponent team.
  void clearOpponentTeam() {
    _state = _state.copyWith(clearOpponentTeam: true);
    notifyListeners();
  }

  // ── Formation ──────────────────────────────────────────────────────────────

  /// Changes the formation for the primary team.
  ///
  /// If [applyCoordinates] is `true` (default), players are repositioned to
  /// match the new formation's coordinates in order.
  void changeFormation(
    SoccerFormation formation, {
    bool applyCoordinates = true,
  }) {
    if (!applyCoordinates) {
      _state = _state.copyWith(formation: formation);
      notifyListeners();
      return;
    }
    final team = _state.team;
    if (team == null) {
      _state = _state.copyWith(formation: formation);
      notifyListeners();
      return;
    }
    final fieldPlayers = team.fieldPlayers;
    final updatedPlayers = List<SoccerPlayer>.from(team.players);
    for (var i = 0;
        i < fieldPlayers.length && i < formation.positions.length;
        i++) {
      final playerIndex = updatedPlayers.indexOf(fieldPlayers[i]);
      if (playerIndex >= 0) {
        updatedPlayers[playerIndex] = fieldPlayers[i]
            .copyWith(coordinate: formation.positions[i].coordinate);
      }
    }
    _state = _state.copyWith(
      formation: formation,
      team: team.copyWith(players: updatedPlayers),
    );
    notifyListeners();
  }

  /// Changes the opponent formation.
  void changeOpponentFormation(
    SoccerFormation formation, {
    bool applyCoordinates = true,
  }) {
    if (!applyCoordinates) {
      _state = _state.copyWith(opponentFormation: formation);
      notifyListeners();
      return;
    }
    final team = _state.opponentTeam;
    if (team == null) {
      _state = _state.copyWith(opponentFormation: formation);
      notifyListeners();
      return;
    }
    final fieldPlayers = team.fieldPlayers;
    final updatedPlayers = List<SoccerPlayer>.from(team.players);
    for (var i = 0;
        i < fieldPlayers.length && i < formation.positions.length;
        i++) {
      final playerIndex = updatedPlayers.indexOf(fieldPlayers[i]);
      if (playerIndex >= 0) {
        updatedPlayers[playerIndex] = fieldPlayers[i]
            .copyWith(coordinate: formation.positions[i].coordinate);
      }
    }
    _state = _state.copyWith(
      opponentFormation: formation,
      opponentTeam: team.copyWith(players: updatedPlayers),
    );
    notifyListeners();
  }

  // ── Player movement ────────────────────────────────────────────────────────

  /// Moves a player to a new coordinate on the field.
  ///
  /// Throws an [ArgumentError] if no player with [playerId] is found.
  void movePlayer(String playerId, FieldCoordinate coordinate) {
    _updatePlayer(
      playerId,
      (p) => p.copyWith(coordinate: coordinate, isBench: false),
    );
  }

  /// Swaps the positions of two players.
  ///
  /// If either player is on the bench, the bench/field flags are swapped too.
  void swapPlayers(String playerAId, String playerBId) {
    final team = _state.team;
    if (team == null) return;
    final players = List<SoccerPlayer>.from(team.players);
    final idxA = players.indexWhere((p) => p.id == playerAId);
    final idxB = players.indexWhere((p) => p.id == playerBId);
    if (idxA < 0 || idxB < 0) return;

    final a = players[idxA];
    final b = players[idxB];
    players[idxA] = a.copyWith(
      coordinate: b.coordinate,
      isBench: b.isBench,
      clearCoordinate: b.coordinate == null,
    );
    players[idxB] = b.copyWith(
      coordinate: a.coordinate,
      isBench: a.isBench,
      clearCoordinate: a.coordinate == null,
    );
    _state = _state.copyWith(team: team.copyWith(players: players));
    notifyListeners();
  }

  /// Substitutes a bench player ([benchPlayerId]) onto the field in place of
  /// a field player ([fieldPlayerId]).
  ///
  /// The bench player receives the field player's coordinate and is moved to
  /// the field; the field player is moved to the bench.
  void substitutePlayer({
    required String fieldPlayerId,
    required String benchPlayerId,
  }) {
    final team = _state.team;
    if (team == null) return;
    final players = List<SoccerPlayer>.from(team.players);
    final fieldIdx = players.indexWhere((p) => p.id == fieldPlayerId);
    final benchIdx = players.indexWhere((p) => p.id == benchPlayerId);
    if (fieldIdx < 0 || benchIdx < 0) return;

    final fieldPlayer = players[fieldIdx];
    final benchPlayer = players[benchIdx];

    players[fieldIdx] = fieldPlayer.copyWith(
      isBench: true,
      clearCoordinate: true,
    );
    players[benchIdx] = benchPlayer.copyWith(
      coordinate: fieldPlayer.coordinate,
      isBench: false,
    );
    _state = _state.copyWith(team: team.copyWith(players: players));
    notifyListeners();
  }

  /// Moves a player to the bench (removes their field coordinate).
  void moveToBench(String playerId) {
    _updatePlayer(
      playerId,
      (p) => p.copyWith(isBench: true, clearCoordinate: true),
    );
  }

  /// Moves a player from the bench to a field coordinate.
  void moveToField(String playerId, FieldCoordinate coordinate) {
    _updatePlayer(
      playerId,
      (p) => p.copyWith(isBench: false, coordinate: coordinate),
    );
  }

  // ── Highlighting ───────────────────────────────────────────────────────────

  /// Highlights a single player.
  void highlightPlayer(String playerId) {
    final team = _state.team;
    if (team == null) return;
    final idx = team.players.indexWhere((p) => p.id == playerId);
    if (idx < 0) return;
    final updated = List<SoccerPlayer>.from(team.players);
    updated[idx] = updated[idx].copyWith(isHighlighted: true);
    _state = _state.copyWith(
      team: team.copyWith(players: updated),
      highlightedPlayerIds: [
        ..._state.highlightedPlayerIds,
        if (!_state.highlightedPlayerIds.contains(playerId)) playerId,
      ],
    );
    notifyListeners();
  }

  /// Highlights multiple players by their IDs.
  void highlightPlayers(List<String> playerIds) {
    final team = _state.team;
    if (team == null) return;
    final updated = team.players
        .map(
          (p) => playerIds.contains(p.id)
              ? p.copyWith(isHighlighted: true)
              : p,
        )
        .toList();
    final ids = {..._state.highlightedPlayerIds, ...playerIds}.toList();
    _state = _state.copyWith(
      team: team.copyWith(players: updated),
      highlightedPlayerIds: ids,
    );
    notifyListeners();
  }

  /// Clears all player highlights.
  void clearHighlights() {
    final team = _state.team;
    if (team == null) return;
    final updated = team.players
        .map((p) => p.copyWith(isHighlighted: false))
        .toList();
    _state = _state.copyWith(
      team: team.copyWith(players: updated),
      highlightedPlayerIds: const [],
    );
    notifyListeners();
  }

  // ── Selection ──────────────────────────────────────────────────────────────

  /// Selects or deselects a player depending on the current [SelectionMode].
  ///
  /// In [SelectionMode.single] mode, previously selected players are
  /// deselected. In [SelectionMode.multiple] mode, the selection is toggled.
  /// In [SelectionMode.none] mode, this is a no-op.
  void selectPlayer(String playerId) {
    switch (_state.selectionMode) {
      case SelectionMode.none:
        return;
      case SelectionMode.single:
        _selectSingle(playerId);
      case SelectionMode.multiple:
        _toggleSelection(playerId);
    }
  }

  /// Clears the selection for all players.
  void clearSelection() {
    final team = _state.team;
    if (team == null) {
      _state = _state.copyWith(selectedPlayerIds: const []);
      notifyListeners();
      return;
    }
    final updated = team.players
        .map((p) => p.copyWith(isSelected: false))
        .toList();
    _state = _state.copyWith(
      team: team.copyWith(players: updated),
      selectedPlayerIds: const [],
    );
    notifyListeners();
  }

  // ── Mode management ────────────────────────────────────────────────────────

  /// Updates the current [DragDropMode].
  void setDragDropMode(DragDropMode mode) {
    _state = _state.copyWith(dragDropMode: mode);
    notifyListeners();
  }

  /// Updates the current [SelectionMode].
  void setSelectionMode(SelectionMode mode) {
    if (mode == SelectionMode.none) clearSelection();
    _state = _state.copyWith(selectionMode: mode);
    notifyListeners();
  }

  /// Updates the [FieldDirection].
  void setFieldDirection(FieldDirection direction) {
    _state = _state.copyWith(fieldDirection: direction);
    notifyListeners();
  }

  // ── Queries ────────────────────────────────────────────────────────────────

  /// Returns a player by ID from either team, or `null`.
  SoccerPlayer? getPlayerById(String id) => _state.playerById(id);

  /// Returns the coordinate of a player, or `null`.
  FieldCoordinate? getPlayerCoordinate(String playerId) =>
      getPlayerById(playerId)?.coordinate;

  /// Returns all field players for the primary team.
  List<SoccerPlayer> getPlayersOnField() =>
      _state.team?.fieldPlayers ?? const [];

  /// Returns all bench players for the primary team.
  List<SoccerPlayer> getBenchPlayers() =>
      _state.team?.benchPlayers ?? const [];

  /// Returns the vertical mirror of a coordinate.
  FieldCoordinate mirrorCoordinate(FieldCoordinate coordinate) =>
      CoordinateUtils.mirrorCoordinate(coordinate);

  // ── Reset ──────────────────────────────────────────────────────────────────

  /// Resets the controller to an empty [LineupState].
  void reset() {
    _state = const LineupState();
    notifyListeners();
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  void _updatePlayer(
    String playerId,
    SoccerPlayer Function(SoccerPlayer) update,
  ) {
    final team = _state.team;
    if (team == null) return;
    final idx = team.players.indexWhere((p) => p.id == playerId);
    if (idx < 0) return;
    final updated = List<SoccerPlayer>.from(team.players);
    updated[idx] = update(updated[idx]);
    _state = _state.copyWith(team: team.copyWith(players: updated));
    notifyListeners();
  }

  void _selectSingle(String playerId) {
    final team = _state.team;
    if (team == null) return;
    final updated = team.players
        .map((p) => p.copyWith(isSelected: p.id == playerId))
        .toList();
    _state = _state.copyWith(
      team: team.copyWith(players: updated),
      selectedPlayerIds: [playerId],
    );
    notifyListeners();
  }

  void _toggleSelection(String playerId) {
    final team = _state.team;
    if (team == null) return;
    final isSelected =
        !_state.selectedPlayerIds.contains(playerId);
    final updated = team.players
        .map(
          (p) =>
              p.id == playerId ? p.copyWith(isSelected: isSelected) : p,
        )
        .toList();
    final ids = isSelected
        ? [..._state.selectedPlayerIds, playerId]
        : _state.selectedPlayerIds.where((id) => id != playerId).toList();
    _state = _state.copyWith(
      team: team.copyWith(players: updated),
      selectedPlayerIds: ids,
    );
    notifyListeners();
  }
}
