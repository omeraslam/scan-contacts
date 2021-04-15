import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final photoUrl;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String contactNumber;

  UserModel({this.photoUrl, this.userName, this.contactNumber});
}
