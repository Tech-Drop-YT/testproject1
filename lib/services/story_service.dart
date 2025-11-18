import '../models/story.dart';
import '../data/stories_data.dart';

class StoryService {
  Future<List<Story>> getAllStories() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return StoriesData.stories;
  }

  Future<Story?> getStoryById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return StoriesData.stories.firstWhere((story) => story.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Story>> getStoriesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (category == 'All') {
      return StoriesData.stories;
    }
    return StoriesData.stories
        .where((story) => story.category == category)
        .toList();
  }
}
