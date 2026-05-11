import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';
import 'person_model.dart';
import 'tv_show_model.dart';
import 'tv_episode_model.dart';

part 'find_model.g.dart';

@JsonSerializable()
class FindResponse {
  @JsonKey(name: 'movie_results')
  final List<Movie> movieResults;
  @JsonKey(name: 'person_results')
  final List<Person> personResults;
  @JsonKey(name: 'tv_results')
  final List<TvShow> tvResults;
  @JsonKey(name: 'tv_episode_results')
  final List<TvEpisode> tvEpisodeResults;
  @JsonKey(name: 'tv_season_results')
  final List<dynamic> tvSeasonResults;

  FindResponse({
    required this.movieResults,
    required this.personResults,
    required this.tvResults,
    required this.tvEpisodeResults,
    required this.tvSeasonResults,
  });

  factory FindResponse.fromJson(Map<String, dynamic> json) => _$FindResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FindResponseToJson(this);
}
