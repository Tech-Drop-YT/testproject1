// FILE: lib/src/utils/constants.dart

import 'package:flutter/material.dart';
import '../models/enums.dart';

/// Game constants and configuration
class GameConstants {
  GameConstants._();

  // Board dimensions
  static const double boardSize = 600.0;
  static const double tokenSize = 30.0;
  static const double diceSize = 60.0;

  // Animation durations
  static const Duration diceRollDuration = Duration(milliseconds: 800);
  static const Duration tokenMoveDuration = Duration(milliseconds: 300);
  static const Duration killAnimationDuration = Duration(milliseconds: 500);
  static const Duration winAnimationDuration = Duration(milliseconds: 1500);

  // Colors
  static const Map<PlayerColor, Color> playerColors = {
    PlayerColor.red: Color(0xFFE53935),
    PlayerColor.green: Color(0xFF43A047),
    PlayerColor.yellow: Color(0xFFFDD835),
    PlayerColor.blue: Color(0xFF1E88E5),
  };

  static const Map<PlayerColor, Color> playerLightColors = {
    PlayerColor.red: Color(0xFFFF6F60),
    PlayerColor.green: Color(0xFF66BB6A),
    PlayerColor.yellow: Color(0xFFFFEB3B),
    PlayerColor.blue: Color(0xFF42A5F5),
  };

  // Board colors
  static const Color boardBackground = Color(0xFFFAFAFA);
  static const Color boardBackgroundDark = Color(0xFF1E1E1E);
  static const Color safeSquareColor = Color(0xFF90CAF9);
  static const Color starSquareColor = Color(0xFFFFD54F);
  static const Color normalSquareColor = Color(0xFFFFFFFF);

  // UI colors
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color accentLight = Color(0xFF03DAC6);
  static const Color accentDark = Color(0xFF03DAC6);

  // Sounds (placeholders)
  static const String diceRollSound = 'assets/sounds/dice_roll.mp3';
  static const String tokenMoveSound = 'assets/sounds/token_move.mp3';
  static const String killSound = 'assets/sounds/kill.mp3';
  static const String winSound = 'assets/sounds/win.mp3';

  // Board layout
  static const int totalSquares = 52;
  static const int homePathLength = 6;
  static const int tokensPerPlayer = 4;

  // Starting positions for each color
  static const Map<PlayerColor, int> startPositions = {
    PlayerColor.red: 1,
    PlayerColor.green: 14,
    PlayerColor.yellow: 27,
    PlayerColor.blue: 40,
  };

  // Home entry positions for each color
  static const Map<PlayerColor, int> homeEntryPositions = {
    PlayerColor.red: 51,
    PlayerColor.green: 12,
    PlayerColor.yellow: 25,
    PlayerColor.blue: 38,
  };

  // Safe squares
  static const Set<int> safeSquares = {1, 9, 14, 22, 27, 35, 40, 48};

  // Star squares
  static const Set<int> starSquares = {5, 18, 31, 44};

  // Game rules
  static const int maxPlayers = 4;
  static const int minPlayers = 2;
  static const int diceMin = 1;
  static const int diceMax = 6;
  static const int sixForRelease = 6;
  static const int tripleSixThreshold = 3;
}

/// Text constants
class TextConstants {
  TextConstants._();

  static const String appName = 'Ludo Dual Dice';
  static const String appVersion = '1.0.0';

  // Menu
  static const String newGame = 'New Game';
  static const String resume = 'Resume';
  static const String settings = 'Settings';
  static const String howToPlay = 'How to Play';
  static const String about = 'About';

  // Game
  static const String rollDice = 'ROLL DICE';
  static const String yourTurn = 'Your Turn';
  static const String waiting = 'Waiting...';
  static const String selectToken = 'Select a token to move';
  static const String noValidMoves = 'No valid moves!';
  static const String extraTurn = 'Extra Turn!';
  static const String tripleSix = 'Triple 6! Turn Cancelled!';
  static const String winner = 'Winner!';
  static const String gameOver = 'Game Over';

  // Player setup
  static const String selectPlayers = 'Select Number of Players';
  static const String playerName = 'Player Name';
  static const String playerType = 'Player Type';
  static const String human = 'Human';
  static const String bot = 'Bot';
  static const String difficulty = 'Difficulty';
  static const String easy = 'Easy';
  static const String medium = 'Medium';
  static const String hard = 'Hard';

  // Settings
  static const String soundEffects = 'Sound Effects';
  static const String music = 'Music';
  static const String vibration = 'Vibration';
  static const String darkMode = 'Dark Mode';
  static const String language = 'Language';

  // Rules
  static const String rulesTitle = 'Game Rules';
  static const String dualDiceRule = 'Two dice are rolled each turn';
  static const String moveOptionsRule = 'Move one token by sum, or use dice separately';
  static const String sixRule = 'Roll a 6 to release tokens from home';
  static const String extraTurnRule = 'Get extra turns for 6s, kills, and reaching home';
  static const String tripleSixRule = 'Triple 6 cancels your turn completely';
  static const String killRule = 'Land on opponent to send them home';
  static const String blockRule = 'Two same-color tokens block the path';
  static const String winRule = 'First to get all 4 tokens home wins!';
}

/// Asset paths
class AssetPaths {
  AssetPaths._();

  // Images
  static const String boardBackground = 'assets/images/board.png';
  static const String dice1 = 'assets/images/dice_1.png';
  static const String dice2 = 'assets/images/dice_2.png';
  static const String dice3 = 'assets/images/dice_3.png';
  static const String dice4 = 'assets/images/dice_4.png';
  static const String dice5 = 'assets/images/dice_5.png';
  static const String dice6 = 'assets/images/dice_6.png';

  // Sounds
  static const String diceRoll = 'assets/sounds/dice_roll.mp3';
  static const String tokenMove = 'assets/sounds/token_move.mp3';
  static const String tokenKill = 'assets/sounds/kill.mp3';
  static const String victory = 'assets/sounds/win.mp3';
  static const String buttonClick = 'assets/sounds/button.mp3';
}
