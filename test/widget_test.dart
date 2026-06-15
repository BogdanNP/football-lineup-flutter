import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

SoccerTeam _team(SoccerFormation formation) {
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
  return SoccerTeam(id: 't', name: 'Team', players: players);
}

void main() {
  group('PlayerWidget', () {
    testWidgets('renders circle player', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PlayerWidget(
            player: const SoccerPlayer(
              id: 'p1',
              name: 'Salah',
              shirtNumber: 11,
              coordinate: FieldCoordinate(x: 50, y: 20),
            ),
            theme: const SoccerLineupThemeData(),
          ),
        ),
      );
      expect(find.text('Salah'), findsOneWidget);
      expect(find.text('11'), findsOneWidget);
    });

    testWidgets('renders shirt player', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PlayerWidget(
            player: const SoccerPlayer(
              id: 'p1',
              name: 'Mané',
              shirtNumber: 10,
              coordinate: FieldCoordinate(x: 50, y: 20),
            ),
            theme: const SoccerLineupThemeData(),
            type: PlayerWidgetType.shirt,
          ),
        ),
      );
      expect(find.text('Mané'), findsOneWidget);
    });

    testWidgets('calls onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          PlayerWidget(
            player: const SoccerPlayer(id: 'p1', name: 'A'),
            theme: const SoccerLineupThemeData(),
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.tap(find.byType(PlayerWidget));
      expect(tapped, isTrue);
    });

    testWidgets('uses custom playerBuilder', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PlayerWidget(
            player: const SoccerPlayer(id: 'p1', name: 'Test'),
            theme: const SoccerLineupThemeData(),
            type: PlayerWidgetType.custom,
            playerBuilder: (_, __, ___) =>
                const Text('custom_player_widget'),
          ),
        ),
      );
      expect(find.text('custom_player_widget'), findsOneWidget);
    });
  });

  group('SoccerTeamField', () {
    testWidgets('renders field and players', (tester) async {
      final controller = SoccerLineupController();
      controller.setTeam(_team(SoccerFormations.f433));
      controller.changeFormation(SoccerFormations.f433);

      await tester.pumpWidget(
        _wrap(
          SoccerTeamField(
            controller: controller,
            theme: const SoccerLineupThemeData(
              fieldPrimaryColor: Color(0xFF2D8653),
            ),
          ),
        ),
      );
      await tester.pump();

      // All 11 field players should be visible
      expect(find.byType(PlayerWidget), findsNWidgets(11));
      controller.dispose();
    });

    testWidgets('responds to controller changes', (tester) async {
      final controller = SoccerLineupController();
      controller.setTeam(_team(SoccerFormations.f433));
      controller.changeFormation(SoccerFormations.f433);

      await tester.pumpWidget(
        _wrap(
          SoccerTeamField(
            controller: controller,
            theme: const SoccerLineupThemeData(
              fieldPrimaryColor: Color(0xFF2D8653),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(PlayerWidget), findsNWidgets(11));

      // Change formation - player count stays 11
      controller.changeFormation(SoccerFormations.f442);
      await tester.pump();
      expect(find.byType(PlayerWidget), findsNWidgets(11));

      controller.dispose();
    });
  });

  group('BenchPlayersView', () {
    const benchPlayers = [
      SoccerPlayer(id: 'b1', name: 'Sub1', shirtNumber: 12, isBench: true),
      SoccerPlayer(id: 'b2', name: 'Sub2', shirtNumber: 14, isBench: true),
    ];

    testWidgets('renders bench players in horizontal layout', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BenchPlayersView(
            players: benchPlayers,
            theme: const SoccerLineupThemeData(),
            layout: BenchLayout.horizontal,
          ),
        ),
      );
      expect(find.text('Sub1'), findsOneWidget);
      expect(find.text('Sub2'), findsOneWidget);
    });

    testWidgets('calls onPlayerTap', (tester) async {
      SoccerPlayer? tapped;
      await tester.pumpWidget(
        _wrap(
          SizedBox(
            height: 200,
            child: BenchPlayersView(
              players: benchPlayers,
              theme: const SoccerLineupThemeData(),
              onPlayerTap: (p) => tapped = p,
            ),
          ),
        ),
      );
      await tester.tap(find.text('Sub1'));
      expect(tapped?.id, 'b1');
    });

    testWidgets('uses custom benchBuilder', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BenchPlayersView(
            players: benchPlayers,
            theme: const SoccerLineupThemeData(),
            benchBuilder: (_, __, ___) =>
                const Text('custom_bench'),
          ),
        ),
      );
      expect(find.text('custom_bench'), findsOneWidget);
    });
  });

  group('MatchLineupView', () {
    testWidgets('renders both teams', (tester) async {
      final controller = SoccerLineupController();
      controller.setTeam(_team(SoccerFormations.f433));
      controller.setOpponentTeam(_team(SoccerFormations.f442));
      controller.changeFormation(SoccerFormations.f433);
      controller.changeOpponentFormation(SoccerFormations.f442);

      await tester.pumpWidget(
        _wrap(
          MatchLineupView(
            controller: controller,
            theme: const SoccerLineupThemeData(
              fieldPrimaryColor: Color(0xFF2D8653),
            ),
          ),
        ),
      );
      await tester.pump();
      // 11 home + 11 away = 22 player widgets
      expect(find.byType(PlayerWidget), findsNWidgets(22));
      controller.dispose();
    });
  });
}
