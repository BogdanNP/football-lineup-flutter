import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

void main() {
  group('CoordinateUtils', () {
    test('mirrorCoordinate flips y', () {
      const coord = FieldCoordinate(x: 30, y: 25);
      final mirrored = CoordinateUtils.mirrorCoordinate(coord);
      expect(mirrored.x, 30.0);
      expect(mirrored.y, 75.0);
    });

    test('distanceBetweenCoordinates returns 0 for same point', () {
      const a = FieldCoordinate(x: 50, y: 50);
      expect(CoordinateUtils.distanceBetweenCoordinates(a, a), 0.0);
    });

    test('distanceBetweenCoordinates returns correct distance', () {
      const a = FieldCoordinate(x: 0, y: 0);
      const b = FieldCoordinate(x: 3, y: 4);
      expect(CoordinateUtils.distanceBetweenCoordinates(a, b), 5.0);
    });

    test('nearestCoordinate returns closest', () {
      const target = FieldCoordinate(x: 10, y: 10);
      final candidates = [
        const FieldCoordinate(x: 50, y: 50),
        const FieldCoordinate(x: 12, y: 12),
        const FieldCoordinate(x: 80, y: 80),
      ];
      final nearest = CoordinateUtils.nearestCoordinate(target, candidates);
      expect(nearest, const FieldCoordinate(x: 12, y: 12));
    });

    test('nearestCoordinate returns null for empty list', () {
      const target = FieldCoordinate(x: 50, y: 50);
      expect(CoordinateUtils.nearestCoordinate(target, []), isNull);
    });

    test('nearestPlayer returns closest player', () {
      const target = FieldCoordinate(x: 10, y: 10);
      final players = [
        const SoccerPlayer(
            id: 'a',
            name: 'A',
            coordinate: FieldCoordinate(x: 50, y: 50)),
        const SoccerPlayer(
            id: 'b',
            name: 'B',
            coordinate: FieldCoordinate(x: 12, y: 12)),
      ];
      final nearest = CoordinateUtils.nearestPlayer(target, players);
      expect(nearest?.id, 'b');
    });

    test('nearestPlayer returns null when no field players', () {
      final players = [
        const SoccerPlayer(id: 'a', name: 'A', isBench: true),
      ];
      expect(CoordinateUtils.nearestPlayer(
        const FieldCoordinate(x: 0, y: 0),
        players,
      ), isNull);
    });

    test('playersOnField filters correctly', () {
      final players = [
        const SoccerPlayer(
            id: 'f',
            name: 'F',
            coordinate: FieldCoordinate(x: 50, y: 50)),
        const SoccerPlayer(id: 'b', name: 'B', isBench: true),
      ];
      expect(CoordinateUtils.playersOnField(players).length, 1);
    });

    test('benchPlayers filters correctly', () {
      final players = [
        const SoccerPlayer(
            id: 'f',
            name: 'F',
            coordinate: FieldCoordinate(x: 50, y: 50)),
        const SoccerPlayer(id: 'b', name: 'B', isBench: true),
      ];
      expect(CoordinateUtils.benchPlayers(players).length, 1);
    });

    test('playerById finds correct player', () {
      final players = [
        const SoccerPlayer(id: 'a', name: 'A'),
        const SoccerPlayer(id: 'b', name: 'B'),
      ];
      expect(CoordinateUtils.playerById('b', players)?.name, 'B');
    });

    test('playerById returns null when not found', () {
      final players = [const SoccerPlayer(id: 'a', name: 'A')];
      expect(CoordinateUtils.playerById('z', players), isNull);
    });

    test('toPixelOffset converts correctly', () {
      const coord = FieldCoordinate(x: 50, y: 25);
      final offset = CoordinateUtils.toPixelOffset(coord, 400, 600);
      expect(offset.dx, 200.0);
      expect(offset.dy, 150.0);
    });

    test('fromPixelOffset converts correctly', () {
      final coord = CoordinateUtils.fromPixelOffset(200, 150, 400, 600);
      expect(coord.x, 50.0);
      expect(coord.y, 25.0);
    });

    test('fromPixelOffset clamps to 0-100', () {
      final coord = CoordinateUtils.fromPixelOffset(-50, 700, 400, 600);
      expect(coord.x, 0.0);
      expect(coord.y, 100.0);
    });
  });
}
