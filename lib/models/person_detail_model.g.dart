// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetail _$PersonDetailFromJson(Map<String, dynamic> json) => PersonDetail(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  adult: json['adult'] as bool,
  gender: (json['gender'] as num).toInt(),
  biography: json['biography'] as String,
  birthday: json['birthday'] as String?,
  deathday: json['deathday'] as String?,
  alsoKnownAs: (json['also_known_as'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  knownForDepartment: json['known_for_department'] as String?,
  placeOfBirth: json['place_of_birth'] as String?,
  popularity: (json['popularity'] as num).toDouble(),
  profilePath: json['profile_path'] as String?,
  imdbId: json['imdb_id'] as String?,
  homepage: json['homepage'] as String?,
);

Map<String, dynamic> _$PersonDetailToJson(PersonDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adult': instance.adult,
      'gender': instance.gender,
      'biography': instance.biography,
      'birthday': instance.birthday,
      'deathday': instance.deathday,
      'also_known_as': instance.alsoKnownAs,
      'known_for_department': instance.knownForDepartment,
      'place_of_birth': instance.placeOfBirth,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'imdb_id': instance.imdbId,
      'homepage': instance.homepage,
    };
