// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactModelAdapter extends TypeAdapter<ContactModel> {
  @override
  ContactModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactModel(
      frontImage: fields[0] as dynamic,
      backImage2: fields[1] as dynamic,
      userName: fields[2] as String,
      companyName: fields[3] as String,
      email: fields[4] as String,
      companyEmail: fields[5] as String,
      address: fields[6] as String,
      mobileNumber: fields[7] as String,
      companyNumber: fields[8] as String,
      designations: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.frontImage)
      ..writeByte(1)
      ..write(obj.backImage2)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.companyName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.companyEmail)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.mobileNumber)
      ..writeByte(8)
      ..write(obj.companyNumber)
      ..writeByte(9)
      ..write(obj.designations);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
