// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileImage _$ProfileImageFromJson(Map<String, dynamic> json) => ProfileImage(
  aspectRatio: (json['aspect_ratio'] as num).toDouble(),
  height: (json['height'] as num).toInt(),
  iso6391: json['iso_639_1'] as String?,
  filePath: json['file_path'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  width: (json['width'] as num).toInt(),
);

Map<String, dynamic> _$ProfileImageToJson(ProfileImage instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso6391,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };

PersonImages _$PersonImagesFromJson(Map<String, dynamic> json) => PersonImages(
  id: (json['id'] as num).toInt(),
  profiles: (json['profiles'] as List<dynamic>)
      .map((e) => ProfileImage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PersonImagesToJson(PersonImages instance) =>
    <String, dynamic>{'id': instance.id, 'profiles': instance.profiles};
