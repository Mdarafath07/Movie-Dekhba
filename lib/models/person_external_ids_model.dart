import 'package:json_annotation/json_annotation.dart';

part 'person_external_ids_model.g.dart';

/// External IDs that belong to a person.
/// Returned by GET /3/person/{person_id}/external_ids.
///
/// Supported sources: Facebook, IMDb, Instagram, TikTok,
/// Twitter, Wikidata, YouTube (plus legacy Freebase / TVRage).
@JsonSerializable()
class PersonExternalIds {
  final int id;

  @JsonKey(name: 'freebase_mid')
  final String? freebaseMid;

  @JsonKey(name: 'freebase_id')
  final String? freebaseId;

  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  @JsonKey(name: 'tvrage_id')
  final int? tvrageId;

  @JsonKey(name: 'wikidata_id')
  final String? wikidataId;

  @JsonKey(name: 'facebook_id')
  final String? facebookId;

  @JsonKey(name: 'instagram_id')
  final String? instagramId;

  @JsonKey(name: 'tiktok_id')
  final String? tiktokId;

  @JsonKey(name: 'twitter_id')
  final String? twitterId;

  @JsonKey(name: 'youtube_id')
  final String? youtubeId;

  PersonExternalIds({
    required this.id,
    this.freebaseMid,
    this.freebaseId,
    this.imdbId,
    this.tvrageId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.tiktokId,
    this.twitterId,
    this.youtubeId,
  });

  factory PersonExternalIds.fromJson(Map<String, dynamic> json) =>
      _$PersonExternalIdsFromJson(json);
  Map<String, dynamic> toJson() => _$PersonExternalIdsToJson(this);
}
