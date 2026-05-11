// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeItem _$ChangeItemFromJson(Map<String, dynamic> json) => ChangeItem(
  id: json['id'] as String,
  action: json['action'] as String,
  time: json['time'] as String,
  iso6391: json['iso_639_1'] as String?,
  iso31661: json['iso_3166_1'] as String?,
  value: json['value'],
);

Map<String, dynamic> _$ChangeItemToJson(ChangeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'time': instance.time,
      'iso_639_1': instance.iso6391,
      'iso_3166_1': instance.iso31661,
      'value': instance.value,
    };

ChangeGroup _$ChangeGroupFromJson(Map<String, dynamic> json) => ChangeGroup(
  key: json['key'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => ChangeItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChangeGroupToJson(ChangeGroup instance) =>
    <String, dynamic>{'key': instance.key, 'items': instance.items};

ChangesResponse _$ChangesResponseFromJson(Map<String, dynamic> json) =>
    ChangesResponse(
      changes: (json['changes'] as List<dynamic>)
          .map((e) => ChangeGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChangesResponseToJson(ChangesResponse instance) =>
    <String, dynamic>{'changes': instance.changes};
