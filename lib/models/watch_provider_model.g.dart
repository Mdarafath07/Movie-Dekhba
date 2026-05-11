// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_provider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProvidersResponse _$WatchProvidersResponseFromJson(
  Map<String, dynamic> json,
) => WatchProvidersResponse(
  id: (json['id'] as num).toInt(),
  results: (json['results'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, WatchProviderRegion.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$WatchProvidersResponseToJson(
  WatchProvidersResponse instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};

WatchProviderRegion _$WatchProviderRegionFromJson(Map<String, dynamic> json) =>
    WatchProviderRegion(
      link: json['link'] as String,
      rent: (json['rent'] as List<dynamic>?)
          ?.map((e) => WatchProviderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      buy: (json['buy'] as List<dynamic>?)
          ?.map((e) => WatchProviderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      flatrate: (json['flatrate'] as List<dynamic>?)
          ?.map((e) => WatchProviderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      ads: (json['ads'] as List<dynamic>?)
          ?.map((e) => WatchProviderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      free: (json['free'] as List<dynamic>?)
          ?.map((e) => WatchProviderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WatchProviderRegionToJson(
  WatchProviderRegion instance,
) => <String, dynamic>{
  'link': instance.link,
  'rent': instance.rent,
  'buy': instance.buy,
  'flatrate': instance.flatrate,
  'ads': instance.ads,
  'free': instance.free,
};

WatchProviderItem _$WatchProviderItemFromJson(Map<String, dynamic> json) =>
    WatchProviderItem(
      logoPath: json['logo_path'] as String?,
      providerId: (json['provider_id'] as num).toInt(),
      providerName: json['provider_name'] as String,
      displayPriority: (json['display_priority'] as num).toInt(),
    );

Map<String, dynamic> _$WatchProviderItemToJson(WatchProviderItem instance) =>
    <String, dynamic>{
      'logo_path': instance.logoPath,
      'provider_id': instance.providerId,
      'provider_name': instance.providerName,
      'display_priority': instance.displayPriority,
    };

TmdbRegion _$TmdbRegionFromJson(Map<String, dynamic> json) => TmdbRegion(
  iso3166_1: json['iso_3166_1'] as String,
  englishName: json['english_name'] as String,
  nativeName: json['native_name'] as String,
);

Map<String, dynamic> _$TmdbRegionToJson(TmdbRegion instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso3166_1,
      'english_name': instance.englishName,
      'native_name': instance.nativeName,
    };

TmdbRegionResponse _$TmdbRegionResponseFromJson(Map<String, dynamic> json) =>
    TmdbRegionResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => TmdbRegion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TmdbRegionResponseToJson(TmdbRegionResponse instance) =>
    <String, dynamic>{'results': instance.results};

TmdbProviderResponse _$TmdbProviderResponseFromJson(
  Map<String, dynamic> json,
) => TmdbProviderResponse(
  results: (json['results'] as List<dynamic>)
      .map((e) => WatchProviderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TmdbProviderResponseToJson(
  TmdbProviderResponse instance,
) => <String, dynamic>{'results': instance.results};
