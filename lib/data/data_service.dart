import 'package:Stashword/data/database.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/data/pending_share_info.dart';
import 'package:Stashword/data/shared_item.dart';

abstract interface class IDataService {
  List<Item> findAllItems({bool Function(Item)? predicate});

  Item? findItemById({required String id});

  Future<void> deleteItemById({required String id});

  List<ItemDeleteInfo> findAllItemDeleteInfos();

  ItemDeleteInfo? findItemDeleteInfoById({required String id});

  Future<void> deleteItemDeleteInfoById({required String id});

  Future<void> createItem({required Item item});

  List<SharedItem> findAllSharedItems();

  Future<void> createSharedItem({required SharedItem sharedItem});

  Future<void> updateSharedItem({required SharedItem sharedItem});

  Future<void> deleteSharedItemById({required String id});

  List<PendingShareInfo> findAllPendingShareInfos();

  Future<void> createPendingShareInfo({required PendingShareInfo shareInfo});

  Future<void> updatePendingShareInfo({required PendingShareInfo shareInfo});

  Future<void> deletePendingShareInfoById({required String id});
}

class DataService implements IDataService {
  final ItemCrud itemCrud;
  final ItemDeleteInfoCrud itemDeleteInfoCrud;
  final SharedItemCrud sharedItemCrud;
  final PendingShareInfoCrud pendingShareInfoCrud;

  const DataService({
    this.itemCrud = Database.itemCrud,
    this.itemDeleteInfoCrud = Database.itemDeleteInfoCrud,
    this.sharedItemCrud = Database.sharedItemCrud,
    this.pendingShareInfoCrud = Database.pendingShareInfoCrud,
  });

  @override
  List<Item> findAllItems({bool Function(Item item)? predicate}) {
    return itemCrud.findAll(predicate: predicate);
  }

  @override
  Future<void> createItem({required Item item}) async {
    await itemCrud.create(item);
  }

  @override
  Future<void> deleteItemById({required String id}) async {
    await itemCrud.delete(id);
  }

  @override
  Future<void> deleteItemDeleteInfoById({required String id}) async {
    await itemDeleteInfoCrud.delete(id);
  }

  @override
  Item? findItemById({required String id}) {
    return itemCrud.find(id);
  }

  @override
  List<ItemDeleteInfo> findAllItemDeleteInfos() {
    return itemDeleteInfoCrud.findAll();
  }

  @override
  ItemDeleteInfo? findItemDeleteInfoById({required String id}) {
    return itemDeleteInfoCrud.find(id);
  }

  @override
  List<SharedItem> findAllSharedItems() {
    return sharedItemCrud.findAll();
  }

  @override
  Future<void> createSharedItem({required SharedItem sharedItem}) async {
    await sharedItemCrud.create(sharedItem);
  }

  @override
  Future<void> updateSharedItem({required SharedItem sharedItem}) async {
    await sharedItemCrud.update(sharedItem);
  }

  @override
  Future<void> deleteSharedItemById({required String id}) async {
    await sharedItemCrud.delete(id);
  }

  @override
  List<PendingShareInfo> findAllPendingShareInfos() {
    return pendingShareInfoCrud.findAll();
  }

  @override
  Future<void> createPendingShareInfo({required PendingShareInfo shareInfo}) async {
    await pendingShareInfoCrud.create(shareInfo);
  }

  @override
  Future<void> updatePendingShareInfo({required PendingShareInfo shareInfo}) async {
    await pendingShareInfoCrud.create(shareInfo);
  }

  @override
  Future<void> deletePendingShareInfoById({required String id}) async {
    await pendingShareInfoCrud.delete(id);
  }
}
