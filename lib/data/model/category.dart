import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String id;
  final String name;
  final String iconUrl;
  final List<String> productImageUrls;
  final int moreItemsCount;

  Category({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.productImageUrls,
    required this.moreItemsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
