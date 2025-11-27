// FILE: lib/src/models/token.dart

import 'enums.dart';

/// Represents a single token/piece in the game
class Token {
  final String id;
  final PlayerColor color;
  final int tokenIndex; // 0-3 for each player

  TokenState state;
  int? position; // null when in home, 0-51 on board, 0-5 in home path

  Token({
    required this.id,
    required this.color,
    required this.tokenIndex,
    this.state = TokenState.home,
    this.position,
  });

  /// Check if token is at home (starting area)
  bool get isAtHome => state == TokenState.home;

  /// Check if token is on the board
  bool get isOnBoard => state == TokenState.active;

  /// Check if token is in home path
  bool get isInHomePath => state == TokenState.homePath;

  /// Check if token has finished
  bool get hasFinished => state == TokenState.finished;

  /// Get the absolute board position (0-51)
  /// Returns null if not on main board
  int? get absolutePosition {
    if (state != TokenState.active) return null;
    return position;
  }

  /// Move token to a new position
  void moveTo(int newPosition, TokenState newState) {
    position = newPosition;
    state = newState;
  }

  /// Reset token to home
  void resetToHome() {
    position = null;
    state = TokenState.home;
  }

  /// Release token from home to starting position
  void release(int startPosition) {
    position = startPosition;
    state = TokenState.active;
  }

  /// Move token into home path
  void enterHomePath(int homePathPosition) {
    position = homePathPosition;
    state = TokenState.homePath;
  }

  /// Mark token as finished
  void finish() {
    position = null;
    state = TokenState.finished;
  }

  /// Create a copy of this token
  Token copyWith({
    String? id,
    PlayerColor? color,
    int? tokenIndex,
    TokenState? state,
    int? position,
  }) {
    return Token(
      id: id ?? this.id,
      color: color ?? this.color,
      tokenIndex: tokenIndex ?? this.tokenIndex,
      state: state ?? this.state,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'Token(${color.name}-$tokenIndex, state: ${state.name}, pos: $position)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Token && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color.name,
      'tokenIndex': tokenIndex,
      'state': state.name,
      'position': position,
    };
  }

  /// Create from JSON
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'] as String,
      color: PlayerColor.values.firstWhere((e) => e.name == json['color']),
      tokenIndex: json['tokenIndex'] as int,
      state: TokenState.values.firstWhere((e) => e.name == json['state']),
      position: json['position'] as int?,
    );
  }
}
