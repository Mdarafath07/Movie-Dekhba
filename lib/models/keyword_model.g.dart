// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) =>
    Keyword(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

MovieKeywordsResponse _$MovieKeywordsResponseFromJson(
  Map<String, dynamic> json,
) => MovieKeywordsResponse(
  id: (json['id'] as num).toInt(),
  keywords: (json['keywords'] as List<dynamic>)
      .map((e) => Keyword.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieKeywordsResponseToJson(
  MovieKeywordsResponse instance,
) => <String, dynamic>{'id': instance.id, 'keywords': instance.keywords};

SearchKeywordResponse _$SearchKeywordResponseFromJson(
  Map<String, dynamic> json,
) => SearchKeywordResponse(
  page: (json['page'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => Keyword.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
);

Map<String, dynamic> _$SearchKeywordResponseToJson(
  SearchKeywordResponse instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
