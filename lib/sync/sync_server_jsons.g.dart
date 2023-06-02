// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_server_jsons.dart';

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
              ?.map((e) => SharedItemJson.fromJson(e as Map<String, dynamic>))
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

ItemJson _$ItemJsonFromJson(Map<String, dynamic> json) => ItemJson(
      itemType: $enumDecode(_$ItemTypeEnumMap, json['itemType']),
      id: json['id'] as String,
      iv: json['iv'] as String,
      blob: json['blob'] as String?,
      addToWatch: json['addToWatch'] as bool? ?? false,
      rgbInt: json['rgbInt'] as int?,
      created: AceUtil.nullableMillisecondsToDateTime(json['created'] as int?),
      lastUsed:
          AceUtil.nullableMillisecondsToDateTime(json['lastUsed'] as int?),
      modified:
          AceUtil.nullableMillisecondsToDateTime(json['modified'] as int?),
      shared: json['shared'] as bool? ?? false,
      sharedSecret: json['sharedSecret'] as String?,
    );

Map<String, dynamic> _$ItemJsonToJson(ItemJson instance) {
  final val = <String, dynamic>{
    'itemType': _$ItemTypeEnumMap[instance.itemType]!,
    'id': instance.id,
    'iv': instance.iv,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blob', instance.blob);
  val['addToWatch'] = instance.addToWatch;
  writeNotNull('rgbInt', instance.rgbInt);
  writeNotNull(
      'created', AceUtil.nullableDateTimeToMilliseconds(instance.created));
  writeNotNull(
      'lastUsed', AceUtil.nullableDateTimeToMilliseconds(instance.lastUsed));
  writeNotNull(
      'modified', AceUtil.nullableDateTimeToMilliseconds(instance.modified));
  val['shared'] = instance.shared;
  writeNotNull('sharedSecret', instance.sharedSecret);
  return val;
}

const _$ItemTypeEnumMap = {
  ItemType.password: 'Password',
  ItemType.bankAccount: 'BankAccount',
  ItemType.ff: 'FF',
  ItemType.note: 'Note',
  ItemType.code: 'Code',
  ItemType.card: 'Wallet',
  ItemType.doc: 'Doc',
};

ItemDeleteInfoJson _$ItemDeleteInfoJsonFromJson(Map<String, dynamic> json) =>
    ItemDeleteInfoJson(
      id: json['id'] as String,
      deleteDate: AceUtil.millisecondsToDateTime(json['deleteDate'] as int),
    );

Map<String, dynamic> _$ItemDeleteInfoJsonToJson(ItemDeleteInfoJson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deleteDate': AceUtil.dateTimeToMilliseconds(instance.deleteDate),
    };

SharedItemJson _$SharedItemJsonFromJson(Map<String, dynamic> json) =>
    SharedItemJson(
      itemType: $enumDecode(_$ItemTypeEnumMap, json['itemType']),
      id: json['id'] as String,
      iv: json['iv'] as String,
      sharer: json['sharer'] as String,
      sharedSecret: json['sharedSecret'] as String,
      blob: json['blob'] as String?,
      addToWatch: json['addToWatch'] as bool? ?? false,
      rgbInt: json['rgbInt'] as int?,
      created: AceUtil.nullableMillisecondsToDateTime(json['created'] as int?),
      lastUsed:
          AceUtil.nullableMillisecondsToDateTime(json['lastUsed'] as int?),
      modified:
          AceUtil.nullableMillisecondsToDateTime(json['modified'] as int?),
    );

Map<String, dynamic> _$SharedItemJsonToJson(SharedItemJson instance) {
  final val = <String, dynamic>{
    'itemType': _$ItemTypeEnumMap[instance.itemType]!,
    'id': instance.id,
    'iv': instance.iv,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blob', instance.blob);
  val['addToWatch'] = instance.addToWatch;
  writeNotNull('rgbInt', instance.rgbInt);
  writeNotNull(
      'created', AceUtil.nullableDateTimeToMilliseconds(instance.created));
  writeNotNull(
      'lastUsed', AceUtil.nullableDateTimeToMilliseconds(instance.lastUsed));
  writeNotNull(
      'modified', AceUtil.nullableDateTimeToMilliseconds(instance.modified));
  val['sharer'] = instance.sharer;
  val['sharedSecret'] = instance.sharedSecret;
  return val;
}

PendingShareInfoJson _$PendingShareInfoJsonFromJson(
        Map<String, dynamic> json) =>
    PendingShareInfoJson(
      itemType: $enumDecode(_$ItemTypeEnumMap, json['itemType']),
      id: json['id'] as String,
      iv: json['iv'] as String,
      shareStatus: $enumDecode(_$ShareStatusEnumMap, json['shareStatus']),
      sharer: json['sharer'] as String,
      sharedSecret: json['sharedSecret'] as String?,
      blob: json['blob'] as String?,
    );

Map<String, dynamic> _$PendingShareInfoJsonToJson(
    PendingShareInfoJson instance) {
  final val = <String, dynamic>{
    'itemType': _$ItemTypeEnumMap[instance.itemType]!,
    'id': instance.id,
    'iv': instance.iv,
    'shareStatus': _$ShareStatusEnumMap[instance.shareStatus]!,
    'sharer': instance.sharer,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sharedSecret', instance.sharedSecret);
  writeNotNull('blob', instance.blob);
  return val;
}

const _$ShareStatusEnumMap = {
  ShareStatus.none: 'None',
  ShareStatus.doesNotExist: 'UserDoesNotExist',
  ShareStatus.pending: 'Pending',
  ShareStatus.declined: 'Declined',
  ShareStatus.accepted: 'Accepted',
  ShareStatus.deletedBySharee: 'DeletedBySharee',
  ShareStatus.needToResend: 'NeedToResend',
};
