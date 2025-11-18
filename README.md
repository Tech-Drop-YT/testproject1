# 🌙 DreamyTales - Kids Story Book App

A beautiful, animated Flutter mobile application designed for children, featuring engaging stories, smooth animations, and a modern modular architecture.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### 📚 Core Features
- **Beautiful Splash Screen** with animated logo, stars, and smooth transitions
- **Interactive Onboarding** with 3 engaging slides for first-time users
- **Home Screen** with categorized stories, trending picks, and personalized suggestions
- **Story Reader** with page-by-page navigation and customizable font sizes
- **Favorites System** to save and revisit beloved stories
- **Shopping Cart** for premium story purchases
- **Profile & Settings** with dark mode and reading preferences

### 🎨 UI/UX Highlights
- Bright, colorful, kid-friendly interface
- Soft gradients and rounded corners
- Pastel color palette perfect for children
- Storybook-inspired fonts (Fredoka & Poppins)
- Smooth animations throughout the app

### 🎭 Animations
- **Hero animations** for seamless screen transitions
- **Scale & Fade transitions** for engaging interactions
- **Lottie animations** ready for stars, sparkles, and book animations
- **Page indicators** with smooth transitions
- **Custom animated widgets** for buttons and cards

### 📖 Story Features
- **10 Sample Stories** across 4 categories:
  - 🗺️ Adventure
  - 🧚 Fairy Tales
  - 🌙 Bedtime
  - 💡 Moral
- Each story includes:
  - Title, description, and author
  - Multiple pages with text and image placeholders
  - Category classification
  - Age group recommendations
  - Rating system
  - Premium/Free designation

## 🏗️ Architecture

### Clean Architecture + Provider Pattern

```
lib/
├── main.dart                      # App entry point with Provider setup
├── core/                          # Core functionality
│   ├── theme/                     # Theme configuration
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   └── constants/
│       └── app_constants.dart
├── models/                        # Data models
│   ├── story.dart
│   └── story_page.dart
├── providers/                     # State management
│   ├── story_provider.dart
│   ├── favorites_provider.dart
│   ├── cart_provider.dart
│   └── theme_provider.dart
├── services/                      # Business logic
│   ├── storage_service.dart
│   └── story_service.dart
├── utils/                         # Helper functions
│   └── helpers.dart
├── widgets/                       # Reusable components
│   ├── custom_button.dart
│   ├── story_card.dart
│   ├── category_chip.dart
│   └── page_indicator.dart
├── screens/                       # UI screens
│   ├── splash/
│   ├── onboarding/
│   ├── home/
│   ├── story_list/
│   ├── story_detail/
│   ├── reader/
│   ├── favorites/
│   ├── cart/
│   └── profile/
└── data/                          # Sample data
    └── stories_data.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd dreamytales
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## 📦 Dependencies

### Core Dependencies
- **provider** (^6.1.1) - State management
- **shared_preferences** (^2.2.2) - Local data persistence
- **hive** (^2.2.3) - NoSQL database
- **hive_flutter** (^1.1.0) - Hive Flutter integration

### UI & Animations
- **lottie** (^3.0.0) - Lottie animations
- **flutter_animate** (^4.5.0) - Additional animations
- **google_fonts** (^6.1.0) - Custom fonts
- **flutter_svg** (^2.0.9) - SVG support
- **cached_network_image** (^3.3.1) - Image caching
- **shimmer** (^3.0.0) - Shimmer effects
- **font_awesome_flutter** (^10.7.0) - Icon library

### Development
- **flutter_lints** (^3.0.1) - Linting rules
- **hive_generator** (^2.0.1) - Code generation for Hive
- **build_runner** (^2.4.8) - Build system

## 🎨 Adding Custom Assets

### Lottie Animations
Place Lottie JSON files in `assets/lottie/`:
- `stars.json` - Animated stars for splash screen
- `sparkles.json` - Sparkle effects
- `book.json` - Book opening animation
- `clouds.json` - Floating clouds
- `reading.json` - Reading character animation
- `empty.json` - Empty state animations

### Images
Add images to respective folders:
- `assets/images/stories/` - Story illustrations
- `assets/images/categories/` - Category icons
- `assets/images/illustrations/` - UI illustrations

### Fonts (Optional Enhancement)
- Download **Fredoka** font from Google Fonts
- Place in `assets/fonts/`
- Update `pubspec.yaml` if using local fonts

## 🎯 Key Screens

### 1. Splash Screen
- Animated logo with scale transition
- Rotating stars background
- Gradient background (purple, blue, yellow)
- Auto-navigation after 3 seconds
- Welcome message with fade-in effect

### 2. Onboarding Screen
- 3 beautifully designed slides
- Page indicators
- Skip button
- Smooth page transitions
- "Get Started" button on final slide

### 3. Home Screen
- Gradient header with search bar
- Category chips (horizontal scroll)
- Trending stories section
- Suggested stories grid
- Bottom navigation bar

### 4. Story Detail Screen
- Hero animation from card
- Cover image with gradient
- Story information (category, rating, age)
- Description
- Favorite toggle button
- Add to cart (for premium stories)
- Read Now button

### 5. Story Reader Screen
- Page-by-page reading experience
- Page navigation (Previous/Next)
- Page indicator
- Customizable font size
- Tap to toggle controls
- Smooth page transitions

### 6. Favorites Screen
- Grid view of favorite stories
- Empty state with beautiful illustration
- Tap to view story details

### 7. Cart Screen
- List of premium stories
- Remove from cart option
- Total price calculation
- Checkout button
- Empty state design

### 8. Profile Screen
- Dark mode toggle
- Font size slider
- About section
- Help & Support
- Privacy Policy

## 🎨 Theme Customization

The app supports both **Light** and **Dark** modes with beautiful color schemes:

### Light Theme
- Background: `#F8F9FA`
- Primary: Purple `#9C6FDE`
- Secondary: Pink `#FF6B9D`
- Accent: Blue `#4FC3F7`

### Dark Theme
- Background: `#1A1D2E`
- Cards: `#2D3142`
- Same vibrant accent colors

## 💾 Data Persistence

The app uses **SharedPreferences** for:
- Favorite stories
- Shopping cart items
- Theme mode preference
- Font size preference
- Onboarding completion status

## 🎭 Animation Details

### Splash Screen Animations
- **Scale Animation**: Logo grows from 0 to full size with elastic effect
- **Fade Animation**: Welcome text fades in smoothly
- **Rotation Animation**: Stars continuously rotate in background

### Screen Transitions
- **Hero Animation**: Story cards transform into detail screen
- **Fade Transition**: Used for onboarding to home navigation
- **Page Transition**: Smooth page changes in reader

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📱 Build APK

```bash
flutter build apk --release
```

## 🎯 Future Enhancements

- [ ] Audio narration for stories
- [ ] Background music in reader
- [ ] More story categories
- [ ] User accounts and cloud sync
- [ ] Download stories for offline reading
- [ ] Parental controls
- [ ] Reading progress tracking
- [ ] Achievement badges
- [ ] Social sharing features
- [ ] Multiple language support

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**DreamyTales Team**

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for beautiful typography
- Lottie for smooth animations
- All the open-source contributors

---

Made with ❤️ for kids and parents everywhere!

## 📸 Screenshots

*Note: Add screenshots of your app here once built*

## 🐛 Known Issues

None at the moment! Please report any issues you find.

## 📞 Support

For support, email support@dreamytales.com or open an issue on GitHub.

---

**Happy Reading! 📚✨**