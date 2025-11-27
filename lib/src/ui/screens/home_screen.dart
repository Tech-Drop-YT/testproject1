// FILE: lib/src/ui/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/enums.dart';
import '../../controllers/theme_controller.dart';
import 'game_setup_screen.dart';

/// Home screen with menu options
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Title
                const Icon(
                  Icons.casino,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'LUDO',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 8,
                  ),
                ),
                const Text(
                  'DUAL DICE',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 60),

                // Menu buttons
                _MenuButton(
                  icon: Icons.play_arrow,
                  label: 'NEW GAME',
                  onPressed: () => Get.to(() => const GameSetupScreen()),
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.lightbulb_outline,
                  label: 'HOW TO PLAY',
                  onPressed: () => _showRules(context),
                ),
                const SizedBox(height: 16),
                Obx(() => _MenuButton(
                      icon: themeController.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      label: themeController.isDarkMode
                          ? 'LIGHT MODE'
                          : 'DARK MODE',
                      onPressed: () => themeController.toggleTheme(),
                    )),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.info_outline,
                  label: 'ABOUT',
                  onPressed: () => _showAbout(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRules(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Play'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '🎲 DUAL DICE SYSTEM\n'
                'Each turn rolls TWO dice automatically.\n\n'
                '🎯 MOVEMENT OPTIONS\n'
                '• Use sum of both dice on one token\n'
                '• Use each die separately on one token\n'
                '• Move two different tokens (one per die)\n\n'
                '⭐ EXTRA TURN RULES\n'
                '• Single 6 → 1 extra turn\n'
                '• Double 6 → 2 extra turns\n'
                '• Triple 6 → Turn cancelled!\n'
                '• Kill opponent → Extra turn\n'
                '• Enter home path → Extra turn\n'
                '• Reach final home → Extra turn\n\n'
                '🏠 RELEASE TOKENS\n'
                'Need a 6 to release tokens from home.\n\n'
                '⚔️ KILL & BLOCK\n'
                '• Land on opponent to send them home\n'
                '• Two same-color tokens block path\n\n'
                '🏆 WIN CONDITION\n'
                'First to get all 4 tokens home wins!',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('GOT IT'),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: const Text(
          'Ludo Dual Dice v1.0.0\n\n'
          'A modern, fully functional offline Ludo game with dual dice mechanics.\n\n'
          'Features:\n'
          '• Dual dice system\n'
          '• Professional Ludo Pro rules\n'
          '• 2-4 players\n'
          '• Bot opponents (Easy/Medium/Hard)\n'
          '• Beautiful animations\n'
          '• Light/Dark mode\n\n'
          'Built with Flutter & GetX',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
        ),
      ),
    );
  }
}
