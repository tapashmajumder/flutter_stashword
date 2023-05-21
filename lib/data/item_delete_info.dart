import 'package:hive/hive.dart';

import 'data_utils.dart';

part 'item_delete_info.g.dart';

@HiveType(typeId: 1)
class ItemDeleteInfo implements WithId {
  @override
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime deleteDate;

  ItemDeleteInfo({required this.id, required this.deleteDate});

  @override
  String toString() {
    return 'ItemDeleteInfo(id: $id)';
  }
}
