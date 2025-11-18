import 'package:flutter/material.dart';
import '../models/story.dart';
import '../services/storage_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final StorageService _storageService;
  final List<String> _favoriteIds = [];

  FavoritesProvider(this._storageService) {
    _loadFavorites();
  }

  List<String> get favoriteIds => _favoriteIds;

  Future<void> _loadFavorites() async {
    final favorites = await _storageService.getFavorites();
    _favoriteIds.clear();
    _favoriteIds.addAll(favorites);
    notifyListeners();
  }

  bool isFavorite(String storyId) {
    return _favoriteIds.contains(storyId);
  }

  Future<void> toggleFavorite(Story story) async {
    if (_favoriteIds.contains(story.id)) {
      _favoriteIds.remove(story.id);
    } else {
      _favoriteIds.add(story.id);
    }
    await _storageService.saveFavorites(_favoriteIds);
    notifyListeners();
  }

  Future<void> addFavorite(String storyId) async {
    if (!_favoriteIds.contains(storyId)) {
      _favoriteIds.add(storyId);
      await _storageService.saveFavorites(_favoriteIds);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String storyId) async {
    _favoriteIds.remove(storyId);
    await _storageService.saveFavorites(_favoriteIds);
    notifyListeners();
  }

  int get favoriteCount => _favoriteIds.length;
}
