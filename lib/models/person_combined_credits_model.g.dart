// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_combined_credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombinedCreditItem _$CombinedCreditItemFromJson(Map<String, dynamic> json) =>
    CombinedCreditItem(
      id: (json['id'] as num).toInt(),
      mediaType: json['media_type'] as String,
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      originalLanguage: json['original_language'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      releaseDate: json['release_date'] as String?,
      video: json['video'] as bool?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      episodeCount: (json['episode_count'] as num?)?.toInt(),
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: (json['order'] as num?)?.toInt(),
      department: json['department'] as String?,
      job: json['job'] as String?,
    );

Map<String, dynamic> _$CombinedCreditItemToJson(CombinedCreditItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': instance.mediaType,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'video': instance.video,
      'name': instance.name,
      'original_name': instance.originalName,
      'first_air_date': instance.firstAirDate,
      'origin_country': instance.originCountry,
      'episode_count': instance.episodeCount,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
      'department': instance.department,
      'job': instance.job,
    };

CombinedCreditsResponse _$CombinedCreditsResponseFromJson(
  Map<String, dynamic> json,
) => CombinedCreditsResponse(
  id: (json['id'] as num).toInt(),
  cast: (json['cast'] as List<dynamic>)
      .map((e) => CombinedCreditItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  crew: (json['crew'] as List<dynamic>)
      .map((e) => CombinedCreditItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CombinedCreditsResponseToJson(
  CombinedCreditsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'cast': instance.cast,
  'crew': instance.crew,
};
