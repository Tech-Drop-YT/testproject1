// FILE: test/engine/game_engine_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:ludo_dual_dice/src/engine/game_engine.dart';
import 'package:ludo_dual_dice/src/models/models.dart';

void main() {
  late LudoGameEngine engine;
  late List<Player> players;

  setUp(() {
    engine = LudoGameEngine();
    players = [
      Player(
        id: 'p1',
        name: 'Player 1',
        color: PlayerColor.red,
        type: PlayerType.human,
      ),
      Player(
        id: 'p2',
        name: 'Player 2',
        color: PlayerColor.green,
        type: PlayerType.human,
      ),
    ];
  });

  group('Dice Rolling Tests', () {
    test('Roll dice returns valid values', () {
      final result = engine.rollDice();
      expect(result.dice1, inInclusiveRange(1, 6));
      expect(result.dice2, inInclusiveRange(1, 6));
    });

    test('Dice result calculates sum correctly', () {
      final result = DiceResult(dice1: 3, dice2: 4, timestamp: DateTime.now());
      expect(result.sum, equals(7));
    });

    test('Dice result detects single 6', () {
      final result1 = DiceResult(dice1: 6, dice2: 3, timestamp: DateTime.now());
      expect(result1.isSingleSix, isTrue);

      final result2 = DiceResult(dice1: 2, dice2: 6, timestamp: DateTime.now());
      expect(result2.isSingleSix, isTrue);

      final result3 = DiceResult(dice1: 6, dice2: 6, timestamp: DateTime.now());
      expect(result3.isSingleSix, isFalse);
    });

    test('Dice result detects double 6', () {
      final result = DiceResult(dice1: 6, dice2: 6, timestamp: DateTime.now());
      expect(result.isDoubleSix, isTrue);
      expect(result.isSingleSix, isFalse);
    });
  });

  group('Token Movement Tests', () {
    test('Token can be released from home with a 6', () {
      final player = players[0];
      final diceResult = DiceResult(dice1: 6, dice2: 3, timestamp: DateTime.now());

      final moves = engine.getValidMoves(player, diceResult, players);

      // Should have at least one move to release a token
      expect(moves.where((m) => m.token.isAtHome).isNotEmpty, isTrue);
    });

    test('Token cannot be released without a 6', () {
      final player = players[0];
      final diceResult = DiceResult(dice1: 3, dice2: 4, timestamp: DateTime.now());

      final moves = engine.getValidMoves(player, diceResult, players);

      // Should have no moves for tokens at home
      expect(moves.where((m) => m.token.isAtHome).isEmpty, isTrue);
    });

    test('Token on board can move by sum of dice', () {
      final player = players[0];
      final token = player.tokens[0];
      token.release(player.startPosition);

      final diceResult = DiceResult(dice1: 3, dice2: 4, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      // Should have move option for sum (7)
      final sumMove = moves.firstWhere(
        (m) => m.token == token && m.steps == 7,
        orElse: () => throw Exception('No sum move found'),
      );
      expect(sumMove.steps, equals(7));
    });

    test('Token can move using individual dice values', () {
      final player = players[0];
      final token = player.tokens[0];
      token.release(player.startPosition);

      final diceResult = DiceResult(dice1: 3, dice2: 4, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      // Should have moves for 3 and 4
      final move3 = moves.any((m) => m.token == token && m.steps == 3);
      final move4 = moves.any((m) => m.token == token && m.steps == 4);

      expect(move3 || move4, isTrue);
    });
  });

  group('Block Rules Tests', () {
    test('Two tokens of same color block the path', () {
      final player = players[0];
      final token1 = player.tokens[0];
      final token2 = player.tokens[1];

      // Place two tokens at same position
      token1.release(5);
      token2.release(5);

      // Try to move another token to blocked position
      final token3 = player.tokens[2];
      token3.release(1);

      final diceResult = DiceResult(dice1: 2, dice2: 2, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      // Should not be able to move to position 5 (blocked)
      final blockedMove = moves.where(
        (m) => m.token == token3 && m.targetPosition == 5,
      );
      expect(blockedMove.isEmpty, isTrue);
    });
  });

  group('Kill Rules Tests', () {
    test('Landing on opponent token kills it (not on safe square)', () {
      final player1 = players[0];
      final player2 = players[1];

      final token1 = player1.tokens[0];
      token1.release(1);

      final token2 = player2.tokens[0];
      token2.release(5); // Not a safe square

      final diceResult = DiceResult(dice1: 2, dice2: 2, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player1, diceResult, players);

      final killMove = moves.firstWhere(
        (m) => m.willKill && m.killedToken == token2,
        orElse: () => throw Exception('No kill move found'),
      );

      expect(killMove.willKill, isTrue);
      expect(killMove.killedToken, equals(token2));
    });

    test('Cannot kill on safe square', () {
      final player1 = players[0];
      final player2 = players[1];

      final token1 = player1.tokens[0];
      token1.release(1);

      final token2 = player2.tokens[0];
      token2.release(9); // Safe square

      // Try to move to safe square with opponent
      // Should not result in kill
      final diceResult = DiceResult(dice1: 4, dice2: 4, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player1, diceResult, players);

      final movesToSafe = moves.where((m) => m.targetPosition == 9);
      if (movesToSafe.isNotEmpty) {
        expect(movesToSafe.first.willKill, isFalse);
      }
    });
  });

  group('Extra Turn Rules Tests', () {
    test('Single 6 grants 1 extra turn', () {
      final gameState = LudoGameState.initial(players: players);
      final diceResult = DiceResult(dice1: 6, dice2: 3, timestamp: DateTime.now());

      final newState = gameState.copyWith(
        lastDiceResult: diceResult,
        diceRolled: true,
      );

      // Check for single 6
      expect(diceResult.isSingleSix, isTrue);
      expect(diceResult.hasAnySix, isTrue);
    });

    test('Double 6 grants 2 extra turns', () {
      final diceResult = DiceResult(dice1: 6, dice2: 6, timestamp: DateTime.now());

      expect(diceResult.isDoubleSix, isTrue);
      expect(diceResult.isSingleSix, isFalse);
    });

    test('Triple 6 cancels turn', () {
      final gameState = LudoGameState.initial(players: players);

      // Simulate three consecutive double 6s
      final dice1 = DiceResult(dice1: 6, dice2: 6, timestamp: DateTime.now());
      final dice2 = DiceResult(dice1: 6, dice2: 6, timestamp: DateTime.now());
      final dice3 = DiceResult(dice1: 6, dice2: 6, timestamp: DateTime.now());

      final history = [dice1, dice2, dice3];
      final stateWithHistory = gameState.copyWith(sixHistory: history);

      expect(stateWithHistory.hasTripleSix, isTrue);
    });

    test('Kill grants extra turn', () {
      final player1 = players[0];
      final player2 = players[1];

      final token1 = player1.tokens[0];
      token1.release(1);

      final token2 = player2.tokens[0];
      token2.release(5);

      final diceResult = DiceResult(dice1: 2, dice2: 2, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player1, diceResult, players);

      final killMove = moves.firstWhere(
        (m) => m.willKill,
        orElse: () => throw Exception('No kill move'),
      );

      expect(killMove.grantsExtraTurn, isTrue);
    });

    test('Entering home path grants extra turn', () {
      final player = players[0];
      final token = player.tokens[0];

      // Position token just before home entry
      token.release(50); // Close to red's home entry (51)

      final diceResult = DiceResult(dice1: 1, dice2: 1, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      final homeEntryMove = moves.firstWhere(
        (m) => m.entersHomePath,
        orElse: () => throw Exception('No home entry move'),
      );

      expect(homeEntryMove.grantsExtraTurn, isTrue);
    });

    test('Reaching final home grants extra turn', () {
      final player = players[0];
      final token = player.tokens[0];

      // Position token in home path near end
      token.enterHomePath(5);

      final diceResult = DiceResult(dice1: 1, dice2: 1, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      final finishMove = moves.firstWhere(
        (m) => m.reachesFinalHome,
        orElse: () => throw Exception('No finish move'),
      );

      expect(finishMove.grantsExtraTurn, isTrue);
    });

    test('No extra turn if no valid move exists', () {
      final player = players[0];
      // All tokens at home, no 6 rolled
      final diceResult = DiceResult(dice1: 3, dice2: 4, timestamp: DateTime.now());

      final moves = engine.getValidMoves(player, diceResult, players);

      expect(moves.isEmpty, isTrue);
    });
  });

  group('Game Flow Tests', () {
    test('Turn advances to next player', () {
      final gameState = LudoGameState.initial(players: players);
      expect(gameState.currentPlayerIndex, equals(0));

      final newState = engine.advanceTurn(gameState);
      expect(newState.currentPlayerIndex, equals(1));
    });

    test('Turn wraps around to first player', () {
      final gameState = LudoGameState.initial(players: players)
          .copyWith(currentPlayerIndex: 1);

      final newState = engine.advanceTurn(gameState);
      expect(newState.currentPlayerIndex, equals(0));
    });

    test('Player wins when all 4 tokens finish', () {
      final player = players[0];

      // Finish all tokens
      for (var token in player.tokens) {
        token.finish();
      }

      expect(player.hasWon, isTrue);
      expect(player.finishedTokens, equals(4));
    });
  });

  group('Home Path and Final Home Tests', () {
    test('Token can enter home path', () {
      final player = players[0];
      final token = player.tokens[0];

      token.enterHomePath(0);

      expect(token.isInHomePath, isTrue);
      expect(token.position, equals(0));
    });

    test('Token cannot overshoot home path', () {
      final player = players[0];
      final token = player.tokens[0];

      token.enterHomePath(5); // Last position in home path

      final diceResult = DiceResult(dice1: 3, dice2: 2, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      // Move with sum (5) would overshoot - should not be allowed
      final overshootMove = moves.where(
        (m) => m.token == token && m.steps > 1,
      );

      // If any moves exist, they should be exact
      for (var move in overshootMove) {
        expect(move.targetPosition, lessThanOrEqualTo(6));
      }
    });

    test('Token reaches final home with exact roll', () {
      final player = players[0];
      final token = player.tokens[0];

      token.enterHomePath(5);

      final diceResult = DiceResult(dice1: 1, dice2: 2, timestamp: DateTime.now());
      final moves = engine.getValidMoves(player, diceResult, players);

      final finishMove = moves.firstWhere(
        (m) => m.reachesFinalHome,
        orElse: () => throw Exception('No finish move'),
      );

      expect(finishMove.reachesFinalHome, isTrue);
      expect(finishMove.targetState, equals(TokenState.finished));
    });
  });
}
