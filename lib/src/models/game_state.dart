// FILE: lib/src/models/game_state.dart

import 'enums.dart';
import 'player.dart';
import 'dice_result.dart';
import 'move.dart';

/// Represents the complete state of a Ludo game
class LudoGameState {
  final List<Player> players;
  final int currentPlayerIndex;
  final GameState state;
  final DiceResult? lastDiceResult;
  final List<Move> availableMoves;
  final bool diceRolled;
  final List<ExtraTurnReason> extraTurnReasons;
  final Player? winner;
  final int turnCount;
  final List<DiceResult> sixHistory; // Track consecutive 6s for triple-6 rule

  const LudoGameState({
    required this.players,
    required this.currentPlayerIndex,
    required this.state,
    this.lastDiceResult,
    this.availableMoves = const [],
    this.diceRolled = false,
    this.extraTurnReasons = const [],
    this.winner,
    this.turnCount = 0,
    this.sixHistory = const [],
  });

  /// Get current player
  Player get currentPlayer => players[currentPlayerIndex];

  /// Get next player index
  int get nextPlayerIndex => (currentPlayerIndex + 1) % players.length;

  /// Check if game is finished
  bool get isFinished => state == GameState.finished;

  /// Check if game is playing
  bool get isPlaying => state == GameState.playing;

  /// Check if dice can be rolled
  bool get canRollDice => isPlaying && !diceRolled;

  /// Check if a move can be made
  bool get canMove => isPlaying && diceRolled && availableMoves.isNotEmpty;

  /// Check if current turn should pass (no valid moves)
  bool get shouldPassTurn => diceRolled && availableMoves.isEmpty;

  /// Get number of players
  int get playerCount => players.length;

  /// Check if triple 6 occurred
  bool get hasTripleSix {
    if (sixHistory.length < 3) return false;

    // Check last 3 dice results
    final last3 = sixHistory.skip(sixHistory.length - 3).toList();
    return last3.every((result) => result.isDoubleSix);
  }

  /// Create initial game state
  factory LudoGameState.initial({
    required List<Player> players,
  }) {
    return LudoGameState(
      players: players,
      currentPlayerIndex: 0,
      state: GameState.playing,
    );
  }

  /// Create a copy with updated values
  LudoGameState copyWith({
    List<Player>? players,
    int? currentPlayerIndex,
    GameState? state,
    DiceResult? lastDiceResult,
    List<Move>? availableMoves,
    bool? diceRolled,
    List<ExtraTurnReason>? extraTurnReasons,
    Player? winner,
    int? turnCount,
    List<DiceResult>? sixHistory,
    bool clearDiceResult = false,
    bool clearExtraTurnReasons = false,
  }) {
    return LudoGameState(
      players: players ?? this.players,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      state: state ?? this.state,
      lastDiceResult: clearDiceResult ? null : (lastDiceResult ?? this.lastDiceResult),
      availableMoves: availableMoves ?? this.availableMoves,
      diceRolled: diceRolled ?? this.diceRolled,
      extraTurnReasons: clearExtraTurnReasons ? [] : (extraTurnReasons ?? this.extraTurnReasons),
      winner: winner ?? this.winner,
      turnCount: turnCount ?? this.turnCount,
      sixHistory: sixHistory ?? this.sixHistory,
    );
  }

  @override
  String toString() {
    return 'LudoGameState(player: ${currentPlayer.name}, state: ${state.name}, '
        'rolled: $diceRolled, moves: ${availableMoves.length})';
  }
}
