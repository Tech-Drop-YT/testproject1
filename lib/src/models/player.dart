// FILE: lib/src/models/player.dart

import 'enums.dart';
import 'token.dart';

/// Represents a player in the game
class Player {
  final String id;
  final String name;
  final PlayerColor color;
  final PlayerType type;
  final BotDifficulty? botDifficulty;
  final List<Token> tokens;

  int consecutiveSixes; // Track consecutive 6s for triple-6 rule
  int extraTurns; // Track accumulated extra turns

  Player({
    required this.id,
    required this.name,
    required this.color,
    required this.type,
    this.botDifficulty,
    List<Token>? tokens,
    this.consecutiveSixes = 0,
    this.extraTurns = 0,
  }) : tokens = tokens ?? _createTokens(id, color);

  /// Create 4 tokens for the player
  static List<Token> _createTokens(String playerId, PlayerColor color) {
    return List.generate(
      4,
      (index) => Token(
        id: '$playerId-token-$index',
        color: color,
        tokenIndex: index,
      ),
    );
  }

  /// Check if player is human
  bool get isHuman => type == PlayerType.human;

  /// Check if player is bot
  bool get isBot => type == PlayerType.bot;

  /// Get number of tokens still at home
  int get tokensAtHome => tokens.where((t) => t.isAtHome).length;

  /// Get number of tokens on board (active + home path)
  int get tokensOnBoard =>
      tokens.where((t) => t.isOnBoard || t.isInHomePath).length;

  /// Get number of finished tokens
  int get finishedTokens => tokens.where((t) => t.hasFinished).length;

  /// Check if player has won (all 4 tokens finished)
  bool get hasWon => finishedTokens == 4;

  /// Check if player has any tokens that can move
  bool get hasMovableTokens => tokens.any((t) => !t.hasFinished);

  /// Get all active tokens (on board or in home path)
  List<Token> get activeTokens =>
      tokens.where((t) => t.isOnBoard || t.isInHomePath).toList();

  /// Get starting position on board for this player's color
  int get startPosition {
    switch (color) {
      case PlayerColor.red:
        return 1; // Red starts at position 1
      case PlayerColor.green:
        return 14; // Green starts at position 14
      case PlayerColor.yellow:
        return 27; // Yellow starts at position 27
      case PlayerColor.blue:
        return 40; // Blue starts at position 40
    }
  }

  /// Get home entry position for this player
  int get homeEntryPosition {
    switch (color) {
      case PlayerColor.red:
        return 51; // Red enters home from position 51
      case PlayerColor.green:
        return 12; // Green enters home from position 12
      case PlayerColor.yellow:
        return 25; // Yellow enters home from position 25
      case PlayerColor.blue:
        return 38; // Blue enters home from position 38
    }
  }

  /// Reset consecutive sixes counter
  void resetConsecutiveSixes() {
    consecutiveSixes = 0;
  }

  /// Increment consecutive sixes
  void incrementConsecutiveSixes() {
    consecutiveSixes++;
  }

  /// Add extra turns
  void addExtraTurns(int count) {
    extraTurns += count;
  }

  /// Use one extra turn
  void useExtraTurn() {
    if (extraTurns > 0) {
      extraTurns--;
    }
  }

  /// Reset extra turns
  void resetExtraTurns() {
    extraTurns = 0;
  }

  /// Check if player has extra turns remaining
  bool get hasExtraTurns => extraTurns > 0;

  /// Create a copy of this player
  Player copyWith({
    String? id,
    String? name,
    PlayerColor? color,
    PlayerType? type,
    BotDifficulty? botDifficulty,
    List<Token>? tokens,
    int? consecutiveSixes,
    int? extraTurns,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      type: type ?? this.type,
      botDifficulty: botDifficulty ?? this.botDifficulty,
      tokens: tokens ?? this.tokens.map((t) => t.copyWith()).toList(),
      consecutiveSixes: consecutiveSixes ?? this.consecutiveSixes,
      extraTurns: extraTurns ?? this.extraTurns,
    );
  }

  @override
  String toString() {
    return 'Player($name, ${color.name}, finished: $finishedTokens/4, extra turns: $extraTurns)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Player && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.name,
      'type': type.name,
      'botDifficulty': botDifficulty?.name,
      'tokens': tokens.map((t) => t.toJson()).toList(),
      'consecutiveSixes': consecutiveSixes,
      'extraTurns': extraTurns,
    };
  }

  /// Create from JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      name: json['name'] as String,
      color: PlayerColor.values.firstWhere((e) => e.name == json['color']),
      type: PlayerType.values.firstWhere((e) => e.name == json['type']),
      botDifficulty: json['botDifficulty'] != null
          ? BotDifficulty.values
              .firstWhere((e) => e.name == json['botDifficulty'])
          : null,
      tokens: (json['tokens'] as List)
          .map((t) => Token.fromJson(t as Map<String, dynamic>))
          .toList(),
      consecutiveSixes: json['consecutiveSixes'] as int? ?? 0,
      extraTurns: json['extraTurns'] as int? ?? 0,
    );
  }
}
