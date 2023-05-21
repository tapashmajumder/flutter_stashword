import 'package:hive/hive.dart';

import 'data_utils.dart';

part 'pending_share_info.g.dart';

@HiveType(typeId: 2)
class PendingShareInfo implements WithId {
  @override
  @HiveField(0)
  String id;

  @HiveField(1)
  String? blob;

  @HiveField(2)
  String itemType;

  @HiveField(3)
  String iv;

  @HiveField(4)
  String? sharedSecret;

  @HiveField(5)
  String sharer;

  @HiveField(6)
  String shareStatus;

  PendingShareInfo({
    required this.itemType,
    required this.id,
    required this.iv,
    required this.sharer,
    required this.shareStatus,
  });

  @override
  String toString() {
    return 'PendingShareInfo(id: $id)';
  }
}
