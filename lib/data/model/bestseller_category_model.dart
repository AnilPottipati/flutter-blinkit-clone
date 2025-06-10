class BestsellerCategory {
  final String id;
  final String name;
  final int moreCount;
  final List<String> imageUrls; // Should contain exactly 4 image URLs

  BestsellerCategory({
    required this.id,
    required this.name,
    required this.moreCount,
    required this.imageUrls,
  }) : assert(imageUrls.length == 4, 'BestsellerCategory must have exactly 4 image URLs');

  factory BestsellerCategory.fromJson(Map<String, dynamic> json) {
    return BestsellerCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      moreCount: json['moreCount'] as int,
      imageUrls: List<String>.from(json['imageUrls'] as List<dynamic>),
    );
  }
}
