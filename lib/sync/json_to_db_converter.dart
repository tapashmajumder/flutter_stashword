
import 'package:Stashword/data/item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/sync/server_jsons.dart';

class JsonToDb {
  static Item fromJsonToDb(ItemJson json) {
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

  static ItemJson fromDbToJson(Item item) {
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
}