// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[1] as String,
      phoneNumber: fields[2] as String,
      uploadAdhaar: fields[3] as String,
      occupation: fields[4] as String,
      checkin: fields[5] as String,
      checkout: fields[6] as String,
      advanceAmount: fields[7] as String,
      image: fields[8] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.uploadAdhaar)
      ..writeByte(4)
      ..write(obj.occupation)
      ..writeByte(5)
      ..write(obj.checkin)
      ..writeByte(6)
      ..write(obj.checkout)
      ..writeByte(7)
      ..write(obj.advanceAmount)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
