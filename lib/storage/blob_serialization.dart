import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:Stashword/model/item_models.dart';

part 'blob_serialization.g.dart';

@JsonSerializable(includeIfNull: false)
class BaseBlob {
  String? name;
  String? notes;
  @JsonKey(name: "photos")
  List<String> photoIds = [];
  @JsonKey(name: "categories")
  List<String> tags = [];
  @JsonKey(name: "custom")
  List<CustomFieldInfo> customFields = [];

  BaseBlob();

  String? get serialized {
    try {
      return json.encode(this);
    } catch (e) {
      return null;
    }
  }

}

@JsonSerializable(includeIfNull: false)
class PasswordBlob extends BaseBlob {
  String? url;
  String? userName;
  String? password;
  String? otpToken;

  PasswordBlob();

  // Json Helpers
  factory PasswordBlob.fromJson(Map<String, dynamic> json) =>
      _$PasswordBlobFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordBlobToJson(this);

  static PasswordBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return PasswordBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable(includeIfNull: false)
class BankAccountBlob extends BaseBlob {
  String? accountNo;
  String? routingNo;
  String? supportNo;
  String? pinNo;
  String? swiftCode;

  BankAccountBlob();

  // Json Helpers
  factory BankAccountBlob.fromJson(Map<String, dynamic> json) =>
      _$BankAccountBlobFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountBlobToJson(this);

  static BankAccountBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return BankAccountBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable(includeIfNull: false)
class FFBlob extends BaseBlob {
  String? ffNo;
  String? supportNo;

  FFBlob();

  // Json Helpers
  factory FFBlob.fromJson(Map<String, dynamic> json) =>
      _$FFBlobFromJson(json);

  Map<String, dynamic> toJson() => _$FFBlobToJson(this);

  static FFBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return FFBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}
