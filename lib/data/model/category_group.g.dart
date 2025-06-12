// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryGroup _$CategoryGroupFromJson(Map<String, dynamic> json) =>
    CategoryGroup(
      title: json['title'] as String,
      categories:
          (json['categories'] as List<dynamic>)
              .map((e) => MainCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CategoryGroupToJson(CategoryGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
    };
