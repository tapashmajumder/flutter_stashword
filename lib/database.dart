import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'item.dart';

interface class C1 {};

class Database {
  static const String _itemBoxName = 'items';
  static const String _encryptionKeyName = 'encryptionKey';

  static Future<void> init({String? subdir}) async {
    await Hive.initFlutter(subdir);
    Hive.registerAdapter(ItemAdapter());
  }

  static Future<void> open({FlutterSecureStorage secureStorage = const FlutterSecureStorage()}) async {
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

  static Future<String> _generateAndStoreEncryptionKey(FlutterSecureStorage secureStorage) async {
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