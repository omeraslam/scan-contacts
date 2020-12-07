// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactImagesModelAdapter extends TypeAdapter<ContactImagesModel> {
  @override
  ContactImagesModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactImagesModel(
      frontImage: fields[0] as dynamic,
      backImage2: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ContactImagesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.frontImage)
      ..writeByte(1)
      ..write(obj.backImage2);
  }

  @override
  // TODO: implement typeId
  int get typeId => 2;
}
