// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_jsons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      exists: json['exists'] as bool,
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'exists': instance.exists,
    };

SyncConfirmCodeResult _$SyncConfirmCodeResultFromJson(
        Map<String, dynamic> json) =>
    SyncConfirmCodeResult(
      confirmCodeResult: ConfirmCodeResult.fromJson(
          json['confirmCodeResult'] as Map<String, dynamic>),
      validateAccountResult: ValidateAccountResult.fromJson(
          json['validateAccountResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SyncConfirmCodeResultToJson(
        SyncConfirmCodeResult instance) =>
    <String, dynamic>{
      'confirmCodeResult': instance.confirmCodeResult,
      'validateAccountResult': instance.validateAccountResult,
    };

ConfirmCodeResult _$ConfirmCodeResultFromJson(Map<String, dynamic> json) =>
    ConfirmCodeResult(
      success: json['success'] as bool,
      exists: json['exists'] as bool,
      expiredSecurityToken: json['expiredSecurityToken'] as bool,
      invalidCode: json['invalidCode'] as bool,
      numAttempts: json['numAttempts'] as int,
    );

Map<String, dynamic> _$ConfirmCodeResultToJson(ConfirmCodeResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'exists': instance.exists,
      'expiredSecurityToken': instance.expiredSecurityToken,
      'invalidCode': instance.invalidCode,
      'numAttempts': instance.numAttempts,
    };

ValidateAccountResult _$ValidateAccountResultFromJson(
        Map<String, dynamic> json) =>
    ValidateAccountResult(
      accessToken: json['accessToken'] as String?,
      vaultSalt: json['vaultSalt'] as String?,
      ci: json['ci'] as int? ?? 0,
      vaultLocked: json['vaultLocked'] as bool? ?? false,
      paying: json['paying'] as bool? ?? false,
      validUntil:
          AceUtil.nullableMillisecondsToDateTime(json['validUntil'] as int?),
      userVersion: json['userVersion'] as int? ?? 0,
    );

Map<String, dynamic> _$ValidateAccountResultToJson(
    ValidateAccountResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('accessToken', instance.accessToken);
  writeNotNull('vaultSalt', instance.vaultSalt);
  val['ci'] = instance.ci;
  val['vaultLocked'] = instance.vaultLocked;
  val['paying'] = instance.paying;
  writeNotNull('validUntil',
      AceUtil.nullableDateTimeToMilliseconds(instance.validUntil));
  val['userVersion'] = instance.userVersion;
  return val;
}
