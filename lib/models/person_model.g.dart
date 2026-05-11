// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnownForItem _$KnownForItemFromJson(Map<String, dynamic> json) => KnownForItem(
  id: (json['id'] as num).toInt(),
  mediaType: json['media_type'] as String,
  title: json['title'] as String?,
  name: json['name'] as String?,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  overview: json['overview'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  releaseDate: json['release_date'] as String?,
  firstAirDate: json['first_air_date'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$KnownForItemToJson(KnownForItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': instance.mediaType,
      'title': instance.title,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
      'first_air_date': instance.firstAirDate,
      'genre_ids': instance.genreIds,
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  adult: json['adult'] as bool?,
  gender: (json['gender'] as num?)?.toInt(),
  knownForDepartment: json['known_for_department'] as String?,
  profilePath: json['profile_path'] as String?,
  popularity: (json['popularity'] as num).toDouble(),
  knownFor: (json['known_for'] as List<dynamic>?)
      ?.map((e) => KnownForItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'adult': instance.adult,
  'gender': instance.gender,
  'known_for_department': instance.knownForDepartment,
  'profile_path': instance.profilePath,
  'popularity': instance.popularity,
  'known_for': instance.knownFor,
};

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
