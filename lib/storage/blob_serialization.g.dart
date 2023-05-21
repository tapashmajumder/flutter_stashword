// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_serialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBlob _$BaseBlobFromJson(Map<String, dynamic> json) => BaseBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>).map((e) => e as String).toList()
  ..tags =
      (json['categories'] as List<dynamic>).map((e) => e as String).toList()
  ..customFields = (json['custom'] as List<dynamic>)
      .map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$BaseBlobToJson(BaseBlob instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('notes', instance.notes);
  val['photos'] = instance.photoIds;
  val['categories'] = instance.tags;
  val['custom'] = instance.customFields;
  return val;
}

PasswordBlob _$PasswordBlobFromJson(Map<String, dynamic> json) => PasswordBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>).map((e) => e as String).toList()
  ..tags =
      (json['categories'] as List<dynamic>).map((e) => e as String).toList()
  ..customFields = (json['custom'] as List<dynamic>)
      .map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
      .toList()
  ..url = json['url'] as String?
  ..userName = json['userName'] as String?
  ..password = json['password'] as String?
  ..otpToken = json['otpToken'] as String?;

Map<String, dynamic> _$PasswordBlobToJson(PasswordBlob instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('notes', instance.notes);
  val['photos'] = instance.photoIds;
  val['categories'] = instance.tags;
  val['custom'] = instance.customFields;
  writeNotNull('url', instance.url);
  writeNotNull('userName', instance.userName);
  writeNotNull('password', instance.password);
  writeNotNull('otpToken', instance.otpToken);
  return val;
}
