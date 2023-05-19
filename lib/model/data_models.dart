enum ItemType {
  password,
  bankAccount,
  ff,
  note,
  code,
  card,
  doc,
}

enum FieldType {
  email,
  date,
  string,
  phoneNumber,
  number,
}

enum CardType {
  visa,
  mc,
  amex,
  disc,
  other,
}

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

enum Year {
  y2015,
  y2016,
  y2017,
  y2018,
  y2019,
  y2020,
  y2021,
  y2022,
  y2023,
  y2024,
  y2025,
  y2026,
  y2027,
  y2028,
  y2029,
  y2030,
  y2031,
  y2032,
  y2033,
  y2034,
  y2035,
  y2036,
  y2037,
  y2038,
  y2039,
  y2040,
  y2041,
  y2042,
  y2043,
  y2044,
  y2045,
  y2046,
  y2047,
  y2048,
  y2049,
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

class DocField {
  FieldType fieldType;
  String label;
  String placeHolder;
  String? value;

  DocField({
    required this.fieldType,
    required this.label,
    required this.placeHolder,
    this.value,
  });
}

class CustomFieldInfo {
  String name;
  String value;
  FieldType type;

  CustomFieldInfo(
    this.name,
    this.value,
    this.type,
  );
}

class ItemModel {
  ItemType itemType;
  final String id;
  final String iv;
  String? name;
  String? notes;
  List<String> photoIds;
  List<String> tags;
  List<CustomFieldInfo> customFields;
  bool addToWatch;
  int colorIndex;
  DateTime? created;
  DateTime? lastUsed;
  DateTime? modified;
  bool shared;
  String? sharedSecret;

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
    this.colorIndex = 0,
    this.created,
    this.lastUsed,
    this.modified,
    this.shared = false,
    this.sharedSecret,
  });
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
          shared: shared,
          sharedSecret: sharedSecret,
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
          shared: shared,
          sharedSecret: sharedSecret,
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
          shared: shared,
          sharedSecret: sharedSecret,
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
          shared: shared,
          sharedSecret: sharedSecret,
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
          shared: shared,
          sharedSecret: sharedSecret,
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
          shared: shared,
          sharedSecret: sharedSecret,
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
    int colorIndex = 0,
    DateTime? created,
    DateTime? modified,
    DateTime? lastUsed,
    bool shared = false,
    String? sharedSecret,
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
    shared: shared,
    sharedSecret: sharedSecret,
  );
}
