import 'package:json_annotation/json_annotation.dart';

part 'tv_aggregate_credits_model.g.dart';

@JsonSerializable()
class TvAggregateCreditsResponse {
  final int id;
  final List<TvAggregateCast> cast;
  final List<TvAggregateCrew> crew;

  TvAggregateCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory TvAggregateCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$TvAggregateCreditsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TvAggregateCreditsResponseToJson(this);
}

@JsonSerializable()
class TvAggregateCast {
  final bool adult;
  final int gender;
  final int id;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final double popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  final List<TvRole> roles;
  @JsonKey(name: 'total_episode_count')
  final int totalEpisodeCount;
  final int order;

  TvAggregateCast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.roles,
    required this.totalEpisodeCount,
    required this.order,
  });

  factory TvAggregateCast.fromJson(Map<String, dynamic> json) =>
      _$TvAggregateCastFromJson(json);
  Map<String, dynamic> toJson() => _$TvAggregateCastToJson(this);
}

@JsonSerializable()
class TvRole {
  @JsonKey(name: 'credit_id')
  final String creditId;
  final String character;
  @JsonKey(name: 'episode_count')
  final int episodeCount;

  TvRole({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  factory TvRole.fromJson(Map<String, dynamic> json) => _$TvRoleFromJson(json);
  Map<String, dynamic> toJson() => _$TvRoleToJson(this);
}

@JsonSerializable()
class TvAggregateCrew {
  final bool adult;
  final int gender;
  final int id;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final double popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  final List<TvJob> jobs;
  @JsonKey(name: 'total_episode_count')
  final int totalEpisodeCount;
  final String department;

  TvAggregateCrew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.jobs,
    required this.totalEpisodeCount,
    required this.department,
  });

  factory TvAggregateCrew.fromJson(Map<String, dynamic> json) =>
      _$TvAggregateCrewFromJson(json);
  Map<String, dynamic> toJson() => _$TvAggregateCrewToJson(this);
}

@JsonSerializable()
class TvJob {
  @JsonKey(name: 'credit_id')
  final String creditId;
  final String job;
  @JsonKey(name: 'episode_count')
  final int episodeCount;

  TvJob({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  factory TvJob.fromJson(Map<String, dynamic> json) => _$TvJobFromJson(json);
  Map<String, dynamic> toJson() => _$TvJobToJson(this);
}
