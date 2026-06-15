import 'package:flutter/material.dart';

import '../screens/basic_lineup_screen.dart';
import '../screens/formation_switching_screen.dart';
import '../screens/drag_drop_screen.dart';
import '../screens/bench_substitutions_screen.dart';
import '../screens/match_lineup_screen.dart';
import '../screens/custom_player_widgets_screen.dart';
import '../screens/theme_customization_screen.dart';
import '../screens/player_tap_callbacks_screen.dart';
import '../screens/highlighting_screen.dart';
import '../screens/animated_transitions_screen.dart';
import '../screens/free_movement_screen.dart';
import '../screens/swap_mode_screen.dart';
import '../screens/custom_field_screen.dart';
import '../screens/selection_modes_screen.dart';
import '../screens/controller_api_screen.dart';
import '../screens/custom_builders_screen.dart';
import '../screens/runtime_formation_screen.dart';
import '../screens/mirrored_opponent_screen.dart';
import '../screens/full_flow_screen.dart';
import '../screens/light_dark_theme_screen.dart';

/// The home screen listing all example demonstrations.
class HomeScreen extends StatelessWidget {
  /// Creates the [HomeScreen].
  const HomeScreen({super.key, required this.onToggleTheme});

  /// Callback to toggle light/dark mode.
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Lineup Examples'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Toggle theme',
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        children: [
          _section(context, 'Basic'),
          _tile(context, '1. Basic Lineup', const BasicLineupScreen()),
          _tile(context, '2. Formation Switching',
              const FormationSwitchingScreen()),
          _tile(context, '3. Drag & Drop', const DragDropScreen()),
          _tile(
              context, '4. Bench Substitutions', const BenchSubstitutionsScreen()),
          _tile(context, '5. Match Lineup (Home vs Away)',
              const MatchLineupScreen()),
          _section(context, 'Customization'),
          _tile(context, '6. Custom Player Widgets',
              const CustomPlayerWidgetsScreen()),
          _tile(context, '7. Theme Customization',
              const ThemeCustomizationScreen()),
          _tile(context, '8. Player Tap Callbacks',
              const PlayerTapCallbacksScreen()),
          _tile(context, '9. Highlighting Players', const HighlightingScreen()),
          _tile(context, '10. Animated Transitions',
              const AnimatedTransitionsScreen()),
          _section(context, 'Interaction'),
          _tile(context, '11. Free Movement Mode', const FreeMovementScreen()),
          _tile(context, '12. Swap Mode', const SwapModeScreen()),
          _tile(
              context, '13. Custom Field Background', const CustomFieldScreen()),
          _tile(context, '14. Selection Modes', const SelectionModesScreen()),
          _section(context, 'Advanced'),
          _tile(
              context, '15. Controller API', const ControllerApiScreen()),
          _tile(context, '16. Custom Builders', const CustomBuildersScreen()),
          _tile(
              context,
              '17. Runtime Formation Creation',
              const RuntimeFormationScreen()),
          _tile(context, '18. Mirrored Opponent Field',
              const MirroredOpponentScreen()),
          _tile(context, '19. Light Theme', const LightDarkThemeScreen(isDark: false)),
          _tile(
              context, '20. Dark Theme', const LightDarkThemeScreen(isDark: true)),
          _section(context, 'Full Flow'),
          _tile(context, '21. Full Flow Demo', const FullFlowScreen()),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _tile(BuildContext context, String title, Widget screen) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => screen),
      ),
    );
  }
}
