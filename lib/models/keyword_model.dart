import 'package:json_annotation/json_annotation.dart';

part 'keyword_model.g.dart';

@JsonSerializable()
class Keyword {
  final int id;
  final String name;

  Keyword({required this.id, required this.name});

  factory Keyword.fromJson(Map<String, dynamic> json) => _$KeywordFromJson(json);
  Map<String, dynamic> toJson() => _$KeywordToJson(this);
}

@JsonSerializable()
class MovieKeywordsResponse {
  final int id;
  final List<Keyword> keywords;

  MovieKeywordsResponse({required this.id, required this.keywords});

  factory MovieKeywordsResponse.fromJson(Map<String, dynamic> json) => _$MovieKeywordsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieKeywordsResponseToJson(this);
}

@JsonSerializable()
class SearchKeywordResponse {
  final int page;
  final List<Keyword> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  SearchKeywordResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchKeywordResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchKeywordResponseToJson(this);
}
