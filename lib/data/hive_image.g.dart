// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveImageAdapter extends TypeAdapter<HiveImage> {
  @override
  final int typeId = 3;

  @override
  HiveImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveImage(
      id: fields[0] as String,
      itemId: fields[1] as String,
    )..data = fields[2] as Uint8List?;
  }

  @override
  void write(BinaryWriter writer, HiveImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemId)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
