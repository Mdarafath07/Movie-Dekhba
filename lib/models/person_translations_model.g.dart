// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_translations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonTranslationData _$PersonTranslationDataFromJson(
  Map<String, dynamic> json,
) => PersonTranslationData(
  biography: json['biography'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$PersonTranslationDataToJson(
  PersonTranslationData instance,
) => <String, dynamic>{'biography': instance.biography, 'name': instance.name};

PersonTranslation _$PersonTranslationFromJson(Map<String, dynamic> json) =>
    PersonTranslation(
      iso31661: json['iso_3166_1'] as String,
      iso6391: json['iso_639_1'] as String,
      name: json['name'] as String,
      englishName: json['english_name'] as String,
      data: PersonTranslationData.fromJson(
        json['data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PersonTranslationToJson(PersonTranslation instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
      'iso_639_1': instance.iso6391,
      'name': instance.name,
      'english_name': instance.englishName,
      'data': instance.data,
    };

PersonTranslationsResponse _$PersonTranslationsResponseFromJson(
  Map<String, dynamic> json,
) => PersonTranslationsResponse(
  id: (json['id'] as num).toInt(),
  translations: (json['translations'] as List<dynamic>)
      .map((e) => PersonTranslation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PersonTranslationsResponseToJson(
  PersonTranslationsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'translations': instance.translations,
};
