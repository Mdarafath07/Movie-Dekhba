// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_tv_credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvCastCreditItem _$TvCastCreditItemFromJson(Map<String, dynamic> json) =>
    TvCastCreditItem(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num).toInt(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      name: json['name'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      character: json['character'] as String?,
      creditId: json['credit_id'] as String,
      episodeCount: (json['episode_count'] as num).toInt(),
    );

Map<String, dynamic> _$TvCastCreditItemToJson(TvCastCreditItem instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate,
      'name': instance.name,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'character': instance.character,
      'credit_id': instance.creditId,
      'episode_count': instance.episodeCount,
    };

TvCrewCreditItem _$TvCrewCreditItemFromJson(Map<String, dynamic> json) =>
    TvCrewCreditItem(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num).toInt(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      name: json['name'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      creditId: json['credit_id'] as String,
      department: json['department'] as String?,
      job: json['job'] as String?,
      episodeCount: (json['episode_count'] as num).toInt(),
    );

Map<String, dynamic> _$TvCrewCreditItemToJson(TvCrewCreditItem instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate,
      'name': instance.name,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
      'episode_count': instance.episodeCount,
    };

PersonTvCreditsResponse _$PersonTvCreditsResponseFromJson(
  Map<String, dynamic> json,
) => PersonTvCreditsResponse(
  id: (json['id'] as num).toInt(),
  cast: (json['cast'] as List<dynamic>)
      .map((e) => TvCastCreditItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  crew: (json['crew'] as List<dynamic>)
      .map((e) => TvCrewCreditItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PersonTvCreditsResponseToJson(
  PersonTvCreditsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'cast': instance.cast,
  'crew': instance.crew,
};
