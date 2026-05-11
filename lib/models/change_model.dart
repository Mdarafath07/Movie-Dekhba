import 'package:json_annotation/json_annotation.dart';

part 'change_model.g.dart';

/// Represents a single change item within a change group.
@JsonSerializable()
class ChangeItem {
  final String id;
  final String action;
  final String time;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  // `value` is a dynamic object — can contain poster, backdrop, keyword, etc.
  final dynamic value;

  ChangeItem({
    required this.id,
    required this.action,
    required this.time,
    this.iso6391,
    this.iso31661,
    this.value,
  });

  factory ChangeItem.fromJson(Map<String, dynamic> json) => _$ChangeItemFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeItemToJson(this);
}

/// Represents a group of changes under a common key (e.g. "images", "plot_keywords").
@JsonSerializable()
class ChangeGroup {
  final String key;
  final List<ChangeItem> items;

  ChangeGroup({required this.key, required this.items});

  factory ChangeGroup.fromJson(Map<String, dynamic> json) => _$ChangeGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeGroupToJson(this);
}

/// Top-level changes response for a movie or TV show.
@JsonSerializable()
class ChangesResponse {
  final List<ChangeGroup> changes;

  ChangesResponse({required this.changes});

  factory ChangesResponse.fromJson(Map<String, dynamic> json) => _$ChangesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChangesResponseToJson(this);
}
