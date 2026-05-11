// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetail _$CompanyDetailFromJson(Map<String, dynamic> json) =>
    CompanyDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      headquarters: json['headquarters'] as String?,
      homepage: json['homepage'] as String?,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
      parentCompany: json['parent_company'] == null
          ? null
          : CompanyDetail.fromJson(
              json['parent_company'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CompanyDetailToJson(CompanyDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'headquarters': instance.headquarters,
      'homepage': instance.homepage,
      'logo_path': instance.logoPath,
      'origin_country': instance.originCountry,
      'parent_company': instance.parentCompany,
    };

CompanyAlternativeName _$CompanyAlternativeNameFromJson(
  Map<String, dynamic> json,
) => CompanyAlternativeName(
  name: json['name'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$CompanyAlternativeNameToJson(
  CompanyAlternativeName instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.type};

CompanyAlternativeNamesResponse _$CompanyAlternativeNamesResponseFromJson(
  Map<String, dynamic> json,
) => CompanyAlternativeNamesResponse(
  id: (json['id'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => CompanyAlternativeName.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CompanyAlternativeNamesResponseToJson(
  CompanyAlternativeNamesResponse instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};

CompanyLogo _$CompanyLogoFromJson(Map<String, dynamic> json) => CompanyLogo(
  aspectRatio: (json['aspect_ratio'] as num).toDouble(),
  filePath: json['file_path'] as String,
  height: (json['height'] as num).toInt(),
  id: json['id'] as String,
  fileType: json['file_type'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  width: (json['width'] as num).toInt(),
);

Map<String, dynamic> _$CompanyLogoToJson(CompanyLogo instance) =>
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

CompanyImagesResponse _$CompanyImagesResponseFromJson(
  Map<String, dynamic> json,
) => CompanyImagesResponse(
  id: (json['id'] as num).toInt(),
  logos: (json['logos'] as List<dynamic>)
      .map((e) => CompanyLogo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CompanyImagesResponseToJson(
  CompanyImagesResponse instance,
) => <String, dynamic>{'id': instance.id, 'logos': instance.logos};

SearchCompanyResult _$SearchCompanyResultFromJson(Map<String, dynamic> json) =>
    SearchCompanyResult(
      id: (json['id'] as num).toInt(),
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String?,
    );

Map<String, dynamic> _$SearchCompanyResultToJson(
  SearchCompanyResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'logo_path': instance.logoPath,
  'name': instance.name,
  'origin_country': instance.originCountry,
};

SearchCompanyResponse _$SearchCompanyResponseFromJson(
  Map<String, dynamic> json,
) => SearchCompanyResponse(
  page: (json['page'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => SearchCompanyResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
);

Map<String, dynamic> _$SearchCompanyResponseToJson(
  SearchCompanyResponse instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
