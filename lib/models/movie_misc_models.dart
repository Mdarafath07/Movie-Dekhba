import 'package:json_annotation/json_annotation.dart';

part 'movie_misc_models.g.dart';

/// Represents alternative titles for a movie.
@JsonSerializable()
class AlternativeTitlesResponse {
  final int id;
  final List<AlternativeTitle> titles;

  AlternativeTitlesResponse({required this.id, required this.titles});

  factory AlternativeTitlesResponse.fromJson(Map<String, dynamic> json) => _$AlternativeTitlesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AlternativeTitlesResponseToJson(this);
}

@JsonSerializable()
class AlternativeTitle {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String title;
  final String type;

  AlternativeTitle({required this.iso31661, required this.title, required this.type});

  factory AlternativeTitle.fromJson(Map<String, dynamic> json) => _$AlternativeTitleFromJson(json);
  Map<String, dynamic> toJson() => _$AlternativeTitleToJson(this);
}

/// Represents external IDs for a movie.
@JsonSerializable()
class ExternalIds {
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'wikidata_id')
  final String? wikidataId;
  @JsonKey(name: 'facebook_id')
  final String? facebookId;
  @JsonKey(name: 'instagram_id')
  final String? instagramId;
  @JsonKey(name: 'twitter_id')
  final String? twitterId;

  ExternalIds({
    required this.id,
    this.imdbId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  factory ExternalIds.fromJson(Map<String, dynamic> json) => _$ExternalIdsFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalIdsToJson(this);
}

/// Represents the account state (favorite, watchlist, rated) for a movie.
@JsonSerializable()
class AccountState {
  final int id;
  final bool favorite;
  final bool watchlist;
  // `rated` can be a boolean false or an object `{"value": 9}`. We'll handle it dynamically or map it.
  final dynamic rated;

  AccountState({
    required this.id,
    required this.favorite,
    required this.watchlist,
    this.rated,
  });

  factory AccountState.fromJson(Map<String, dynamic> json) => _$AccountStateFromJson(json);
  Map<String, dynamic> toJson() => _$AccountStateToJson(this);
}

/// Represents movie images (backdrops, logos, posters).
@JsonSerializable()
class MovieImages {
  final int id;
  final List<MovieImageItem> backdrops;
  final List<MovieImageItem> logos;
  final List<MovieImageItem> posters;

  MovieImages({
    required this.id,
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  factory MovieImages.fromJson(Map<String, dynamic> json) => _$MovieImagesFromJson(json);
  Map<String, dynamic> toJson() => _$MovieImagesToJson(this);
}

@JsonSerializable()
class MovieImageItem {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final int width;

  MovieImageItem({
    required this.aspectRatio,
    required this.height,
    this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory MovieImageItem.fromJson(Map<String, dynamic> json) => _$MovieImageItemFromJson(json);
  Map<String, dynamic> toJson() => _$MovieImageItemToJson(this);
}
