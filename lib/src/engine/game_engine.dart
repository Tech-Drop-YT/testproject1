// FILE: lib/src/engine/game_engine.dart

import 'dart:math';
import '../models/models.dart';

/// Core game engine for Ludo with dual dice mechanics
/// Handles all game logic separately from UI
class LudoGameEngine {
  final Random _random = Random();

  // Board constants
  static const int totalBoardSquares = 52;
  static const int homePathLength = 6;
  static const int tokensPerPlayer = 4;

  // Safe squares on the board (0-indexed)
  static const Set<int> safeSquares = {
    1, 9, 14, 22, 27, 35, 40, 48, // Starting positions and their +8 positions
  };

  // Star squares (bonus squares)
  static const Set<int> starSquares = {
    5, 18, 31, 44, // Middle of each side
  };

  /// Roll both dice
  DiceResult rollDice() {
    final dice1 = _random.nextInt(6) + 1;
    final dice2 = _random.nextInt(6) + 1;
    return DiceResult(
      dice1: dice1,
      dice2: dice2,
      timestamp: DateTime.now(),
    );
  }

  /// Get all valid moves for current player based on dice result
  List<Move> getValidMoves(
    Player player,
    DiceResult diceResult,
    List<Player> allPlayers,
  ) {
    final moves = <Move>[];

    // Check each token
    for (final token in player.tokens) {
      if (token.hasFinished) continue;

      // If token is at home, can only release with a 6
      if (token.isAtHome) {
        if (diceResult.hasAnySix) {
          final releaseMove = _createReleaseMove(token, player, allPlayers);
          if (releaseMove != null) moves.add(releaseMove);
        }
        continue;
      }

      // Token is on board - try all move options
      // Option 1: Use sum of both dice
      final sumMove = _createMove(token, diceResult.sum, player, allPlayers);
      if (sumMove != null) moves.add(sumMove);

      // Option 2: Use only dice1
      final dice1Move = _createMove(token, diceResult.dice1, player, allPlayers);
      if (dice1Move != null && !_isDuplicateMove(dice1Move, moves)) {
        moves.add(dice1Move);
      }

      // Option 3: Use only dice2
      final dice2Move = _createMove(token, diceResult.dice2, player, allPlayers);
      if (dice2Move != null && !_isDuplicateMove(dice2Move, moves)) {
        moves.add(dice2Move);
      }
    }

    return moves;
  }

  /// Check if a move is duplicate
  bool _isDuplicateMove(Move move, List<Move> existingMoves) {
    return existingMoves.any((m) =>
        m.token == move.token &&
        m.targetPosition == move.targetPosition &&
        m.steps == move.steps);
  }

  /// Create a move for releasing a token from home
  Move? _createReleaseMove(
    Token token,
    Player player,
    List<Player> allPlayers,
  ) {
    final startPos = player.startPosition;

    // Check if starting position is blocked by own tokens
    if (_isBlockedByOwnTokens(startPos, player)) {
      return null;
    }

    // Check if there's an opponent token at start position
    final opponentToken = _getTokenAtPosition(startPos, allPlayers, player.color);
    final willKill = opponentToken != null && !_isSafeSquare(startPos);

    return Move(
      token: token,
      steps: 0, // Release is not counted as steps
      targetPosition: startPos,
      targetState: TokenState.active,
      willKill: willKill,
      killedToken: opponentToken,
    );
  }

  /// Create a move for a token
  Move? _createMove(
    Token token,
    int steps,
    Player player,
    List<Player> allPlayers,
  ) {
    if (steps <= 0) return null;

    // Calculate target position
    final result = _calculateTargetPosition(token, steps, player);
    if (result == null) return null;

    final targetPosition = result['position'] as int?;
    final targetState = result['state'] as TokenState;
    final entersHomePath = result['entersHomePath'] as bool;
    final reachesFinalHome = result['reachesFinalHome'] as bool;

    // If moving in home path or finishing, always valid
    if (targetState == TokenState.homePath || targetState == TokenState.finished) {
      return Move(
        token: token,
        steps: steps,
        targetPosition: targetPosition,
        targetState: targetState,
        entersHomePath: entersHomePath,
        reachesFinalHome: reachesFinalHome,
      );
    }

    // Check if blocked by own tokens
    if (_isBlockedByOwnTokens(targetPosition!, player)) {
      return null;
    }

    // Check for opponent token
    final opponentToken = _getTokenAtPosition(targetPosition, allPlayers, player.color);
    final willKill = opponentToken != null && !_isSafeSquare(targetPosition);

    return Move(
      token: token,
      steps: steps,
      targetPosition: targetPosition,
      targetState: targetState,
      willKill: willKill,
      killedToken: opponentToken,
      entersHomePath: entersHomePath,
      reachesFinalHome: reachesFinalHome,
    );
  }

