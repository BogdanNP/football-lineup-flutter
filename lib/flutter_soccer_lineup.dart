/// A highly customizable soccer (football) lineup package for Flutter.
///
/// Inspired by apps like Sofascore and FotMob, this package provides:
///
/// - **Data models**: [SoccerPlayer], [SoccerTeam], [SoccerFormation],
///   [FieldCoordinate], [PlayerPosition], [LineupState].
/// - **Built-in formations**: 4-4-2, 4-3-3, 4-2-3-1, and 12 more via
///   [SoccerFormations].
/// - **Controller**: [SoccerLineupController] — move players, swap, substitute,
///   highlight, select, change formation.
/// - **Themes**: [SoccerLineupThemeData] — fully customisable colours, text
///   styles, radii, shadows, animations.
/// - **Widgets**: [SoccerTeamField], [MatchLineupView], [BenchPlayersView],
///   [PlayerWidget].
/// - **Utilities**: [CoordinateUtils] — coordinate math, nearest-player
///   queries, pixel↔normalised conversions.
/// - **Animations**: [AnimationConfig] — fade, scale, slide, position, custom.
/// - **Drag & drop**: [DragDropMode.swapPlayers] and [DragDropMode.freeMove].
/// - **Selection**: [SelectionMode.single] and [SelectionMode.multiple].
///
/// ## Quick start
///
/// ```dart
/// final controller = SoccerLineupController();
///
/// controller.setTeam(SoccerTeam(
///   id: 'home',
///   name: 'Home Team',
///   players: SoccerFormations.f433.positions.map((pos) => SoccerPlayer(
///     id: pos.id,
///     name: pos.label ?? pos.id,
///     coordinate: pos.coordinate,
///   )).toList(),
/// ));
/// controller.changeFormation(SoccerFormations.f433);
///
/// // In your widget:
/// SoccerTeamField(
///   controller: controller,
///   theme: SoccerLineupThemeData.fromContext(context),
///   onPlayerTap: (player) => print('Tapped: ${player.name}'),
/// )
/// ```
library flutter_soccer_lineup;

// Enums
export 'src/enums/enums.dart';

// Models
export 'src/models/field_coordinate.dart';
export 'src/models/lineup_state.dart';
export 'src/models/player_position.dart';
export 'src/models/soccer_formation.dart';
export 'src/models/soccer_player.dart';
export 'src/models/soccer_team.dart';

// Formations
export 'src/formations/formations.dart';

// Controllers
export 'src/controllers/soccer_lineup_controller.dart';

// Themes
export 'src/themes/soccer_lineup_theme_data.dart';

// Painters
export 'src/painters/field_painter.dart';

// Animations
export 'src/animations/animation_config.dart';

// Widgets
export 'src/widgets/bench_players_view.dart';
export 'src/widgets/match_lineup_view.dart';
export 'src/widgets/player_widget.dart';
export 'src/widgets/soccer_team_field.dart';

// Utils
export 'src/utils/coordinate_utils.dart';
