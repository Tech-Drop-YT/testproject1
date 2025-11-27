// FILE: lib/src/ui/widgets/board_widget.dart

import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../utils/constants.dart';
import 'token_widget.dart';

/// Main game board widget
class BoardWidget extends StatelessWidget {
  final List<Player> players;
  final List<Move> availableMoves;
  final Function(Move)? onMoveSelected;

  const BoardWidget({
    Key? key,
    required this.players,
    this.availableMoves = const [],
    this.onMoveSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.9;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDark ? GameConstants.boardBackgroundDark : GameConstants.boardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Board layout (simplified cross pattern)
          _buildBoardLayout(size, isDark),
          // Player home areas
          _buildHomeAreas(size),
          // Tokens
          _buildTokens(size),
        ],
      ),
    );
  }

  Widget _buildBoardLayout(double size, bool isDark) {
    final pathWidth = size / 15;

    return Stack(
      children: [
        // Center square
        Positioned(
          left: size * 0.4,
          top: size * 0.4,
          child: Container(
            width: size * 0.2,
            height: size * 0.2,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.home, size: 40),
            ),
          ),
        ),
        // Four colored paths (simplified)
        ...PlayerColor.values.take(4).map((color) {
          return _buildColoredPath(size, color, pathWidth);
        }).toList(),
      ],
    );
  }

  Widget _buildColoredPath(double size, PlayerColor color, double pathWidth) {
    final playerColor = GameConstants.playerColors[color] ?? Colors.grey;

    double left = 0, top = 0, width = 0, height = 0;

    switch (color) {
      case PlayerColor.red:
        left = size * 0.4;
        top = size * 0.6;
        width = pathWidth * 2;
        height = size * 0.4;
        break;
      case PlayerColor.green:
        left = 0;
        top = size * 0.4;
        width = size * 0.4;
        height = pathWidth * 2;
        break;
      case PlayerColor.yellow:
        left = size * 0.4;
        top = 0;
        width = pathWidth * 2;
        height = size * 0.4;
        break;
      case PlayerColor.blue:
        left = size * 0.6;
        top = size * 0.4;
        width = size * 0.4;
        height = pathWidth * 2;
        break;
    }

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: height,
        color: playerColor.withOpacity(0.3),
      ),
    );
  }

  Widget _buildHomeAreas(double size) {
    final quadrantSize = size * 0.35;

    return Stack(
      children: PlayerColor.values.take(4).map((color) {
        final playerColor = GameConstants.playerColors[color] ?? Colors.grey;
        double left = 0, top = 0;

        switch (color) {
          case PlayerColor.red:
            left = size * 0.05;
            top = size * 0.6;
            break;
          case PlayerColor.green:
            left = size * 0.6;
            top = size * 0.05;
            break;
          case PlayerColor.yellow:
            left = size * 0.6;
            top = size * 0.6;
            break;
          case PlayerColor.blue:
            left = size * 0.05;
            top = size * 0.05;
            break;
        }

        return Positioned(
          left: left,
          top: top,
          child: Container(
            width: quadrantSize,
            height: quadrantSize,
            decoration: BoxDecoration(
              color: playerColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: playerColor, width: 2),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTokens(double size) {
    return Stack(
      children: players.expand((player) {
        return player.tokens.map((token) {
          return Positioned(
            left: _getTokenX(token, size),
            top: _getTokenY(token, size),
            child: TokenWidget(
              token: token,
              isHighlighted: _isTokenHighlighted(token),
              onTap: () => _onTokenTap(token),
            ),
          );
        });
      }).toList(),
    );
  }

  double _getTokenX(Token token, double size) {
    // Simplified positioning - tokens in home area or on board
    if (token.isAtHome) {
      return _getHomeTokenX(token, size);
    }
    // On board - simplified circular arrangement
    return size * 0.45; // Placeholder
  }

  double _getTokenY(Token token, double size) {
    // Simplified positioning - tokens in home area or on board
    if (token.isAtHome) {
      return _getHomeTokenY(token, size);
    }
    // On board - simplified circular arrangement
    return size * 0.45; // Placeholder
  }

  double _getHomeTokenX(Token token, double size) {
    final baseX = _getHomeBaseX(token.color, size);
    final offsetX = (token.tokenIndex % 2) * 40.0;
    return baseX + offsetX;
  }

  double _getHomeTokenY(Token token, double size) {
    final baseY = _getHomeBaseY(token.color, size);
    final offsetY = (token.tokenIndex ~/ 2) * 40.0;
    return baseY + offsetY;
  }

  double _getHomeBaseX(PlayerColor color, double size) {
    switch (color) {
      case PlayerColor.red:
        return size * 0.1;
      case PlayerColor.green:
        return size * 0.65;
      case PlayerColor.yellow:
        return size * 0.65;
      case PlayerColor.blue:
        return size * 0.1;
    }
  }

  double _getHomeBaseY(PlayerColor color, double size) {
    switch (color) {
      case PlayerColor.red:
        return size * 0.65;
      case PlayerColor.green:
        return size * 0.1;
      case PlayerColor.yellow:
        return size * 0.65;
      case PlayerColor.blue:
        return size * 0.1;
    }
  }

  bool _isTokenHighlighted(Token token) {
    return availableMoves.any((move) => move.token == token);
  }

  void _onTokenTap(Token token) {
    final move = availableMoves.firstWhereOrNull((m) => m.token == token);
    if (move != null && onMoveSelected != null) {
      onMoveSelected!(move);
    }
  }
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
