
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
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
}