
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/data/shared_item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/sync/server_jsons.dart';

class JsonToDb {
  static Item fromItemJsonToItem(ItemJson json) {
    final item = Item(
      itemType: json.itemType.value,
      id: json.id,
      iv: json.iv,
    );
    item.addToWatch = json.addToWatch;
    item.blob = json.blob;
    item.colorIndex = json.colorIndex;
    item.created = json.created;
    item.lastUsed = json.modified;
    item.modified = json.modified;
    item.shared = json.shared;
    item.sharedSecret = json.sharedSecret;

    return item;
  }

  static ItemJson fromItemToItemJson(Item item) {
    final json = ItemJson(
      itemType: ItemTypeExtension.fromString(value: item.itemType) ?? ItemType.password,
      id: item.id,
      iv: item.iv,
    );
    json.addToWatch = item.addToWatch;
    json.blob = item.blob;
    json.colorIndex = item.colorIndex;
    json.created = item.created;
    json.lastUsed = item.modified;
    json.modified = item.modified;
    json.shared = item.shared;
    json.sharedSecret = item.sharedSecret;

    return json;
  }

  static ItemDeleteInfo fromItemDeleteInfoJsonToItemDeleteInfo(ItemDeleteInfoJson json) {
    final itemDeleteInfo = ItemDeleteInfo(
        id: json.id,
        deleteDate: json.deleteDate,
    );
    return itemDeleteInfo;
  }

  static ItemDeleteInfoJson fromItemDeleteInfoToItemDeleteInfoJson(ItemDeleteInfo itemDeleteInfo) {
    final json = ItemDeleteInfoJson(
      id: itemDeleteInfo.id,
      deleteDate: itemDeleteInfo.deleteDate,
    );
    return json;
  }

  static SharedItem fromSharedItemJsonToSharedItem(SharedItemJson json) {
    final sharedItem = SharedItem(
      itemType: json.itemType.value,
      id: json.id,
      iv: json.iv,
      sharer: json.sharer,
      sharedSecret: json.sharedSecret,
    );
    sharedItem.addToWatch = json.addToWatch;
    sharedItem.blob = json.blob;
    sharedItem.colorIndex = json.colorIndex;
    sharedItem.created = json.created;
    sharedItem.lastUsed = json.modified;
    sharedItem.modified = json.modified;
    sharedItem.sharer = json.sharer;
    sharedItem.sharedSecret = json.sharedSecret;

    return sharedItem;
  }

  static SharedItemJson fromSharedItemToSharedItemJson(SharedItem sharedItem) {
    final json = SharedItemJson(
      itemType: ItemTypeExtension.fromString(value: sharedItem.itemType) ?? ItemType.password,
      id: sharedItem.id,
      iv: sharedItem.iv,
      sharer: sharedItem.sharer,
      sharedSecret: sharedItem.sharedSecret,
    );
    json.addToWatch = sharedItem.addToWatch;
    json.blob = sharedItem.blob;
    json.colorIndex = sharedItem.colorIndex;
    json.created = sharedItem.created;
    json.lastUsed = sharedItem.modified;
    json.modified = sharedItem.modified;

    return json;
  }
}