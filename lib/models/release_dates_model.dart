import 'package:json_annotation/json_annotation.dart';

part 'release_dates_model.g.dart';

@JsonSerializable()
class ReleaseDatesResponse {
  final int id;
  final List<ReleaseDatesResult> results;

  ReleaseDatesResponse({required this.id, required this.results});

  factory ReleaseDatesResponse.fromJson(Map<String, dynamic> json) => _$ReleaseDatesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDatesResponseToJson(this);
}

@JsonSerializable()
class ReleaseDatesResult {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  @JsonKey(name: 'release_dates')
  final List<ReleaseDateItem> releaseDates;

  ReleaseDatesResult({required this.iso31661, required this.releaseDates});

  factory ReleaseDatesResult.fromJson(Map<String, dynamic> json) => _$ReleaseDatesResultFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDatesResultToJson(this);
}

@JsonSerializable()
class ReleaseDateItem {
  final String certification;
  // Descriptors can sometimes be empty arrays or absent, so we make it optional dynamic list
  final List<dynamic>? descriptors;
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;
  final String? note;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int type;

  ReleaseDateItem({
    required this.certification,
    this.descriptors,
    this.iso6391,
    this.note,
    required this.releaseDate,
    required this.type,
  });

  factory ReleaseDateItem.fromJson(Map<String, dynamic> json) => _$ReleaseDateItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDateItemToJson(this);
}
