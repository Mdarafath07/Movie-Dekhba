import 'package:json_annotation/json_annotation.dart';

part 'tv_show_model.g.dart';

@JsonSerializable()
class TvShow {
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  TvShow({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    this.firstAirDate,
    this.genreIds,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) => _$TvShowFromJson(json);
  Map<String, dynamic> toJson() => _$TvShowToJson(this);
}

@JsonSerializable()
class TvShowResponse {
  final int page;
  final List<TvShow> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  TvShowResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => _$TvShowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TvShowResponseToJson(this);
}
