import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:Stashword/data/database.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/data/pending_share_info.dart';
import 'package:Stashword/data/hive_image.dart';

void main() {
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    await Database.init(subdir: "hive_db_dir");
    await Database.open(secureStorage: DevSecureStorage());
  });

  tearDownAll(() async {
    await Database.close();
    await Hive.close();
  });

  group('Item CRUD Tests', () {
    testWidgets('Create and Retrieve Item', (WidgetTester tester) async {
      const id = "id1";
      const addToWatch = true;
      const blob = "zee-blob";
      const colorIndex = 22;
      final created = DateTime.timestamp();
      const itemType = "password";
      const iv = "iv1";
      final lastUsed = DateTime.timestamp();
      final modified = DateTime.timestamp();
      const shared = true;
      const sharedSecret = "zee-shared-secret";

      final object = Item(id: id, itemType: itemType, iv: iv);
      object.addToWatch = addToWatch;
      object.blob = blob;
      object.colorIndex = colorIndex;
      object.created = created;
      object.lastUsed = lastUsed;
      object.modified = modified;
      object.shared = shared;
      object.sharedSecret = sharedSecret;
      await tester.runAsync(() => ItemCrud.create(object));

      final found = ItemCrud.find(id);
      expect(found?.id, equals(id));
      expect(found?.itemType, itemType);
      expect(found?.created, created);
      expect(found?.addToWatch, addToWatch);
      expect(found?.blob, blob);
      expect(found?.colorIndex, colorIndex);
      expect(found?.iv, iv);
      expect(found?.lastUsed, lastUsed);
      expect(found?.modified, modified);
      expect(found?.shared, shared);
      expect(found?.sharedSecret, sharedSecret);
    });

    testWidgets('Update Item', (WidgetTester tester) async {
      const id = "id1";
      const itemType = "password";
      const iv = "iv1";
      final object = Item(id: id, itemType: itemType, iv: iv);
      await tester.runAsync(() => ItemCrud.create(object));

      var updated = Item(id: id, itemType: itemType, iv: itemType);
      updated.shared = true;
      updated.sharedSecret = "SharedSecret";
      await tester.runAsync(() => ItemCrud.update(updated));

      final found = ItemCrud.find(id);
      expect(found?.shared, equals(true));
      expect(found?.sharedSecret, "SharedSecret");
    });

    testWidgets('Delete Person', (WidgetTester tester) async {
      const id = "id1";
      const itemType = "password";
      const iv = "iv1";
      final object = Item(id: id, iv: iv, itemType: itemType);
      await tester.runAsync(() => ItemCrud.create(object));

      await tester.runAsync(() => ItemCrud.delete(id));

      final found = ItemCrud.find(id);
      expect(found, isNull);
    });
  });

  group('ItemDeleteInfo CRUD Tests', () {
    testWidgets('Create and Retrieve ItemDeleteInfo', (WidgetTester tester) async {
      const id = "id1";
      final deleteDate = DateTime.timestamp();
      final object = ItemDeleteInfo(id: id, deleteDate: deleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.create(object));

      final found = ItemDeleteInfoCrud.find(id);
      expect(found?.id, equals(id));
      expect(found?.deleteDate, deleteDate);
    });

    testWidgets('Update ItemDeleteInfo', (WidgetTester tester) async {
      const id = "id1";
      final deleteDate = DateTime.timestamp();
      final object = ItemDeleteInfo(id: id, deleteDate: deleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.create(object));

      final newDeleteDate = DateTime.timestamp();
      final updated = ItemDeleteInfo(id: id, deleteDate: newDeleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.update(updated));

      final found = ItemDeleteInfoCrud.find(id);
      expect(found?.deleteDate, equals(newDeleteDate));
    });

    testWidgets('Delete ItemDeleteInfo', (WidgetTester tester) async {
      const id = "id1";
      final deleteDate = DateTime.timestamp();
      final object = ItemDeleteInfo(id: id, deleteDate: deleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.create(object));

      await tester.runAsync(() => ItemDeleteInfoCrud.delete(id));

      final found = ItemDeleteInfoCrud.find('1');
      expect(found, isNull);
    });
  });

  group('PendingShareInfo CRUD Tests', () {
    testWidgets('Create and Retrieve PendingShareInfo', (WidgetTester tester) async {
      const itemType = "password";
      const id = "id1";
      const iv = "iv1";
      const sharer = "sharer1@gmail.com";
      const shareStatus = "pendingApproval";
      const sharedSecret = "zee-shared-secret";
      final object = PendingShareInfo(
        itemType: itemType,
        id: id,
        iv: iv,
        sharer: sharer,
        shareStatus: shareStatus,
      );
      object.sharedSecret = sharedSecret;
      await tester.runAsync(() => PendingShareInfoCrud.create(object));

      final found = PendingShareInfoCrud.find(id);
      expect(found?.id, equals(id));
      expect(found?.itemType, equals(itemType));
      expect(found?.iv, equals(iv));
      expect(found?.sharer, equals(sharer));
      expect(found?.shareStatus, equals(shareStatus));
      expect(found?.sharedSecret, equals(sharedSecret));
      expect(found?.blob, isNull);
    });

    testWidgets('Update PendingShareInfo', (WidgetTester tester) async {
      const itemType = "password";
      const id = "id1";
      const iv = "iv1";
      const sharer = "sharer1@gmail.com";
      const shareStatus = "pendingApproval";
      const sharedSecret = "zee-shared-secret";
      const blob = "zee-blob";
      final object = PendingShareInfo(
        itemType: itemType,
        id: id,
        iv: iv,
        sharer: sharer,
        shareStatus: shareStatus,
      );
      object.blob = blob;
      await tester.runAsync(() => PendingShareInfoCrud.create(object));

      const newShareStatus = "new-share-status";
      const newBlob = "new-blob";
      final updated = PendingShareInfo(
        itemType: itemType,
        id: id,
        iv: iv,
        sharer: sharer,
        shareStatus: newShareStatus,
      );
      updated.blob = newBlob;
      updated.sharedSecret = sharedSecret;
      await tester.runAsync(() => PendingShareInfoCrud.update(updated));

      final found = PendingShareInfoCrud.find(id);
      expect(found?.id, equals(id));
      expect(found?.blob, equals(newBlob));
      expect(found?.itemType, equals(itemType));
      expect(found?.iv, equals(iv));
      expect(found?.sharedSecret, equals(sharedSecret));
      expect(found?.sharer, equals(sharer));
      expect(found?.shareStatus, equals(newShareStatus));
    });

    testWidgets('Delete PendingShareInfo', (WidgetTester tester) async {
      const itemType = "password";
      const id = "id1";
      const iv = "iv1";
      const sharer = "sharer1@gmail.com";
      const shareStatus = "pendingApproval";
      const sharedSecret = "zee-shared-secret";
      const blob = "zee-blob";
      final object = PendingShareInfo(
        itemType: itemType,
        id: id,
        iv: iv,
        sharer: sharer,
        shareStatus: shareStatus,
      );
      object.blob = blob;
      object.sharedSecret = sharedSecret;
      await tester.runAsync(() => PendingShareInfoCrud.create(object));

      await tester.runAsync(() => PendingShareInfoCrud.delete(id));
      final found = PendingShareInfoCrud.find(id);
      expect(found, isNull);
    });
  });

  group('HiveImage CRUD Tests', () {
    testWidgets('Create and Retrieve HiveImage', (WidgetTester tester) async {
      const crud = Database.imageCrud;

      const List<int> list = [10, 5, 20, 40];
      final data = Uint8List.fromList(list);
      const id = "item1-image1";
      const itemId = "item1";
      final object = HiveImage(
        id: id,
        itemId: itemId,
      );
      object.data = data;
      await tester.runAsync(() => crud.create(object));

      final found = crud.find(id);
      expect(found?.id, equals(id));
      expect(found?.itemId, equals(itemId));
      expect(found?.data, equals(data));
    });

    testWidgets('Update HiveImage', (WidgetTester tester) async {
      const crud = Database.imageCrud;

      const List<int> list = [10, 5, 20, 40];
      final data = Uint8List.fromList(list);
      const id = "item1-image1";
      const itemId = "item1";
      final object = HiveImage(
        id: id,
        itemId: itemId,
      );
      object.data = data;
      await tester.runAsync(() => crud.create(object));

      const List<int> newList = [10, 5, 20, 40, 50, 60];
      final newData = Uint8List.fromList(newList);
      final updated = HiveImage(
        id: id,
        itemId: itemId,
      );
      updated.data = newData;
      await tester.runAsync(() => crud.update(updated));

      final found = crud.find(id);
      expect(found?.id, equals(id));
      expect(found?.itemId, equals(itemId));
      expect(found?.data, equals(newData));
    });

    testWidgets('Delete HiveImage', (WidgetTester tester) async {
      const crud = Database.imageCrud;

      const List<int> list = [10, 5, 20, 40];
      final data = Uint8List.fromList(list);
      const id = "item1-image1";
      const itemId = "item1";
      final object = HiveImage(
        id: id,
        itemId: itemId,
      );
      object.data = data;
      await tester.runAsync(() => crud.create(object));

      await tester.runAsync(() => crud.delete(id));
      final found = crud.find(id);
      expect(found, isNull);
    });
  });
}

class DevSecureStorage implements ISecureStorage {
  final Map _map = HashMap<String, String?>();

  DevSecureStorage();

  @override
  Future<String?> read({required String key}) async {
    return _map[key];
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    _map[key] = value;
  }
}


class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  static String kTemporaryPath = 'temporaryPath';
  static String kApplicationSupportPath = 'applicationSupportPath';
  static String kDownloadsPath = 'downloadsPath';
  static String kLibraryPath = 'libraryPath';
  static String kApplicationDocumentsPath = 'test';
  static String kExternalCachePath = 'externalCachePath';
  static String kExternalStoragePath = 'externalStoragePath';

  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}
