import 'package:Stashword/data/item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/storage/blob_serialization.dart';

void main() {
  print("Hello, World!");
  final model = PasswordModel(id: "id1", iv: "iv1");
  model.password = "password";
  model.photoIds = ["1id"];
  model.userName = "zee'user@#\$@\$#%ame";

  Item item = ModelToDbConverter.fromModelToItem(model: model);

  print("itemBlob: ${item.blob}");

  final PasswordModel foundModel = ModelToDbConverter.fromItemToModel(item: item);

  print("${foundModel.userName}");
}

abstract class BaseConverter<Blob extends BaseBlob, Model extends ItemModel> {
  String get itemType;

  Blob createBlob();

  void setCustomFromModelToBlob(Model model, Blob blob);

  Model createModel({required String id, required String iv});

  Blob? blobFromString(String serialized);

  void setCustomFromBlobToModel(Blob blob, Model model);

  Item itemFromItemModel({required Model model}) {
    final item = Item(
      itemType: model.itemType.value,
      id: model.id,
      iv: model.iv,
    );

    _setBaseValuesInItemFromModel(item, model);
    Blob blob = createBlob();
    _setBaseValuesInItemBlobFromModel(blob, model);

    setCustomFromModelToBlob(model, blob);

    item.blob = blob.serialized;
    return item;
  }

  Model modelFromItem({required Item item}) {
    final model = createModel(id: item.id, iv: item.iv);

    _setBaseValuesInModelFromItem(model, item);
    final itemBlob = item.blob;
    if (itemBlob != null) {
      final blobObject = blobFromString(itemBlob);
      if (blobObject != null) {
        _setBaseValuesInModelFromItemBlob(model, blobObject);
        setCustomFromBlobToModel(blobObject, model);
      }
    }

    return model;
  }

  static void _setBaseValuesInItemFromModel(Item item, ItemModel model) {
    item.addToWatch = model.addToWatch;
    item.colorIndex = model.colorIndex;
    item.created = model.created;
    item.lastUsed = model.lastUsed;
    item.modified = model.modified;
    item.shared = model.shared;
    item.sharedSecret = model.sharedSecret;
  }

  static void _setBaseValuesInModelFromItem(ItemModel model, Item item) {
    model.addToWatch = item.addToWatch;
    model.colorIndex = item.colorIndex;
    model.created = item.created;
    model.lastUsed = item.lastUsed;
    model.modified = item.modified;
    model.shared = item.shared;
    model.sharedSecret = item.sharedSecret;
  }

  static void _setBaseValuesInItemBlobFromModel(BaseBlob blob, ItemModel model) {
    blob.name = model.name;
    blob.notes = model.notes;
    blob.photoIds = model.photoIds;
    blob.tags = model.tags;
    blob.customFields = model.customFields;
  }

  static void _setBaseValuesInModelFromItemBlob(ItemModel model, BaseBlob blob) {
    model.name = blob.name;
    model.notes = blob.notes;
    model.photoIds = blob.photoIds;
    model.tags = blob.tags;
    model.customFields = blob.customFields;
  }
}

class PasswordConverter extends BaseConverter<PasswordBlob, PasswordModel> {
  @override
  String get itemType => ItemType.password.value;

  @override
  PasswordBlob createBlob() {
    return PasswordBlob();
  }

  @override
  void setCustomFromModelToBlob(PasswordModel model, PasswordBlob blob) {
    blob.url = model.url;
    blob.userName = model.userName;
    blob.password = model.password;
    blob.otpToken = model.otpToken;
  }

  @override
  PasswordModel createModel({required String id, required String iv}) {
    return PasswordModel(id: id, iv: iv);
  }

  @override
  PasswordBlob? blobFromString(String serialized) {
    return PasswordBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(PasswordBlob blob, PasswordModel model) {
    model.url = blob.url;
    model.userName = blob.userName;
    model.password = blob.password;
    model.otpToken = blob.otpToken;
  }
}

class BankAccountConverter extends BaseConverter<BankAccountBlob, BankAccountModel> {
  @override
  String get itemType => ItemType.bankAccount.value;

  @override
  BankAccountBlob createBlob() {
    return BankAccountBlob();
  }

  @override
  void setCustomFromModelToBlob(BankAccountModel model, BankAccountBlob blob) {
    blob.accountNo = model.accountNo;
    blob.routingNo = model.routingNo;
    blob.supportNo = model.supportNo;
    blob.pinNo = model.pinNo;
    blob.swiftCode = model.swiftCode;
  }

  @override
  BankAccountModel createModel({required String id, required String iv}) {
    return BankAccountModel(id: id, iv: iv);
  }

  @override
  BankAccountBlob? blobFromString(String serialized) {
    return BankAccountBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(BankAccountBlob blob, BankAccountModel model) {
    model.accountNo = blob.accountNo;
    model.routingNo = blob.routingNo;
    model.supportNo = blob.supportNo;
    model.pinNo = blob.pinNo;
    model.swiftCode = blob.swiftCode;
  }
}

class FFConverter extends BaseConverter<FFBlob, FFModel> {
  @override
  String get itemType => ItemType.ff.value;

  @override
  FFBlob createBlob() {
    return FFBlob();
  }

