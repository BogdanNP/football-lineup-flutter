## 0.1.0

* Initial release.
* Added `SoccerPlayer`, `SoccerTeam`, `SoccerFormation`, `FieldCoordinate`,
  `PlayerPosition`, and `LineupState` data models.
* Added 15 built-in formations: 4-4-2, 4-3-3, 4-2-3-1, 4-1-4-1, 4-5-1,
  3-5-2, 3-4-3, 3-4-2-1, 5-3-2, 5-4-1, 4-3-2-1, 4-1-2-1-2, 4-2-2-2,
  4-3-1-2, 4-2-4.
* Added `SoccerLineupController` with full player movement, swap, substitution,
  highlight, selection, and formation-change support.
* Added `SoccerLineupThemeData` with Material 3 colour-scheme integration.
* Added `FieldPainter` supporting grass, darkGrass, blueprint, chalkboard,
  custom, and image field styles.
* Added `PlayerWidget` with circle, shirt, avatar, card, and custom widget types.
* Added `SoccerTeamField` with drag-and-drop (swap / free-move) support.
* Added `MatchLineupView` for rendering both teams on a single field.
* Added `BenchPlayersView` with horizontal, vertical, grid, and custom layouts.
* Added `CoordinateUtils` utilities: `mirrorCoordinate`, `nearestCoordinate`,
  `nearestPlayer`, `playersOnField`, `benchPlayers`, `playerById`,
  `toPixelOffset`, `fromPixelOffset`, `distanceBetweenCoordinates`.
* Added `AnimationConfig` with fade, scale, slide, position, and custom presets.
* Added comprehensive unit tests, widget tests, and controller tests.
* Added a complete example app with 20 demonstration screens.
