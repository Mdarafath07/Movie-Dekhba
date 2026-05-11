import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class Account {
  final int id;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  final String name;
  @JsonKey(name: 'include_adult')
  final bool includeAdult;
  final String username;
  final Avatar? avatar;

  Account({
    required this.id,
    this.iso6391,
    this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
    this.avatar,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class Avatar {
  final Gravatar? gravatar;
  final TmdbAvatar? tmdb;

  Avatar({this.gravatar, this.tmdb});

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable()
class Gravatar {
  final String? hash;

  Gravatar({this.hash});

  factory Gravatar.fromJson(Map<String, dynamic> json) => _$GravatarFromJson(json);
  Map<String, dynamic> toJson() => _$GravatarToJson(this);
}

@JsonSerializable()
class TmdbAvatar {
  @JsonKey(name: 'avatar_path')
  final String? avatarPath;

  TmdbAvatar({this.avatarPath});

  factory TmdbAvatar.fromJson(Map<String, dynamic> json) => _$TmdbAvatarFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbAvatarToJson(this);
}
