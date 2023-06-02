import 'package:Stashword/data/data_service.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/sync/json_to_db_converter.dart';
import 'package:Stashword/sync/sync_server_jsons.dart';

final class SyncOutgoing {
  static SyncInfo create({required final IDataService dataService, required final DateTime? lastSyncDate}) {
    final List<Item> createdItems = lastSyncDate != null
        ? dataService.findAllItems(predicate: (item) => isCreatedAfter(item: item, lastSyncDate: lastSyncDate))
        : dataService.findAllItems();

    final List<Item> updatedItems = lastSyncDate != null
        ? dataService.findAllItems(predicate: (item) => isUpdatedAfter(item: item, lastSyncDate: lastSyncDate))
        : [];

    List<ItemDeleteInfo> deletedItems = dataService.findAllItemDeleteInfos();

    return SyncInfo(
      createdItems: createdItems.map(JsonToDb.fromItemToItemJson).toList(growable: false),
      modifiedItems: updatedItems.map(JsonToDb.fromItemToItemJson).toList(growable: false),
      deletedItems: deletedItems.map(JsonToDb.fromItemDeleteInfoToItemDeleteInfoJson).toList(growable: false),
      lastSyncDate: lastSyncDate,
    );
  }

  static bool isCreatedAfter({required Item item, required DateTime lastSyncDate}) {
    final created = item.created;
    return created != null && created.millisecondsSinceEpoch > lastSyncDate.millisecondsSinceEpoch;
  }

  static bool isUpdatedAfter({required Item item, required DateTime lastSyncDate}) {
    final created = item.created;
    final updated = item.modified;
    return created != null &&
        updated != null &&
        created.millisecondsSinceEpoch <= lastSyncDate.millisecondsSinceEpoch &&
        updated.millisecondsSinceEpoch > lastSyncDate.millisecondsSinceEpoch;
  }
}
