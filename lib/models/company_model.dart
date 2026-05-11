import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyDetail {
  final int id;
  final String name;
  final String? description;
  final String? headquarters;
  final String? homepage;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'origin_country')
  final String? originCountry;
  @JsonKey(name: 'parent_company')
  final CompanyDetail? parentCompany;

  CompanyDetail({
    required this.id,
    required this.name,
    this.description,
    this.headquarters,
    this.homepage,
    this.logoPath,
    this.originCountry,
    this.parentCompany,
  });

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => _$CompanyDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyDetailToJson(this);
}

@JsonSerializable()
class CompanyAlternativeName {
  final String name;
  final String type;

  CompanyAlternativeName({
    required this.name,
    required this.type,
  });

  factory CompanyAlternativeName.fromJson(Map<String, dynamic> json) => _$CompanyAlternativeNameFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyAlternativeNameToJson(this);
}

@JsonSerializable()
class CompanyAlternativeNamesResponse {
  final int id;
  final List<CompanyAlternativeName> results;

  CompanyAlternativeNamesResponse({
    required this.id,
    required this.results,
  });

  factory CompanyAlternativeNamesResponse.fromJson(Map<String, dynamic> json) => _$CompanyAlternativeNamesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyAlternativeNamesResponseToJson(this);
}

@JsonSerializable()
class CompanyLogo {
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

  CompanyLogo({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.id,
    required this.fileType,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory CompanyLogo.fromJson(Map<String, dynamic> json) => _$CompanyLogoFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyLogoToJson(this);
}

@JsonSerializable()
class CompanyImagesResponse {
  final int id;
  final List<CompanyLogo> logos;

  CompanyImagesResponse({
    required this.id,
    required this.logos,
  });

  factory CompanyImagesResponse.fromJson(Map<String, dynamic> json) => _$CompanyImagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyImagesResponseToJson(this);
}

@JsonSerializable()
class SearchCompanyResult {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  SearchCompanyResult({
    required this.id,
    this.logoPath,
    required this.name,
    this.originCountry,
  });

  factory SearchCompanyResult.fromJson(Map<String, dynamic> json) =>
      _$SearchCompanyResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCompanyResultToJson(this);
}

@JsonSerializable()
class SearchCompanyResponse {
  final int page;
  final List<SearchCompanyResult> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  SearchCompanyResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCompanyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCompanyResponseToJson(this);
}
