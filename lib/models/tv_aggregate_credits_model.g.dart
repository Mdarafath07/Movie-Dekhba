// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_aggregate_credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvAggregateCreditsResponse _$TvAggregateCreditsResponseFromJson(
  Map<String, dynamic> json,
) => TvAggregateCreditsResponse(
  id: (json['id'] as num).toInt(),
  cast: (json['cast'] as List<dynamic>)
      .map((e) => TvAggregateCast.fromJson(e as Map<String, dynamic>))
      .toList(),
  crew: (json['crew'] as List<dynamic>)
      .map((e) => TvAggregateCrew.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TvAggregateCreditsResponseToJson(
  TvAggregateCreditsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'cast': instance.cast,
  'crew': instance.crew,
};

TvAggregateCast _$TvAggregateCastFromJson(Map<String, dynamic> json) =>
    TvAggregateCast(
      adult: json['adult'] as bool,
      gender: (json['gender'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => TvRole.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalEpisodeCount: (json['total_episode_count'] as num).toInt(),
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$TvAggregateCastToJson(TvAggregateCast instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'roles': instance.roles,
      'total_episode_count': instance.totalEpisodeCount,
      'order': instance.order,
    };

TvRole _$TvRoleFromJson(Map<String, dynamic> json) => TvRole(
  creditId: json['credit_id'] as String,
  character: json['character'] as String,
  episodeCount: (json['episode_count'] as num).toInt(),
);

Map<String, dynamic> _$TvRoleToJson(TvRole instance) => <String, dynamic>{
  'credit_id': instance.creditId,
  'character': instance.character,
  'episode_count': instance.episodeCount,
};

TvAggregateCrew _$TvAggregateCrewFromJson(Map<String, dynamic> json) =>
    TvAggregateCrew(
      adult: json['adult'] as bool,
      gender: (json['gender'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      jobs: (json['jobs'] as List<dynamic>)
          .map((e) => TvJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalEpisodeCount: (json['total_episode_count'] as num).toInt(),
      department: json['department'] as String,
    );

Map<String, dynamic> _$TvAggregateCrewToJson(TvAggregateCrew instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'jobs': instance.jobs,
      'total_episode_count': instance.totalEpisodeCount,
      'department': instance.department,
    };

TvJob _$TvJobFromJson(Map<String, dynamic> json) => TvJob(
  creditId: json['credit_id'] as String,
  job: json['job'] as String,
  episodeCount: (json['episode_count'] as num).toInt(),
);

Map<String, dynamic> _$TvJobToJson(TvJob instance) => <String, dynamic>{
  'credit_id': instance.creditId,
  'job': instance.job,
  'episode_count': instance.episodeCount,
};
