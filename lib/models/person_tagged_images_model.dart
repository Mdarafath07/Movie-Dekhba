import 'package:json_annotation/json_annotation.dart';

part 'person_tagged_images_model.g.dart';

// ---------------------------------------------------------------------------
// Tagged media — polymorphic (movie or tv_episode)
// ---------------------------------------------------------------------------

@JsonSerializable()
class TaggedMedia {
  final int id;

  /// Present for movies
  final String? title;

  /// Present for tv_episodes
  final String? name;

  final String? overview;

  @JsonKey(name: 'media_type')
  final String mediaType;

  /// movie fields
  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  final double? popularity;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  final bool? video;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// tv_episode fields
  @JsonKey(name: 'air_date')
  final String? airDate;

  @JsonKey(name: 'episode_number')
  final int? episodeNumber;

  @JsonKey(name: 'production_code')
  final String? productionCode;

  final int? runtime;

  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  @JsonKey(name: 'show_id')
  final int? showId;

  @JsonKey(name: 'still_path')
  final String? stillPath;

  const TaggedMedia({
    required this.id,
    this.title,
    this.name,
    this.overview,
    required this.mediaType,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  factory TaggedMedia.fromJson(Map<String, dynamic> json) =>
      _$TaggedMediaFromJson(json);

  Map<String, dynamic> toJson() => _$TaggedMediaToJson(this);
}

// ---------------------------------------------------------------------------
// Tagged image result item
// ---------------------------------------------------------------------------

@JsonSerializable()
class TaggedImage {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;

  @JsonKey(name: 'file_path')
  final String filePath;

  final int height;
  final int width;

  /// String ID from TMDB (not an int)
  final String id;

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  @JsonKey(name: 'image_type')
  final String imageType;

  final TaggedMedia media;

  @JsonKey(name: 'media_type')
  final String mediaType;

  const TaggedImage({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.width,
    required this.id,
    this.iso6391,
    required this.voteAverage,
    required this.voteCount,
    required this.imageType,
    required this.media,
    required this.mediaType,
  });

  factory TaggedImage.fromJson(Map<String, dynamic> json) =>
      _$TaggedImageFromJson(json);

  Map<String, dynamic> toJson() => _$TaggedImageToJson(this);
}

// ---------------------------------------------------------------------------
// Paginated response wrapper
// ---------------------------------------------------------------------------

@JsonSerializable()
class PersonTaggedImagesResponse {
  final int id;
  final int page;
  final List<TaggedImage> results;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  const PersonTaggedImagesResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PersonTaggedImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonTaggedImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonTaggedImagesResponseToJson(this);
}
