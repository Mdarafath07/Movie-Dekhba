// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_dates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseDatesResponse _$ReleaseDatesResponseFromJson(
  Map<String, dynamic> json,
) => ReleaseDatesResponse(
  id: (json['id'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => ReleaseDatesResult.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReleaseDatesResponseToJson(
  ReleaseDatesResponse instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};

ReleaseDatesResult _$ReleaseDatesResultFromJson(Map<String, dynamic> json) =>
    ReleaseDatesResult(
      iso31661: json['iso_3166_1'] as String,
      releaseDates: (json['release_dates'] as List<dynamic>)
          .map((e) => ReleaseDateItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReleaseDatesResultToJson(ReleaseDatesResult instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
      'release_dates': instance.releaseDates,
    };

ReleaseDateItem _$ReleaseDateItemFromJson(Map<String, dynamic> json) =>
    ReleaseDateItem(
      certification: json['certification'] as String,
      descriptors: json['descriptors'] as List<dynamic>?,
      iso6391: json['iso_639_1'] as String?,
      note: json['note'] as String?,
      releaseDate: json['release_date'] as String,
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$ReleaseDateItemToJson(ReleaseDateItem instance) =>
    <String, dynamic>{
      'certification': instance.certification,
      'descriptors': instance.descriptors,
      'iso_639_1': instance.iso6391,
      'note': instance.note,
      'release_date': instance.releaseDate,
      'type': instance.type,
    };
