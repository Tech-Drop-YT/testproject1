import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final StorageService _storageService;
  ThemeMode _themeMode = ThemeMode.light;
  double _fontSize = 18.0;

  ThemeProvider(this._storageService) {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _loadPreferences() async {
    _themeMode = await _storageService.getThemeMode();
    _fontSize = await _storageService.getFontSize();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _storageService.saveThemeMode(_themeMode);
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await _storageService.saveFontSize(size);
    notifyListeners();
  }
}
