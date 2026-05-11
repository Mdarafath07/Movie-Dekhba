// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_multi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSearchResult _$MultiSearchResultFromJson(Map<String, dynamic> json) =>
    MultiSearchResult(
      mediaType: json['media_type'] as String,
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      profilePath: json['profile_path'] as String?,
      overview: json['overview'] as String?,
      originalLanguage: json['original_language'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
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
      gender: (json['gender'] as num?)?.toInt(),
      knownForDepartment: json['known_for_department'] as String?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => KnownForItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultiSearchResultToJson(MultiSearchResult instance) =>
    <String, dynamic>{
      'media_type': instance.mediaType,
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'profile_path': instance.profilePath,
      'overview': instance.overview,
      'original_language': instance.originalLanguage,
      'popularity': instance.popularity,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genre_ids': instance.genreIds,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'video': instance.video,
      'name': instance.name,
      'original_name': instance.originalName,
      'first_air_date': instance.firstAirDate,
      'origin_country': instance.originCountry,
      'gender': instance.gender,
      'known_for_department': instance.knownForDepartment,
      'known_for': instance.knownFor,
    };

MultiSearchResponse _$MultiSearchResponseFromJson(Map<String, dynamic> json) =>
    MultiSearchResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MultiSearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MultiSearchResponseToJson(
  MultiSearchResponse instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
