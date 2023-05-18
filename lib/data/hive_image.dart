import 'dart:typed_data';
import 'package:Stashword/data/database.dart';
import 'package:hive/hive.dart';

part 'hive_image.g.dart';

@HiveType(typeId: 3)
class HiveImage extends WithId {
  @override
  @HiveField(0)
  String id;

  @HiveField(1)
  String itemId;

  @HiveField(2)
  Uint8List? data;

  HiveImage({required this.id, required this.itemId});

  @override
  String toString() {
    return 'HiveImage(id: $id, itemId: $itemId)';
  }
}