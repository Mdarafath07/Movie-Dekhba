import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewResponse {
  final int id;
  final int page;
  final List<Review> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  ReviewResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}

@JsonSerializable()
class Review {
  final String author;
  @JsonKey(name: 'author_details')
  final AuthorDetails authorDetails;
  final String content;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String id;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final String url;

  Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class AuthorDetails {
  final String name;
  final String username;
  @JsonKey(name: 'avatar_path')
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);
}

// ---------------------------------------------------------------------------
// ReviewDetail — returned by GET /3/review/{review_id}
// Includes all base Review fields plus media context fields.
// ---------------------------------------------------------------------------

@JsonSerializable()
class ReviewDetail {
  final String id;
  final String author;

  @JsonKey(name: 'author_details')
  final AuthorDetails authorDetails;

  final String content;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @JsonKey(name: 'media_id')
  final int mediaId;

  @JsonKey(name: 'media_title')
  final String mediaTitle;

  @JsonKey(name: 'media_type')
  final String mediaType;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  final String url;

  const ReviewDetail({
    required this.id,
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    this.iso6391,
    required this.mediaId,
    required this.mediaTitle,
    required this.mediaType,
    required this.updatedAt,
    required this.url,
  });

  factory ReviewDetail.fromJson(Map<String, dynamic> json) =>
      _$ReviewDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDetailToJson(this);
}
