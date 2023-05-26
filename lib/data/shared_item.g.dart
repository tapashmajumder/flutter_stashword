// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SharedItemAdapter extends TypeAdapter<SharedItem> {
  @override
  final int typeId = 4;

  @override
  SharedItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SharedItem(
      itemType: fields[5] as String,
      id: fields[0] as String,
      iv: fields[6] as String,
      sharer: fields[10] as String,
      sharedSecret: fields[9] as String,
      colorIndex: fields[3] as int?,
      addToWatch: fields[1] as bool,
      blob: fields[2] as String?,
      created: fields[4] as DateTime?,
      modified: fields[8] as DateTime?,
      lastUsed: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SharedItem obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.addToWatch)
      ..writeByte(2)
      ..write(obj.blob)
      ..writeByte(3)
      ..write(obj.colorIndex)
      ..writeByte(4)
      ..write(obj.created)
      ..writeByte(5)
      ..write(obj.itemType)
      ..writeByte(6)
      ..write(obj.iv)
      ..writeByte(7)
      ..write(obj.lastUsed)
      ..writeByte(8)
      ..write(obj.modified)
      ..writeByte(9)
      ..write(obj.sharedSecret)
      ..writeByte(10)
      ..write(obj.sharer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SharedItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
