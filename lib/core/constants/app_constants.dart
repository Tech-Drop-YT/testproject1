class AppConstants {
  // App Info
  static const String appName = 'DreamyTales';
  static const String appTagline = 'Magical Stories for Amazing Kids';

  // Storage Keys
  static const String keyFavorites = 'favorites';
  static const String keyCart = 'cart';
  static const String keyThemeMode = 'theme_mode';
  static const String keyFontSize = 'font_size';
  static const String keyOnboardingComplete = 'onboarding_complete';

  // Categories
  static const List<String> categories = [
    'All',
    'Adventure',
    'Fairy Tales',
    'Bedtime',
    'Moral',
  ];

  // Story Categories
  static const String categoryAdventure = 'Adventure';
  static const String categoryFairyTales = 'Fairy Tales';
  static const String categoryBedtime = 'Bedtime';
  static const String categoryMoral = 'Moral';

  // Premium
  static const double premiumStoryPrice = 2.99;

  // Animations
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);

  // Assets
  static const String lottieStars = 'assets/lottie/stars.json';
  static const String lottieBook = 'assets/lottie/book.json';
  static const String lottieSparkles = 'assets/lottie/sparkles.json';
  static const String lottieClouds = 'assets/lottie/clouds.json';
  static const String lottieReading = 'assets/lottie/reading.json';
  static const String lottieEmpty = 'assets/lottie/empty.json';

  // Font Sizes
  static const double fontSizeSmall = 16.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeExtraLarge = 24.0;
}
