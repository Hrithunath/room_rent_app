// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomModelAdapter extends TypeAdapter<RoomModel> {
  @override
  final int typeId = 1;

  @override
  RoomModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomModel(
      room: fields[1] as String,
      floor: fields[2] as String,
      guests: fields[3] as String,
      bed: fields[4] as String,
      rent: fields[5] as String,
      image: fields[6] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RoomModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.room)
      ..writeByte(2)
      ..write(obj.floor)
      ..writeByte(3)
      ..write(obj.guests)
      ..writeByte(4)
      ..write(obj.bed)
      ..writeByte(5)
      ..write(obj.rent)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
