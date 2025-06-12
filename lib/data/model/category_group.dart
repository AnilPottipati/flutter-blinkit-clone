import 'package:json_annotation/json_annotation.dart';
import 'main_category.dart';

part 'category_group.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryGroup {
  final String title;
  final List<MainCategory> categories;

  CategoryGroup({
    required this.title,
    required this.categories,
  });

  factory CategoryGroup.fromJson(Map<String, dynamic> json) => _$CategoryGroupFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryGroupToJson(this);
}
