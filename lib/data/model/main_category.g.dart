// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCategory _$MainCategoryFromJson(Map<String, dynamic> json) => MainCategory(
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  subcategories:
      (json['subcategories'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$MainCategoryToJson(MainCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'subcategories': instance.subcategories,
    };
