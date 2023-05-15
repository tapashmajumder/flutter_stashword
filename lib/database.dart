import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'item.dart';

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
  static const String _encryptionKeyName = 'encryptionKey';

  static Future<void> init({String? subdir}) async {
    await Hive.initFlutter(subdir);
    Hive.registerAdapter(ItemAdapter());
  }

  static Future<void> open({ISecureStorage secureStorage = const ProdSecureStorage()}) async {
    final String encryptionKeyString = await secureStorage.read(key: _encryptionKeyName) ?? await _generateAndStoreEncryptionKey(secureStorage);
    final encryptionKey = base64Url.decode(encryptionKeyString);
    await Hive.openBox<Item>(_itemBoxName, encryptionCipher: HiveAesCipher(encryptionKey));
  }

  static Box<Item> getItemBox() {
    return Hive.box<Item>(_itemBoxName);
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
  static Future<void> createItem(Item item) async {
    final box = Database.getItemBox();
    await box.put(item.id, item);
  }

  static Item? findItem(String id) {
    final box = Database.getItemBox();
    return box.get(id);
  }

  static Future<void> updateItem(Item item) async {
    final box = Database.getItemBox();
    await box.put(item.id, item);
  }

  static Future<void> deleteItem(String id) async {
    final box = Database.getItemBox();
    await box.delete(id);
  }
}