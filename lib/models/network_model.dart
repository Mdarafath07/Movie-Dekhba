import 'package:json_annotation/json_annotation.dart';

part 'network_model.g.dart';

@JsonSerializable()
class Network {
  final String headquarters;
  final String homepage;
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  Network({
    required this.headquarters,
    required this.homepage,
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkToJson(this);
}

@JsonSerializable()
class NetworkAlternativeNamesResponse {
  final int id;
  final List<NetworkAlternativeName> results;

  NetworkAlternativeNamesResponse({required this.id, required this.results});

  factory NetworkAlternativeNamesResponse.fromJson(Map<String, dynamic> json) => _$NetworkAlternativeNamesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkAlternativeNamesResponseToJson(this);
}

@JsonSerializable()
class NetworkAlternativeName {
  final String name;
  final String type;

  NetworkAlternativeName({required this.name, required this.type});

  factory NetworkAlternativeName.fromJson(Map<String, dynamic> json) => _$NetworkAlternativeNameFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkAlternativeNameToJson(this);
}

@JsonSerializable()
class NetworkImagesResponse {
  final int id;
  final List<NetworkLogo> logos;

  NetworkImagesResponse({required this.id, required this.logos});

  factory NetworkImagesResponse.fromJson(Map<String, dynamic> json) => _$NetworkImagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkImagesResponseToJson(this);
}

@JsonSerializable()
class NetworkLogo {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  @JsonKey(name: 'file_path')
  final String filePath;
  final int height;
  final String id;
  @JsonKey(name: 'file_type')
  final String fileType;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final int width;

  NetworkLogo({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.id,
    required this.fileType,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory NetworkLogo.fromJson(Map<String, dynamic> json) => _$NetworkLogoFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkLogoToJson(this);
}
