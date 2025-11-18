import 'story_page.dart';

class Story {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String coverImage;
  final List<StoryPage> pages;
  final String category;
  final bool isPremium;
  final double rating;
  final int ageGroup;
  final String author;

  Story({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.coverImage,
    required this.pages,
    required this.category,
    required this.isPremium,
    this.rating = 4.5,
    this.ageGroup = 5,
    this.author = 'DreamyTales',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'coverImage': coverImage,
      'pages': pages.map((page) => page.toJson()).toList(),
      'category': category,
      'isPremium': isPremium,
      'rating': rating,
      'ageGroup': ageGroup,
      'author': author,
    };
  }

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      coverImage: json['coverImage'] as String,
      pages: (json['pages'] as List)
          .map((page) => StoryPage.fromJson(page as Map<String, dynamic>))
          .toList(),
      category: json['category'] as String,
      isPremium: json['isPremium'] as bool,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      ageGroup: json['ageGroup'] as int? ?? 5,
      author: json['author'] as String? ?? 'DreamyTales',
    );
  }

  Story copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnail,
    String? coverImage,
    List<StoryPage>? pages,
    String? category,
    bool? isPremium,
    double? rating,
    int? ageGroup,
    String? author,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      coverImage: coverImage ?? this.coverImage,
      pages: pages ?? this.pages,
      category: category ?? this.category,
      isPremium: isPremium ?? this.isPremium,
      rating: rating ?? this.rating,
      ageGroup: ageGroup ?? this.ageGroup,
      author: author ?? this.author,
    );
  }
}
