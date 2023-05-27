// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocField _$DocFieldFromJson(Map<String, dynamic> json) => DocField(
      fieldType: $enumDecodeNullable(_$FieldTypeEnumMap, json['fieldType']) ??
          FieldType.string,
      label: json['label'] as String,
      placeHolder: json['placeHolder'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$DocFieldToJson(DocField instance) {
  final val = <String, dynamic>{
    'fieldType': _$FieldTypeEnumMap[instance.fieldType]!,
    'label': instance.label,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('placeHolder', instance.placeHolder);
  writeNotNull('value', instance.value);
  return val;
}

const _$FieldTypeEnumMap = {
  FieldType.email: 'email',
  FieldType.date: 'date',
  FieldType.string: 'string',
  FieldType.phoneNumber: 'phoneNumber',
  FieldType.number: 'number',
};

CustomFieldInfo _$CustomFieldInfoFromJson(Map<String, dynamic> json) =>
    CustomFieldInfo(
      type: $enumDecodeNullable(_$FieldTypeEnumMap, json['type']) ??
          FieldType.string,
      name: json['name'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$CustomFieldInfoToJson(CustomFieldInfo instance) =>
    <String, dynamic>{
      'type': _$FieldTypeEnumMap[instance.type]!,
      'name': instance.name,
      'value': instance.value,
    };
