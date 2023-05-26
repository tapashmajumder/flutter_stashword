// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_jsons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemJson _$ItemJsonFromJson(Map<String, dynamic> json) => ItemJson(
      itemType: $enumDecode(_$ItemTypeEnumMap, json['itemType']),
      id: json['id'] as String,
      iv: json['iv'] as String,
      blob: json['blob'] as String?,
      addToWatch: json['addToWatch'] as bool? ?? false,
      colorIndex: json['colorIndex'] as int?,
      created: AceUtil.millisecondsToDateTime(json['created'] as int?),
      lastUsed: AceUtil.millisecondsToDateTime(json['lastUsed'] as int?),
      modified: AceUtil.millisecondsToDateTime(json['modified'] as int?),
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
  writeNotNull('colorIndex', instance.colorIndex);
  writeNotNull('created', AceUtil.dateTimeToMilliseconds(instance.created));
  writeNotNull('lastUsed', AceUtil.dateTimeToMilliseconds(instance.lastUsed));
  writeNotNull('modified', AceUtil.dateTimeToMilliseconds(instance.modified));
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
