import 'package:Stashword/data/data_service.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/data/pending_share_info.dart';
import 'package:Stashword/data/shared_item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/model/pending_share_info_model.dart';
import 'package:Stashword/sync/sync_incoming.dart';
import 'package:Stashword/sync/sync_outgoing.dart';
import 'package:Stashword/sync/sync_server_jsons.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  group('sync outgoing', () {
    test('sync outgoing - last sync date null', () async {
      final dataService = MockSyncIncomingDataService();
      dataService.items.addAll([
        Item(itemType: ItemType.password.value, id: "id1", iv: "iv1"),
        Item(itemType: ItemType.password.value, id: "id2", iv: "iv2"),
      ]);

      final syncInfo = SyncOutgoing.create(dataService: dataService, lastSyncDate: null);
      expect(syncInfo.createdItems.length, 2);
      expect(syncInfo.modifiedItems.length, 0);
      expect(syncInfo.deletedItems.length, 0);
      expect(syncInfo.lastSyncDate, null);
    });

    test('sync outgoing', () async {
      final dataService = MockSyncIncomingDataService();
      final now = DateTime.timestamp();
      final lastSyncDate = now.subtract(const Duration(hours: 1));
      dataService.items.addAll([
        Item( // created before, modified after
          itemType: ItemType.password.value,
          id: "id1",
          iv: "iv1",
          created: lastSyncDate.subtract(const Duration(seconds: 1)),
          modified: lastSyncDate.add(const Duration(seconds: 1)),
        ),
        Item( // created after, modified after
          itemType: ItemType.password.value,
          id: "id2",
          iv: "iv2",
          created: lastSyncDate.add(const Duration(seconds: 1)),
          modified: lastSyncDate.add(const Duration(seconds: 2)),
        ),
      ]);

      dataService.itemDeleteInfos.addAll([
        ItemDeleteInfo(id: "id3", deleteDate: lastSyncDate.subtract(const Duration(seconds: 2))),
      ]);

      final syncInfo = SyncOutgoing.create(dataService: dataService, lastSyncDate: lastSyncDate);
      expect(syncInfo.createdItems.length, 1);
      expect(syncInfo.createdItems[0].id, "id2");
      expect(syncInfo.modifiedItems.length, 1);
      expect(syncInfo.modifiedItems[0].id, "id1");
      expect(syncInfo.deletedItems.length, 1);
      expect(syncInfo.lastSyncDate, lastSyncDate);
    });
  });

  group('SyncIncoming', () {
    test('process creates and updates items - check item modified dates properly', () async {
      final dataService = MockSyncIncomingDataService();

      const serverBlob = 'server-blob';
      const clientBlob = 'client-blob';

      final createDate = DateTime.timestamp().subtract(const Duration(days: 5));
      final modifiedInServerDate = DateTime.timestamp().subtract(const Duration(days: 1));
      final serverItem = ItemJson(
        itemType: ItemType.password,
        id: "id2",
        iv: "iv2",
        created: createDate,
        modified: modifiedInServerDate,
        blob: serverBlob,
      );

      final modifiedInClientDate = modifiedInServerDate.add(const Duration(seconds: 1));
      final clientItem = Item(
        itemType: ItemType.password.value,
        id: serverItem.id,
        iv: serverItem.iv,
        created: serverItem.created,
        modified: modifiedInClientDate,
        blob: clientBlob,
      );
      dataService.items.add(clientItem);

      final syncInfo = SyncInfo(
        createdItems: [],
        modifiedItems: [
          serverItem,
        ],
        deletedItems: [],
        sharedItems: [],
        pendingShares: [],
      );

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.items.length, 1);
      expect(dataService.items[0].blob, clientBlob);

      dataService.items.clear();
      clientItem.modified = modifiedInServerDate.subtract(const Duration(seconds: 1));
      dataService.items.add(clientItem);

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.items.length, 1);
      expect(dataService.items[0].blob, serverBlob);
    });

    test('process creates and updates items - when item delete info exists in client', () async {
      final dataService = MockSyncIncomingDataService();

      final createDate = DateTime.timestamp().subtract(const Duration(days: 5));
      final modifiedInServerDate = DateTime.timestamp().subtract(const Duration(days: 1));
      final ItemJson modifiedItem = ItemJson(
        itemType: ItemType.password,
        id: "id2",
        iv: "iv2",
        created: createDate,
        modified: modifiedInServerDate,
      );

      // Deleted after modified, so item will not be added
      final clientDeleteDate = modifiedInServerDate.add(const Duration(seconds: 1));
      ItemDeleteInfo deleteInfo = ItemDeleteInfo(id: modifiedItem.id, deleteDate: clientDeleteDate);
      dataService.itemDeleteInfos.add(deleteInfo);

      final syncInfo = SyncInfo(
        createdItems: [
          ItemJson(itemType: ItemType.password, id: 'id1', iv: 'iv1', blob: 'server-blob'),
        ],
        modifiedItems: [
          modifiedItem,
        ],
        deletedItems: [],
        sharedItems: [],
        pendingShares: [],
      );

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.items.length, 1);

      // modified is after delete, so item will be added
      deleteInfo.deleteDate = modifiedInServerDate.subtract(const Duration(seconds: 1));
      dataService.itemDeleteInfos.clear();
      dataService.itemDeleteInfos.add(deleteInfo);

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.items.length, 2);
    });

    test('process deletes', () async {
      final dataService = MockSyncIncomingDataService();

      final deleteDate = DateTime.timestamp().subtract(const Duration(days: 5));
      final deleteInfo = ItemDeleteInfoJson(id: "id1", deleteDate: deleteDate);

      final clientItem = Item(
        itemType: ItemType.password.value,
        id: deleteInfo.id,
        iv: "iv1",
        created: deleteDate.subtract(const Duration(days: 2)),
        modified: deleteDate.add(const Duration(seconds: 2)), // modified in client after delete in server.
      );
      dataService.items.add(clientItem);

      final syncInfo = SyncInfo(
        createdItems: [],
        modifiedItems: [],
        deletedItems: [
          deleteInfo,
        ],
        sharedItems: [],
        pendingShares: [],
      );

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.items.length, 1);

      // modified in client before delete, so item will be deleted
      dataService.items[0].modified = deleteDate.subtract(const Duration(seconds: 1));

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.items.length, 0);
    });

    test('process shared items', () async {
      final dataService = MockSyncIncomingDataService();

      final item1InServer = SharedItemJson(
        itemType: ItemType.password,
        id: "id1",
        iv: "iv1",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        blob: "item-1-in-server-blob",
      );
      final item2InServer = SharedItemJson(
        itemType: ItemType.password,
        id: "id2",
        iv: "iv2",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        blob: "item-2-in-server-blob",
      );

      final item2InClient = SharedItem(
        itemType: ItemType.password.value,
        id: "id2",
        iv: "iv2",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        blob: "item-2-in-client-blob",
      );

      final item3InClient = SharedItem(
        itemType: ItemType.password.value,
        id: "id3",
        iv: "iv3",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        blob: "item-3-in-client-blob",
      );

      dataService.sharedItems.addAll([item2InClient, item3InClient]);

      final syncInfo = SyncInfo(
        createdItems: [],
        modifiedItems: [],
        deletedItems: [],
        sharedItems: [item1InServer, item2InServer],
        pendingShares: [],
      );

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.sharedItems.map((item) => item.blob).toSet(), {item1InServer.blob, item2InServer.blob});
    });

    test('process pending shares', () async {
      final dataService = MockSyncIncomingDataService();

      final item1InServer = PendingShareInfoJson(
        itemType: ItemType.password,
        id: "id1",
        iv: "iv1",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        shareStatus: ShareStatus.pending,
        blob: "item-1-in-server-blob",
      );
      final item2InServer = PendingShareInfoJson(
        itemType: ItemType.password,
        id: "id2",
        iv: "iv2",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        shareStatus: ShareStatus.accepted,
        blob: "item-2-in-server-blob",
      );

      final item2InClient = PendingShareInfo(
        itemType: ItemType.password.value,
        id: "id2",
        iv: "iv2",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        shareStatus: ShareStatus.accepted.value,
        blob: "item-2-in-client-blob",
      );

      final item3InClient = PendingShareInfo(
        itemType: ItemType.password.value,
        id: "id3",
        iv: "iv3",
        sharer: "user1@example.com",
        sharedSecret: "sharedSecret1",
        shareStatus: ShareStatus.needToResend.value,
        blob: "item-3-in-client-blob",
      );

      dataService.pendingShareInfos.addAll([item2InClient, item3InClient]);

      final syncInfo = SyncInfo(
        createdItems: [],
        modifiedItems: [],
        deletedItems: [],
        sharedItems: [],
        pendingShares: [item1InServer, item2InServer],
      );

      await SyncIncoming.process(
        syncInfo: syncInfo,
        currentDate: DateTime.now(),
        dataService: dataService,
      );

      expect(dataService.pendingShareInfos.map((item) => item.blob).toSet(), {item1InServer.blob, item2InServer.blob});
    });
  });
}

