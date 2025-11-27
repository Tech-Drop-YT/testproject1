// FILE: lib/src/utils/helpers.dart

import 'package:flutter/material.dart';
import '../models/models.dart';
import 'constants.dart';

/// Helper utilities for the game
class GameHelpers {
  GameHelpers._();

  /// Get color for a player
  static Color getPlayerColor(PlayerColor color, [bool light = false]) {
    if (light) {
      return GameConstants.playerLightColors[color] ?? Colors.grey;
    }
    return GameConstants.playerColors[color] ?? Colors.grey;
  }

  /// Get player name based on color
  static String getDefaultPlayerName(PlayerColor color, int index) {
    return '${color.name.toUpperCase()} Player';
  }

  /// Generate unique player ID
  static String generatePlayerId(PlayerColor color) {
    return 'player_${color.name}_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Generate unique token ID
  static String generateTokenId(String playerId, int tokenIndex) {
    return '${playerId}_token_$tokenIndex';
  }

  /// Format time duration
  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get square color based on type
  static Color getSquareColor(int position, bool isDarkMode) {
    if (GameConstants.safeSquares.contains(position)) {
      return GameConstants.safeSquareColor;
    } else if (GameConstants.starSquares.contains(position)) {
      return GameConstants.starSquareColor;
    } else {
      return isDarkMode
          ? GameConstants.boardBackgroundDark
          : GameConstants.normalSquareColor;
    }
  }

  /// Calculate board position coordinates
  static Offset getBoardPositionOffset(int position, double boardSize) {
    // This is a simplified version - actual implementation would map
    // each position to its x,y coordinates on the board
    final angle = (position * 360.0 / GameConstants.totalSquares) * (3.14159 / 180.0);
    final radius = boardSize * 0.35;
    final centerX = boardSize / 2;
    final centerY = boardSize / 2;

    return Offset(
      centerX + radius * cos(angle),
      centerY + radius * sin(angle),
    );
  }

  /// Get home area position for token
  static Offset getHomePosition(PlayerColor color, int tokenIndex, double boardSize) {
    final quadrantSize = boardSize / 2;
    double baseX = 0, baseY = 0;

    switch (color) {
      case PlayerColor.red:
        baseX = quadrantSize * 0.25;
        baseY = quadrantSize * 0.25;
        break;
      case PlayerColor.green:
        baseX = boardSize - quadrantSize * 0.75;
        baseY = quadrantSize * 0.25;
        break;
      case PlayerColor.yellow:
        baseX = boardSize - quadrantSize * 0.75;
        baseY = boardSize - quadrantSize * 0.75;
        break;
      case PlayerColor.blue:
        baseX = quadrantSize * 0.25;
        baseY = boardSize - quadrantSize * 0.75;
        break;
    }

    // Arrange 4 tokens in 2x2 grid
    final offsetX = (tokenIndex % 2) * 40.0;
    final offsetY = (tokenIndex ~/ 2) * 40.0;

    return Offset(baseX + offsetX, baseY + offsetY);
  }

  /// Check if it's night time (for theme suggestions)
  static bool isNightTime() {
    final hour = DateTime.now().hour;
    return hour < 6 || hour >= 18;
  }

  /// Validate player name
  static String? validatePlayerName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Please enter a name';
    }
    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (name.trim().length > 20) {
      return 'Name must be less than 20 characters';
    }
    return null;
  }

  /// Get dice face unicode or asset
  static String getDiceFace(int value) {
    const faces = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
    if (value >= 1 && value <= 6) {
      return faces[value - 1];
    }
    return '?';
  }

  /// Get win message
  static String getWinMessage(String playerName) {
    final messages = [
      '$playerName wins! 🎉',
      'Victory for $playerName! 👑',
      '$playerName is the champion! 🏆',
      'Congratulations $playerName! 🎊',
    ];
    return messages[DateTime.now().millisecond % messages.length];
  }

  /// Get extra turn message
  static String getExtraTurnMessage(List<ExtraTurnReason> reasons) {
    if (reasons.isEmpty) return '';

    final messages = reasons.map((r) => r.description).toList();
    if (messages.length == 1) {
      return messages.first;
    } else {
      return '${messages.join(', ')} - ${reasons.length} extra turns!';
    }
  }

  /// Calculate AI move score (for bot difficulty)
  static double calculateMoveScore(
    Move move,
    Player player,
    BotDifficulty difficulty,
  ) {
    double score = 0;

    switch (difficulty) {
      case BotDifficulty.easy:
        // Easy: Random-ish, slight preference for progress
        score = move.steps.toDouble();
        break;

      case BotDifficulty.medium:
        // Medium: Balanced strategy
        if (move.willKill) score += 50;
        if (move.entersHomePath) score += 30;
        if (move.reachesFinalHome) score += 100;
        score += move.steps * 2;
        break;

      case BotDifficulty.hard:
        // Hard: Aggressive and strategic
        if (move.willKill) score += 80;
        if (move.entersHomePath) score += 40;
        if (move.reachesFinalHome) score += 150;
        if (move.token.isAtHome) score += 20; // Prioritize getting tokens out
        score += move.steps * 3;
        break;
    }

    return score;
  }

  /// Simple cos function (for position calculation)
  static double cos(double radians) {
    // Simplified - in real app would use dart:math
    return 0.0; // Placeholder
  }

  /// Simple sin function (for position calculation)
  static double sin(double radians) {
    // Simplified - in real app would use dart:math
    return 0.0; // Placeholder
  }
}

/// Extension on PlayerColor for convenience
extension PlayerColorExtension on PlayerColor {
  Color get color => GameHelpers.getPlayerColor(this);
  Color get lightColor => GameHelpers.getPlayerColor(this, true);
}
