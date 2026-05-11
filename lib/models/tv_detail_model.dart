import 'package:json_annotation/json_annotation.dart';

part 'tv_detail_model.g.dart';

@JsonSerializable()
class TvDetailGenre {
  final int id;
  final String name;

  TvDetailGenre({required this.id, required this.name});

  factory TvDetailGenre.fromJson(Map<String, dynamic> json) => _$TvDetailGenreFromJson(json);
  Map<String, dynamic> toJson() => _$TvDetailGenreToJson(this);
}

@JsonSerializable()
class TvNetwork {
  final int id;
  final String name;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  TvNetwork({required this.id, required this.name, this.logoPath, this.originCountry});

  factory TvNetwork.fromJson(Map<String, dynamic> json) => _$TvNetworkFromJson(json);
  Map<String, dynamic> toJson() => _$TvNetworkToJson(this);
}

@JsonSerializable()
class TvSeason {
  final int id;
  final String name;
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @JsonKey(name: 'episode_count')
  final int? episodeCount;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'air_date')
  final String? airDate;
  final String? overview;

  TvSeason({
    required this.id,
    required this.name,
    required this.seasonNumber,
    this.episodeCount,
    this.posterPath,
    this.airDate,
    this.overview,
  });

  factory TvSeason.fromJson(Map<String, dynamic> json) => _$TvSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$TvSeasonToJson(this);
}

@JsonSerializable()
class TvDetail {
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @JsonKey(name: 'number_of_seasons')
  final int? numberOfSeasons;
  @JsonKey(name: 'number_of_episodes')
  final int? numberOfEpisodes;
  final List<TvDetailGenre> genres;
  final List<TvSeason> seasons;
  final List<TvNetwork> networks;
  final List<String> languages;
  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRunTime;
  final String? status;
  final String? tagline;

  TvDetail({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    this.firstAirDate,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    required this.genres,
    required this.seasons,
    required this.networks,
    required this.languages,
    this.episodeRunTime,
    this.status,
    this.tagline,
  });

  factory TvDetail.fromJson(Map<String, dynamic> json) => _$TvDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TvDetailToJson(this);
}

@JsonSerializable()
class TvEpisodeDetail {
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'episode_number')
  final int episodeNumber;
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @JsonKey(name: 'still_path')
  final String? stillPath;
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  final int? runtime;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final List<TvCrew>? crew;
  @JsonKey(name: 'guest_stars')
  final List<TvGuestStar>? guestStars;

  TvEpisodeDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    required this.seasonNumber,
    this.stillPath,
    this.airDate,
    required this.voteAverage,
    this.runtime,
    this.voteCount,
    this.crew,
    this.guestStars,
  });

  factory TvEpisodeDetail.fromJson(Map<String, dynamic> json) => _$TvEpisodeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeDetailToJson(this);
}

@JsonSerializable()
class TvSeasonDetail {
  final int id;
  final String name;
  final String? overview;
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'air_date')
  final String? airDate;
  final List<TvEpisodeDetail> episodes;

  TvSeasonDetail({
    required this.id,
    required this.name,
    this.overview,
    required this.seasonNumber,
    this.posterPath,
    this.airDate,
    required this.episodes,
  });

  factory TvSeasonDetail.fromJson(Map<String, dynamic> json) => _$TvSeasonDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TvSeasonDetailToJson(this);
}

@JsonSerializable()
class TvCrew {
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

  TvCrew({
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

  factory TvCrew.fromJson(Map<String, dynamic> json) => _$TvCrewFromJson(json);
  Map<String, dynamic> toJson() => _$TvCrewToJson(this);
}

@JsonSerializable()
class TvGuestStar {
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

  TvGuestStar({
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

  factory TvGuestStar.fromJson(Map<String, dynamic> json) => _$TvGuestStarFromJson(json);
  Map<String, dynamic> toJson() => _$TvGuestStarToJson(this);
}
