// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
  headquarters: json['headquarters'] as String,
  homepage: json['homepage'] as String,
  id: (json['id'] as num).toInt(),
  logoPath: json['logo_path'] as String?,
  name: json['name'] as String,
  originCountry: json['origin_country'] as String,
);

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
  'headquarters': instance.headquarters,
  'homepage': instance.homepage,
  'id': instance.id,
  'logo_path': instance.logoPath,
  'name': instance.name,
  'origin_country': instance.originCountry,
};

NetworkAlternativeNamesResponse _$NetworkAlternativeNamesResponseFromJson(
  Map<String, dynamic> json,
) => NetworkAlternativeNamesResponse(
  id: (json['id'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => NetworkAlternativeName.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NetworkAlternativeNamesResponseToJson(
  NetworkAlternativeNamesResponse instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};

NetworkAlternativeName _$NetworkAlternativeNameFromJson(
  Map<String, dynamic> json,
) => NetworkAlternativeName(
  name: json['name'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$NetworkAlternativeNameToJson(
  NetworkAlternativeName instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.type};

NetworkImagesResponse _$NetworkImagesResponseFromJson(
  Map<String, dynamic> json,
) => NetworkImagesResponse(
  id: (json['id'] as num).toInt(),
  logos: (json['logos'] as List<dynamic>)
      .map((e) => NetworkLogo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NetworkImagesResponseToJson(
  NetworkImagesResponse instance,
) => <String, dynamic>{'id': instance.id, 'logos': instance.logos};

NetworkLogo _$NetworkLogoFromJson(Map<String, dynamic> json) => NetworkLogo(
  aspectRatio: (json['aspect_ratio'] as num).toDouble(),
  filePath: json['file_path'] as String,
  height: (json['height'] as num).toInt(),
  id: json['id'] as String,
  fileType: json['file_type'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  width: (json['width'] as num).toInt(),
);

Map<String, dynamic> _$NetworkLogoToJson(NetworkLogo instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'file_path': instance.filePath,
      'height': instance.height,
      'id': instance.id,
      'file_type': instance.fileType,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };
