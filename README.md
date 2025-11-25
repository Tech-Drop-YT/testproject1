# Solvex - Professional Multi-Tool Calculator

A beautiful, modern, and professional Flutter calculator app with multiple tools and a stunning UI.

## ✨ Features

### 🎨 Design
- **Electric Blue** (#2962FF) primary brand color
- Modern, minimalistic UI with rounded corners
- Soft shadows and smooth animations
- Light & Dark mode themes
- Responsive layout

### 🧮 Calculators

#### 1. Standard Calculator
- Basic arithmetic operations (+, −, ×, ÷)
- Percentage calculations
- Plus/minus toggle
- Clear & backspace
- Floating-point precision
- History management with local storage

#### 2. Scientific Calculator
- Trigonometric functions (sin, cos, tan)
- Logarithms (log, ln)
- Powers (x², x³, xʸ)
- Roots (√, ∛)
- Constants (π, e)
- Parenthesis support
- Memory operations (M+, M−, MR, MC)
- RAD/DEG angle mode toggle
- Reciprocal (1/x)

#### 3. Temperature Converter
- Celsius (°C)
- Fahrenheit (°F)
- Kelvin (K)
- Rankine (R)
- Reaumur (°Re)
- Real-time conversion
- Educational info cards

#### 4. Length/Distance Converter
- Meter (m)
- Centimeter (cm)
- Millimeter (mm)
- Kilometer (km)
- Inch (in)
- Foot (ft)
- Yard (yd)
- Mile (mi)
- Nautical Mile (nmi)
- Instant conversion with precision

#### 5. BMI Calculator
- Weight input (kg)
- Height input (cm)
- Real-time BMI calculation
- Color-coded categories:
  - Underweight (< 18.5)
  - Normal (18.5 - 24.9)
  - Overweight (25.0 - 29.9)
  - Obesity (≥ 30.0)
- Animated results card
- Category reference guide

## 🏗️ Architecture

### Folder Structure
```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   └── calculation_history.dart
├── providers/                # State management (Provider)
│   ├── calculator_provider.dart
│   ├── scientific_calculator_provider.dart
│   └── theme_provider.dart
├── screens/                  # All app screens
│   ├── home_screen.dart
│   ├── standard_calculator_screen.dart
│   ├── scientific_calculator_screen.dart
│   ├── temperature_converter_screen.dart
│   ├── length_converter_screen.dart
│   ├── bmi_calculator_screen.dart
│   └── history_screen.dart
├── theme/                    # Theme configuration
│   └── app_theme.dart
├── utils/                    # Utility classes
│   ├── temperature_converter.dart
│   └── length_converter.dart
└── widgets/                  # Reusable widgets
    ├── calculator_button.dart
    └── calculator_card.dart
```

### State Management
- **Provider** for state management
- Separate providers for different calculators
- Theme provider for dark/light mode switching

### Local Storage
- **SharedPreferences** for:
  - Calculation history
  - Theme preferences
  - Memory values

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (≥3.0.0)
- Dart SDK (≥3.0.0)

### Installation

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Build for release:**
   ```bash
   # Android
   flutter build apk --release

   # iOS
   flutter build ios --release
   ```

## 📦 Dependencies

- `provider: ^6.1.1` - State management
- `shared_preferences: ^2.2.2` - Local storage
- `math_expressions: ^2.4.0` - Mathematical expression evaluation
- `intl: ^0.19.0` - Date formatting
- `cupertino_icons: ^1.0.6` - iOS-style icons

## 🎯 Key Features Implementation

### Animations
- Hero animations for screen transitions
- Implicit animations for UI elements
- Scale animations on button press
- Fade-in animations for calculator cards
- Elastic animations for BMI results

### Precision & Accuracy
- No floating-point inaccuracies
- Proper decimal handling
- Scientific notation for very large/small numbers
- Accurate conversion formulas

### User Experience
- Smooth transitions
- Intuitive UI
- Real-time conversions
- Persistent theme selection
- Calculation history

## 🎨 Theme Colors

### Light Mode
- Background: #F5F7FA
- Surface: #FFFFFF
- Primary: #2962FF (Electric Blue)
- Text: #1A1A1A

### Dark Mode
- Background: #0F1419
- Surface: #1A1F2E
- Primary: #2962FF (Electric Blue)
- Text: #FFFFFF
- Accent shadows with neon effect

## 📱 Screenshots

The app features:
- Beautiful home dashboard with animated cards
- Modern calculator interfaces
- Real-time converters
- Clean BMI calculator with color-coded results
- Calculation history viewer
- Seamless light/dark mode switching

## 🔮 Future Enhancements

Possible additions:
- Currency converter
- Unit converter (weight, volume, etc.)
- Age calculator
- Date calculator
- Loan calculator
- Tip calculator

## 📄 License

This project is created for demonstration purposes.

## 👨‍💻 Developer Notes

Built with:
- Flutter Material 3 design
- Clean architecture principles
- Reusable components
- Responsive design
- Performance optimizations

---

**Solvex** - Your professional calculation companion 🧮✨