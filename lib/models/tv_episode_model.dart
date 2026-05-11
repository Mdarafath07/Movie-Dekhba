import 'package:json_annotation/json_annotation.dart';

part 'tv_episode_model.g.dart';

@JsonSerializable()
class TvEpisode {
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'episode_number')
  final int episodeNumber;
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @JsonKey(name: 'show_id')
  final int showId;
  @JsonKey(name: 'still_path')
  final String? stillPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  TvEpisode({
    required this.id,
    required this.name,
    required this.overview,
    this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
    required this.voteAverage,
  });

  factory TvEpisode.fromJson(Map<String, dynamic> json) => _$TvEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeToJson(this);
}

@JsonSerializable()
class TvEpisodeResponse {
  final int page;
  final List<TvEpisode> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  TvEpisodeResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvEpisodeResponse.fromJson(Map<String, dynamic> json) => _$TvEpisodeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TvEpisodeResponseToJson(this);
}
