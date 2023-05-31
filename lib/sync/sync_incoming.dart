import 'package:Stashword/data/data_service.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/sync/json_to_db_converter.dart';
import 'package:Stashword/sync/server_jsons.dart';
import 'package:Stashword/util/ace_util.dart';

final class SyncIncoming {
  static const _maxColorIndex = 6;

  static Future<void> process({
    required SyncInfo syncInfo,
    required DateTime currentDate,
    required IDataService dataService,
  }) async {
    await _processCreatesAndUpdates(
      items: List.from(syncInfo.createdItems)..addAll(syncInfo.modifiedItems),
      currentDate: currentDate,
      dataService: dataService,
    );
    await _processDeletes(deleteInfos: syncInfo.deletedItems, dataService: dataService);
    await _processSharedItems(sharedItems: syncInfo.sharedItems, dataService: dataService);
    await _processPendingShareItems(pendingShares: syncInfo.pendingShares, dataService: dataService);
  }

  static Future<void> _processPendingShareItems({
    required List<PendingShareInfoJson> pendingShares,
    required IDataService dataService,
  }) async {
    final serverItemsMap = {for (var pendingShare in pendingShares) pendingShare.id: pendingShare};

    final pendingSharesInDb = dataService.findAllPendingShareInfos();
    final dbItemsMap = {for (var pendingShare in pendingSharesInDb) pendingShare.id: pendingShare};

    // Server items to be created in db
    final idsToBeCreated = serverItemsMap.keys.toSet().difference(dbItemsMap.keys.toSet());
    for (var id in idsToBeCreated) {
      final shareInfo = JsonToDb.fromPendingShareInfoJsonToPendingShareInfo(serverItemsMap[id]!);
      await dataService.createPendingShareInfo(shareInfo: shareInfo);
    }

    // Db items to be deleted
    final idsToBeDeleted = dbItemsMap.keys.toSet().difference(serverItemsMap.keys.toSet());
    for (var id in idsToBeDeleted) {
      await dataService.deletePendingShareInfoById(id: id);
    }

    // Items to be updated
    final idsToUpdate = dbItemsMap.keys.toSet().intersection(serverItemsMap.keys.toSet());
    for (var id in idsToUpdate) {
      final serverItem = serverItemsMap[id]!;
      final shareInfo = JsonToDb.fromPendingShareInfoJsonToPendingShareInfo(serverItem);
      await dataService.updatePendingShareInfo(shareInfo: shareInfo);
    }
  }

  static Future<void> _processSharedItems({
    required List<SharedItemJson> sharedItems,
    required IDataService dataService,
  }) async {
    final serverItemsMap = {for (var item in sharedItems) item.id: item};

    final sharedItemsInDb = dataService.findAllSharedItems();
    final dbItemsMap = {for (var item in sharedItemsInDb) item.id: item};

    // Server items to be created in db
    final idsToBeCreated = serverItemsMap.keys.toSet().difference(dbItemsMap.keys.toSet());
    for (var id in idsToBeCreated) {
      final sharedItem = JsonToDb.fromSharedItemJsonToSharedItem(serverItemsMap[id]!);
      await dataService.createSharedItem(sharedItem: sharedItem);
    }

    // Db items to be deleted
    final idsToBeDeleted = dbItemsMap.keys.toSet().difference(serverItemsMap.keys.toSet());
    for (var id in idsToBeDeleted) {
      await dataService.deleteSharedItemById(id: id);
    }

    // Items to be updated
    final idsToUpdate = dbItemsMap.keys.toSet().intersection(serverItemsMap.keys.toSet());
    for (var id in idsToUpdate) {
      final serverItem = serverItemsMap[id]!;
      final sharedItem = JsonToDb.fromSharedItemJsonToSharedItem(serverItem);
      await dataService.updateSharedItem(sharedItem: sharedItem);
    }
  }

  static Future<void> _processDeletes({
    required List<ItemDeleteInfoJson> deleteInfos,
    required IDataService dataService,
  }) async {
    for (var deleteInfo in deleteInfos) {
      await _handleDelete(deleteInfo: deleteInfo, dataService: dataService);
    }
  }

  static Future<void> _handleDelete({
    required ItemDeleteInfoJson deleteInfo,
    required IDataService dataService,
  }) async {
    final byId = dataService.findItemById(id: deleteInfo.id);
    if (byId == null) {
      return;
    }

    final modifiedInClient = byId.modified;
    if (modifiedInClient == null || deleteInfo.deleteDate.millisecondsSinceEpoch > modifiedInClient.millisecondsSinceEpoch) {
      await dataService.deleteItemById(id: byId.id);
    }
  }

  static Future<void> _processCreatesAndUpdates({
    required List<ItemJson> items,
    required DateTime currentDate,
    required IDataService dataService,
  }) async {
    for (var item in items) {
      await _handleCreateOrUpdate(serverJson: item, currentDate: currentDate, dataService: dataService);
    }
  }

  static Future<void> _handleCreateOrUpdate({
    required ItemJson serverJson,
    required DateTime currentDate,
    required IDataService dataService,
  }) async {
    final inDb = dataService.findItemById(id: serverJson.id);
    if (inDb == null) {
      await notFoundById(serverJson: serverJson, currentDate: currentDate, dataService: dataService);
    } else {
      await foundById(serverJson: serverJson, clientItem: inDb, currentDate: currentDate, dataService: dataService);
    }
  }

  static Future<void> foundById({
    required ItemJson serverJson,
    required Item clientItem,
    required DateTime currentDate,
    required IDataService dataService,
  }) async {
    final serverModifiedDate = serverJson.modified;
    final clientModifiedDate = clientItem.modified;
    if (serverModifiedDate != null &&
        (clientModifiedDate == null || serverModifiedDate.millisecondsSinceEpoch > clientModifiedDate.millisecondsSinceEpoch)) {
      // Delete item and then create item
      await dataService.deleteItemById(id: clientItem.id);
      await createClientItem(json: serverJson, currentDate: currentDate, dataService: dataService);
    } else {
      // Item in client is more recent.
    }
  }

  static Future<void> notFoundById({
    required ItemJson serverJson,
    required DateTime currentDate,
    required IDataService dataService,
  }) async {
    ItemDeleteInfo? deleteInfo = dataService.findItemDeleteInfoById(id: serverJson.id);
    if (deleteInfo == null) {
      // This was not deleted in server, so we should create one
      await createClientItem(json: serverJson, currentDate: currentDate, dataService: dataService);
    } else {
      // This item was deleted in client, so if this item was modified in server after the delete date
      // then create again
      final modifiedDateInServer = serverJson.modified;
      if (modifiedDateInServer != null) {
        if (modifiedDateInServer.millisecondsSinceEpoch > deleteInfo.deleteDate.millisecondsSinceEpoch) {
          await createClientItem(json: serverJson, currentDate: currentDate, dataService: dataService);
          await dataService.deleteItemDeleteInfoById(id: serverJson.id);
        }
      }
    }
  }

  static Future<void> createClientItem({
    required ItemJson json,
    required DateTime currentDate,
    required IDataService dataService,
  }) async {
    final Item item = JsonToDb.fromItemJsonToItem(json);
    item.created ??= currentDate;
    item.lastUsed ??= currentDate;
    item.colorIndex ??= AceUtil.nextRandom(max: _maxColorIndex);
    await dataService.createItem(item: item);
  }
}
