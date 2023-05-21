import 'package:hive/hive.dart';

import 'data_utils.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item implements WithId {
  @override
  @HiveField(0)
  String id;

  @HiveField(1)
  bool addToWatch = false;

  @HiveField(2)
  String? blob;

  @HiveField(3)
  int? colorIndex;

  @HiveField(4)
  DateTime? created;

  @HiveField(5)
  String itemType;

  @HiveField(6)
  String iv;

  @HiveField(7)
  DateTime? lastUsed;

  @HiveField(8)
  DateTime? modified;

  @HiveField(9)
  bool shared = false;

  @HiveField(10)
  String? sharedSecret;

  Item({required this.itemType, required this.id, required this.iv});

  @override
  String toString() {
    return 'Item(id: $id)';
  }
}