  @override
  void setCustomFromModelToBlob(FFModel model, FFBlob blob) {
    blob.ffNo = model.ffNo;
    blob.supportNo = model.supportNo;
  }

  @override
  FFModel createModel({required String id, required String iv}) {
    return FFModel(id: id, iv: iv);
  }

  @override
  FFBlob? blobFromString(String serialized) {
    return FFBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(FFBlob blob, FFModel model) {
    model.ffNo = blob.ffNo;
    model.supportNo = blob.supportNo;
  }
}

class NoteConverter extends BaseConverter<NoteBlob, NoteModel> {
  @override
  String get itemType => ItemType.note.value;

  @override
  NoteBlob createBlob() {
    return NoteBlob();
  }

  @override
  void setCustomFromModelToBlob(NoteModel model, NoteBlob blob) {
  }

  @override
  NoteModel createModel({required String id, required String iv}) {
    return NoteModel(id: id, iv: iv);
  }

  @override
  NoteBlob? blobFromString(String serialized) {
    return NoteBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(NoteBlob blob, NoteModel model) {
  }
}

class CodeConverter extends BaseConverter<CodeBlob, CodeModel> {
  @override
  String get itemType => ItemType.code.value;

  @override
  CodeBlob createBlob() {
    return CodeBlob();
  }

  @override
  void setCustomFromModelToBlob(CodeModel model, CodeBlob blob) {
    blob.code = model.code;
  }

  @override
  CodeModel createModel({required String id, required String iv}) {
    return CodeModel(id: id, iv: iv);
  }

  @override
  CodeBlob? blobFromString(String serialized) {
    return CodeBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(CodeBlob blob, CodeModel model) {
    model.code = blob.code;
  }
}

class CardConverter extends BaseConverter<CardBlob, CardModel> {
  @override
  String get itemType => ItemType.card.value;

  @override
  CardBlob createBlob() {
    return CardBlob();
  }

  @override
  void setCustomFromModelToBlob(CardModel model, CardBlob blob) {
    blob.cardType = model.cardType;
    blob.cardHolderName = model.cardHolderName;
    blob.cardNumber = model.cardNumber;
    blob.verificationNumber = model.verificationNumber;
    blob.expirationMonth = model.expirationMonth;
    blob.expirationYear = model.expirationYear;
    blob.pinNumber = model.pinNumber;
    blob.supportNumber = model.supportNumber;
  }

  @override
  CardModel createModel({required String id, required String iv}) {
    return CardModel(id: id, iv: iv);
  }

  @override
  CardBlob? blobFromString(String serialized) {
    return CardBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(CardBlob blob, CardModel model) {
    model.cardType = blob.cardType;
    model.cardHolderName = blob.cardHolderName;
    model.cardNumber = blob.cardNumber;
    model.verificationNumber = blob.verificationNumber;
    model.expirationMonth = blob.expirationMonth;
    model.expirationYear = blob.expirationYear;
    model.pinNumber = blob.pinNumber;
    model.supportNumber = blob.supportNumber;
  }
}

class DocConverter extends BaseConverter<DocBlob, DocModel> {
  @override
  String get itemType => ItemType.doc.value;

  @override
  DocBlob createBlob() {
    return DocBlob();
  }

  @override
  void setCustomFromModelToBlob(DocModel model, DocBlob blob) {
    blob.docType = model.docType;
    blob.fields = model.fields;
  }

  @override
  DocModel createModel({required String id, required String iv}) {
    return DocModel(id: id, iv: iv);
  }

  @override
  DocBlob? blobFromString(String serialized) {
    return DocBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(DocBlob blob, DocModel model) {
    model.docType = blob.docType;
    model.fields = blob.fields;
  }
}

class ModelToDbConverter {
  static Item fromModelToItem<Model extends ItemModel>({required Model model}) {
    final BaseConverter converter = _getConverterForModel(model: model);
    return converter.itemFromItemModel(model: model);
  }

  static T fromItemToModel<T extends ItemModel>({required Item item}) {
    final BaseConverter converter = _getConverterForItem(item: item);
    return converter.modelFromItem(item: item) as T;
  }

  static BaseConverter _getConverterForModel({required ItemModel model}) {
    switch (model) {
      case PasswordModel _:
        return PasswordConverter();
      case BankAccountModel _:
        return BankAccountConverter();
      case FFModel _:
        return FFConverter();
      case NoteModel _:
        return 
            NoteConverter();
      case CodeModel _:
        return CodeConverter();
      case CardModel _:
        return CardConverter();
      case DocModel _:
        return DocConverter();
    }
  }

  static BaseConverter _getConverterForItem({required Item item}) {
    final ItemType itemType = ItemTypeExtension.fromString(value: item.itemType) ?? ItemType.password;
    switch (itemType) {
      case ItemType.password:
        return PasswordConverter();
      case ItemType.bankAccount:
        return BankAccountConverter();
      case ItemType.ff:
        return FFConverter();
      case ItemType.note:
        return NoteConverter();
      case ItemType.code:
        return CodeConverter();
      case ItemType.card:
        return CardConverter();
      case ItemType.doc:
        return DocConverter();
    }
  }
}

