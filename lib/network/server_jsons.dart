import 'package:Stashword/util/ace_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_jsons.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginResult {
  final bool exists;

  LoginResult({required this.exists});

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class SyncConfirmCodeResult {
  final ConfirmCodeResult confirmCodeResult;
  final ValidateAccountResult validateAccountResult;

  SyncConfirmCodeResult({
    required this.confirmCodeResult,
    required this.validateAccountResult,
  });

  factory SyncConfirmCodeResult.fromJson(Map<String, dynamic> json) => _$SyncConfirmCodeResultFromJson(json);

  Map<String, dynamic> toJson() => _$SyncConfirmCodeResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class ConfirmCodeResult {
  final bool success;
  final bool exists;
  final bool expiredSecurityToken;
  final bool invalidCode;
  final int numAttempts;

  ConfirmCodeResult({
    required this.success,
    required this.exists,
    required this.expiredSecurityToken,
    required this.invalidCode,
    required this.numAttempts,
  });

  factory ConfirmCodeResult.fromJson(Map<String, dynamic> json) => _$ConfirmCodeResultFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmCodeResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable(includeIfNull: false)
class ValidateAccountResult {
  final String? accessToken;
  final String? vaultSalt;
  final int ci;
  final bool vaultLocked;
  final bool paying;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  final DateTime? validUntil;
  final int userVersion;

  ValidateAccountResult({
    this.accessToken,
    this.vaultSalt,
    this.ci = 0,
    this.vaultLocked = false,
    this.paying = false,
    this.validUntil,
    this.userVersion = 0,
  });

  factory ValidateAccountResult.fromJson(Map<String, dynamic> json) => _$ValidateAccountResultFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateAccountResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
