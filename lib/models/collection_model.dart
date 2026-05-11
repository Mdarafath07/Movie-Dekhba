import 'package:json_annotation/json_annotation.dart';

part 'collection_model.g.dart';

@JsonSerializable()
class Collection {
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final List<CollectionPart>? parts;

  Collection({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.parts,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

@JsonSerializable()
class CollectionPart {
  final int id;
  final String title;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;

  CollectionPart({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
  });

  factory CollectionPart.fromJson(Map<String, dynamic> json) => _$CollectionPartFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionPartToJson(this);
}

@JsonSerializable()
class BelongsToCollection {
  final int id;
  final String name;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => _$BelongsToCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable()
class SearchCollectionResult {
  final int id;
  final String name;
  @JsonKey(name: 'original_name')
  final String? originalName;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final bool? adult;

  SearchCollectionResult({
    required this.id,
    required this.name,
    this.originalName,
    this.originalLanguage,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.adult,
  });

  factory SearchCollectionResult.fromJson(Map<String, dynamic> json) =>
      _$SearchCollectionResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCollectionResultToJson(this);
}

@JsonSerializable()
class SearchCollectionResponse {
  final int page;
  final List<SearchCollectionResult> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  SearchCollectionResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCollectionResponseToJson(this);
}
