import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_models.g.dart';

enum ItemType {
  @JsonValue("Password")
  password(value: "Password"),
  @JsonValue("BankAccount")
  bankAccount(value: "BankAccount"),
  @JsonValue("FF")
  ff(value: "FF"),
  @JsonValue("Note")
  note(value: "Note"),
  @JsonValue("Code")
  code(value: "Code"),
  @JsonValue("Wallet")
  card(value: "Wallet"),
  @JsonValue("Doc")
  doc(value: "Doc");

  final String value;

  const ItemType({required this.value});
}

extension ItemTypeExtension on ItemType {
  static ItemType fromString({required String value}) {
    return ItemType.values.firstWhereOrNull((element) => element.value == value) ?? ItemType.password;
  }
}

enum FieldType {
  email,
  date,
  string,
  phoneNumber,
  number,
}

enum CardType {
  @JsonValue("Visa")
  visa,
  @JsonValue("MasterCard")
  mc,
  @JsonValue("Amex")
  amex,
  @JsonValue("Discover")
  disc,
  @JsonValue("Other")
  other,
}

enum Month {
  @JsonValue("January")
  january,
  @JsonValue("February")
  february,
  @JsonValue("March")
  march,
  @JsonValue("April")
  april,
  @JsonValue("May")
  may,
  @JsonValue("June")
  june,
  @JsonValue("July")
  july,
  @JsonValue("August")
  august,
  @JsonValue("September")
  september,
  @JsonValue("October")
  october,
  @JsonValue("November")
  november,
  @JsonValue("December")
  december,
}

enum Year {
  @JsonValue("2015")
  y2015,
  @JsonValue("2016")
  y2016,
  @JsonValue("2017")
  y2017,
  @JsonValue("2018")
  y2018,
  @JsonValue("2019")
  y2019,
  @JsonValue("2020")
  y2020,
  @JsonValue("2021")
  y2021,
  @JsonValue("2022")
  y2022,
  @JsonValue("2023")
  y2023,
  @JsonValue("2024")
  y2024,
  @JsonValue("2025")
  y2025,
  @JsonValue("2026")
  y2026,
  @JsonValue("2027")
  y2027,
  @JsonValue("2028")
  y2028,
  @JsonValue("2029")
  y2029,
  @JsonValue("2030")
  y2030,
  @JsonValue("2031")
  y2031,
  @JsonValue("2032")
  y2032,
  @JsonValue("2033")
  y2033,
  @JsonValue("2034")
  y2034,
  @JsonValue("2035")
  y2035,
  @JsonValue("2036")
  y2036,
  @JsonValue("2037")
  y2037,
  @JsonValue("2038")
  y2038,
  @JsonValue("2039")
  y2039,
  @JsonValue("2040")
  y2040,
  @JsonValue("2041")
  y2041,
  @JsonValue("2042")
  y2042,
  @JsonValue("2043")
  y2043,
  @JsonValue("2044")
  y2044,
  @JsonValue("2045")
  y2045,
  @JsonValue("2046")
  y2046,
  @JsonValue("2047")
  y2047,
  @JsonValue("2048")
  y2048,
  @JsonValue("2049")
  y2049,
  @JsonValue("2050")
  y2050,
}

enum DocType {
  license,
  insurance,
  passport,
  prescription,
  ssn,
  other,
}

@JsonSerializable(includeIfNull: false)
class DocField extends Equatable {
  @JsonKey(defaultValue: FieldType.string)
  FieldType fieldType;
  String label;
  String? placeHolder;
  String? value;

  DocField({
    required this.fieldType,
    required this.label,
    this.placeHolder,
    this.value,
  });

  factory DocField.fromJson(Map<String, dynamic> json) => _$DocFieldFromJson(json);

  Map<String, dynamic> toJson() => _$DocFieldToJson(this);

  @override
  List<Object?> get props => [fieldType, label, placeHolder, value];
}

@JsonSerializable(includeIfNull: false)
class CustomFieldInfo extends Equatable {
  @JsonKey(defaultValue: FieldType.string)
  FieldType type;
  String name;
  String value;

