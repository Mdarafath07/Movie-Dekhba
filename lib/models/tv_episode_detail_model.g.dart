// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_episode_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvEpisodeCastMember _$TvEpisodeCastMemberFromJson(Map<String, dynamic> json) =>
    TvEpisodeCastMember(
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

Map<String, dynamic> _$TvEpisodeCastMemberToJson(
  TvEpisodeCastMember instance,
) => <String, dynamic>{
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

TvEpisodeCrewMember _$TvEpisodeCrewMemberFromJson(Map<String, dynamic> json) =>
    TvEpisodeCrewMember(
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

Map<String, dynamic> _$TvEpisodeCrewMemberToJson(
  TvEpisodeCrewMember instance,
) => <String, dynamic>{
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

TvEpisodeFullDetail _$TvEpisodeFullDetailFromJson(Map<String, dynamic> json) =>
    TvEpisodeFullDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String,
      airDate: json['air_date'] as String?,
      episodeNumber: (json['episode_number'] as num).toInt(),
      seasonNumber: (json['season_number'] as num).toInt(),
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      runtime: (json['runtime'] as num?)?.toInt(),
      productionCode: json['production_code'] as String?,
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => TvEpisodeCrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List<dynamic>?)
          ?.map((e) => TvEpisodeCastMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvEpisodeFullDetailToJson(
  TvEpisodeFullDetail instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'overview': instance.overview,
  'air_date': instance.airDate,
  'episode_number': instance.episodeNumber,
  'season_number': instance.seasonNumber,
  'still_path': instance.stillPath,
  'vote_average': instance.voteAverage,
  'vote_count': instance.voteCount,
  'runtime': instance.runtime,
  'production_code': instance.productionCode,
  'crew': instance.crew,
  'guest_stars': instance.guestStars,
};

TvEpisodeCredits _$TvEpisodeCreditsFromJson(Map<String, dynamic> json) =>
    TvEpisodeCredits(
      id: (json['id'] as num).toInt(),
      cast: (json['cast'] as List<dynamic>)
          .map((e) => TvEpisodeCastMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => TvEpisodeCrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List<dynamic>)
          .map((e) => TvEpisodeCastMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvEpisodeCreditsToJson(TvEpisodeCredits instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
      'crew': instance.crew,
      'guest_stars': instance.guestStars,
    };

TvEpisodeExternalIds _$TvEpisodeExternalIdsFromJson(
  Map<String, dynamic> json,
) => TvEpisodeExternalIds(
  id: (json['id'] as num).toInt(),
  imdbId: json['imdb_id'] as String?,
  freebaseMid: json['freebase_mid'] as String?,
  freebaseId: json['freebase_id'] as String?,
  tvdbId: (json['tvdb_id'] as num?)?.toInt(),
  tvrageId: (json['tvrage_id'] as num?)?.toInt(),
  wikidataId: json['wikidata_id'] as String?,
);

Map<String, dynamic> _$TvEpisodeExternalIdsToJson(
  TvEpisodeExternalIds instance,
) => <String, dynamic>{
  'id': instance.id,
  'imdb_id': instance.imdbId,
  'freebase_mid': instance.freebaseMid,
  'freebase_id': instance.freebaseId,
  'tvdb_id': instance.tvdbId,
  'tvrage_id': instance.tvrageId,
  'wikidata_id': instance.wikidataId,
};

TvEpisodeStill _$TvEpisodeStillFromJson(Map<String, dynamic> json) =>
    TvEpisodeStill(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: (json['height'] as num).toInt(),
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      width: (json['width'] as num).toInt(),
    );

Map<String, dynamic> _$TvEpisodeStillToJson(TvEpisodeStill instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };

TvEpisodeImages _$TvEpisodeImagesFromJson(Map<String, dynamic> json) =>
    TvEpisodeImages(
      id: (json['id'] as num).toInt(),
      stills: (json['stills'] as List<dynamic>)
          .map((e) => TvEpisodeStill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvEpisodeImagesToJson(TvEpisodeImages instance) =>
    <String, dynamic>{'id': instance.id, 'stills': instance.stills};

TvEpisodeVideo _$TvEpisodeVideoFromJson(Map<String, dynamic> json) =>
    TvEpisodeVideo(
      id: json['id'] as String,
      iso6391: json['iso_639_1'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: (json['size'] as num).toInt(),
      type: json['type'] as String,
      official: json['official'] as bool,
      publishedAt: json['published_at'] as String?,
    );

Map<String, dynamic> _$TvEpisodeVideoToJson(TvEpisodeVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iso_639_1': instance.iso6391,
      'iso_3166_1': instance.iso31661,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'published_at': instance.publishedAt,
    };

TvEpisodeVideosResponse _$TvEpisodeVideosResponseFromJson(
  Map<String, dynamic> json,
) => TvEpisodeVideosResponse(
  id: (json['id'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => TvEpisodeVideo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TvEpisodeVideosResponseToJson(
  TvEpisodeVideosResponse instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};
