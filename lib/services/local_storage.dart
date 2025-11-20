import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _themeKey = 'theme_mode';
  static const String _historyKey = 'calculation_history';
  static const String _vibrationKey = 'vibration_enabled';
  static const String _soundKey = 'sound_enabled';

  // Theme Management
  Future<bool> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_themeKey, isDarkMode);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Default to light mode
  }

  // History Management
  Future<bool> saveHistory(List<Map<String, String>> history) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(history);
    return await prefs.setString(_historyKey, jsonString);
  }

  Future<List<Map<String, String>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((item) => Map<String, String>.from(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_historyKey);
  }

  Future<bool> addToHistory(String expression, String result) async {
    final history = await getHistory();
    history.insert(0, {
      'expression': expression,
      'result': result,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Keep only last 100 calculations
    if (history.length > 100) {
      history.removeRange(100, history.length);
    }

    return await saveHistory(history);
  }

  // Settings Management
  Future<bool> saveVibrationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_vibrationKey, enabled);
  }

  Future<bool> getVibrationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_vibrationKey) ?? true; // Default enabled
  }

  Future<bool> saveSoundEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_soundKey, enabled);
  }

  Future<bool> getSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundKey) ?? false; // Default disabled
  }

  // Clear all data
  Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
