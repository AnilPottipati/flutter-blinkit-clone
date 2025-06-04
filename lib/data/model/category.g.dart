// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  iconUrl: json['iconUrl'] as String,
  productImageUrls:
      (json['productImageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  moreItemsCount: (json['moreItemsCount'] as num).toInt(),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'iconUrl': instance.iconUrl,
  'productImageUrls': instance.productImageUrls,
  'moreItemsCount': instance.moreItemsCount,
};
