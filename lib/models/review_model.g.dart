// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      id: (json['id'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  author: json['author'] as String,
  authorDetails: AuthorDetails.fromJson(
    json['author_details'] as Map<String, dynamic>,
  ),
  content: json['content'] as String,
  createdAt: json['created_at'] as String,
  id: json['id'] as String,
  updatedAt: json['updated_at'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'author': instance.author,
  'author_details': instance.authorDetails,
  'content': instance.content,
  'created_at': instance.createdAt,
  'id': instance.id,
  'updated_at': instance.updatedAt,
  'url': instance.url,
};

AuthorDetails _$AuthorDetailsFromJson(Map<String, dynamic> json) =>
    AuthorDetails(
      name: json['name'] as String,
      username: json['username'] as String,
      avatarPath: json['avatar_path'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AuthorDetailsToJson(AuthorDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'avatar_path': instance.avatarPath,
      'rating': instance.rating,
    };

ReviewDetail _$ReviewDetailFromJson(Map<String, dynamic> json) => ReviewDetail(
  id: json['id'] as String,
  author: json['author'] as String,
  authorDetails: AuthorDetails.fromJson(
    json['author_details'] as Map<String, dynamic>,
  ),
  content: json['content'] as String,
  createdAt: json['created_at'] as String,
  iso6391: json['iso_639_1'] as String?,
  mediaId: (json['media_id'] as num).toInt(),
  mediaTitle: json['media_title'] as String,
  mediaType: json['media_type'] as String,
  updatedAt: json['updated_at'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$ReviewDetailToJson(ReviewDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'author_details': instance.authorDetails,
      'content': instance.content,
      'created_at': instance.createdAt,
      'iso_639_1': instance.iso6391,
      'media_id': instance.mediaId,
      'media_title': instance.mediaTitle,
      'media_type': instance.mediaType,
      'updated_at': instance.updatedAt,
      'url': instance.url,
    };
