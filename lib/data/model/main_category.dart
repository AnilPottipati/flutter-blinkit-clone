import 'package:json_annotation/json_annotation.dart';

part 'main_category.g.dart';

@JsonSerializable()
class MainCategory {
  final String name;
  final String imageUrl; // Placeholder image URL
  final List<String> subcategories;

  MainCategory({
    required this.name,
    required this.imageUrl,
    required this.subcategories,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => _$MainCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$MainCategoryToJson(this);
}
