// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocField _$DocFieldFromJson(Map<String, dynamic> json) => DocField(
      fieldType: $enumDecode(_$FieldTypeEnumMap, json['fieldType']),
      label: json['label'] as String,
      placeHolder: json['placeHolder'] as String,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$DocFieldToJson(DocField instance) {
  final val = <String, dynamic>{
    'fieldType': _$FieldTypeEnumMap[instance.fieldType]!,
    'label': instance.label,
    'placeHolder': instance.placeHolder,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

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
