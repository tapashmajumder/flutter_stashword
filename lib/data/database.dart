import 'dart:async';
import 'dart:convert';

import 'package:Stashword/data/hive_image.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'item.dart';
import 'item_delete_info.dart';
import 'pending_share_info.dart';
import 'shared_item.dart';

abstract interface class ISecureStorage {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String? value});
}

class ProdSecureStorage implements ISecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  const ProdSecureStorage();

  @override
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    await _secureStorage.write(key: key, value: value);
  }
}

class Database {
  static const String _itemBoxName = 'items';
  static const String _itemDeleteInfoBoxName = "item_delete_infos";
  static const String _pendingShareInfoBoxName = "pending_share_infos";
  static const String _imageBoxName = "images";
  static const String _sharedItemBoxName = 'shared_items';

  static const String _encryptionKeyName = 'encryptionKey';

  static const itemCrud = ItemCrud();
  static const imageCrud = HiveImageCrud();
  static const sharedItemCrud = SharedItemCrud();
  static const itemDeleteInfoCrud = ItemDeleteInfoCrud();
  static const pendingShareInfoCrud = PendingShareInfoCrud();

  static final List<Crud> _cruds = [
    itemCrud,
    imageCrud,
    sharedItemCrud,
    itemDeleteInfoCrud,
    pendingShareInfoCrud,
  ];

  static Future<void> init({String? subdir}) async {
    await Hive.initFlutter(subdir);

    for (var crud in _cruds) {
       crud.registerAdapter();
    }
  }

  static Future<void> open({ISecureStorage secureStorage = const ProdSecureStorage()}) async {
    final String encryptionKeyString = await secureStorage.read(key: _encryptionKeyName) ?? await _generateAndStoreEncryptionKey(secureStorage);
    final encryptionKey = base64Url.decode(encryptionKeyString);
    final encryptionCipher = HiveAesCipher(encryptionKey);

    for (var crud in _cruds) {
      await crud.openBox(encryptionCipher: encryptionCipher);
    }
  }

  static Future<void> close() async {
    await Hive.close();
  }

  static Future<String> _generateAndStoreEncryptionKey(ISecureStorage secureStorage) async {
    final key = base64Url.encode(Hive.generateSecureKey());
    await secureStorage.write(key: _encryptionKeyName, value: key);
    return key;
  }
}

class ItemCrud extends Crud<Item> {
  const ItemCrud();

  @override
  String get boxName => Database._itemBoxName;

  @override
  bool get encrypted => true;

  @override
  void registerAdapter() {
    Hive.registerAdapter(ItemAdapter());
  }
}

class ItemDeleteInfoCrud extends Crud<ItemDeleteInfo> {
  const ItemDeleteInfoCrud();

  @override
  String get boxName => Database._itemDeleteInfoBoxName;

  @override
  bool get encrypted => false;

  @override
  void registerAdapter() {
    Hive.registerAdapter(ItemDeleteInfoAdapter());
  }
}

class PendingShareInfoCrud extends Crud<PendingShareInfo> {
  const PendingShareInfoCrud();

  @override
  String get boxName => Database._pendingShareInfoBoxName;

  @override
  bool get encrypted => true;

  @override
  void registerAdapter() {
    Hive.registerAdapter(PendingShareInfoAdapter());
  }
}

class HiveImageCrud extends Crud<HiveImage> {
  const HiveImageCrud();

  @override
  String get boxName => Database._imageBoxName;

  @override
  bool get encrypted => true;

  @override
  void registerAdapter() {
    Hive.registerAdapter(HiveImageAdapter());
  }
}

class SharedItemCrud extends Crud<SharedItem> {
  const SharedItemCrud();

  @override
  String get boxName => Database._sharedItemBoxName;

  @override
  bool get encrypted => true;

  @override
  void registerAdapter() {
    Hive.registerAdapter(SharedItemAdapter());
  }
}

abstract class WithId {
  String get id;
}

abstract class Crud<T extends WithId> {
  const Crud();

  bool get encrypted;
  String get boxName;
  void registerAdapter();

  Future<void> openBox({required HiveAesCipher encryptionCipher}) async {
    if (encrypted) {
      await Hive.openBox<T>(boxName, encryptionCipher: encryptionCipher);
    } else {
      await Hive.openBox<T>(boxName);
    }
  }

  List<T> findAll({bool Function(T)? predicate}) {
    final box = _getBox();
    if (predicate == null) {
      return box.values.toList(growable: false);
    } else {
      return box.values.where(predicate).toList(growable: false);
    }
  }

  Future<void> create(T object) async {
    final box = _getBox();
    await box.put(object.id, object);
  }

  T? find(String id) {
    final box = _getBox();
    return box.get(id);
  }

  Future<void> update(T object) async {
    final box = _getBox();
    await box.put(object.id, object);
  }

  Future<void> delete(String id) async {
    final box = _getBox();
    await box.delete(id);
  }

  Box<T> _getBox() {
    return Hive.box<T>(boxName);
  }
}
