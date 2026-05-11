import 'package:json_annotation/json_annotation.dart';

part 'tv_episode_detail_model.g.dart';

@JsonSerializable()
class TvEpisodeCastMember {
  final int id;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final String character;
  @JsonKey(name: 'credit_id')
  final String creditId;
  final int order;
  final bool? adult;
  final int? gender;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final double? popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  TvEpisodeCastMember({
    required this.id,
    required this.name,
    required this.originalName,
    required this.character,
    required this.creditId,
    required this.order,
    this.adult,
    this.gender,
    this.knownForDepartment,
    this.popularity,
    this.profilePath,
  });

  factory TvEpisodeCastMember.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeCastMemberFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeCastMemberToJson(this);
}

@JsonSerializable()
class TvEpisodeCrewMember {
  final int id;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final String department;
  final String job;
  @JsonKey(name: 'credit_id')
  final String creditId;
  final bool? adult;
  final int? gender;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final double? popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  TvEpisodeCrewMember({
    required this.id,
    required this.name,
    required this.originalName,
    required this.department,
    required this.job,
    required this.creditId,
    this.adult,
    this.gender,
    this.knownForDepartment,
    this.popularity,
    this.profilePath,
  });

  factory TvEpisodeCrewMember.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeCrewMemberFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeCrewMemberToJson(this);
}

/// Full response from /3/tv/{series_id}/season/{season_number}/episode/{episode_number}
@JsonSerializable()
class TvEpisodeFullDetail {
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'episode_number')
  final int episodeNumber;
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @JsonKey(name: 'still_path')
  final String? stillPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final int? runtime;
  @JsonKey(name: 'production_code')
  final String? productionCode;
  final List<TvEpisodeCrewMember>? crew;
  @JsonKey(name: 'guest_stars')
  final List<TvEpisodeCastMember>? guestStars;

  TvEpisodeFullDetail({
    required this.id,
    required this.name,
    required this.overview,
    this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    this.stillPath,
    required this.voteAverage,
    this.voteCount,
    this.runtime,
    this.productionCode,
    this.crew,
    this.guestStars,
  });

  factory TvEpisodeFullDetail.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeFullDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeFullDetailToJson(this);
}

/// Response from /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/credits
@JsonSerializable()
class TvEpisodeCredits {
  final int id;
  final List<TvEpisodeCastMember> cast;
  final List<TvEpisodeCrewMember> crew;
  @JsonKey(name: 'guest_stars')
  final List<TvEpisodeCastMember> guestStars;

  TvEpisodeCredits({
    required this.id,
    required this.cast,
    required this.crew,
    required this.guestStars,
  });

  factory TvEpisodeCredits.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeCreditsFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeCreditsToJson(this);
}

/// Response from /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/external_ids
@JsonSerializable()
class TvEpisodeExternalIds {
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'freebase_mid')
  final String? freebaseMid;
  @JsonKey(name: 'freebase_id')
  final String? freebaseId;
  @JsonKey(name: 'tvdb_id')
  final int? tvdbId;
  @JsonKey(name: 'tvrage_id')
  final int? tvrageId;
  @JsonKey(name: 'wikidata_id')
  final String? wikidataId;

  TvEpisodeExternalIds({
    required this.id,
    this.imdbId,
    this.freebaseMid,
    this.freebaseId,
    this.tvdbId,
    this.tvrageId,
    this.wikidataId,
  });

  factory TvEpisodeExternalIds.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeExternalIdsFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeExternalIdsToJson(this);
}

/// A single still image for an episode
@JsonSerializable()
class TvEpisodeStill {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  final int height;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final int width;

  TvEpisodeStill({
    required this.aspectRatio,
    required this.height,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory TvEpisodeStill.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeStillFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeStillToJson(this);
}

/// Response from /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/images
@JsonSerializable()
class TvEpisodeImages {
  final int id;
  final List<TvEpisodeStill> stills;

  TvEpisodeImages({required this.id, required this.stills});

  factory TvEpisodeImages.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeImagesFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeImagesToJson(this);
}

/// A video result
@JsonSerializable()
class TvEpisodeVideo {
  final String id;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  @JsonKey(name: 'published_at')
  final String? publishedAt;

  TvEpisodeVideo({
    required this.id,
    this.iso6391,
    this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    this.publishedAt,
  });

  factory TvEpisodeVideo.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeVideoFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeVideoToJson(this);
}

/// Response from /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/videos
@JsonSerializable()
class TvEpisodeVideosResponse {
  final int id;
  final List<TvEpisodeVideo> results;

  TvEpisodeVideosResponse({required this.id, required this.results});

  factory TvEpisodeVideosResponse.fromJson(Map<String, dynamic> json) =>
      _$TvEpisodeVideosResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeVideosResponseToJson(this);
}
