// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_misc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlternativeTitlesResponse _$AlternativeTitlesResponseFromJson(
  Map<String, dynamic> json,
) => AlternativeTitlesResponse(
  id: (json['id'] as num).toInt(),
  titles: (json['titles'] as List<dynamic>)
      .map((e) => AlternativeTitle.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AlternativeTitlesResponseToJson(
  AlternativeTitlesResponse instance,
) => <String, dynamic>{'id': instance.id, 'titles': instance.titles};

AlternativeTitle _$AlternativeTitleFromJson(Map<String, dynamic> json) =>
    AlternativeTitle(
      iso31661: json['iso_3166_1'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AlternativeTitleToJson(AlternativeTitle instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
      'title': instance.title,
      'type': instance.type,
    };

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) => ExternalIds(
  id: (json['id'] as num).toInt(),
  imdbId: json['imdb_id'] as String?,
  wikidataId: json['wikidata_id'] as String?,
  facebookId: json['facebook_id'] as String?,
  instagramId: json['instagram_id'] as String?,
  twitterId: json['twitter_id'] as String?,
);

Map<String, dynamic> _$ExternalIdsToJson(ExternalIds instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'wikidata_id': instance.wikidataId,
      'facebook_id': instance.facebookId,
      'instagram_id': instance.instagramId,
      'twitter_id': instance.twitterId,
    };

AccountState _$AccountStateFromJson(Map<String, dynamic> json) => AccountState(
  id: (json['id'] as num).toInt(),
  favorite: json['favorite'] as bool,
  watchlist: json['watchlist'] as bool,
  rated: json['rated'],
);

Map<String, dynamic> _$AccountStateToJson(AccountState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'favorite': instance.favorite,
      'watchlist': instance.watchlist,
      'rated': instance.rated,
    };

MovieImages _$MovieImagesFromJson(Map<String, dynamic> json) => MovieImages(
  id: (json['id'] as num).toInt(),
  backdrops: (json['backdrops'] as List<dynamic>)
      .map((e) => MovieImageItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  logos: (json['logos'] as List<dynamic>)
      .map((e) => MovieImageItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  posters: (json['posters'] as List<dynamic>)
      .map((e) => MovieImageItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieImagesToJson(MovieImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'backdrops': instance.backdrops,
      'logos': instance.logos,
      'posters': instance.posters,
    };

MovieImageItem _$MovieImageItemFromJson(Map<String, dynamic> json) =>
    MovieImageItem(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: (json['height'] as num).toInt(),
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      width: (json['width'] as num).toInt(),
    );

Map<String, dynamic> _$MovieImageItemToJson(MovieImageItem instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso6391,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };
