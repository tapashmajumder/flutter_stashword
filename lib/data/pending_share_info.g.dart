// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_share_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingShareInfoAdapter extends TypeAdapter<PendingShareInfo> {
  @override
  final int typeId = 2;

  @override
  PendingShareInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingShareInfo(
      itemType: fields[2] as String,
      id: fields[0] as String,
      iv: fields[3] as String,
      sharer: fields[5] as String,
      shareStatus: fields[6] as String,
      blob: fields[1] as String?,
      sharedSecret: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PendingShareInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.blob)
      ..writeByte(2)
      ..write(obj.itemType)
      ..writeByte(3)
      ..write(obj.iv)
      ..writeByte(4)
      ..write(obj.sharedSecret)
      ..writeByte(5)
      ..write(obj.sharer)
      ..writeByte(6)
      ..write(obj.shareStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingShareInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
