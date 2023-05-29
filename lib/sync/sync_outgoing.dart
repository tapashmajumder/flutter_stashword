import 'package:Stashword/data/database.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/sync/json_to_db_converter.dart';
import 'package:Stashword/sync/server_jsons.dart';

abstract interface class ISyncOutgoingInput {
  DateTime? get lastSyncDate; // This is the last time data was synchronized

  List<Item> findAllItems({bool Function(Item)? predicate});

  List<ItemDeleteInfo> findAllItemDeleteInfos();
}

class SyncOutgoingInput implements ISyncOutgoingInput {
  const SyncOutgoingInput({
    this.lastSyncDate,
  });

  @override
  final DateTime? lastSyncDate;

  @override
  List<ItemDeleteInfo> findAllItemDeleteInfos() {
    return Database.itemDeleteInfoCrud.findAll();
  }

  @override
  List<Item> findAllItems({bool Function(Item item)? predicate}) {
    if (predicate == null) {
      return Database.itemCrud.findAll();
    } else {
      return Database.itemCrud.findAll(predicate: predicate);
    }
  }
}

final class SyncOutgoing {
  static SyncInfo create({ISyncOutgoingInput input = const SyncOutgoingInput()}) {
    final lastSyncDate = input.lastSyncDate;
    final List<Item> createdItems;
    if (lastSyncDate != null) {
      createdItems = input.findAllItems(predicate: (item) => isCreatedAfter(item: item, lastSyncDate: lastSyncDate));
    } else {
      // all created, 0 updated
      createdItems = input.findAllItems();
    }

    final List<Item> updatedItems;
    if (lastSyncDate != null) {
      updatedItems = input.findAllItems(predicate: (item) => isUpdatedAfter(item: item, lastSyncDate: lastSyncDate));
    } else {
      // all created, 0 updated
      updatedItems = [];
    }

    List<ItemDeleteInfo> deletedItems = input.findAllItemDeleteInfos();

    return SyncInfo(
      createdItems: createdItems.map(JsonToDb.fromItemToItemJson).toList(growable: false),
      modifiedItems: updatedItems.map(JsonToDb.fromItemToItemJson).toList(growable: false),
      deletedItems: deletedItems.map(JsonToDb.fromItemDeleteInfoToItemDeleteInfoJson).toList(growable: false),
      lastSyncDate: lastSyncDate,
    );
  }

  static bool isCreatedAfter({required Item item, required DateTime lastSyncDate}) {
    final created = item.created;
    if (created == null) {
      return false;
    }
    return (created.millisecondsSinceEpoch > lastSyncDate.millisecondsSinceEpoch);
  }

  static bool isUpdatedAfter({required Item item, required DateTime lastSyncDate}) {
    final created = item.created;
    final updated = item.modified;
    if (created == null || updated == null) {
      return false;
    }
    return (created.millisecondsSinceEpoch <= lastSyncDate.millisecondsSinceEpoch &&
        updated.millisecondsSinceEpoch > lastSyncDate.millisecondsSinceEpoch);
  }
}