class MockSyncIncomingDataService implements IDataService {
  final List<Item> items = [];
  final List<ItemDeleteInfo> itemDeleteInfos = [];
  final List<PendingShareInfo> pendingShareInfos = [];
  final List<SharedItem> sharedItems = [];

  @override
  Future<void> close() async {
  }

  @override
  Future<void> init() async {
  }

  @override
  Future<void> createItem({required Item item}) async {
    items.add(item);
  }

  @override
  Future<void> deleteItemById({required String id}) async {
    items.removeWhere((value) => value.id == id);
  }

  @override
  Future<void> deleteItemDeleteInfoById({required String id}) async {
    itemDeleteInfos.removeWhere((value) => value.id == id);
  }

  @override
  Item? findItemById({required String id}) {
    return items.firstWhereOrNull((value) => value.id == id);
  }

  @override
  Future<void> createPendingShareInfo({required PendingShareInfo shareInfo}) async {
    pendingShareInfos.add(shareInfo);
  }

  @override
  Future<void> createSharedItem({required SharedItem sharedItem}) async {
    sharedItems.add(sharedItem);
  }

  @override
  List<PendingShareInfo> findAllPendingShareInfos() {
    return pendingShareInfos;
  }

  @override
  List<SharedItem> findAllSharedItems() {
    return sharedItems;
  }

  @override
  ItemDeleteInfo? findItemDeleteInfoById({required String id}) {
    return itemDeleteInfos.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Future<void> updatePendingShareInfo({required PendingShareInfo shareInfo}) async {
    pendingShareInfos.removeWhere((element) => element.id == shareInfo.id);
    pendingShareInfos.add(shareInfo);
  }

  @override
  Future<void> updateSharedItem({required SharedItem sharedItem}) async {
    sharedItems.removeWhere((element) => element.id == sharedItem.id);
    sharedItems.add(sharedItem);
  }

  @override
  Future<void> deletePendingShareInfoById({required String id}) async {
    pendingShareInfos.removeWhere((element) => element.id == id);
  }

  @override
  Future<void> deleteSharedItemById({required String id}) async {
    sharedItems.removeWhere((element) => element.id == id);
  }

  @override
  List<ItemDeleteInfo> findAllItemDeleteInfos() {
    return itemDeleteInfos;
  }

  @override
  List<Item> findAllItems({bool Function(Item p1)? predicate}) {
    if (predicate == null) {
      return items;
    } else {
      return items.where(predicate).toList(growable: false);
    }
  }

  @override
  Future<void> updateItem({required Item item}) async {
    throw UnimplementedError();
  }
}
