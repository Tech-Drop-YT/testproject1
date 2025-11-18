import 'package:flutter/material.dart';
import '../models/story.dart';
import '../services/story_service.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService _storyService;
  List<Story> _stories = [];
  bool _isLoading = false;
  String _selectedCategory = 'All';

  StoryProvider(this._storyService) {
    loadStories();
  }

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  Future<void> loadStories() async {
    _isLoading = true;
    notifyListeners();

    _stories = await _storyService.getAllStories();

    _isLoading = false;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Story> get filteredStories {
    if (_selectedCategory == 'All') {
      return _stories;
    }
    return _stories.where((story) => story.category == _selectedCategory).toList();
  }

  List<Story> getStoriesByCategory(String category) {
    if (category == 'All') {
      return _stories;
    }
    return _stories.where((story) => story.category == category).toList();
  }

  List<Story> getTrendingStories() {
    return _stories.where((story) => story.rating >= 4.5).take(5).toList();
  }

  List<Story> getSuggestedStories() {
    return _stories.take(6).toList();
  }

  Story? getStoryById(String id) {
    try {
      return _stories.firstWhere((story) => story.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Story> getFavoriteStories(List<String> favoriteIds) {
    return _stories.where((story) => favoriteIds.contains(story.id)).toList();
  }

  List<Story> getCartStories(List<String> cartIds) {
    return _stories.where((story) => cartIds.contains(story.id)).toList();
  }

  List<Story> searchStories(String query) {
    if (query.isEmpty) return _stories;

    final lowercaseQuery = query.toLowerCase();
    return _stories.where((story) {
      return story.title.toLowerCase().contains(lowercaseQuery) ||
          story.description.toLowerCase().contains(lowercaseQuery) ||
          story.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
