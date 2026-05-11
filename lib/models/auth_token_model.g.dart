// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbRequestToken _$TmdbRequestTokenFromJson(Map<String, dynamic> json) =>
    TmdbRequestToken(
      success: json['success'] as bool,
      expiresAt: json['expires_at'] as String,
      requestToken: json['request_token'] as String,
    );

Map<String, dynamic> _$TmdbRequestTokenToJson(TmdbRequestToken instance) =>
    <String, dynamic>{
      'success': instance.success,
      'expires_at': instance.expiresAt,
      'request_token': instance.requestToken,
    };

TmdbSession _$TmdbSessionFromJson(Map<String, dynamic> json) => TmdbSession(
  success: json['success'] as bool,
  sessionId: json['session_id'] as String,
);

Map<String, dynamic> _$TmdbSessionToJson(TmdbSession instance) =>
    <String, dynamic>{
      'success': instance.success,
      'session_id': instance.sessionId,
    };