  /// Calculate target position for a token move
  Map<String, dynamic>? _calculateTargetPosition(
    Token token,
    int steps,
    Player player,
  ) {
    if (token.isAtHome) return null;

    // If token is in home path
    if (token.isInHomePath) {
      final newPos = token.position! + steps;
      if (newPos > homePathLength) return null; // Overshoot

      if (newPos == homePathLength) {
        // Reached final home
        return {
          'position': null,
          'state': TokenState.finished,
          'entersHomePath': false,
          'reachesFinalHome': true,
        };
      } else {
        // Still in home path
        return {
          'position': newPos,
          'state': TokenState.homePath,
          'entersHomePath': false,
          'reachesFinalHome': false,
        };
      }
    }

    // Token is on main board
    final currentPos = token.position!;
    final homeEntry = player.homeEntryPosition;

    // Calculate new position with wrapping
    int newPos = (currentPos + steps) % totalBoardSquares;

    // Check if token should enter home path
    final crossedHomeEntry = _crossesHomeEntry(currentPos, steps, homeEntry);

    if (crossedHomeEntry) {
      // Calculate position in home path
      final stepsAfterHomeEntry = _getStepsAfterHomeEntry(currentPos, steps, homeEntry);

      if (stepsAfterHomeEntry > homePathLength) {
        return null; // Overshoot
      }

      if (stepsAfterHomeEntry == homePathLength) {
        // Reached final home
        return {
          'position': null,
          'state': TokenState.finished,
          'entersHomePath': true,
          'reachesFinalHome': true,
        };
      } else {
        // Entered home path
        return {
          'position': stepsAfterHomeEntry,
          'state': TokenState.homePath,
          'entersHomePath': true,
          'reachesFinalHome': false,
        };
      }
    }

    // Normal move on board
    return {
      'position': newPos,
      'state': TokenState.active,
      'entersHomePath': false,
      'reachesFinalHome': false,
    };
  }

  /// Check if move crosses home entry
  bool _crossesHomeEntry(int currentPos, int steps, int homeEntry) {
    for (int i = 1; i <= steps; i++) {
      final pos = (currentPos + i) % totalBoardSquares;
      if (pos == homeEntry) return true;
    }
    return false;
  }

  /// Get steps after crossing home entry
  int _getStepsAfterHomeEntry(int currentPos, int steps, int homeEntry) {
    int stepsToHome = 0;
    for (int i = 1; i <= steps; i++) {
      final pos = (currentPos + i) % totalBoardSquares;
      if (pos == homeEntry) {
        stepsToHome = steps - i;
        break;
      }
    }
    return stepsToHome;
  }

  /// Check if position is blocked by player's own tokens (2 tokens form a block)
  bool _isBlockedByOwnTokens(int position, Player player) {
    final tokensAtPos = player.tokens
        .where((t) => t.isOnBoard && t.position == position)
        .length;
    return tokensAtPos >= 2; // Two tokens form an unbreakable block
  }

  /// Get opponent token at position (returns null if safe or no token)
  Token? _getTokenAtPosition(
    int position,
    List<Player> allPlayers,
    PlayerColor excludeColor,
  ) {
    for (final player in allPlayers) {
      if (player.color == excludeColor) continue;

      for (final token in player.tokens) {
        if (token.isOnBoard && token.position == position) {
          return token;
        }
      }
    }
    return null;
  }

  /// Check if square is safe
  bool _isSafeSquare(int position) {
    return safeSquares.contains(position);
  }

