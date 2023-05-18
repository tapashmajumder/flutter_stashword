import 'dart:async';
import 'dart:convert';

import 'package:Stashword/data/hive_image.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'item.dart';
import 'item_delete_info.dart';
import 'pending_share_info.dart';

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

  static const String _encryptionKeyName = 'encryptionKey';

  static const imageCrud = HiveImageCrud();

  static final List<Crud> _cruds = [
    imageCrud,
  ];

  static Future<void> init({String? subdir}) async {
    await Hive.initFlutter(subdir);
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(ItemDeleteInfoAdapter());
    Hive.registerAdapter(PendingShareInfoAdapter());
    for (var crud in _cruds) {
      Hive.registerAdapter(crud.adapter);
    }
  }

  static Future<void> open({ISecureStorage secureStorage = const ProdSecureStorage()}) async {
    final String encryptionKeyString = await secureStorage.read(key: _encryptionKeyName) ?? await _generateAndStoreEncryptionKey(secureStorage);
    final encryptionKey = base64Url.decode(encryptionKeyString);
    final encryptionCipher = HiveAesCipher(encryptionKey);
    await Hive.openBox<Item>(_itemBoxName, encryptionCipher: encryptionCipher);
    await Hive.openBox<ItemDeleteInfo>(_itemDeleteInfoBoxName);
    await Hive.openBox<PendingShareInfo>(_pendingShareInfoBoxName, encryptionCipher: encryptionCipher);
    for (var crud in _cruds) {
      await crud.openBox(encryptionCipher: encryptionCipher);
    }
  }

  static Box<Item> getItemBox() {
    return Hive.box<Item>(_itemBoxName);
  }

  static Box<ItemDeleteInfo> getItemDeleteInfoBox() {
    return Hive.box<ItemDeleteInfo>(_itemDeleteInfoBoxName);
  }

  static Box<PendingShareInfo> getPendingShareInfoBox() {
    return Hive.box<PendingShareInfo>(_pendingShareInfoBoxName);
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


class ItemCrud {
  static Future<void> create(Item item) async {
    final box = Database.getItemBox();
    await box.put(item.id, item);
  }

  static Item? find(String id) {
    final box = Database.getItemBox();
    return box.get(id);
  }

  static Future<void> update(Item item) async {
    final box = Database.getItemBox();
    await box.put(item.id, item);
  }

  static Future<void> delete(String id) async {
    final box = Database.getItemBox();
    await box.delete(id);
  }
}

class ItemDeleteInfoCrud {
  static Future<void> create(ItemDeleteInfo deleteInfo) async {
    final box = Database.getItemDeleteInfoBox();
    await box.put(deleteInfo.id, deleteInfo);
  }

  static ItemDeleteInfo? find(String id) {
    final box = Database.getItemDeleteInfoBox();
    return box.get(id);
  }

  static Future<void> update(ItemDeleteInfo deleteInfo) async {
    final box = Database.getItemDeleteInfoBox();
    await box.put(deleteInfo.id, deleteInfo);
  }

  static Future<void> delete(String id) async {
    final box = Database.getItemDeleteInfoBox();
    await box.delete(id);
  }
}

class PendingShareInfoCrud {
  static Future<void> create(PendingShareInfo object) async {
    final box = Database.getPendingShareInfoBox();
    await box.put(object.id, object);
  }

  static PendingShareInfo? find(String id) {
    final box = Database.getPendingShareInfoBox();
    return box.get(id);
  }

  static Future<void> update(PendingShareInfo object) async {
    final box = Database.getPendingShareInfoBox();
    await box.put(object.id, object);
  }

  static Future<void> delete(String id) async {
    final box = Database.getPendingShareInfoBox();
    await box.delete(id);
  }
}

abstract class WithId {
  String get id;
}

abstract class Crud<T extends WithId> {
  const Crud();

  bool get encrypted;
  String get boxName;
  TypeAdapter<T> get adapter;

  Future<void> openBox({required HiveAesCipher encryptionCipher}) async {
    if (encrypted) {
      await Hive.openBox<T>(boxName, encryptionCipher: encryptionCipher);
    } else {
      await Hive.openBox<T>(boxName);
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

class HiveImageCrud extends Crud<HiveImage> {
  const HiveImageCrud();

  @override
  TypeAdapter<HiveImage> get adapter => HiveImageAdapter();

  @override
  String get boxName => Database._imageBoxName;

  @override
  bool get encrypted => true;
}
