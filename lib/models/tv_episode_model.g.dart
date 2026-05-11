// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvEpisode _$TvEpisodeFromJson(Map<String, dynamic> json) => TvEpisode(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  overview: json['overview'] as String,
  airDate: json['air_date'] as String?,
  episodeNumber: (json['episode_number'] as num).toInt(),
  seasonNumber: (json['season_number'] as num).toInt(),
  showId: (json['show_id'] as num).toInt(),
  stillPath: json['still_path'] as String?,
  voteAverage: (json['vote_average'] as num).toDouble(),
);

Map<String, dynamic> _$TvEpisodeToJson(TvEpisode instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'overview': instance.overview,
  'air_date': instance.airDate,
  'episode_number': instance.episodeNumber,
  'season_number': instance.seasonNumber,
  'show_id': instance.showId,
  'still_path': instance.stillPath,
  'vote_average': instance.voteAverage,
};

TvEpisodeResponse _$TvEpisodeResponseFromJson(Map<String, dynamic> json) =>
    TvEpisodeResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => TvEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$TvEpisodeResponseToJson(TvEpisodeResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
