// FILE: lib/src/ui/screens/game_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/game_controller.dart';
import '../../utils/constants.dart';
import '../widgets/board_widget.dart';
import '../widgets/dice_widget.dart';

/// Main game screen
class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ludo Dual Dice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _showResetDialog(context, controller),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final gameState = controller.gameState;
          if (gameState == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Current player indicator
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Column(
                  children: [
                    Text(
                      controller.currentPlayer?.name ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: GameConstants.playerColors[
                            controller.currentPlayer?.color],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                          controller.message.value,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),

              // Game board
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: BoardWidget(
                        players: controller.players,
                        availableMoves: controller.availableMoves,
                        onMoveSelected: (move) => controller.executeMove(move),
                      ),
                    ),
                  ),
                ),
              ),

              // Dice area
              Container(
                padding: const EdgeInsets.all(24),
                child: Obx(() {
                  final diceResult = controller.lastDiceResult;
                  return DualDiceWidget(
                    dice1Value: diceResult?.dice1 ?? 1,
                    dice2Value: diceResult?.dice2 ?? 1,
                    isRolling: controller.isRolling.value,
                    onRoll: controller.canRollDice ? () => controller.rollDice() : null,
                    enabled: controller.canRollDice,
                  );
                }),
              ),

              // Player status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.players.map((player) {
                    return _buildPlayerStatus(player);
                  }).toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPlayerStatus(player) {
    final color = GameConstants.playerColors[player.color] ?? Colors.grey;
    final isCurrentPlayer = Get.find<GameController>().currentPlayer == player;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrentPlayer ? color : Colors.transparent,
          width: 3,
        ),
      ),
      child: Column(
        children: [
          Text(
            player.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isCurrentPlayer ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home, size: 12, color: color),
              const SizedBox(width: 2),
              Text(
                '${player.finishedTokens}/4',
                style: TextStyle(fontSize: 12, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, GameController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Game?'),
        content: const Text('Are you sure you want to start a new game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Get.back();
              controller.resetGame();
            },
            child: const Text('RESET'),
          ),
        ],
      ),
    );
  }
}
