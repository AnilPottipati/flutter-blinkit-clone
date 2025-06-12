class FeaturedItem {
  final String id;
  final String tag;
  final String title;
  final String? subtitle;
  final String imageUrl;
  final String? logoUrl; // For distinct logos like MIVI if not part of imageUrl

  FeaturedItem({
    required this.id,
    required this.tag,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    this.logoUrl,
  });

  factory FeaturedItem.fromJson(Map<String, dynamic> json) {
    return FeaturedItem(
      id: json['id'] as String,
      tag: json['tag'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String,
      logoUrl: json['logoUrl'] as String?,
    );
  }
}
