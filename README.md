# Solvex - Modern Flutter Calculator App

<div align="center">
  <h3>🧮 A Beautiful, Feature-Rich Calculator App</h3>
  <p>Built with Flutter 3.29.3 & Dart 3.7.2</p>
</div>

## 🎨 Overview

**Solvex** is a modern, professional calculator app featuring a clean UI, dark/light themes, and both standard and scientific calculation modes. The app includes calculation history, memory operations, and a beautiful Electric Blue (#2962FF) theme.

## ✨ Features

### Core Functionality
- ✅ **Standard Calculator**
  - Basic operations: Addition, Subtraction, Multiplication, Division
  - Percentage calculations
  - Plus/minus toggle
  - Clear and backspace functions
  - Precise floating-point handling

- ✅ **Scientific Calculator**
  - Trigonometric functions (sin, cos, tan + inverse)
  - Logarithms (ln, log)
  - Power functions (x², x³, custom powers)
  - Root functions (√, ∛)
  - Mathematical constants (π, e)
  - Memory operations (MC, MR, M+, M-)
  - Parenthesis support
  - Radians/Degrees toggle

### User Experience
- 🎨 **Beautiful UI/UX**
  - Modern, minimal design
  - Smooth animations and transitions
  - Soft shadows and rounded corners
  - Responsive layout for all screen sizes

- 🌓 **Theme Support**
  - Light Mode (white + Electric Blue accents)
  - Dark Mode (black/dark grey + Electric Blue accents)
  - Theme persistence using SharedPreferences
  - Smooth theme transitions

- 📜 **History System**
  - Stores up to 100 calculations locally
  - Scrollable history list
  - Tap to reuse previous expressions
  - Delete individual items or clear all
  - Timestamp display (relative time)

- ⚙️ **Settings**
  - Theme toggle
  - Vibration feedback control
  - Sound effects control
  - App information

### Technical Features
- 📱 Adaptive layout for phones and tablets
- 🔄 State management with Provider
- 💾 Local storage with SharedPreferences
- 🎯 Haptic feedback on button press
- 🚀 Splash screen with branding
- 📦 Custom app icon

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── theme/
│   │   ├── light_theme.dart          # Light theme configuration
│   │   └── dark_theme.dart           # Dark theme configuration
│   └── constants/
│       └── colors.dart                # App color palette
├── features/
│   ├── calculator/
│   │   ├── ui/
│   │   │   ├── standard_calculator.dart    # Standard calculator UI
│   │   │   └── scientific_calculator.dart  # Scientific calculator UI
│   │   ├── controller/
│   │   │   └── calculator_controller.dart  # Calculator logic & state
│   │   └── widgets/
│   │       ├── button.dart                 # Reusable button widget
│   │       └── display.dart                # Display widget
│   ├── history/
│   │   ├── ui/
│   │   │   └── history_screen.dart         # History screen UI
│   │   └── controller/
│   │       └── history_controller.dart     # History management
│   └── settings/
│       └── ui/
│           └── settings_screen.dart        # Settings screen
└── services/
    └── local_storage.dart                  # SharedPreferences wrapper
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2              # State management
  shared_preferences: ^2.3.3    # Local storage
  google_fonts: ^6.2.1          # Custom fonts
  math_expressions: ^2.6.0      # Math parsing
  cupertino_icons: ^1.0.8       # iOS-style icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_native_splash: ^2.4.2    # Splash screen
  flutter_launcher_icons: ^0.14.1  # App icon generation
```

## 🚀 Getting Started

### Prerequisites
- Flutter 3.29.3 or higher
- Dart 3.7.2 or higher
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDEs)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd testproject1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Create app assets**
   - Add your app icon to `assets/app_icon.png` (1024x1024)
   - Add your splash logo to `assets/splash_logo.png` (512x512)
   - See `assets/README.md` for detailed requirements

4. **Generate splash screen and icons**
   ```bash
   flutter pub run flutter_native_splash:create
   flutter pub run flutter_launcher_icons
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 Theming

### Color Palette

**Primary Brand Color:**
- Electric Blue: `#2962FF`

**Light Theme:**
- Background: `#F5F5F5`
- Surface: `#FFFFFF`
- Text: `#212121`

**Dark Theme:**
- Background: `#121212`
- Surface: `#1E1E1E`
- Text: `#FFFFFF`

### Customization

To customize the theme, edit:
- `lib/core/constants/colors.dart` - Color definitions
- `lib/core/theme/light_theme.dart` - Light theme settings
- `lib/core/theme/dark_theme.dart` - Dark theme settings

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📱 Building for Production

### Android
```bash
flutter build apk --release          # Build APK
flutter build appbundle --release    # Build App Bundle
```

### iOS
```bash
flutter build ios --release
```

## 🔧 Configuration

### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Package name: `com.example.solvex`

### iOS
- Minimum iOS version: 12.0
- Bundle ID: `com.example.solvex`

## 📄 License

This project is licensed under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📧 Support

For issues and questions, please create an issue in the repository.

---

<div align="center">
  <p>Made with ❤️ using Flutter</p>
  <p><strong>Solvex</strong> - Calculate with Confidence</p>
</div>
