import 'package:json_annotation/json_annotation.dart';

part 'watch_provider_model.g.dart';

@JsonSerializable()
class WatchProvidersResponse {
  final int id;
  final Map<String, WatchProviderRegion> results;

  WatchProvidersResponse({required this.id, required this.results});

  factory WatchProvidersResponse.fromJson(Map<String, dynamic> json) => _$WatchProvidersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WatchProvidersResponseToJson(this);
}

@JsonSerializable()
class WatchProviderRegion {
  final String link;
  final List<WatchProviderItem>? rent;
  final List<WatchProviderItem>? buy;
  final List<WatchProviderItem>? flatrate;
  final List<WatchProviderItem>? ads;
  final List<WatchProviderItem>? free;

  WatchProviderRegion({
    required this.link,
    this.rent,
    this.buy,
    this.flatrate,
    this.ads,
    this.free,
  });

  factory WatchProviderRegion.fromJson(Map<String, dynamic> json) => _$WatchProviderRegionFromJson(json);
  Map<String, dynamic> toJson() => _$WatchProviderRegionToJson(this);
}

@JsonSerializable()
class WatchProviderItem {
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'provider_id')
  final int providerId;
  @JsonKey(name: 'provider_name')
  final String providerName;
  @JsonKey(name: 'display_priority')
  final int displayPriority;

  WatchProviderItem({
    this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory WatchProviderItem.fromJson(Map<String, dynamic> json) => _$WatchProviderItemFromJson(json);
  Map<String, dynamic> toJson() => _$WatchProviderItemToJson(this);
}

@JsonSerializable()
class TmdbRegion {
  @JsonKey(name: 'iso_3166_1')
  final String iso3166_1;
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'native_name')
  final String nativeName;

  TmdbRegion({
    required this.iso3166_1,
    required this.englishName,
    required this.nativeName,
  });

  factory TmdbRegion.fromJson(Map<String, dynamic> json) => _$TmdbRegionFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbRegionToJson(this);
}

@JsonSerializable()
class TmdbRegionResponse {
  final List<TmdbRegion> results;

  TmdbRegionResponse({required this.results});

  factory TmdbRegionResponse.fromJson(Map<String, dynamic> json) => _$TmdbRegionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbRegionResponseToJson(this);
}

@JsonSerializable()
class TmdbProviderResponse {
  final List<WatchProviderItem> results;

  TmdbProviderResponse({required this.results});

  factory TmdbProviderResponse.fromJson(Map<String, dynamic> json) => _$TmdbProviderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbProviderResponseToJson(this);
}
