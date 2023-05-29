// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncInfo _$SyncInfoFromJson(Map<String, dynamic> json) => SyncInfo(
      createdItems: (json['createdItems'] as List<dynamic>?)
              ?.map((e) => ItemJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      modifiedItems: (json['modifiedItems'] as List<dynamic>?)
              ?.map((e) => ItemJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      deletedItems: (json['deletedItems'] as List<dynamic>?)
              ?.map(
                  (e) => ItemDeleteInfoJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sharedItems: (json['sharedItems'] as List<dynamic>?)
              ?.map((e) => ItemJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pendingShares: (json['pendingShares'] as List<dynamic>?)
              ?.map((e) =>
                  PendingShareInfoJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastSyncDate:
          AceUtil.nullableMillisecondsToDateTime(json['lastSyncDate'] as int?),
    );

Map<String, dynamic> _$SyncInfoToJson(SyncInfo instance) {
  final val = <String, dynamic>{
    'createdItems': instance.createdItems,
    'modifiedItems': instance.modifiedItems,
    'deletedItems': instance.deletedItems,
    'sharedItems': instance.sharedItems,
    'pendingShares': instance.pendingShares,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lastSyncDate',
      AceUtil.nullableDateTimeToMilliseconds(instance.lastSyncDate));
  return val;
}
