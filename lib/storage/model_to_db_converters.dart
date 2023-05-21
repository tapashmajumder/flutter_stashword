import 'package:Stashword/data/item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/storage/blob_serialization.dart';

void main() {
  print("Hello, World!");
  final model = PasswordModel(id: "id1", iv: "iv1");
  model.password = "password";
  model.photoIds = ["1id"];
  model.userName = "zee'user@#\$@\$#%ame";

  Item item = ModelToDbConverter.itemFromPasswordModel(model: model);

  print("${item.blob}");

  final foundModel = ModelToDbConverter.passwordModelFromItem(item: item);

  print("${foundModel.userName}");
}

class ModelToDbConverter {
  static Item itemFromPasswordModel({required PasswordModel model}) {
    final item = Item(
      itemType: ItemType.password.value,
      id: model.id,
      iv: model.iv,
    );

    _setBaseValuesInItemFromModel(item, model);
    PasswordBlob blob = PasswordBlob();
    _setBaseValuesInItemBlobFromModel(blob, model);

    // custom values for passwords
    blob.url = model.url;
    blob.userName = model.userName;
    blob.password = model.password;
    blob.otpToken = model.otpToken;

    item.blob = blob.serialized;
    return item;
  }

  static PasswordModel passwordModelFromItem({required Item item}) {
    final model = PasswordModel(
      id: item.id,
      iv: item.iv
    );

    _setBaseValuesInModelFromItem(model, item);
    final itemBlob = item.blob;
    if (itemBlob != null) {
      final passwordBlob = PasswordBlob.deserialize(itemBlob);
      if (passwordBlob != null) {
        _setBaseValuesInModelFromItemBlob(model, passwordBlob);
        model.url = passwordBlob.url;
        model.userName = passwordBlob.userName;
        model.password = passwordBlob.password;
        model.otpToken = passwordBlob.otpToken;
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

