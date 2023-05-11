import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:Stashword/database.dart';
import 'package:Stashword/item.dart';

void main() {
  group('Item CRUD Tests', () {
    setUpAll(() async {
      PathProviderPlatform.instance = FakePathProviderPlatform();
      await Database.init(subdir: "hive_db_dir");
      await Database.open();
    });

    tearDownAll(() async {
      await Database.close();
      await Hive.close();
    });

    testWidgets('Create and Retrieve Item', (WidgetTester tester) async {
      final item = Item(id: "1", itemType: "Password", iv: "iv1");
      await tester.runAsync(() => ItemCrud.createItem(item));

      final found = ItemCrud.findItem("1");
      expect(found?.id, equals("1"));
      expect(found?.itemType, "Password");
    });

    testWidgets('Update Item', (WidgetTester tester) async {
      final item = Item(id: '1', itemType: "Password", iv: "iv1");
      await tester.runAsync(() => ItemCrud.createItem(item));

      var updated = Item(id: '1', itemType: "Password", iv: "iv1");
      updated.shared = true;
      updated.sharedSecret = "SharedSecret";
      await tester.runAsync(() => ItemCrud.updateItem(updated));

      final found = ItemCrud.findItem('1');
      expect(found?.shared, equals(true));
      expect(found?.sharedSecret, "SharedSecret");
    });

    testWidgets('Delete Person', (WidgetTester tester) async {
      final item = Item(id: '1', iv: 'iv1', itemType: "Password");
      await tester.runAsync(() => ItemCrud.createItem(item));

      await tester.runAsync(() => ItemCrud.deleteItem("1"));

      final found = ItemCrud.findItem('1');
      expect(found, isNull);
    });
  });
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
