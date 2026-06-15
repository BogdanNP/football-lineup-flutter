# flutter_soccer_lineup

[![pub.dev](https://img.shields.io/pub/v/flutter_soccer_lineup.svg)](https://pub.dev/packages/flutter_soccer_lineup)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A highly customizable soccer (football) lineup package for Flutter. Inspired by
apps like **Sofascore** and **FotMob**, this package provides everything you
need to build tactical boards, match lineup screens, formation viewers, and
interactive drag-and-drop editors.

---

## Features

| Feature | Description |
|---|---|
| **15 built-in formations** | 4-4-2, 4-3-3, 4-2-3-1, 4-1-4-1, 4-5-1, 3-5-2, 3-4-3, 3-4-2-1, 5-3-2, 5-4-1, 4-3-2-1, 4-1-2-1-2, 4-2-2-2, 4-3-1-2, 4-2-4 |
| **Custom formations** | Define any formation at runtime with normalized coordinates |
| **Drag & drop** | Swap players or free-move players on the field |
| **Substitutions** | Move players between bench and field |
| **Themes** | Full Material 3 integration; every colour, style and radius is customizable |
| **Field styles** | Grass, dark grass, blueprint, chalkboard, custom painter, custom image |
| **Player widgets** | Circle, shirt, avatar, card, or fully custom |
| **Match lineup** | Render both teams on a single field with automatic opponent mirroring |
| **Bench view** | Horizontal, vertical, grid, or custom bench layouts |
| **Highlighting** | Highlight individual players or groups |
| **Selection** | Single or multiple player selection |
| **Animations** | Fade, scale, slide, position, or custom animation builders |
| **Accessibility** | Full Semantics and screen-reader support |
| **Zero hardcoding** | No hardcoded colours, strings, or assumptions |

---

## Installation

```yaml
dependencies:
  flutter_soccer_lineup: ^0.1.0
```

---

## Quick Start

```dart
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

// 1. Create a controller
final controller = SoccerLineupController();

// 2. Set a team using a built-in formation
controller.setTeam(SoccerTeam(
  id: 'home',
  name: 'My Team',
  players: SoccerFormations.f433.positions.map((pos) => SoccerPlayer(
    id: pos.id,
    name: pos.label ?? pos.id,
    shirtNumber: SoccerFormations.f433.positions.indexOf(pos) + 1,
    coordinate: pos.coordinate,
  )).toList(),
));
controller.changeFormation(SoccerFormations.f433);

// 3. Display the field
SoccerTeamField(
  controller: controller,
  theme: SoccerLineupThemeData.fromContext(context),
  onPlayerTap: (player) => print('Tapped: ${player.name}'),
)
```

---

## Data Models

### FieldCoordinate

Normalized field position — `x` and `y` are in `0.0–100.0`.

```dart
const coord = FieldCoordinate(x: 50, y: 20);
final mirrored = coord.mirrored; // FieldCoordinate(x: 50, y: 80)
```

### SoccerPlayer

```dart
const player = SoccerPlayer(
  id: 'unique_id',
  name: 'Mohamed Salah',
  shirtNumber: 11,
  imageUrl: 'https://example.com/salah.jpg',
  coordinate: FieldCoordinate(x: 80, y: 20),
  metadata: {'position': 'RW', 'rating': 90},
);
```

### SoccerTeam

```dart
const team = SoccerTeam(
  id: 'lfc',
  name: 'Liverpool FC',
  players: [...fieldPlayers, ...benchPlayers],
);
```

### SoccerFormation

```dart
// Built-in
final formation = SoccerFormations.f433;

// Custom at runtime
const myFormation = SoccerFormation(
  id: 'my-formation',
  name: 'My Formation',
  positions: [
    PlayerPosition(id: 'GK', label: 'GK', coordinate: FieldCoordinate(x: 50, y: 90)),
    // ... more positions
  ],
);
```

---

## Controller

```dart
final controller = SoccerLineupController();

controller.setTeam(team);
controller.setOpponentTeam(opponent);
controller.changeFormation(SoccerFormations.f442);

controller.movePlayer('player_id', FieldCoordinate(x: 60, y: 30));
controller.swapPlayers('player_a', 'player_b');
controller.substitutePlayer(fieldPlayerId: 'old', benchPlayerId: 'new');

controller.highlightPlayer('player_id');
controller.highlightPlayers(['id1', 'id2']);
controller.clearHighlights();

controller.setSelectionMode(SelectionMode.multiple);
controller.selectPlayer('player_id');
controller.clearSelection();

controller.setDragDropMode(DragDropMode.swapPlayers);
controller.setFieldDirection(FieldDirection.topToBottom);

final fieldPlayers = controller.getPlayersOnField();
final benchPlayers = controller.getBenchPlayers();
final player = controller.getPlayerById('player_id');
```

---

## Themes

```dart
// Derive from Material 3 context (recommended)
final theme = SoccerLineupThemeData.fromContext(context);

// Full custom theme
final theme = SoccerLineupThemeData(
  fieldStyle: FieldStyle.blueprint,
  fieldPrimaryColor: Color(0xFF0A3D62),
  fieldLineColor: Color(0xFF60A3D9),
  playerColor: Colors.blue,
  playerRadius: 24.0,
  animationConfig: AnimationConfig.position,
);
```

---

## Drag & Drop

```dart
SoccerTeamField(
  controller: controller,
  theme: theme,
  // controller.setDragDropMode(DragDropMode.swapPlayers) enables drag
  onPlayerSwap: (a, b) => print('Swapped: ${a.name} ↔ ${b.name}'),
  onPlayerDropped: (player, coord) => print('Dropped at $coord'),
)
```

---

## Custom Player Builder

```dart
SoccerTeamField(
  controller: controller,
  theme: theme,
  playerBuilder: (context, player, theme) => MyCustomPlayerWidget(
    player: player,
  ),
)
```

---

## Match Lineup View

```dart
MatchLineupView(
  controller: controller,
  theme: SoccerLineupThemeData.fromContext(context),
  mirrorOpponent: true, // opponent appears on upper half
  onPlayerTap: (player, isOpponent) {
    print('${isOpponent ? "Opponent" : "Home"}: ${player.name}');
  },
)
```

---

## Bench View

```dart
BenchPlayersView(
  players: controller.getBenchPlayers(),
  theme: theme,
  layout: BenchLayout.horizontal,
  onPlayerTap: (player) => print('Bench tap: ${player.name}'),
)
```

---

## Utilities

```dart
// Mirror a coordinate
final mirrored = CoordinateUtils.mirrorCoordinate(coord);

// Distance between two coordinates
final dist = CoordinateUtils.distanceBetweenCoordinates(a, b);

// Find nearest player to a tap position
final nearest = CoordinateUtils.nearestPlayer(tapCoord, players);

// Convert pixel position to field coordinate
final fieldCoord = CoordinateUtils.fromPixelOffset(dx, dy, width, height);
```

---

## Example App

See the `example/` directory for a complete Material 3 app with 20 screens
demonstrating every feature:

1. Basic lineup
2. Formation switching
3. Drag & drop
4. Bench substitutions
5. Match lineup (home vs opponent)
6. Custom player widgets
7. Theme customization
8. Player tap callbacks
9. Highlighting
10. Animated transitions
11. Free movement mode
12. Swap mode
13. Custom field background
14. Selection modes
15. Controller API
16. Custom builders
17. Runtime formation creation
18. Mirrored opponent field
19. Light theme
20. Dark theme

---

## License

MIT — see [LICENSE](LICENSE).
