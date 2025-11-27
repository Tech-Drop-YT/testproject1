// FILE: lib/src/models/enums.dart

/// Represents the four player colors in Ludo
enum PlayerColor {
  red,
  green,
  yellow,
  blue;

  /// Get display name
  String get displayName => name.toUpperCase();

  /// Get color index (0-3)
  int get index {
    switch (this) {
      case PlayerColor.red:
        return 0;
      case PlayerColor.green:
        return 1;
      case PlayerColor.yellow:
        return 2;
      case PlayerColor.blue:
        return 3;
    }
  }
}

/// Represents the type of player (human or bot)
enum PlayerType {
  human,
  bot;

  bool get isHuman => this == PlayerType.human;
  bool get isBot => this == PlayerType.bot;
}

/// Bot difficulty levels
enum BotDifficulty {
  easy,
  medium,
  hard;

  String get displayName {
    switch (this) {
      case BotDifficulty.easy:
        return 'Easy';
      case BotDifficulty.medium:
        return 'Medium';
      case BotDifficulty.hard:
        return 'Hard';
    }
  }
}

/// Token state in the game
enum TokenState {
  home,       // In starting area
  active,     // On the board
  homePath,   // In colored home path
  finished;   // Reached final home (center)

  bool get isHome => this == TokenState.home;
  bool get isActive => this == TokenState.active;
  bool get isHomePath => this == TokenState.homePath;
  bool get isFinished => this == TokenState.finished;
}

/// Game state
enum GameState {
  notStarted,
  playing,
  paused,
  finished;

  bool get isPlaying => this == GameState.playing;
  bool get isFinished => this == GameState.finished;
}

/// Square types on the board
enum SquareType {
  normal,
  safe,
  star,
  homeEntry;

  bool get isSafe => this == SquareType.safe;
  bool get isStar => this == SquareType.star;
}

/// Theme mode
enum ThemeMode {
  light,
  dark;

  bool get isLight => this == ThemeMode.light;
  bool get isDark => this == ThemeMode.dark;
}

/// Extra turn reasons for tracking
enum ExtraTurnReason {
  singleSix,
  doubleSix,
  kill,
  homeEntry,
  finalHome;

  String get description {
    switch (this) {
      case ExtraTurnReason.singleSix:
        return 'Rolled a 6!';
      case ExtraTurnReason.doubleSix:
        return 'Double 6!';
      case ExtraTurnReason.kill:
        return 'Killed opponent!';
      case ExtraTurnReason.homeEntry:
        return 'Entered home path!';
      case ExtraTurnReason.finalHome:
        return 'Token reached home!';
    }
  }
}
