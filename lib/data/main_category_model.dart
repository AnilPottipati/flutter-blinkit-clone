class MainCategory {
  final String name;
  final String imageUrl;
  final List<String> subcategories; // Or List<SubCategory> if you have a SubCategory model

  MainCategory({
    required this.name,
    required this.imageUrl,
    required this.subcategories,
  });

  // If you plan to use this with Firestore or similar, you might add:
  // factory MainCategory.fromMap(Map<String, dynamic> map) {
  //   return MainCategory(
  //     name: map['name'] ?? '',
  //     imageUrl: map['imageUrl'] ?? '',
  //     subcategories: List<String>.from(map['subcategories'] ?? []),
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     'imageUrl': imageUrl,
  //     'subcategories': subcategories,
  //   };
  // }
}
