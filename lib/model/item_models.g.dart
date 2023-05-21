// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomFieldInfo _$CustomFieldInfoFromJson(Map<String, dynamic> json) =>
    CustomFieldInfo(
      json['name'] as String,
      json['value'] as String,
      $enumDecode(_$FieldTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CustomFieldInfoToJson(CustomFieldInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'type': _$FieldTypeEnumMap[instance.type]!,
    };

const _$FieldTypeEnumMap = {
  FieldType.email: 'email',
  FieldType.date: 'date',
  FieldType.string: 'string',
  FieldType.phoneNumber: 'phoneNumber',
  FieldType.number: 'number',
};
