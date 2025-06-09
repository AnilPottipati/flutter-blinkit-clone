class FeaturedItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  FeaturedItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  factory FeaturedItem.fromJson(Map<String, dynamic> json) {
    return FeaturedItem(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
