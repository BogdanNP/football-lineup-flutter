import 'package:flutter_soccer_lineup/flutter_soccer_lineup.dart';

/// Shared sample data used across example screens.
abstract final class SampleData {
  /// Creates a sample home team with 11 field players using [formation].
  static SoccerTeam homeTeam(SoccerFormation formation) {
    final names = [
      'Alisson', 'Alexander-Arnold', 'Van Dijk', 'Matip', 'Robertson',
      'Henderson', 'Fabinho', 'Thiago', 'Salah', 'Firmino', 'Mané',
    ];
    final players = List.generate(
      formation.positions.length,
      (i) => SoccerPlayer(
        id: 'home_$i',
        name: names[i % names.length],
        shirtNumber: i + 1,
        coordinate: formation.positions[i].coordinate,
      ),
    );
    return SoccerTeam(
      id: 'home',
      name: 'Liverpool FC',
      players: [
        ...players,
        // Bench players
        SoccerPlayer(
          id: 'home_b1',
          name: 'Keïta',
          shirtNumber: 12,
          isBench: true,
        ),
        SoccerPlayer(
          id: 'home_b2',
          name: 'Jota',
          shirtNumber: 20,
          isBench: true,
        ),
        SoccerPlayer(
          id: 'home_b3',
          name: 'Jones',
          shirtNumber: 17,
          isBench: true,
        ),
        SoccerPlayer(
          id: 'home_b4',
          name: 'Kelleher',
          shirtNumber: 62,
          isBench: true,
        ),
      ],
    );
  }

  /// Creates a sample opponent team with 11 field players using [formation].
  static SoccerTeam opponentTeam(SoccerFormation formation) {
    final names = [
      'De Gea', 'Wan-Bissaka', 'Varane', 'Maguire', 'Shaw',
      'Fred', 'McTominay', 'Pogba', 'Rashford', 'Cavani', 'Greenwood',
    ];
    final players = List.generate(
      formation.positions.length,
      (i) => SoccerPlayer(
        id: 'away_$i',
        name: names[i % names.length],
        shirtNumber: i + 1,
        coordinate: formation.positions[i].coordinate,
      ),
    );
    return SoccerTeam(
      id: 'away',
      name: 'Man United',
      players: [
        ...players,
        SoccerPlayer(id: 'away_b1', name: 'Mata', shirtNumber: 8, isBench: true),
        SoccerPlayer(id: 'away_b2', name: 'Lingard', shirtNumber: 14, isBench: true),
      ],
    );
  }
}
