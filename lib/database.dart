import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import 'item.dart';

class Database {
  static const String _itemBoxName = 'items';

  static Future<void> init({String? subdir}) async {
    await Hive.initFlutter(subdir);
    Hive.registerAdapter(ItemAdapter());
  }

  static Future<void> open() async {
    await Hive.openBox<Item>(_itemBoxName);
  }

  static Box<Item> getItemBox() {
    return Hive.box<Item>(_itemBoxName);
  }

  static Future<void> close() async {
    await Hive.close();
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