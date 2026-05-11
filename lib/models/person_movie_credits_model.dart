import 'package:json_annotation/json_annotation.dart';

part 'person_movie_credits_model.g.dart';

/// A single movie credit item — used for both cast and crew entries.
/// Returned inside GET /3/person/{person_id}/movie_credits.
@JsonSerializable()
class MovieCreditItem {
  final int id;
  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  final String? overview;
  final double? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  final String? title;
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  // --- Cast-specific fields ---

  /// Role name; present on cast entries.
  final String? character;

  @JsonKey(name: 'credit_id')
  final String? creditId;

  /// Billing order — lower = more prominent; present on cast entries.
  final int? order;

  // --- Crew-specific fields ---

  /// e.g. "Directing", "Production"; present on crew entries.
  final String? department;

  /// e.g. "Director", "Producer"; present on crew entries.
  final String? job;

  MovieCreditItem({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool get isCastEntry => character != null;
  bool get isCrewEntry => department != null;

  factory MovieCreditItem.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditItemFromJson(json);
  Map<String, dynamic> toJson() => _$MovieCreditItemToJson(this);
}

/// Top-level response from GET /3/person/{person_id}/movie_credits.
@JsonSerializable()
class PersonMovieCreditsResponse {
  final int id;
  final List<MovieCreditItem> cast;
  final List<MovieCreditItem> crew;

  PersonMovieCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory PersonMovieCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonMovieCreditsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PersonMovieCreditsResponseToJson(this);
}
