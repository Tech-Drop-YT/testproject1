// FILE: lib/src/controllers/game_controller.dart

import 'package:get/get.dart';
import '../models/models.dart';
import '../engine/game_engine.dart';
import '../services/audio_service.dart';

/// Main game controller using GetX
class GameController extends GetxController {
  final LudoGameEngine _engine = LudoGameEngine();
  final AudioService _audioService = Get.find<AudioService>();

  // Observable game state
  final Rx<LudoGameState?> _gameState = Rx<LudoGameState?>(null);
  LudoGameState? get gameState => _gameState.value;

  // UI state
  final RxBool isRolling = false.obs;
  final RxBool isMoving = false.obs;
  final RxString message = ''.obs;
  final RxList<Move> selectedMoves = <Move>[].obs;

  // Getters
  Player? get currentPlayer => gameState?.currentPlayer;
  DiceResult? get lastDiceResult => gameState?.lastDiceResult;
  List<Move> get availableMoves => gameState?.availableMoves ?? [];
  bool get canRollDice => gameState?.canRollDice ?? false;
  bool get canMove => gameState?.canMove ?? false;
  List<Player> get players => gameState?.players ?? [];
  Player? get winner => gameState?.winner;
  bool get isGameFinished => gameState?.isFinished ?? false;

  /// Initialize a new game
  void initGame({
    required int playerCount,
    required List<String> playerNames,
    required List<PlayerType> playerTypes,
    List<BotDifficulty?>? botDifficulties,
  }) {
    // Create players
    final colors = [
      PlayerColor.red,
      PlayerColor.green,
      PlayerColor.yellow,
      PlayerColor.blue,
    ];

    final playerList = <Player>[];
    for (int i = 0; i < playerCount; i++) {
      final player = Player(
        id: 'player_$i',
        name: playerNames[i],
        color: colors[i],
        type: playerTypes[i],
        botDifficulty: botDifficulties?[i],
      );
      playerList.add(player);
    }

    // Create initial game state
    _gameState.value = LudoGameState.initial(players: playerList);
    message.value = '${currentPlayer?.name}\'s turn - Roll the dice!';

    // Auto-roll for bot if first player is bot
    if (currentPlayer?.isBot ?? false) {
      Future.delayed(const Duration(milliseconds: 500), () {
        rollDice();
      });
    }
  }

  /// Roll both dice
  Future<void> rollDice() async {
    if (!canRollDice || isRolling.value) return;

    isRolling.value = true;
    message.value = 'Rolling dice...';

    // Play sound
    _audioService.playDiceRoll();

    // Simulate dice roll animation
    await Future.delayed(const Duration(milliseconds: 800));

    // Process dice roll
    final newState = _engine.processDiceRoll(gameState!);
    _gameState.value = newState;

    isRolling.value = false;

    // Check for triple 6
    if (newState.hasTripleSix) {
      message.value = 'Triple 6! Your turn is cancelled!';
      await Future.delayed(const Duration(milliseconds: 2000));
      passTurn();
      return;
    }

    // Update message
    if (availableMoves.isEmpty) {
      message.value = 'No valid moves! Turn passed.';
      await Future.delayed(const Duration(milliseconds: 1500));
      passTurn();
    } else {
      final dice = lastDiceResult!;
      message.value = 'Rolled ${dice.dice1} and ${dice.dice2} - Select a token!';

      // Auto-play for bot
      if (currentPlayer?.isBot ?? false) {
        await Future.delayed(const Duration(milliseconds: 1000));
        _executeBotMove();
      }
    }
  }

