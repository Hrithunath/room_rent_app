// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevenueModelAdapter extends TypeAdapter<RevenueModel> {
  @override
  final int typeId = 4;

  @override
  RevenueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevenueModel(
      roomId: fields[0] as int?,
      userId: fields[1] as int?,
      rent: fields[2] as double,
      isOccupied: fields[3] as bool,
      room: fields[4] as String,
      image: fields[5] as String,
      floor: fields[6] as String,
      datePaided: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RevenueModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.roomId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.rent)
      ..writeByte(3)
      ..write(obj.isOccupied)
      ..writeByte(4)
      ..write(obj.room)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.floor)
      ..writeByte(7)
      ..write(obj.datePaided);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevenueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
