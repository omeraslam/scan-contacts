import 'package:hive/hive.dart';

 part 'contact_images.g.dart';

@HiveType(typeId: 2)
class ContactImagesModel {
  @HiveField(0)
  final frontImage;
  @HiveField(1)
  final backImage2;

  ContactImagesModel({
    this.frontImage,
    this.backImage2,
  });
}
