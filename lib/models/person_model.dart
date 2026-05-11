import 'package:json_annotation/json_annotation.dart';

part 'person_model.g.dart';

/// A media item (movie or TV show) that the person is known for.
@JsonSerializable()
class KnownForItem {
  final int id;
  @JsonKey(name: 'media_type')
  final String mediaType;
  /// Title (movies) or name (TV shows)
  final String? title;
  final String? name;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final String? overview;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  KnownForItem({
    required this.id,
    required this.mediaType,
    this.title,
    this.name,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
    this.firstAirDate,
    this.genreIds,
  });

  /// Display title regardless of media type
  String get displayTitle => title ?? name ?? '';

  factory KnownForItem.fromJson(Map<String, dynamic> json) => _$KnownForItemFromJson(json);
  Map<String, dynamic> toJson() => _$KnownForItemToJson(this);
}

@JsonSerializable()
class Person {
  final int id;
  final String name;
  final bool? adult;
  /// 0 = not set, 1 = female, 2 = male, 3 = non-binary
  final int? gender;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  final double popularity;
  @JsonKey(name: 'known_for')
  final List<KnownForItem>? knownFor;

  Person({
    required this.id,
    required this.name,
    this.adult,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    required this.popularity,
    this.knownFor,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class PersonResponse {
  final int page;
  final List<Person> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  PersonResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PersonResponse.fromJson(Map<String, dynamic> json) => _$PersonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);
}
