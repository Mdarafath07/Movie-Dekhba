import 'package:json_annotation/json_annotation.dart';

part 'person_tv_credits_model.g.dart';

// ---------------------------------------------------------------------------
// TV cast credit item
// ---------------------------------------------------------------------------

@JsonSerializable()
class TvCastCreditItem {
  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  final int id;

  @JsonKey(name: 'origin_country')
  final List<String> originCountry;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  @JsonKey(name: 'original_name')
  final String originalName;

  final String overview;
  final double popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;

  final String name;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  final String? character;

  @JsonKey(name: 'credit_id')
  final String creditId;

  @JsonKey(name: 'episode_count')
  final int episodeCount;

  const TvCastCreditItem({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    this.character,
    required this.creditId,
    required this.episodeCount,
  });

  factory TvCastCreditItem.fromJson(Map<String, dynamic> json) =>
      _$TvCastCreditItemFromJson(json);

  Map<String, dynamic> toJson() => _$TvCastCreditItemToJson(this);
}

// ---------------------------------------------------------------------------
// TV crew credit item
// ---------------------------------------------------------------------------

@JsonSerializable()
class TvCrewCreditItem {
  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  final int id;

  @JsonKey(name: 'origin_country')
  final List<String> originCountry;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  @JsonKey(name: 'original_name')
  final String originalName;

  final String overview;
  final double popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;

  final String name;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  @JsonKey(name: 'credit_id')
  final String creditId;

  final String? department;
  final String? job;

  @JsonKey(name: 'episode_count')
  final int episodeCount;

  const TvCrewCreditItem({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.creditId,
    this.department,
    this.job,
    required this.episodeCount,
  });

  factory TvCrewCreditItem.fromJson(Map<String, dynamic> json) =>
      _$TvCrewCreditItemFromJson(json);

  Map<String, dynamic> toJson() => _$TvCrewCreditItemToJson(this);
}

// ---------------------------------------------------------------------------
// Response wrapper
// ---------------------------------------------------------------------------

@JsonSerializable()
class PersonTvCreditsResponse {
  final int id;
  final List<TvCastCreditItem> cast;
  final List<TvCrewCreditItem> crew;

  const PersonTvCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory PersonTvCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonTvCreditsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonTvCreditsResponseToJson(this);
}
