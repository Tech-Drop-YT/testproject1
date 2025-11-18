import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Favorites
  Future<List<String>> getFavorites() async {
    return _prefs.getStringList(AppConstants.keyFavorites) ?? [];
  }

  Future<bool> saveFavorites(List<String> favorites) async {
    return await _prefs.setStringList(AppConstants.keyFavorites, favorites);
  }

  // Cart
  Future<List<String>> getCart() async {
    return _prefs.getStringList(AppConstants.keyCart) ?? [];
  }

  Future<bool> saveCart(List<String> cart) async {
    return await _prefs.setStringList(AppConstants.keyCart, cart);
  }

  // Theme Mode
  Future<ThemeMode> getThemeMode() async {
    final isDark = _prefs.getBool(AppConstants.keyThemeMode) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<bool> saveThemeMode(ThemeMode mode) async {
    return await _prefs.setBool(
        AppConstants.keyThemeMode, mode == ThemeMode.dark);
  }

  // Font Size
  Future<double> getFontSize() async {
    return _prefs.getDouble(AppConstants.keyFontSize) ??
        AppConstants.fontSizeMedium;
  }

  Future<bool> saveFontSize(double size) async {
    return await _prefs.setDouble(AppConstants.keyFontSize, size);
  }

  // Onboarding
  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool(AppConstants.keyOnboardingComplete) ?? false;
  }

  Future<bool> setOnboardingComplete(bool complete) async {
    return await _prefs.setBool(AppConstants.keyOnboardingComplete, complete);
  }

  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
