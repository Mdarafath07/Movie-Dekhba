import 'package:json_annotation/json_annotation.dart';

part 'person_translations_model.g.dart';

// ---------------------------------------------------------------------------
// Translation data payload
// ---------------------------------------------------------------------------

@JsonSerializable()
class PersonTranslationData {
  final String biography;
  final String name;

  const PersonTranslationData({
    required this.biography,
    required this.name,
  });

  factory PersonTranslationData.fromJson(Map<String, dynamic> json) =>
      _$PersonTranslationDataFromJson(json);

  Map<String, dynamic> toJson() => _$PersonTranslationDataToJson(this);
}

// ---------------------------------------------------------------------------
// Single translation entry
// ---------------------------------------------------------------------------

@JsonSerializable()
class PersonTranslation {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;

  @JsonKey(name: 'iso_639_1')
  final String iso6391;

  final String name;

  @JsonKey(name: 'english_name')
  final String englishName;

  final PersonTranslationData data;

  const PersonTranslation({
    required this.iso31661,
    required this.iso6391,
    required this.name,
    required this.englishName,
    required this.data,
  });

  factory PersonTranslation.fromJson(Map<String, dynamic> json) =>
      _$PersonTranslationFromJson(json);

  Map<String, dynamic> toJson() => _$PersonTranslationToJson(this);
}

// ---------------------------------------------------------------------------
// Response wrapper
// ---------------------------------------------------------------------------

@JsonSerializable()
class PersonTranslationsResponse {
  final int id;
  final List<PersonTranslation> translations;

  const PersonTranslationsResponse({
    required this.id,
    required this.translations,
  });

  factory PersonTranslationsResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonTranslationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonTranslationsResponseToJson(this);
}
