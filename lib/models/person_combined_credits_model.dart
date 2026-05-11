import 'package:json_annotation/json_annotation.dart';

part 'person_combined_credits_model.g.dart';

/// A single credit item from the combined credits endpoint.
/// Covers both movies (`media_type == "movie"`) and
/// TV shows (`media_type == "tv"`).
@JsonSerializable()
class CombinedCreditItem {
  final int id;

  /// "movie" or "tv"
  @JsonKey(name: 'media_type')
  final String mediaType;

  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  final String? overview;
  final double? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  // --- Movie-specific fields ---

  /// Available when media_type == "movie"
  final String? title;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  final bool? video;

  // --- TV-specific fields ---

  /// Available when media_type == "tv"
  final String? name;

  @JsonKey(name: 'original_name')
  final String? originalName;

  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;

  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  /// Number of episodes (TV only, on crew items too)
  @JsonKey(name: 'episode_count')
  final int? episodeCount;

  // --- Cast-specific fields ---
  final String? character;

  @JsonKey(name: 'credit_id')
  final String? creditId;

  /// Cast order (lower = more prominent role)
  final int? order;

  // --- Crew-specific fields ---
  final String? department;
  final String? job;

  CombinedCreditItem({
    required this.id,
    required this.mediaType,
    required this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.video,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
    this.episodeCount,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  /// Display-friendly title regardless of media type.
  String get displayTitle => title ?? name ?? '';

  /// Display-friendly date regardless of media type.
  String? get displayDate => releaseDate ?? firstAirDate;

  bool get isMovie => mediaType == 'movie';
  bool get isTv => mediaType == 'tv';

  factory CombinedCreditItem.fromJson(Map<String, dynamic> json) =>
      _$CombinedCreditItemFromJson(json);
  Map<String, dynamic> toJson() => _$CombinedCreditItemToJson(this);
}

/// Top-level response from /3/person/{person_id}/combined_credits.
@JsonSerializable()
class CombinedCreditsResponse {
  final int id;

  /// Movies and TV shows where the person acted.
  final List<CombinedCreditItem> cast;

  /// Movies and TV shows where the person worked behind the scenes.
  final List<CombinedCreditItem> crew;

  CombinedCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CombinedCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$CombinedCreditsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CombinedCreditsResponseToJson(this);
}