  CustomFieldInfo({
    required this.type,
    required this.name,
    required this.value,
  });

  factory CustomFieldInfo.fromJson(Map<String, dynamic> json) => _$CustomFieldInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomFieldInfoToJson(this);

  @override
  List<Object?> get props => [name, value, type];
}

sealed class ItemModel implements Comparable<ItemModel> {
  ItemType itemType;
  final String id;
  final String iv;
  String? name;
  String? notes;
  List<String> photoIds;
  List<String> tags;
  List<CustomFieldInfo> customFields;
  bool addToWatch;
  int? colorIndex;
  DateTime? created;
  DateTime? lastUsed;
  DateTime? modified;
  bool sharedItem;
  bool shared;
  String? sharedSecret;
  String? sharer;

  ItemModel({
    required this.itemType,
    required this.id,
    required this.iv,
    this.name,
    this.notes,
    this.photoIds = const [],
    this.tags = const [],
    this.customFields = const [],
    this.addToWatch = false,
    this.colorIndex,
    this.created,
    this.lastUsed,
    this.modified,
    this.sharedItem = false,
    this.shared = false,
    this.sharedSecret,
    this.sharer,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;


  @override
  int compareTo(ItemModel other) {
    if (name == null && other.name == null) {
      return 0;
    }
    if (name == null) {
      return -1;
    }
    if (other.name == null) {
      return 1;
    }
    return name!.toLowerCase().compareTo(other.name!.toLowerCase());
  }
}

class PasswordModel extends ItemModel {
  String? url;
  String? userName;
  String? password;
  String? otpToken;

  PasswordModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
    this.url,
    this.userName,
    this.password,
    this.otpToken,
  }) : super(
          itemType: ItemType.password,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}

class BankAccountModel extends ItemModel {
  String? accountNo;
  String? routingNo;
  String? supportNo;
  String? pinNo;
  String? swiftCode;

  BankAccountModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
    this.accountNo,
    this.routingNo,
    this.supportNo,
    this.pinNo,
    this.swiftCode,
  }) : super(
          itemType: ItemType.bankAccount,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}

class CodeModel extends ItemModel {
  String? code;

  CodeModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
    this.code,
  }) : super(
          itemType: ItemType.code,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}

class FFModel extends ItemModel {
  String? ffNo;
  String? supportNo;

  FFModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
    this.ffNo,
    this.supportNo,
  }) : super(
          itemType: ItemType.ff,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}

class NoteModel extends ItemModel {
  NoteModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
  }) : super(
          itemType: ItemType.note,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}

class CardModel extends ItemModel {
  CardType cardType;
  String? cardHolderName;
  String? cardNumber;
  String? verificationNumber;
  Month? expirationMonth;
  Year? expirationYear;
  String? pinNumber;
  String? supportNumber;

  CardModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
    this.cardType = CardType.other,
    this.cardHolderName,
    this.cardNumber,
    this.verificationNumber,
    this.expirationMonth,
    this.expirationYear,
    this.pinNumber,
    this.supportNumber,
  }) : super(
          itemType: ItemType.card,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}

class DocModel extends ItemModel {
  DocType docType;
  List<DocField> fields;

  DocModel({
    required String id,
    required String iv,
    String? name,
    String? notes,
    List<String> photoIds = const [],
    List<String> tags = const [],
    List<CustomFieldInfo> customFields = const [],
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool sharedItem = false,
    bool shared = false,
    String? sharedSecret,
    String? sharer,
    this.docType = DocType.other,
    this.fields = const [],
  }) : super(
          itemType: ItemType.doc,
          id: id,
          iv: iv,
          name: name,
          notes: notes,
          photoIds: photoIds,
          tags: tags,
          customFields: customFields,
          addToWatch: addToWatch,
          colorIndex: colorIndex,
          created: created,
          modified: modified,
          lastUsed: lastUsed,
          sharedItem: sharedItem,
          shared: shared,
          sharedSecret: sharedSecret,
          sharer: sharer,
        );
}
