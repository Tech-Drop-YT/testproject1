// FILE: lib/src/models/move.dart

import 'enums.dart';
import 'token.dart';

/// Represents a possible move in the game
class Move {
  final Token token;
  final int steps;
  final int? targetPosition;
  final TokenState targetState;
  final bool willKill;
  final Token? killedToken;
  final bool entersHomePath;
  final bool reachesFinalHome;
  final bool canBlock;

  const Move({
    required this.token,
    required this.steps,
    required this.targetPosition,
    required this.targetState,
    this.willKill = false,
    this.killedToken,
    this.entersHomePath = false,
    this.reachesFinalHome = false,
    this.canBlock = false,
  });

  /// Check if this move results in extra turns
  bool get grantsExtraTurn {
    return willKill || entersHomePath || reachesFinalHome;
  }

  /// Get description of the move
  String get description {
    final buffer = StringBuffer();
    buffer.write('Move ${token.color.name}-${token.tokenIndex}');
    buffer.write(' by $steps steps');

    if (willKill) buffer.write(' (KILL)');
    if (entersHomePath) buffer.write(' (HOME PATH)');
    if (reachesFinalHome) buffer.write(' (FINISH)');
    if (canBlock) buffer.write(' (BLOCK)');

    return buffer.toString();
  }

  @override
  String toString() => description;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Move &&
        other.token == token &&
        other.steps == steps &&
        other.targetPosition == targetPosition;
  }

  @override
  int get hashCode =>
      token.hashCode ^ steps.hashCode ^ targetPosition.hashCode;

  /// Create a copy of this move
  Move copyWith({
    Token? token,
    int? steps,
    int? targetPosition,
    TokenState? targetState,
    bool? willKill,
    Token? killedToken,
    bool? entersHomePath,
    bool? reachesFinalHome,
    bool? canBlock,
  }) {
    return Move(
      token: token ?? this.token,
      steps: steps ?? this.steps,
      targetPosition: targetPosition ?? this.targetPosition,
      targetState: targetState ?? this.targetState,
      willKill: willKill ?? this.willKill,
      killedToken: killedToken ?? this.killedToken,
      entersHomePath: entersHomePath ?? this.entersHomePath,
      reachesFinalHome: reachesFinalHome ?? this.reachesFinalHome,
      canBlock: canBlock ?? this.canBlock,
    );
  }
}

/// Represents a compound move using both dice
class CompoundMove {
  final Move? move1; // First move (can be null for single token move)
  final Move? move2; // Second move (can be null for single token move)
  final bool usesSingleToken;
  final int totalSteps;

  const CompoundMove({
    this.move1,
    this.move2,
    required this.usesSingleToken,
    required this.totalSteps,
  });

  /// Check if this is a valid compound move
  bool get isValid => move1 != null || move2 != null;

  /// Get all moves in this compound move
  List<Move> get moves {
    final result = <Move>[];
    if (move1 != null) result.add(move1!);
    if (move2 != null) result.add(move2!);
    return result;
  }

  /// Check if any move in this compound grants extra turn
  bool get grantsExtraTurn {
    return moves.any((m) => m.grantsExtraTurn);
  }

  @override
  String toString() {
    if (usesSingleToken) {
      return 'CompoundMove(single token, $totalSteps steps)';
    } else {
      return 'CompoundMove(two tokens, ${moves.length} moves)';
    }
  }
}
