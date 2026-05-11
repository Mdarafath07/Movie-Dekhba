import 'package:json_annotation/json_annotation.dart';

part 'person_images_model.g.dart';

/// A single profile image belonging to a person.
@JsonSerializable()
class ProfileImage {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;

  final int height;

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @JsonKey(name: 'file_path')
  final String filePath;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  final int width;

  ProfileImage({
    required this.aspectRatio,
    required this.height,
    this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);
}

/// Top-level response from GET /3/person/{person_id}/images.
@JsonSerializable()
class PersonImages {
  final int id;

  /// Ordered by vote_average descending (highest-rated first).
  final List<ProfileImage> profiles;

  PersonImages({required this.id, required this.profiles});

  factory PersonImages.fromJson(Map<String, dynamic> json) =>
      _$PersonImagesFromJson(json);
  Map<String, dynamic> toJson() => _$PersonImagesToJson(this);
}
