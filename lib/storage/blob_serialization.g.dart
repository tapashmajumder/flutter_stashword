// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_serialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBlob _$BaseBlobFromJson(Map<String, dynamic> json) => BaseBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [];

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
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
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

BankAccountBlob _$BankAccountBlobFromJson(Map<String, dynamic> json) =>
    BankAccountBlob()
      ..name = json['name'] as String?
      ..notes = json['notes'] as String?
      ..photoIds = (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          []
      ..tags = (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          []
      ..customFields = (json['custom'] as List<dynamic>?)
              ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
      ..accountNo = json['accountNo'] as String?
      ..routingNo = json['routingNo'] as String?
      ..supportNo = json['supportNo'] as String?
      ..pinNo = json['pinNo'] as String?
      ..swiftCode = json['swiftCode'] as String?;

Map<String, dynamic> _$BankAccountBlobToJson(BankAccountBlob instance) {
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
  writeNotNull('accountNo', instance.accountNo);
  writeNotNull('routingNo', instance.routingNo);
  writeNotNull('supportNo', instance.supportNo);
  writeNotNull('pinNo', instance.pinNo);
  writeNotNull('swiftCode', instance.swiftCode);
  return val;
}

FFBlob _$FFBlobFromJson(Map<String, dynamic> json) => FFBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..ffNo = json['ffNo'] as String?
  ..supportNo = json['supportNo'] as String?;

Map<String, dynamic> _$FFBlobToJson(FFBlob instance) {
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
  writeNotNull('ffNo', instance.ffNo);
  writeNotNull('supportNo', instance.supportNo);
  return val;
}

NoteBlob _$NoteBlobFromJson(Map<String, dynamic> json) => NoteBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [];

Map<String, dynamic> _$NoteBlobToJson(NoteBlob instance) {
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

CodeBlob _$CodeBlobFromJson(Map<String, dynamic> json) => CodeBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..code = json['code'] as String?;

Map<String, dynamic> _$CodeBlobToJson(CodeBlob instance) {
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
  writeNotNull('code', instance.code);
  return val;
}

CardBlob _$CardBlobFromJson(Map<String, dynamic> json) => CardBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..cardType =
      $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']) ?? CardType.other
  ..cardHolderName = json['cardHolderName'] as String?
  ..cardNumber = json['cardNumber'] as String?
  ..verificationNumber = json['verificationNumber'] as String?
  ..expirationMonth =
      $enumDecodeNullable(_$MonthEnumMap, json['expirationMonth'])
  ..expirationYear = $enumDecodeNullable(_$YearEnumMap, json['expirationYear'])
  ..pinNumber = json['pinNumber'] as String?
  ..supportNumber = json['supportNumber'] as String?;

Map<String, dynamic> _$CardBlobToJson(CardBlob instance) {
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
  val['cardType'] = _$CardTypeEnumMap[instance.cardType]!;
  writeNotNull('cardHolderName', instance.cardHolderName);
  writeNotNull('cardNumber', instance.cardNumber);
  writeNotNull('verificationNumber', instance.verificationNumber);
  writeNotNull('expirationMonth', _$MonthEnumMap[instance.expirationMonth]);
  writeNotNull('expirationYear', _$YearEnumMap[instance.expirationYear]);
  writeNotNull('pinNumber', instance.pinNumber);
  writeNotNull('supportNumber', instance.supportNumber);
  return val;
}

const _$CardTypeEnumMap = {
  CardType.visa: 'Visa',
  CardType.mc: 'MasterCard',
  CardType.amex: 'Amex',
  CardType.disc: 'Discover',
  CardType.other: 'Other',
};

const _$MonthEnumMap = {
  Month.january: 'January',
  Month.february: 'February',
  Month.march: 'March',
  Month.april: 'April',
  Month.may: 'May',
  Month.june: 'June',
  Month.july: 'July',
  Month.august: 'August',
  Month.september: 'September',
  Month.october: 'October',
  Month.november: 'November',
  Month.december: 'December',
};

const _$YearEnumMap = {
  Year.y2015: '2015',
  Year.y2016: '2016',
  Year.y2017: '2017',
  Year.y2018: '2018',
  Year.y2019: '2019',
  Year.y2020: '2020',
  Year.y2021: '2021',
  Year.y2022: '2022',
  Year.y2023: '2023',
  Year.y2024: '2024',
  Year.y2025: '2025',
  Year.y2026: '2026',
  Year.y2027: '2027',
  Year.y2028: '2028',
  Year.y2029: '2029',
  Year.y2030: '2030',
  Year.y2031: '2031',
  Year.y2032: '2032',
  Year.y2033: '2033',
  Year.y2034: '2034',
  Year.y2035: '2035',
  Year.y2036: '2036',
  Year.y2037: '2037',
  Year.y2038: '2038',
  Year.y2039: '2039',
  Year.y2040: '2040',
  Year.y2041: '2041',
  Year.y2042: '2042',
  Year.y2043: '2043',
  Year.y2044: '2044',
  Year.y2045: '2045',
  Year.y2046: '2046',
  Year.y2047: '2047',
  Year.y2048: '2048',
  Year.y2049: '2049',
  Year.y2050: '2050',
};

DocBlob _$DocBlobFromJson(Map<String, dynamic> json) => DocBlob()
  ..name = json['name'] as String?
  ..notes = json['notes'] as String?
  ..photoIds =
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..tags = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..customFields = (json['custom'] as List<dynamic>?)
          ?.map((e) => CustomFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..docType =
      $enumDecodeNullable(_$DocTypeEnumMap, json['docType']) ?? DocType.other
  ..fields = (json['fields'] as List<dynamic>?)
          ?.map((e) => DocField.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [];

Map<String, dynamic> _$DocBlobToJson(DocBlob instance) {
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
  val['docType'] = _$DocTypeEnumMap[instance.docType]!;
  val['fields'] = instance.fields;
  return val;
}

const _$DocTypeEnumMap = {
  DocType.license: 'license',
  DocType.insurance: 'insurance',
  DocType.passport: 'passport',
  DocType.prescription: 'prescription',
  DocType.ssn: 'ssn',
  DocType.other: 'other',
};
