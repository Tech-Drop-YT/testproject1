// FILE: lib/src/ui/screens/game_setup_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/enums.dart';
import '../../controllers/game_controller.dart';
import 'game_screen.dart';

/// Screen for setting up a new game
class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({Key? key}) : super(key: key);

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  int playerCount = 2;
  final List<TextEditingController> nameControllers = List.generate(
    4,
    (i) => TextEditingController(text: 'Player ${i + 1}'),
  );
  final List<PlayerType> playerTypes = List.generate(4, (i) => i == 0 ? PlayerType.human : PlayerType.bot);
  final List<BotDifficulty> botDifficulties = List.generate(4, (i) => BotDifficulty.medium);

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Game Setup'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Player count selector
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Number of Players',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [2, 3, 4].map((count) {
                          return ChoiceChip(
                            label: Text('$count Players'),
                            selected: playerCount == count,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => playerCount = count);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Player configurations
              ...List.generate(playerCount, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPlayerConfig(index),
                );
              }),

              const SizedBox(height: 24),

              // Start button
              ElevatedButton.icon(
                onPressed: _startGame,
                icon: const Icon(Icons.play_arrow, size: 32),
                label: const Text('START GAME'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerConfig(int index) {
    final colors = [PlayerColor.red, PlayerColor.green, PlayerColor.yellow, PlayerColor.blue];
    final color = colors[index];
    final colorValue = _getColorValue(color);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorValue, width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${color.name.toUpperCase()} PLAYER',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorValue,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameControllers[index],
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<PlayerType>(
                    value: playerTypes[index],
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: PlayerType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => playerTypes[index] = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                if (playerTypes[index] == PlayerType.bot)
                  Expanded(
                    child: DropdownButtonFormField<BotDifficulty>(
                      value: botDifficulties[index],
                      decoration: const InputDecoration(
                        labelText: 'Difficulty',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: BotDifficulty.values.map((difficulty) {
                        return DropdownMenuItem(
                          value: difficulty,
                          child: Text(difficulty.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => botDifficulties[index] = value);
                        }
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorValue(PlayerColor color) {
    const colors = {
      PlayerColor.red: Color(0xFFE53935),
      PlayerColor.green: Color(0xFF43A047),
      PlayerColor.yellow: Color(0xFFFDD835),
      PlayerColor.blue: Color(0xFF1E88E5),
    };
    return colors[color] ?? Colors.grey;
  }

  void _startGame() {
    final gameController = Get.find<GameController>();

    final names = nameControllers
        .take(playerCount)
        .map((c) => c.text.trim().isEmpty ? 'Player' : c.text.trim())
        .toList();

    final types = playerTypes.take(playerCount).toList();
    final difficulties = botDifficulties
        .take(playerCount)
        .toList()
        .asMap()
        .entries
        .map((e) => types[e.key] == PlayerType.bot ? e.value : null)
        .toList();

    gameController.initGame(
      playerCount: playerCount,
      playerNames: names,
      playerTypes: types,
      botDifficulties: difficulties,
    );

    Get.off(() => const GameScreen());
  }
}
