import 'package:json_annotation/json_annotation.dart';
import 'person_model.dart';

part 'search_multi_model.g.dart';

/// A single result from /search/multi.
///
/// The API returns movies, TV shows, and people in one list, discriminated by
/// [mediaType] ("movie" | "tv" | "person").  All type-specific fields are
/// nullable; use [mediaType] to decide which ones to access.
@JsonSerializable()
class MultiSearchResult {
  @JsonKey(name: 'media_type')
  final String mediaType;
  final int id;
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  final String? overview;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  final double? popularity;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  // ── Movie-specific ──────────────────────────────────────────
  final String? title;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final bool? video;

  // ── TV-specific ─────────────────────────────────────────────
  final String? name;
  @JsonKey(name: 'original_name')
  final String? originalName;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  // ── Person-specific ─────────────────────────────────────────
  final int? gender;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  @JsonKey(name: 'known_for')
  final List<KnownForItem>? knownFor;

  MultiSearchResult({
    required this.mediaType,
    required this.id,
    this.adult,
    this.backdropPath,
    this.posterPath,
    this.profilePath,
    this.overview,
    this.originalLanguage,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    this.genreIds,
    // Movie
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.video,
    // TV
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
    // Person
    this.gender,
    this.knownForDepartment,
    this.knownFor,
  });

  /// A human-readable display title regardless of media type.
  String get displayTitle => title ?? name ?? '';

  /// The image path to show (profile for people, poster for others).
  String? get displayImagePath =>
      mediaType == 'person' ? profilePath : posterPath;

  factory MultiSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MultiSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$MultiSearchResultToJson(this);
}

@JsonSerializable()
class MultiSearchResponse {
  final int page;
  final List<MultiSearchResult> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MultiSearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MultiSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$MultiSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MultiSearchResponseToJson(this);
}
