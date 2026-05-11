// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvDetailGenre _$TvDetailGenreFromJson(Map<String, dynamic> json) =>
    TvDetailGenre(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$TvDetailGenreToJson(TvDetailGenre instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

TvNetwork _$TvNetworkFromJson(Map<String, dynamic> json) => TvNetwork(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  logoPath: json['logo_path'] as String?,
  originCountry: json['origin_country'] as String?,
);

Map<String, dynamic> _$TvNetworkToJson(TvNetwork instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logo_path': instance.logoPath,
  'origin_country': instance.originCountry,
};

TvSeason _$TvSeasonFromJson(Map<String, dynamic> json) => TvSeason(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  seasonNumber: (json['season_number'] as num).toInt(),
  episodeCount: (json['episode_count'] as num?)?.toInt(),
  posterPath: json['poster_path'] as String?,
  airDate: json['air_date'] as String?,
  overview: json['overview'] as String?,
);

Map<String, dynamic> _$TvSeasonToJson(TvSeason instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'season_number': instance.seasonNumber,
  'episode_count': instance.episodeCount,
  'poster_path': instance.posterPath,
  'air_date': instance.airDate,
  'overview': instance.overview,
};

TvDetail _$TvDetailFromJson(Map<String, dynamic> json) => TvDetail(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  voteAverage: (json['vote_average'] as num).toDouble(),
  firstAirDate: json['first_air_date'] as String?,
  numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt(),
  numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>)
      .map((e) => TvDetailGenre.fromJson(e as Map<String, dynamic>))
      .toList(),
  seasons: (json['seasons'] as List<dynamic>)
      .map((e) => TvSeason.fromJson(e as Map<String, dynamic>))
      .toList(),
  networks: (json['networks'] as List<dynamic>)
      .map((e) => TvNetwork.fromJson(e as Map<String, dynamic>))
      .toList(),
  languages: (json['languages'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  status: json['status'] as String?,
  tagline: json['tagline'] as String?,
);

Map<String, dynamic> _$TvDetailToJson(TvDetail instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'overview': instance.overview,
  'poster_path': instance.posterPath,
  'backdrop_path': instance.backdropPath,
  'vote_average': instance.voteAverage,
  'first_air_date': instance.firstAirDate,
  'number_of_seasons': instance.numberOfSeasons,
  'number_of_episodes': instance.numberOfEpisodes,
  'genres': instance.genres,
  'seasons': instance.seasons,
  'networks': instance.networks,
  'languages': instance.languages,
  'episode_run_time': instance.episodeRunTime,
  'status': instance.status,
  'tagline': instance.tagline,
};

TvEpisodeDetail _$TvEpisodeDetailFromJson(Map<String, dynamic> json) =>
    TvEpisodeDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String,
      episodeNumber: (json['episode_number'] as num).toInt(),
      seasonNumber: (json['season_number'] as num).toInt(),
      stillPath: json['still_path'] as String?,
      airDate: json['air_date'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      runtime: (json['runtime'] as num?)?.toInt(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => TvCrew.fromJson(e as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List<dynamic>?)
          ?.map((e) => TvGuestStar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvEpisodeDetailToJson(TvEpisodeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'episode_number': instance.episodeNumber,
      'season_number': instance.seasonNumber,
      'still_path': instance.stillPath,
      'air_date': instance.airDate,
      'vote_average': instance.voteAverage,
      'runtime': instance.runtime,
      'vote_count': instance.voteCount,
      'crew': instance.crew,
      'guest_stars': instance.guestStars,
    };

TvSeasonDetail _$TvSeasonDetailFromJson(Map<String, dynamic> json) =>
    TvSeasonDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String?,
      seasonNumber: (json['season_number'] as num).toInt(),
      posterPath: json['poster_path'] as String?,
      airDate: json['air_date'] as String?,
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => TvEpisodeDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvSeasonDetailToJson(TvSeasonDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'season_number': instance.seasonNumber,
      'poster_path': instance.posterPath,
      'air_date': instance.airDate,
      'episodes': instance.episodes,
    };

TvCrew _$TvCrewFromJson(Map<String, dynamic> json) => TvCrew(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  originalName: json['original_name'] as String,
  department: json['department'] as String,
  job: json['job'] as String,
  creditId: json['credit_id'] as String,
  adult: json['adult'] as bool?,
  gender: (json['gender'] as num?)?.toInt(),
  knownForDepartment: json['known_for_department'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
  profilePath: json['profile_path'] as String?,
);

Map<String, dynamic> _$TvCrewToJson(TvCrew instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'original_name': instance.originalName,
  'department': instance.department,
  'job': instance.job,
  'credit_id': instance.creditId,
  'adult': instance.adult,
  'gender': instance.gender,
  'known_for_department': instance.knownForDepartment,
  'popularity': instance.popularity,
  'profile_path': instance.profilePath,
};

TvGuestStar _$TvGuestStarFromJson(Map<String, dynamic> json) => TvGuestStar(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  originalName: json['original_name'] as String,
  character: json['character'] as String,
  creditId: json['credit_id'] as String,
  order: (json['order'] as num).toInt(),
  adult: json['adult'] as bool?,
  gender: (json['gender'] as num?)?.toInt(),
  knownForDepartment: json['known_for_department'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
  profilePath: json['profile_path'] as String?,
);

Map<String, dynamic> _$TvGuestStarToJson(TvGuestStar instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
      'adult': instance.adult,
      'gender': instance.gender,
      'known_for_department': instance.knownForDepartment,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };
