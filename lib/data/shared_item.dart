import 'package:hive/hive.dart';

import 'data_utils.dart';

part 'shared_item.g.dart';

@HiveType(typeId: 4)
class SharedItem implements WithId {
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
  String sharedSecret;

  @HiveField(10)
  String sharer;

  SharedItem({
    required this.itemType,
    required this.id,
    required this.iv,
    required this.sharer,
    required this.sharedSecret,
  });

  @override
  String toString() {
    return 'SharedItem(id: $id, sharer: $sharer)';
  }
}
