import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'list_model.g.dart';

@JsonSerializable()
class TmdbList {
  @JsonKey(name: 'created_by')
  final String? createdBy;
  final String? description;
  @JsonKey(name: 'favorite_count')
  final int favoriteCount;
  final String id;
  final List<Movie>? items;
  @JsonKey(name: 'item_count')
  final int? itemCount;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  final String? name;
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  TmdbList({
    this.createdBy,
    this.description,
    required this.favoriteCount,
    required this.id,
    this.items,
    this.itemCount,
    this.iso6391,
    this.name,
    this.posterPath,
  });

  factory TmdbList.fromJson(Map<String, dynamic> json) => _$TmdbListFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbListToJson(this);
}

@JsonSerializable()
class ListItemStatus {
  final int id;
  @JsonKey(name: 'item_present')
  final bool itemPresent;

  ListItemStatus({required this.id, required this.itemPresent});

  factory ListItemStatus.fromJson(Map<String, dynamic> json) => _$ListItemStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ListItemStatusToJson(this);
}
