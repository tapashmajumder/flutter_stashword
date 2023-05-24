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
      itemType: ItemType.password.value,
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
    model.colorIndex = item.colorIndex ?? 0;
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
      case PasswordModel:
        return PasswordConverter();
      case BankAccountModel:
        return BankAccountConverter();
      default:
        throw StateError("could not find converter");
    }
  }

  static BaseConverter _getConverterForItem({required Item item}) {
    final ItemType itemType = ItemTypeExtension.fromString(value: item.itemType) ?? ItemType.password;
    switch (itemType) {
      case ItemType.password:
        return PasswordConverter();
      case ItemType.bankAccount:
        return BankAccountConverter();
      default:
        throw StateError("Unknown itemType: $itemType");
    }
  }
}

