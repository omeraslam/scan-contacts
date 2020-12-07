import 'package:hive/hive.dart';
 part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel extends HiveObject {
  @HiveField(0)
  final frontImage;
  @HiveField(1)
  final backImage2;
  @HiveField(2)
  final String userName;
  @HiveField(3)
  final String companyName;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String companyEmail;
  @HiveField(6)
  final String address;
  @HiveField(7)
  final String mobileNumber;
  @HiveField(8)
  final String companyNumber;
  @HiveField(9)
  final String designations;

  ContactModel({
    this.frontImage,
    this.backImage2,
    this.userName,
    this.companyName,
    this.email,
    this.companyEmail,
    this.address,
    this.mobileNumber,
    this.companyNumber,
    this.designations
  });
}
