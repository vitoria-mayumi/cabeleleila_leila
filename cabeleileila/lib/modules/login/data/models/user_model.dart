import 'package:cabeleileila/modules/login/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.username,
    required super.password,
    required super.contactNumber,
    required super.userType,
    required super.nickName,
  });
}
