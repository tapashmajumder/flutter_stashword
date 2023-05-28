import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/pending_share_info.dart';
import 'package:Stashword/data/shared_item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/model/pending_share_info_model.dart';
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

  Blob instantiateBlob();

  void setCustomFromModelToBlob(Model model, Blob blob);

  Model instantiateModel({required String id, required String iv});

  Blob? blobFromString(String serialized);

  void setCustomFromBlobToModel(Blob blob, Model model);

  Item fromModelToItem({required Model model}) {
    final item = _createItemWithBaseValuesFromModel(model);
    item.blob = _createBlobFromModel(model: model)?.serialized;
    return item;
  }

  SharedItem fromModelToSharedItem({required Model model}) {
      final sharedItem = _createSharedItemWithBaseValuesFromModel(model);
      sharedItem.blob = _createBlobFromModel(model: model)?.serialized;
      return sharedItem;
  }

  Model fromItemToModel({required Item item}) {
    final model = _createModelWithBaseValuesFromItem(item);
    _copyValuesFromBlobToModel(item.blob, model);
    return model;
  }

  Model fromSharedItemToModel({required SharedItem sharedItem}) {
    final model = _createModelWithBaseValuesFromSharedItem(sharedItem);
    _copyValuesFromBlobToModel(sharedItem.blob, model);
    return model;
  }

  Blob? _createBlobFromModel({required Model model}) {
    Blob blob = instantiateBlob();
    _setBaseValuesInItemBlobFromModel(blob, model);
    setCustomFromModelToBlob(model, blob);
    return blob;
  }

  Model _createModelWithBaseValuesFromItem(Item item) {
    final model = instantiateModel(id: item.id, iv: item.iv);
    _setBaseValuesInModelFromItem(model, item);
    return model;
  }

  Model _createModelWithBaseValuesFromSharedItem(final SharedItem sharedItem) {
    final model = instantiateModel(id: sharedItem.id, iv: sharedItem.iv);
    _setBaseValuesInModelFromSharedItem(model, sharedItem);
    return model;
  }

  void _copyValuesFromBlobToModel(String? blob, Model model) {
    if (blob != null) {
      final blobObject = blobFromString(blob);
      if (blobObject != null) {
        _setBaseValuesInModelFromItemBlob(model, blobObject);
        setCustomFromBlobToModel(blobObject, model);
      }
    }
  }

  static Item _createItemWithBaseValuesFromModel(ItemModel model) {
    return Item(
      itemType: model.itemType.value,
      id: model.id,
      iv: model.iv,
      shared: model.shared,
      sharedSecret: model.sharedSecret ?? "",
      created: model.created,
      lastUsed: model.lastUsed,
      modified: model.modified,
      addToWatch: model.addToWatch,
      colorIndex: model.colorIndex,
    );
  }

  static SharedItem _createSharedItemWithBaseValuesFromModel(ItemModel model) {
    return SharedItem(
      itemType: model.itemType.value,
      id: model.id,
      iv: model.iv,
      sharer: model.sharer ?? "",
      sharedSecret: model.sharedSecret ?? "",
      created: model.created,
      lastUsed: model.lastUsed,
      modified: model.modified,
      addToWatch: model.addToWatch,
      colorIndex: model.colorIndex,
    );
  }

  static void _setBaseValuesInModelFromItem(ItemModel model, Item item) {
    model.sharedItem = false;
    model.addToWatch = item.addToWatch;
    model.colorIndex = item.colorIndex;
    model.created = item.created;
    model.lastUsed = item.lastUsed;
    model.modified = item.modified;
    model.shared = item.shared;
    model.sharedSecret = item.sharedSecret;
  }

  static void _setBaseValuesInModelFromSharedItem(ItemModel model, SharedItem sharedItem) {
    model.sharedItem = true;
    model.shared = true;
    model.addToWatch = sharedItem.addToWatch;
    model.colorIndex = sharedItem.colorIndex;
    model.created = sharedItem.created;
    model.lastUsed = sharedItem.lastUsed;
    model.modified = sharedItem.modified;
    model.sharer = sharedItem.sharer;
    model.sharedSecret = sharedItem.sharedSecret;
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
  PasswordBlob instantiateBlob() {
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
  PasswordModel instantiateModel({required String id, required String iv}) {
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
  BankAccountBlob instantiateBlob() {
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
  BankAccountModel instantiateModel({required String id, required String iv}) {
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
  FFBlob instantiateBlob() {
    return FFBlob();
  }

  @override
  void setCustomFromModelToBlob(FFModel model, FFBlob blob) {
    blob.ffNo = model.ffNo;
    blob.supportNo = model.supportNo;
  }

  @override
  FFModel instantiateModel({required String id, required String iv}) {
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
  NoteBlob instantiateBlob() {
    return NoteBlob();
  }

  @override
  void setCustomFromModelToBlob(NoteModel model, NoteBlob blob) {}

  @override
  NoteModel instantiateModel({required String id, required String iv}) {
    return NoteModel(id: id, iv: iv);
  }

  @override
  NoteBlob? blobFromString(String serialized) {
    return NoteBlob.deserialize(serialized);
  }

  @override
  void setCustomFromBlobToModel(NoteBlob blob, NoteModel model) {}
}

class CodeConverter extends BaseConverter<CodeBlob, CodeModel> {
  @override
  String get itemType => ItemType.code.value;

  @override
  CodeBlob instantiateBlob() {
    return CodeBlob();
  }

  @override
  void setCustomFromModelToBlob(CodeModel model, CodeBlob blob) {
    blob.code = model.code;
  }

  @override
  CodeModel instantiateModel({required String id, required String iv}) {
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
  CardBlob instantiateBlob() {
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
  CardModel instantiateModel({required String id, required String iv}) {
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
  DocBlob instantiateBlob() {
    return DocBlob();
  }

  @override
  void setCustomFromModelToBlob(DocModel model, DocBlob blob) {
    blob.docType = model.docType;
    blob.fields = model.fields;
  }

  @override
  DocModel instantiateModel({required String id, required String iv}) {
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
    final BaseConverter converter = _getConverterForItemType(itemType: model.itemType);
    return converter.fromModelToItem(model: model);
  }

  static SharedItem fromModelToSharedItem<Model extends ItemModel>({required Model model}) {
    final BaseConverter converter = _getConverterForItemType(itemType: model.itemType);
    return converter.fromModelToSharedItem(model: model);
  }

  static T fromItemToModel<T extends ItemModel>({required Item item}) {
    final ItemType itemType = ItemTypeExtension.fromString(value: item.itemType);
    final BaseConverter converter = _getConverterForItemType(itemType: itemType);
    return converter.fromItemToModel(item: item) as T;
  }

  static T fromSharedItemToModel<T extends ItemModel>({required SharedItem sharedItem}) {
    final ItemType itemType = ItemTypeExtension.fromString(value: sharedItem.itemType);
    final BaseConverter converter = _getConverterForItemType(itemType: itemType);
    return converter.fromSharedItemToModel(sharedItem: sharedItem) as T;
  }

  static PendingShareInfoModel fromPendingShareInfoToPendingShareInfoModel({required PendingShareInfo shareInfo}) {
    final itemType = ItemTypeExtension.fromString(value: shareInfo.itemType);
    final model = PendingShareInfoModel(
      itemType: itemType,
      id: shareInfo.id,
      iv: shareInfo.iv,
      name: _nameFromPendingShareBlob(itemType: itemType, blob: shareInfo.blob),
      sharer: shareInfo.sharer,
      shareStatus: ShareStatusExtension.fromString(value: shareInfo.shareStatus),
      sharedSecret: shareInfo.sharedSecret,
    );
    return model;
  }

  static String? _nameFromPendingShareBlob({required ItemType itemType, required String? blob}) {
    if (blob == null) {
      return null;
    } else {
      switch (itemType) {
        case ItemType.password:
          return PasswordBlob.deserialize(blob)?.name;
        case ItemType.bankAccount:
          return BankAccountBlob.deserialize(blob)?.name;
        case ItemType.ff:
          return FFBlob.deserialize(blob)?.name;
        case ItemType.note:
          return "Note";
        case ItemType.code:
          return CodeBlob.deserialize(blob)?.name;
        case ItemType.card:
          return CardBlob.deserialize(blob)?.name;
        case ItemType.doc:
          return DocBlob.deserialize(blob)?.name;
      }
    }
  }

  static BaseConverter _getConverterForItemType({required ItemType itemType}) {
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
