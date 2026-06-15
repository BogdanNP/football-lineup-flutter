import '../models/player_position.dart';
import '../models/soccer_formation.dart';
import '../models/field_coordinate.dart';

// ignore_for_file: public_member_api_docs

/// Built-in soccer formations.
///
/// All coordinates are normalized to `0–100` and optimised for portrait
/// phones, with the goalkeeper at the bottom (`y ≈ 90`) and the
/// forward line at the top (`y ≈ 10`).
///
/// Use [SoccerFormations.all] to retrieve all built-in formations.
/// Use [SoccerFormations.byId] to retrieve a formation by its identifier.
abstract final class SoccerFormations {
  /// 4-4-2 formation.
  static const SoccerFormation f442 = SoccerFormation(
    id: '4-4-2',
    name: '4-4-2',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'RM', label: 'RM', coordinate: FieldCoordinate(x: 80, y: 55)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 62, y: 55)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 38, y: 55)),
      PlayerPosition(id: 'LM', label: 'LM', coordinate: FieldCoordinate(x: 20, y: 55)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 60, y: 20)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 40, y: 20)),
    ],
  );

  /// 4-3-3 formation.
  static const SoccerFormation f433 = SoccerFormation(
    id: '4-3-3',
    name: '4-3-3',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 70, y: 52)),
      PlayerPosition(id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 52)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 30, y: 52)),
      PlayerPosition(id: 'RW', label: 'RW', coordinate: FieldCoordinate(x: 80, y: 20)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 15)),
      PlayerPosition(id: 'LW', label: 'LW', coordinate: FieldCoordinate(x: 20, y: 20)),
    ],
  );

  /// 4-2-3-1 formation.
  static const SoccerFormation f4231 = SoccerFormation(
    id: '4-2-3-1',
    name: '4-2-3-1',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CDM_R', label: 'CDM', coordinate: FieldCoordinate(x: 62, y: 60)),
      PlayerPosition(id: 'CDM_L', label: 'CDM', coordinate: FieldCoordinate(x: 38, y: 60)),
      PlayerPosition(id: 'RAM', label: 'RAM', coordinate: FieldCoordinate(x: 75, y: 42)),
      PlayerPosition(id: 'CAM', label: 'CAM', coordinate: FieldCoordinate(x: 50, y: 40)),
      PlayerPosition(id: 'LAM', label: 'LAM', coordinate: FieldCoordinate(x: 25, y: 42)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 15)),
    ],
  );

  /// 4-1-4-1 formation.
  static const SoccerFormation f4141 = SoccerFormation(
    id: '4-1-4-1',
    name: '4-1-4-1',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CDM', label: 'CDM', coordinate: FieldCoordinate(x: 50, y: 62)),
      PlayerPosition(id: 'RM', label: 'RM', coordinate: FieldCoordinate(x: 80, y: 48)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 62, y: 48)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 38, y: 48)),
      PlayerPosition(id: 'LM', label: 'LM', coordinate: FieldCoordinate(x: 20, y: 48)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 15)),
    ],
  );

  /// 4-5-1 formation.
  static const SoccerFormation f451 = SoccerFormation(
    id: '4-5-1',
    name: '4-5-1',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'RM', label: 'RM', coordinate: FieldCoordinate(x: 88, y: 50)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 69, y: 50)),
      PlayerPosition(id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 50)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 31, y: 50)),
      PlayerPosition(id: 'LM', label: 'LM', coordinate: FieldCoordinate(x: 12, y: 50)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 15)),
    ],
  );

  /// 3-5-2 formation.
  static const SoccerFormation f352 = SoccerFormation(
    id: '3-5-2',
    name: '3-5-2',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 70, y: 75)),
      PlayerPosition(id: 'CB', label: 'CB', coordinate: FieldCoordinate(x: 50, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 30, y: 75)),
      PlayerPosition(id: 'RWB', label: 'RWB', coordinate: FieldCoordinate(x: 85, y: 52)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 67, y: 52)),
      PlayerPosition(id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 52)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 33, y: 52)),
      PlayerPosition(id: 'LWB', label: 'LWB', coordinate: FieldCoordinate(x: 15, y: 52)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 62, y: 18)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 38, y: 18)),
    ],
  );

  /// 3-4-3 formation.
  static const SoccerFormation f343 = SoccerFormation(
    id: '3-4-3',
    name: '3-4-3',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 70, y: 75)),
      PlayerPosition(id: 'CB', label: 'CB', coordinate: FieldCoordinate(x: 50, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 30, y: 75)),
      PlayerPosition(id: 'RM', label: 'RM', coordinate: FieldCoordinate(x: 80, y: 52)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 60, y: 52)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 40, y: 52)),
      PlayerPosition(id: 'LM', label: 'LM', coordinate: FieldCoordinate(x: 20, y: 52)),
      PlayerPosition(id: 'RW', label: 'RW', coordinate: FieldCoordinate(x: 78, y: 18)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 14)),
      PlayerPosition(id: 'LW', label: 'LW', coordinate: FieldCoordinate(x: 22, y: 18)),
    ],
  );

  /// 3-4-2-1 formation.
  static const SoccerFormation f3421 = SoccerFormation(
    id: '3-4-2-1',
    name: '3-4-2-1',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 70, y: 76)),
      PlayerPosition(id: 'CB', label: 'CB', coordinate: FieldCoordinate(x: 50, y: 76)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 30, y: 76)),
      PlayerPosition(id: 'RWB', label: 'RWB', coordinate: FieldCoordinate(x: 84, y: 56)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 62, y: 56)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 38, y: 56)),
      PlayerPosition(id: 'LWB', label: 'LWB', coordinate: FieldCoordinate(x: 16, y: 56)),
      PlayerPosition(id: 'SS_R', label: 'SS', coordinate: FieldCoordinate(x: 65, y: 32)),
      PlayerPosition(id: 'SS_L', label: 'SS', coordinate: FieldCoordinate(x: 35, y: 32)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 14)),
    ],
  );

  /// 5-3-2 formation.
  static const SoccerFormation f532 = SoccerFormation(
    id: '5-3-2',
    name: '5-3-2',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RWB', label: 'RWB', coordinate: FieldCoordinate(x: 88, y: 74)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 70, y: 76)),
      PlayerPosition(id: 'CB', label: 'CB', coordinate: FieldCoordinate(x: 50, y: 76)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 30, y: 76)),
      PlayerPosition(id: 'LWB', label: 'LWB', coordinate: FieldCoordinate(x: 12, y: 74)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 67, y: 50)),
      PlayerPosition(id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 50)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 33, y: 50)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 62, y: 18)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 38, y: 18)),
    ],
  );

  /// 5-4-1 formation.
  static const SoccerFormation f541 = SoccerFormation(
    id: '5-4-1',
    name: '5-4-1',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RWB', label: 'RWB', coordinate: FieldCoordinate(x: 88, y: 74)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 70, y: 76)),
      PlayerPosition(id: 'CB', label: 'CB', coordinate: FieldCoordinate(x: 50, y: 76)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 30, y: 76)),
      PlayerPosition(id: 'LWB', label: 'LWB', coordinate: FieldCoordinate(x: 12, y: 74)),
      PlayerPosition(id: 'RM', label: 'RM', coordinate: FieldCoordinate(x: 80, y: 50)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 60, y: 50)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 40, y: 50)),
      PlayerPosition(id: 'LM', label: 'LM', coordinate: FieldCoordinate(x: 20, y: 50)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 15)),
    ],
  );

  /// 4-3-2-1 (Christmas tree) formation.
  static const SoccerFormation f4321 = SoccerFormation(
    id: '4-3-2-1',
    name: '4-3-2-1',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 67, y: 57)),
      PlayerPosition(id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 57)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 33, y: 57)),
      PlayerPosition(id: 'SS_R', label: 'SS', coordinate: FieldCoordinate(x: 63, y: 34)),
      PlayerPosition(id: 'SS_L', label: 'SS', coordinate: FieldCoordinate(x: 37, y: 34)),
      PlayerPosition(id: 'ST', label: 'ST', coordinate: FieldCoordinate(x: 50, y: 14)),
    ],
  );

  /// 4-1-2-1-2 (diamond) formation.
  static const SoccerFormation f41212 = SoccerFormation(
    id: '4-1-2-1-2',
    name: '4-1-2-1-2',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CDM', label: 'CDM', coordinate: FieldCoordinate(x: 50, y: 63)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 72, y: 50)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 28, y: 50)),
      PlayerPosition(id: 'CAM', label: 'CAM', coordinate: FieldCoordinate(x: 50, y: 37)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 62, y: 18)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 38, y: 18)),
    ],
  );

  /// 4-2-2-2 formation.
  static const SoccerFormation f4222 = SoccerFormation(
    id: '4-2-2-2',
    name: '4-2-2-2',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CDM_R', label: 'CDM', coordinate: FieldCoordinate(x: 62, y: 60)),
      PlayerPosition(id: 'CDM_L', label: 'CDM', coordinate: FieldCoordinate(x: 38, y: 60)),
      PlayerPosition(id: 'SS_R', label: 'SS', coordinate: FieldCoordinate(x: 68, y: 38)),
      PlayerPosition(id: 'SS_L', label: 'SS', coordinate: FieldCoordinate(x: 32, y: 38)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 62, y: 18)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 38, y: 18)),
    ],
  );

  /// 4-3-1-2 formation.
  static const SoccerFormation f4312 = SoccerFormation(
    id: '4-3-1-2',
    name: '4-3-1-2',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 67, y: 56)),
      PlayerPosition(id: 'CM', label: 'CM', coordinate: FieldCoordinate(x: 50, y: 56)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 33, y: 56)),
      PlayerPosition(id: 'CAM', label: 'CAM', coordinate: FieldCoordinate(x: 50, y: 36)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 62, y: 18)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 38, y: 18)),
    ],
  );

  /// 4-2-4 formation.
  static const SoccerFormation f424 = SoccerFormation(
    id: '4-2-4',
    name: '4-2-4',
    positions: [
      PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
      PlayerPosition(id: 'RB', label: 'RB', coordinate: FieldCoordinate(x: 80, y: 75)),
      PlayerPosition(id: 'CB_R', label: 'CB', coordinate: FieldCoordinate(x: 62, y: 75)),
      PlayerPosition(id: 'CB_L', label: 'CB', coordinate: FieldCoordinate(x: 38, y: 75)),
      PlayerPosition(id: 'LB', label: 'LB', coordinate: FieldCoordinate(x: 20, y: 75)),
      PlayerPosition(id: 'CM_R', label: 'CM', coordinate: FieldCoordinate(x: 62, y: 52)),
      PlayerPosition(id: 'CM_L', label: 'CM', coordinate: FieldCoordinate(x: 38, y: 52)),
      PlayerPosition(id: 'RW', label: 'RW', coordinate: FieldCoordinate(x: 82, y: 18)),
      PlayerPosition(id: 'ST_R', label: 'ST', coordinate: FieldCoordinate(x: 62, y: 14)),
      PlayerPosition(id: 'ST_L', label: 'ST', coordinate: FieldCoordinate(x: 38, y: 14)),
      PlayerPosition(id: 'LW', label: 'LW', coordinate: FieldCoordinate(x: 18, y: 18)),
    ],
  );

  /// All built-in formations in a convenient list.
  static const List<SoccerFormation> all = [
    f442,
    f433,
    f4231,
    f4141,
    f451,
    f352,
    f343,
    f3421,
    f532,
    f541,
    f4321,
    f41212,
    f4222,
    f4312,
    f424,
  ];

  /// Returns the built-in formation with the given [id], or `null`.
  static SoccerFormation? byId(String id) {
    final matches = all.where((f) => f.id == id);
    return matches.isEmpty ? null : matches.first;
  }
}
