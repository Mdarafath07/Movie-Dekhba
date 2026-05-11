// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindResponse _$FindResponseFromJson(Map<String, dynamic> json) => FindResponse(
  movieResults: (json['movie_results'] as List<dynamic>)
      .map((e) => Movie.fromJson(e as Map<String, dynamic>))
      .toList(),
  personResults: (json['person_results'] as List<dynamic>)
      .map((e) => Person.fromJson(e as Map<String, dynamic>))
      .toList(),
  tvResults: (json['tv_results'] as List<dynamic>)
      .map((e) => TvShow.fromJson(e as Map<String, dynamic>))
      .toList(),
  tvEpisodeResults: (json['tv_episode_results'] as List<dynamic>)
      .map((e) => TvEpisode.fromJson(e as Map<String, dynamic>))
      .toList(),
  tvSeasonResults: json['tv_season_results'] as List<dynamic>,
);

Map<String, dynamic> _$FindResponseToJson(FindResponse instance) =>
    <String, dynamic>{
      'movie_results': instance.movieResults,
      'person_results': instance.personResults,
      'tv_results': instance.tvResults,
      'tv_episode_results': instance.tvEpisodeResults,
      'tv_season_results': instance.tvSeasonResults,
    };