  /// Execute a move
  Future<void> executeMove(Move move) async {
    if (!canMove || isMoving.value) return;

    isMoving.value = true;
    message.value = 'Moving token...';

    // Play sound
    _audioService.playTokenMove();

    // Simulate token movement animation
    await Future.delayed(const Duration(milliseconds: 500));

    // Handle kill sound
    if (move.willKill) {
      _audioService.playKill();
    }

    // Execute move
    final newState = _engine.executeMove(gameState!, move);
    _gameState.value = newState;

    isMoving.value = false;

    // Check for winner
    if (newState.winner != null) {
      message.value = '${newState.winner!.name} wins! 🎉';
      _audioService.playWin();
      return;
    }

    // Handle extra turns
    if (newState.extraTurnReasons.isNotEmpty) {
      final extraTurnMsg = _getExtraTurnMessage(newState.extraTurnReasons);
      message.value = extraTurnMsg;
      await Future.delayed(const Duration(milliseconds: 1500));
      message.value = '${currentPlayer?.name}\'s turn - Roll again!';

      // Auto-roll for bot
      if (currentPlayer?.isBot ?? false) {
        await Future.delayed(const Duration(milliseconds: 500));
        rollDice();
      }
    } else {
      // Advance to next player
      passTurn();
    }
  }

  /// Pass turn to next player
  void passTurn() {
    final newState = _engine.advanceTurn(gameState!);
    _gameState.value = newState;
    message.value = '${currentPlayer?.name}\'s turn - Roll the dice!';

    // Auto-roll for bot
    if (currentPlayer?.isBot ?? false) {
      Future.delayed(const Duration(milliseconds: 800), () {
        rollDice();
      });
    }
  }

  /// Execute bot move
  Future<void> _executeBotMove() async {
    if (availableMoves.isEmpty) return;

    final player = currentPlayer;
    if (player == null || !player.isBot) return;

    // Select best move based on difficulty
    Move selectedMove;

    if (player.botDifficulty == BotDifficulty.easy) {
      // Easy: Random move
      selectedMove = availableMoves[DateTime.now().millisecond % availableMoves.length];
    } else {
      // Medium/Hard: Calculate best move
      double bestScore = -1;
      selectedMove = availableMoves.first;

      for (final move in availableMoves) {
        final score = _calculateMoveScore(move, player);
        if (score > bestScore) {
          bestScore = score;
          selectedMove = move;
        }
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));
    executeMove(selectedMove);
  }

  /// Calculate move score for bot AI
  double _calculateMoveScore(Move move, Player player) {
    double score = 0;

    final difficulty = player.botDifficulty ?? BotDifficulty.medium;

    switch (difficulty) {
      case BotDifficulty.easy:
        score = move.steps.toDouble();
        break;

      case BotDifficulty.medium:
        if (move.willKill) score += 50;
        if (move.entersHomePath) score += 30;
        if (move.reachesFinalHome) score += 100;
        if (move.token.isAtHome) score += 15;
        score += move.steps * 2;
        break;

      case BotDifficulty.hard:
        if (move.willKill) score += 80;
        if (move.entersHomePath) score += 40;
        if (move.reachesFinalHome) score += 150;
        if (move.token.isAtHome) score += 25;
        if (move.targetState == TokenState.active) {
          // Prefer moving tokens that are further along
          score += (move.targetPosition ?? 0) * 0.5;
        }
        score += move.steps * 3;
        break;
    }

    return score;
  }

  /// Get extra turn message
  String _getExtraTurnMessage(List<ExtraTurnReason> reasons) {
    if (reasons.isEmpty) return '';

    final count = reasons.length;
    final descriptions = reasons.map((r) => r.description).join(', ');

    return '$descriptions - $count extra ${count == 1 ? 'turn' : 'turns'}!';
  }

  /// Reset game
  void resetGame() {
    _gameState.value = null;
    message.value = '';
    selectedMoves.clear();
    isRolling.value = false;
    isMoving.value = false;
  }

  /// Pause game
  void pauseGame() {
    if (gameState != null) {
      _gameState.value = gameState!.copyWith(state: GameState.paused);
    }
  }

  /// Resume game
  void resumeGame() {
    if (gameState != null) {
      _gameState.value = gameState!.copyWith(state: GameState.playing);
    }
  }

  @override
  void onClose() {
    _gameState.close();
    super.onClose();
  }
}
