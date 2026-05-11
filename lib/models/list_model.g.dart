// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbList _$TmdbListFromJson(Map<String, dynamic> json) => TmdbList(
  createdBy: json['created_by'] as String?,
  description: json['description'] as String?,
  favoriteCount: (json['favorite_count'] as num).toInt(),
  id: json['id'] as String,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
      .toList(),
  itemCount: (json['item_count'] as num?)?.toInt(),
  iso6391: json['iso_639_1'] as String?,
  name: json['name'] as String?,
  posterPath: json['poster_path'] as String?,
);

Map<String, dynamic> _$TmdbListToJson(TmdbList instance) => <String, dynamic>{
  'created_by': instance.createdBy,
  'description': instance.description,
  'favorite_count': instance.favoriteCount,
  'id': instance.id,
  'items': instance.items,
  'item_count': instance.itemCount,
  'iso_639_1': instance.iso6391,
  'name': instance.name,
  'poster_path': instance.posterPath,
};

ListItemStatus _$ListItemStatusFromJson(Map<String, dynamic> json) =>
    ListItemStatus(
      id: (json['id'] as num).toInt(),
      itemPresent: json['item_present'] as bool,
    );

Map<String, dynamic> _$ListItemStatusToJson(ListItemStatus instance) =>
    <String, dynamic>{'id': instance.id, 'item_present': instance.itemPresent};
