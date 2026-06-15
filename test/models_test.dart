import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

void main() {
  group('FieldCoordinate', () {
    test('creates with valid values', () {
      const coord = FieldCoordinate(x: 50, y: 50);
      expect(coord.x, 50.0);
      expect(coord.y, 50.0);
    });

    test('mirrored flips y', () {
      const coord = FieldCoordinate(x: 30, y: 25);
      expect(coord.mirrored.y, 75.0);
      expect(coord.mirrored.x, 30.0);
    });

    test('horizontallyMirrored flips x', () {
      const coord = FieldCoordinate(x: 30, y: 25);
      expect(coord.horizontallyMirrored.x, 70.0);
      expect(coord.horizontallyMirrored.y, 25.0);
    });

    test('fullyMirrored flips both', () {
      const coord = FieldCoordinate(x: 30, y: 25);
      expect(coord.fullyMirrored.x, 70.0);
      expect(coord.fullyMirrored.y, 75.0);
    });

    test('lerp interpolates correctly', () {
      const a = FieldCoordinate(x: 0, y: 0);
      const b = FieldCoordinate(x: 100, y: 100);
      final mid = FieldCoordinate.lerp(a, b, 0.5);
      expect(mid.x, 50.0);
      expect(mid.y, 50.0);
    });

    test('copyWith replaces fields', () {
      const coord = FieldCoordinate(x: 10, y: 20);
      final copy = coord.copyWith(x: 99);
      expect(copy.x, 99.0);
      expect(copy.y, 20.0);
    });

    test('equality works', () {
      const a = FieldCoordinate(x: 50, y: 50);
      const b = FieldCoordinate(x: 50, y: 50);
      expect(a, equals(b));
    });

    test('toString contains x and y', () {
      const coord = FieldCoordinate(x: 12.0, y: 34.0);
      expect(coord.toString(), contains('12.0'));
      expect(coord.toString(), contains('34.0'));
    });
  });

  group('SoccerPlayer', () {
    test('creates with required fields', () {
      const player = SoccerPlayer(id: 'p1', name: 'Salah');
      expect(player.id, 'p1');
      expect(player.name, 'Salah');
      expect(player.isBench, false);
      expect(player.isOnField, false);
    });

    test('isOnField true when coordinate set and not bench', () {
      const player = SoccerPlayer(
        id: 'p1',
        name: 'Salah',
        coordinate: FieldCoordinate(x: 50, y: 20),
      );
      expect(player.isOnField, true);
    });

    test('isOnField false when bench', () {
      const player = SoccerPlayer(
        id: 'p1',
        name: 'Salah',
        coordinate: FieldCoordinate(x: 50, y: 20),
        isBench: true,
      );
      expect(player.isOnField, false);
    });

    test('copyWith replaces fields', () {
      const player = SoccerPlayer(id: 'p1', name: 'Salah', shirtNumber: 11);
      final updated = player.copyWith(name: 'Firmino', shirtNumber: 9);
      expect(updated.name, 'Firmino');
      expect(updated.shirtNumber, 9);
      expect(updated.id, 'p1');
    });

    test('copyWith clearCoordinate sets coordinate null', () {
      const player = SoccerPlayer(
        id: 'p1',
        name: 'Salah',
        coordinate: FieldCoordinate(x: 50, y: 20),
      );
      final cleared = player.copyWith(clearCoordinate: true);
      expect(cleared.coordinate, isNull);
    });

    test('equality based on id', () {
      const a = SoccerPlayer(id: 'p1', name: 'A');
      const b = SoccerPlayer(id: 'p1', name: 'B');
      expect(a, equals(b));
    });
  });

  group('SoccerTeam', () {
    const fieldPlayer = SoccerPlayer(
      id: 'p1',
      name: 'A',
      coordinate: FieldCoordinate(x: 50, y: 50),
    );
    const benchPlayer = SoccerPlayer(id: 'p2', name: 'B', isBench: true);
    const team = SoccerTeam(
      id: 't1',
      name: 'Team A',
      players: [fieldPlayer, benchPlayer],
    );

    test('fieldPlayers returns only field players', () {
      expect(team.fieldPlayers.length, 1);
      expect(team.fieldPlayers.first.id, 'p1');
    });

    test('benchPlayers returns only bench players', () {
      expect(team.benchPlayers.length, 1);
      expect(team.benchPlayers.first.id, 'p2');
    });

    test('equality based on id', () {
      const a = SoccerTeam(id: 't1', name: 'A', players: []);
      const b = SoccerTeam(id: 't1', name: 'B', players: []);
      expect(a, equals(b));
    });
  });

  group('SoccerFormation', () {
    test('built-in 4-4-2 has 11 positions', () {
      expect(SoccerFormations.f442.positions.length, 11);
    });

    test('built-in 4-3-3 has 11 positions', () {
      expect(SoccerFormations.f433.positions.length, 11);
    });

    test('SoccerFormations.all has 15 formations', () {
      expect(SoccerFormations.all.length, 15);
    });

    test('byId returns correct formation', () {
      final f = SoccerFormations.byId('4-4-2');
      expect(f, isNotNull);
      expect(f!.name, '4-4-2');
    });

    test('byId returns null for unknown id', () {
      expect(SoccerFormations.byId('9-9-9'), isNull);
    });

    test('positionById returns correct position', () {
      final pos = SoccerFormations.f433.positionById('GK');
      expect(pos, isNotNull);
      expect(pos!.label, 'GK');
    });

    test('all formations include a GK', () {
      for (final f in SoccerFormations.all) {
        expect(
          f.positions.any((p) => p.id == 'GK'),
          isTrue,
          reason: '${f.name} is missing a GK position',
        );
      }
    });

    test('all formation coordinates are within 0-100', () {
      for (final f in SoccerFormations.all) {
        for (final p in f.positions) {
          expect(p.coordinate.x, inInclusiveRange(0, 100),
              reason: '${f.name} / ${p.id} x out of range');
          expect(p.coordinate.y, inInclusiveRange(0, 100),
              reason: '${f.name} / ${p.id} y out of range');
        }
      }
    });
  });

  group('LineupState', () {
    test('creates empty state', () {
      const state = LineupState();
      expect(state.team, isNull);
      expect(state.opponentTeam, isNull);
    });

    test('playerById finds player in team', () {
      const player = SoccerPlayer(id: 'p1', name: 'Salah');
      const team = SoccerTeam(id: 't1', name: 'T', players: [player]);
      final state = LineupState(team: team);
      expect(state.playerById('p1'), isNotNull);
    });

    test('playerById returns null when not found', () {
      const state = LineupState();
      expect(state.playerById('missing'), isNull);
    });
  });
}
