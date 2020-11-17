// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  UserModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      photoUrl: fields[0] as dynamic,
      userName: fields[1] as String,
      contactNumber: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.photoUrl)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.contactNumber);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
