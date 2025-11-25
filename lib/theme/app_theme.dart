import 'package:flutter/material.dart';

class AppTheme {
  // Brand Color
  static const Color electricBlue = Color(0xFF2962FF);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color darkSurface = Color(0xFF1A1F2E);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B8C1);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: electricBlue,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: electricBlue,
      secondary: electricBlue,
      surface: lightSurface,
      background: lightBackground,
      error: Color(0xFFDC2626),
    ),
    cardTheme: CardTheme(
      color: lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black.withOpacity(0.05),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightText),
      titleTextStyle: TextStyle(
        color: lightText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: lightText,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: lightText,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: lightText,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: lightText,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: lightText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: lightText,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: lightTextSecondary,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: electricBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: electricBlue, width: 2),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: electricBlue,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: electricBlue,
      secondary: electricBlue,
      surface: darkSurface,
      background: darkBackground,
      error: Color(0xFFEF4444),
    ),
    cardTheme: CardTheme(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: electricBlue.withOpacity(0.1),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkText),
      titleTextStyle: TextStyle(
        color: darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: darkText,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: darkText,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: darkText,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: darkText,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkText,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: darkTextSecondary,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: electricBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: electricBlue.withOpacity(0.3),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: electricBlue, width: 2),
      ),
    ),
  );
}
