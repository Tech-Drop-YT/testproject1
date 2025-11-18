class StoryPage {
  final String text;
  final String image;

  StoryPage({
    required this.text,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'image': image,
    };
  }

  factory StoryPage.fromJson(Map<String, dynamic> json) {
    return StoryPage(
      text: json['text'] as String,
      image: json['image'] as String,
    );
  }
}