  /// Execute a move and return updated game state
  LudoGameState executeMove(
    LudoGameState gameState,
    Move move,
  ) {
    final players = List<Player>.from(gameState.players);
    final currentPlayer = players[gameState.currentPlayerIndex];

    // Find and update the token
    final tokenIndex = currentPlayer.tokens.indexOf(move.token);
    final token = currentPlayer.tokens[tokenIndex];

    // Handle kill
    if (move.willKill && move.killedToken != null) {
      _killToken(players, move.killedToken!);
    }

    // Update token position
    if (move.targetState == TokenState.finished) {
      token.finish();
    } else if (move.targetState == TokenState.homePath) {
      token.enterHomePath(move.targetPosition!);
    } else if (move.targetState == TokenState.active) {
      if (token.isAtHome) {
        token.release(move.targetPosition!);
      } else {
        token.moveTo(move.targetPosition!, TokenState.active);
      }
    }

    // Calculate extra turns
    final extraTurnReasons = <ExtraTurnReason>[];

    // Check for 6-based extra turns
    if (gameState.lastDiceResult != null) {
      if (gameState.lastDiceResult!.isSingleSix) {
        extraTurnReasons.add(ExtraTurnReason.singleSix);
      } else if (gameState.lastDiceResult!.isDoubleSix) {
        extraTurnReasons.add(ExtraTurnReason.doubleSix);
        extraTurnReasons.add(ExtraTurnReason.doubleSix); // 2 extra turns
      }
    }

    // Check for move-based extra turns
    if (move.willKill) {
      extraTurnReasons.add(ExtraTurnReason.kill);
    }
    if (move.entersHomePath && !move.reachesFinalHome) {
      extraTurnReasons.add(ExtraTurnReason.homeEntry);
    }
    if (move.reachesFinalHome) {
      extraTurnReasons.add(ExtraTurnReason.finalHome);
    }

    // Check for triple 6 - cancels all bonuses
    final updatedSixHistory = List<DiceResult>.from(gameState.sixHistory);
    if (gameState.lastDiceResult?.isDoubleSix == true) {
      updatedSixHistory.add(gameState.lastDiceResult!);
    } else {
      updatedSixHistory.clear(); // Reset if not double 6
    }

    final hasTripleSix = _checkTripleSix(updatedSixHistory);
    if (hasTripleSix) {
      // Triple 6 cancels all extra turns
      extraTurnReasons.clear();
      updatedSixHistory.clear();
    }

    // Update current player's extra turns
    currentPlayer.extraTurns = extraTurnReasons.length;

    // Check for winner
    Player? winner;
    if (currentPlayer.hasWon) {
      winner = currentPlayer;
    }

    return gameState.copyWith(
      players: players,
      diceRolled: false,
      availableMoves: [],
      extraTurnReasons: extraTurnReasons,
      winner: winner,
      state: winner != null ? GameState.finished : GameState.playing,
      sixHistory: updatedSixHistory,
      clearDiceResult: true,
    );
  }

  /// Check for triple 6 in history
  bool _checkTripleSix(List<DiceResult> history) {
    if (history.length < 3) return false;
    final last3 = history.skip(history.length - 3).toList();
    return last3.every((r) => r.isDoubleSix);
  }

  /// Kill a token (send it back home)
  void _killToken(List<Player> players, Token token) {
    for (final player in players) {
      final index = player.tokens.indexWhere((t) => t.id == token.id);
      if (index != -1) {
        player.tokens[index].resetToHome();
        break;
      }
    }
  }

  /// Advance to next turn
  LudoGameState advanceTurn(LudoGameState gameState) {
    final currentPlayer = gameState.currentPlayer;

    // Check if player has extra turns
    if (currentPlayer.hasExtraTurns) {
      currentPlayer.useExtraTurn();
      return gameState.copyWith(
        players: gameState.players,
        diceRolled: false,
        availableMoves: [],
        clearDiceResult: true,
        clearExtraTurnReasons: true,
      );
    }

    // Move to next player
    final nextIndex = gameState.nextPlayerIndex;
    return gameState.copyWith(
      currentPlayerIndex: nextIndex,
      diceRolled: false,
      availableMoves: [],
      turnCount: gameState.turnCount + 1,
      clearDiceResult: true,
      clearExtraTurnReasons: true,
    );
  }

  /// Process dice roll and update game state
  LudoGameState processDiceRoll(LudoGameState gameState) {
    final diceResult = rollDice();
    final currentPlayer = gameState.currentPlayer;

    // Get valid moves
    final moves = getValidMoves(currentPlayer, diceResult, gameState.players);

    // Update six history
    final updatedSixHistory = List<DiceResult>.from(gameState.sixHistory);
    if (diceResult.isDoubleSix) {
      updatedSixHistory.add(diceResult);
    } else {
      updatedSixHistory.clear();
    }

    return gameState.copyWith(
      lastDiceResult: diceResult,
      diceRolled: true,
      availableMoves: moves,
      sixHistory: updatedSixHistory,
    );
  }

  /// Check if player can roll (includes extra turn logic)
  bool canPlayerRoll(LudoGameState gameState) {
    return gameState.isPlaying && !gameState.diceRolled;
  }

  /// Auto-pass turn if no valid moves
  LudoGameState autoPassIfNoMoves(LudoGameState gameState) {
    if (gameState.shouldPassTurn) {
      // No valid moves, even with a 6 - no extra turn
      return advanceTurn(gameState);
    }
    return gameState;
  }
}
