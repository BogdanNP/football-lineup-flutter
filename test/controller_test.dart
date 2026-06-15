import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

void main() {
  SoccerTeam makeTeam(SoccerFormation formation) {
    final players = formation.positions
        .asMap()
        .entries
        .map(
          (e) => SoccerPlayer(
            id: 'p${e.key}',
            name: 'Player ${e.key}',
            shirtNumber: e.key + 1,
            coordinate: e.value.coordinate,
          ),
        )
        .toList();
    return SoccerTeam(id: 'team', name: 'Team', players: [
      ...players,
      const SoccerPlayer(id: 'bench1', name: 'Bench1', isBench: true),
    ]);
  }

  group('SoccerLineupController', () {
    late SoccerLineupController controller;

    setUp(() {
      controller = SoccerLineupController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('initial state is empty', () {
      expect(controller.state.team, isNull);
      expect(controller.state.formation, isNull);
    });

    test('setTeam updates state', () {
      final team = makeTeam(SoccerFormations.f433);
      controller.setTeam(team);
      expect(controller.state.team, team);
    });

    test('setOpponentTeam updates state', () {
      final team = makeTeam(SoccerFormations.f442);
      controller.setOpponentTeam(team);
      expect(controller.state.opponentTeam, team);
    });

    test('changeFormation updates formation', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.changeFormation(SoccerFormations.f442);
      expect(controller.state.formation?.id, '4-4-2');
    });

    test('movePlayer updates coordinate', () {
      final team = makeTeam(SoccerFormations.f433);
      controller.setTeam(team);
      const newCoord = FieldCoordinate(x: 75, y: 30);
      controller.movePlayer('p0', newCoord);
      expect(controller.getPlayerById('p0')?.coordinate, newCoord);
    });

    test('swapPlayers exchanges coordinates', () {
      final team = makeTeam(SoccerFormations.f433);
      controller.setTeam(team);
      final p0coord =
          controller.getPlayerById('p0')!.coordinate!;
      final p1coord =
          controller.getPlayerById('p1')!.coordinate!;
      controller.swapPlayers('p0', 'p1');
      expect(controller.getPlayerById('p0')!.coordinate, p1coord);
      expect(controller.getPlayerById('p1')!.coordinate, p0coord);
    });

    test('highlightPlayer sets isHighlighted', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.highlightPlayer('p0');
      expect(controller.getPlayerById('p0')!.isHighlighted, isTrue);
    });

    test('clearHighlights removes all highlights', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.highlightPlayers(['p0', 'p1', 'p2']);
      controller.clearHighlights();
      for (final p in controller.getPlayersOnField()) {
        expect(p.isHighlighted, isFalse);
      }
    });

    test('selectPlayer single mode deselects others', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.setSelectionMode(SelectionMode.single);
      controller.selectPlayer('p0');
      controller.selectPlayer('p1');
      expect(controller.getPlayerById('p0')!.isSelected, isFalse);
      expect(controller.getPlayerById('p1')!.isSelected, isTrue);
      expect(controller.state.selectedPlayerIds, ['p1']);
    });

    test('selectPlayer multiple mode accumulates', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.setSelectionMode(SelectionMode.multiple);
      controller.selectPlayer('p0');
      controller.selectPlayer('p1');
      expect(controller.state.selectedPlayerIds.length, 2);
    });

    test('clearSelection empties selection', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.setSelectionMode(SelectionMode.single);
      controller.selectPlayer('p0');
      controller.clearSelection();
      expect(controller.state.selectedPlayerIds, isEmpty);
    });

    test('substitutePlayer swaps field and bench', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      // p0 is on field, bench1 is on bench
      controller.substitutePlayer(
          fieldPlayerId: 'p0', benchPlayerId: 'bench1');
      expect(controller.getPlayerById('p0')!.isBench, isTrue);
      expect(controller.getPlayerById('bench1')!.isBench, isFalse);
    });

    test('getPlayersOnField returns field players', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      expect(controller.getPlayersOnField().length, 11);
    });

    test('getBenchPlayers returns bench players', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      expect(controller.getBenchPlayers().length, 1);
    });

    test('reset clears state', () {
      controller.setTeam(makeTeam(SoccerFormations.f433));
      controller.reset();
      expect(controller.state.team, isNull);
    });

    test('notifyListeners called on state change', () {
      var notified = false;
      controller.addListener(() => notified = true);
      controller.setTeam(makeTeam(SoccerFormations.f433));
      expect(notified, isTrue);
    });

    test('mirrorCoordinate returns mirrored y', () {
      const coord = FieldCoordinate(x: 30, y: 20);
      expect(controller.mirrorCoordinate(coord).y, 80.0);
    });

    test('setFieldDirection updates direction', () {
      controller.setFieldDirection(FieldDirection.topToBottom);
      expect(controller.state.fieldDirection, FieldDirection.topToBottom);
    });

    test('setDragDropMode updates mode', () {
      controller.setDragDropMode(DragDropMode.swapPlayers);
      expect(controller.state.dragDropMode, DragDropMode.swapPlayers);
    });
  });
}
