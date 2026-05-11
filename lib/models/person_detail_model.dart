import 'package:json_annotation/json_annotation.dart';

part 'person_detail_model.g.dart';

/// Full details for a single person from /3/person/{person_id}.
@JsonSerializable()
class PersonDetail {
  final int id;
  final String name;
  final bool adult;

  /// 0 = not set, 1 = female, 2 = male, 3 = non-binary
  final int gender;

  final String biography;

  /// ISO 8601 date string, e.g. "1956-07-09"
  final String? birthday;

  /// ISO 8601 date string; null if still alive.
  final String? deathday;

  @JsonKey(name: 'also_known_as')
  final List<String> alsoKnownAs;

  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;

  final double popularity;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  /// Personal website URL; nullable.
  final String? homepage;

  PersonDetail({
    required this.id,
    required this.name,
    required this.adult,
    required this.gender,
    required this.biography,
    this.birthday,
    this.deathday,
    required this.alsoKnownAs,
    this.knownForDepartment,
    this.placeOfBirth,
    required this.popularity,
    this.profilePath,
    this.imdbId,
    this.homepage,
  });

  /// Convenience: gender label from numeric value.
  String get genderLabel {
    switch (gender) {
      case 1:
        return 'Female';
      case 2:
        return 'Male';
      case 3:
        return 'Non-binary';
      default:
        return 'Not specified';
    }
  }

  factory PersonDetail.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PersonDetailToJson(this);
}
