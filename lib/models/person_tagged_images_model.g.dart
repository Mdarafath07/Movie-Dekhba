// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_tagged_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaggedMedia _$TaggedMediaFromJson(Map<String, dynamic> json) => TaggedMedia(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  name: json['name'] as String?,
  overview: json['overview'] as String?,
  mediaType: json['media_type'] as String,
  adult: json['adult'] as bool?,
  backdropPath: json['backdrop_path'] as String?,
  originalLanguage: json['original_language'] as String?,
  originalTitle: json['original_title'] as String?,
  posterPath: json['poster_path'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  popularity: (json['popularity'] as num?)?.toDouble(),
  releaseDate: json['release_date'] as String?,
  video: json['video'] as bool?,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  airDate: json['air_date'] as String?,
  episodeNumber: (json['episode_number'] as num?)?.toInt(),
  productionCode: json['production_code'] as String?,
  runtime: (json['runtime'] as num?)?.toInt(),
  seasonNumber: (json['season_number'] as num?)?.toInt(),
  showId: (json['show_id'] as num?)?.toInt(),
  stillPath: json['still_path'] as String?,
);

Map<String, dynamic> _$TaggedMediaToJson(TaggedMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'name': instance.name,
      'overview': instance.overview,
      'media_type': instance.mediaType,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
      'genre_ids': instance.genreIds,
      'popularity': instance.popularity,
      'release_date': instance.releaseDate,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'air_date': instance.airDate,
      'episode_number': instance.episodeNumber,
      'production_code': instance.productionCode,
      'runtime': instance.runtime,
      'season_number': instance.seasonNumber,
      'show_id': instance.showId,
      'still_path': instance.stillPath,
    };

TaggedImage _$TaggedImageFromJson(Map<String, dynamic> json) => TaggedImage(
  aspectRatio: (json['aspect_ratio'] as num).toDouble(),
  filePath: json['file_path'] as String,
  height: (json['height'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  id: json['id'] as String,
  iso6391: json['iso_639_1'] as String?,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  imageType: json['image_type'] as String,
  media: TaggedMedia.fromJson(json['media'] as Map<String, dynamic>),
  mediaType: json['media_type'] as String,
);

Map<String, dynamic> _$TaggedImageToJson(TaggedImage instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'file_path': instance.filePath,
      'height': instance.height,
      'width': instance.width,
      'id': instance.id,
      'iso_639_1': instance.iso6391,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'image_type': instance.imageType,
      'media': instance.media,
      'media_type': instance.mediaType,
    };

PersonTaggedImagesResponse _$PersonTaggedImagesResponseFromJson(
  Map<String, dynamic> json,
) => PersonTaggedImagesResponse(
  id: (json['id'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => TaggedImage.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
);

Map<String, dynamic> _$PersonTaggedImagesResponseToJson(
  PersonTaggedImagesResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
