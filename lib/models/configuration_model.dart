import 'package:json_annotation/json_annotation.dart';

part 'configuration_model.g.dart';

@JsonSerializable()
class ApiConfiguration {
  final ImageConfiguration images;
  @JsonKey(name: 'change_keys')
  final List<String> changeKeys;

  ApiConfiguration({
    required this.images,
    required this.changeKeys,
  });

  factory ApiConfiguration.fromJson(Map<String, dynamic> json) => _$ApiConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ApiConfigurationToJson(this);
}

@JsonSerializable()
class ImageConfiguration {
  @JsonKey(name: 'base_url')
  final String baseUrl;
  @JsonKey(name: 'secure_base_url')
  final String secureBaseUrl;
  @JsonKey(name: 'backdrop_sizes')
  final List<String> backdropSizes;
  @JsonKey(name: 'logo_sizes')
  final List<String> logoSizes;
  @JsonKey(name: 'poster_sizes')
  final List<String> posterSizes;
  @JsonKey(name: 'profile_sizes')
  final List<String> profileSizes;
  @JsonKey(name: 'still_sizes')
  final List<String> stillSizes;

  ImageConfiguration({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  factory ImageConfiguration.fromJson(Map<String, dynamic> json) => _$ImageConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ImageConfigurationToJson(this);
}

@JsonSerializable()
class Country {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'native_name')
  final String nativeName;

  Country({
    required this.iso31661,
    required this.englishName,
    required this.nativeName,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class JobDepartment {
  final String department;
  final List<String> jobs;

  JobDepartment({
    required this.department,
    required this.jobs,
  });

  factory JobDepartment.fromJson(Map<String, dynamic> json) => _$JobDepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$JobDepartmentToJson(this);
}

@JsonSerializable()
class Language {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'english_name')
  final String englishName;
  final String name;

  Language({
    required this.iso6391,
    required this.englishName,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class Timezone {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final List<String> zones;

  Timezone({
    required this.iso31661,
    required this.zones,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => _$TimezoneFromJson(json);
  Map<String, dynamic> toJson() => _$TimezoneToJson(this);
}
