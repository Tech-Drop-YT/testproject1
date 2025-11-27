# Ludo Dual Dice 🎲

A modern, fully polished, offline Ludo game with dual dice mechanics and professional Ludo Pro rules.

## Features ✨

### 🎲 Dual Dice System
- Each turn uses **TWO dice** automatically
- Rolling ONE die automatically rolls BOTH dice
- Tap Dice 1, Dice 2, or ROLL button - all trigger both dice

### 🎯 Advanced Movement Rules
- Move one token by sum of both dice
- Move one token using dice1 only
- Move one token using dice2 only
- Move two different tokens (one per die)

### ⭐ Complete Ludo Pro Extra Turn Rules
1. **Single 6** → 1 extra turn
2. **Double 6** (6+6) → 2 extra turns
3. **Triple 6** → Entire turn cancelled, all moves undone
4. **Kill Bonus** → Extra turn when killing opponent
5. **Home Entry** → Extra turn when entering colored home path
6. **Final Home** → Extra turn when token reaches center
7. **Stackable Bonuses** → Extra turns accumulate (except triple 6)
8. **No-Move Rule** → No extra turn if player cannot move

### 🎮 Game Modes
- 2, 3, or 4 players
- Human vs Human
- Human vs Bot (Easy/Medium/Hard AI)
- Mix of human and bot players

### 🎨 Beautiful UI
- Smooth animations for dice rolling
- Token movement with physics
- Kill animations
- Glow effects on safe squares
- Home entry and win animations
- Turn indicator with pulse effect
- Light/Dark mode support
- Responsive design for phones & tablets

### 🏗️ Professional Architecture
- Clean separation of concerns
- Game engine separate from UI
- GetX state management
- Comprehensive test coverage
- Well-documented code

## Installation 📱

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Setup
```bash
# Clone the repository
git clone <repository-url>
cd testproject1

# Get dependencies
flutter pub get

# Run the app
flutter run

# Run tests
flutter test

# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## Project Structure 📁

```
lib/
└── src/
    ├── engine/         # Pure game logic
    │   └── game_engine.dart
    ├── controllers/    # GetX controllers
    │   ├── game_controller.dart
    │   └── theme_controller.dart
    ├── models/         # Data models
    │   ├── enums.dart
    │   ├── dice_result.dart
    │   ├── token.dart
    │   ├── player.dart
    │   ├── move.dart
    │   └── game_state.dart
    ├── ui/             # User interface
    │   ├── screens/
    │   │   ├── home_screen.dart
    │   │   ├── game_setup_screen.dart
    │   │   └── game_screen.dart
    │   └── widgets/
    │       ├── board_widget.dart
    │       ├── dice_widget.dart
    │       └── token_widget.dart
    ├── utils/          # Constants and helpers
    │   ├── constants.dart
    │   └── helpers.dart
    └── services/       # Services
        └── audio_service.dart
```

## How to Play 🎲

1. **Setup**: Choose 2-4 players and configure human/bot players
2. **Roll Dice**: Tap either die or the ROLL button to roll both dice
3. **Move Tokens**: Select a highlighted token to move
4. **Release Tokens**: Need a 6 to release tokens from home
5. **Kill Opponents**: Land on opponent tokens to send them home
6. **Win**: Get all 4 tokens to the center first!

For complete rules, see [GameRules.md](GameRules.md)

## Testing 🧪

### Run All Tests
```bash
flutter test
```

### Run Specific Tests
```bash
# Engine tests
flutter test test/engine/game_engine_test.dart

# Widget tests
flutter test test/widgets/
```

### Test Coverage
The project includes comprehensive tests for:
- ✅ Dual dice mechanics
- ✅ Extra turn rules (all 8 rules)
- ✅ Token movement validation
- ✅ Kill and block rules
- ✅ Home path and final home logic
- ✅ Game flow and turn management
- ✅ UI widget rendering and interactions

## Technology Stack 🛠️

- **Framework**: Flutter 3.x
- **State Management**: GetX
- **Audio**: audioplayers
- **Animations**: flutter_animate
- **Local Storage**: shared_preferences
- **Testing**: flutter_test, mockito

## Key Features Implementation 🔑

### Dual Dice Auto-Roll
```dart
// Tapping any dice or button rolls BOTH dice
DualDiceWidget(
  dice1Value: dice1,
  dice2Value: dice2,
  onRoll: () => controller.rollDice(), // Rolls both automatically
)
```

### Extra Turn System
```dart
// Comprehensive extra turn tracking
enum ExtraTurnReason {
  singleSix,    // +1 turn
  doubleSix,    // +2 turns (counted twice)
  kill,         // +1 turn
  homeEntry,    // +1 turn
  finalHome,    // +1 turn
}
```

### Movement Options
```dart
// Player can choose from multiple move options
final moves = [
  moveBySum(dice1 + dice2),
  moveByDice1(dice1),
  moveByDice2(dice2),
  moveTwoTokens(dice1, dice2),
];
```

## Contributing 🤝

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Add tests for new features
4. Ensure all tests pass
5. Submit a pull request

## License 📄

This project is licensed under the MIT License.

## Acknowledgments 🙏

- Ludo game rules based on professional Ludo Pro standards
- UI/UX inspired by modern mobile game design
- Built with love using Flutter

## Support 💬

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check [GameRules.md](GameRules.md) for detailed rules
- Review the code documentation

---

**Enjoy playing Ludo Dual Dice! 🎲🎉**
