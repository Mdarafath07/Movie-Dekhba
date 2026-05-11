import 'package:json_annotation/json_annotation.dart';

part 'auth_token_model.g.dart';

/// Response from POST /3/authentication/token/new
@JsonSerializable()
class TmdbRequestToken {
  final bool success;
  @JsonKey(name: 'expires_at')
  final String expiresAt;
  @JsonKey(name: 'request_token')
  final String requestToken;

  TmdbRequestToken({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  factory TmdbRequestToken.fromJson(Map<String, dynamic> json) => _$TmdbRequestTokenFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbRequestTokenToJson(this);
}

/// Response from POST /3/authentication/session/new
@JsonSerializable()
class TmdbSession {
  final bool success;
  @JsonKey(name: 'session_id')
  final String sessionId;

  TmdbSession({required this.success, required this.sessionId});

  factory TmdbSession.fromJson(Map<String, dynamic> json) => _$TmdbSessionFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbSessionToJson(this);
}
