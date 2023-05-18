import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:Stashword/data/database.dart';
import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';

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
      final item = Item(id: "1", itemType: "Password", iv: "iv1");
      final created = DateTime.timestamp();
      item.created = created;
      await tester.runAsync(() => ItemCrud.create(item));

      final found = ItemCrud.find("1");
      expect(found?.id, equals("1"));
      expect(found?.itemType, "Password");
      expect(found?.created, created);
    });

    testWidgets('Update Item', (WidgetTester tester) async {
      final item = Item(id: '1', itemType: "Password", iv: "iv1");
      await tester.runAsync(() => ItemCrud.create(item));

      var updated = Item(id: '1', itemType: "Password", iv: "iv1");
      updated.shared = true;
      updated.sharedSecret = "SharedSecret";
      await tester.runAsync(() => ItemCrud.update(updated));

      final found = ItemCrud.find('1');
      expect(found?.shared, equals(true));
      expect(found?.sharedSecret, "SharedSecret");
    });

    testWidgets('Delete Person', (WidgetTester tester) async {
      final item = Item(id: '1', iv: 'iv1', itemType: "Password");
      await tester.runAsync(() => ItemCrud.create(item));

      await tester.runAsync(() => ItemCrud.delete("1"));

      final found = ItemCrud.find('1');
      expect(found, isNull);
    });
  });

  group('ItemDeleteInfo CRUD Tests', () {
    testWidgets('Create and Retrieve ItemDeleteInfo', (WidgetTester tester) async {
      final deleteDate = DateTime.timestamp();
      final itemDeleteInfo = ItemDeleteInfo(id: "1", deleteDate: deleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.create(itemDeleteInfo));

      final found = ItemDeleteInfoCrud.find("1");
      expect(found?.id, equals("1"));
      expect(found?.deleteDate, deleteDate);
    });

    testWidgets('Update ItemDeleteInfo', (WidgetTester tester) async {
      final deleteDate = DateTime.timestamp();
      final itemDeleteInfo = ItemDeleteInfo(id: '1', deleteDate: deleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.create(itemDeleteInfo));

      final newDeleteDate = DateTime.timestamp();
      final updated = ItemDeleteInfo(id: '1', deleteDate: newDeleteDate);
      await tester.runAsync(() => ItemDeleteInfoCrud.update(updated));

      final found = ItemDeleteInfoCrud.find('1');
      expect(found?.deleteDate, equals(newDeleteDate));
    });

    testWidgets('Delete ItemDeleteInfo', (WidgetTester tester) async {
      final itemDeleteInfo = ItemDeleteInfo(id: '1', deleteDate: DateTime.timestamp());
      await tester.runAsync(() => ItemDeleteInfoCrud.create(itemDeleteInfo));

      await tester.runAsync(() => ItemDeleteInfoCrud.delete("1"));

      final found = ItemDeleteInfoCrud.find('1');
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
