import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:Stashword/model/item_models.dart';

part 'blob_serialization.g.dart';

@JsonSerializable(includeIfNull: false)
class BaseBlob {
  String? name;
  String? notes;
  @JsonKey(name: "photos", defaultValue: [])
  List<String> photoIds = [];
  @JsonKey(name: "categories", defaultValue: [])
  List<String> tags = [];
  @JsonKey(name: "custom", defaultValue: [])
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

@JsonSerializable(includeIfNull: false)
class NoteBlob extends BaseBlob {
  NoteBlob();

  // Json Helpers
  factory NoteBlob.fromJson(Map<String, dynamic> json) =>
      _$NoteBlobFromJson(json);

  Map<String, dynamic> toJson() => _$NoteBlobToJson(this);

  static NoteBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return NoteBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable(includeIfNull: false)
class CodeBlob extends BaseBlob {
  String? code;

  CodeBlob();

  // Json Helpers
  factory CodeBlob.fromJson(Map<String, dynamic> json) =>
      _$CodeBlobFromJson(json);

  Map<String, dynamic> toJson() => _$CodeBlobToJson(this);

  static CodeBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return CodeBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable(includeIfNull: false)
class CardBlob extends BaseBlob {
  @JsonKey(defaultValue: CardType.other)
  CardType cardType = CardType.other;
  String? cardHolderName;
  String? cardNumber;
  String? verificationNumber;
  Month? expirationMonth;
  Year? expirationYear;
  String? pinNumber;
  String? supportNumber;

  CardBlob();

  // Json Helpers
  factory CardBlob.fromJson(Map<String, dynamic> json) =>
      _$CardBlobFromJson(json);

  Map<String, dynamic> toJson() => _$CardBlobToJson(this);

  static CardBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return CardBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable(includeIfNull: false)
class DocBlob extends BaseBlob {
  @JsonKey(defaultValue: DocType.other)
  DocType docType = DocType.other;

  @JsonKey(defaultValue: [])
  List<DocField> fields = [];

  DocBlob();

  // Json Helpers
  factory DocBlob.fromJson(Map<String, dynamic> json) =>
      _$DocBlobFromJson(json);

  Map<String, dynamic> toJson() => _$DocBlobToJson(this);

  static DocBlob? deserialize(String source) {
    try {
      final decoded = json.decode(source);
      return DocBlob.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }
}


