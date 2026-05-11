// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiConfiguration _$ApiConfigurationFromJson(Map<String, dynamic> json) =>
    ApiConfiguration(
      images: ImageConfiguration.fromJson(
        json['images'] as Map<String, dynamic>,
      ),
      changeKeys: (json['change_keys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ApiConfigurationToJson(ApiConfiguration instance) =>
    <String, dynamic>{
      'images': instance.images,
      'change_keys': instance.changeKeys,
    };

ImageConfiguration _$ImageConfigurationFromJson(Map<String, dynamic> json) =>
    ImageConfiguration(
      baseUrl: json['base_url'] as String,
      secureBaseUrl: json['secure_base_url'] as String,
      backdropSizes: (json['backdrop_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logoSizes: (json['logo_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      posterSizes: (json['poster_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      profileSizes: (json['profile_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      stillSizes: (json['still_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ImageConfigurationToJson(ImageConfiguration instance) =>
    <String, dynamic>{
      'base_url': instance.baseUrl,
      'secure_base_url': instance.secureBaseUrl,
      'backdrop_sizes': instance.backdropSizes,
      'logo_sizes': instance.logoSizes,
      'poster_sizes': instance.posterSizes,
      'profile_sizes': instance.profileSizes,
      'still_sizes': instance.stillSizes,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  iso31661: json['iso_3166_1'] as String,
  englishName: json['english_name'] as String,
  nativeName: json['native_name'] as String,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'iso_3166_1': instance.iso31661,
  'english_name': instance.englishName,
  'native_name': instance.nativeName,
};

JobDepartment _$JobDepartmentFromJson(Map<String, dynamic> json) =>
    JobDepartment(
      department: json['department'] as String,
      jobs: (json['jobs'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$JobDepartmentToJson(JobDepartment instance) =>
    <String, dynamic>{'department': instance.department, 'jobs': instance.jobs};

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
  iso6391: json['iso_639_1'] as String,
  englishName: json['english_name'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
  'iso_639_1': instance.iso6391,
  'english_name': instance.englishName,
  'name': instance.name,
};

Timezone _$TimezoneFromJson(Map<String, dynamic> json) => Timezone(
  iso31661: json['iso_3166_1'] as String,
  zones: (json['zones'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$TimezoneToJson(Timezone instance) => <String, dynamic>{
  'iso_3166_1': instance.iso31661,
  'zones': instance.zones,
};
