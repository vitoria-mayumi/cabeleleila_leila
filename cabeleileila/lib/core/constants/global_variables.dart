import 'package:cabeleileila/modules/login/domain/entities/user.dart';

class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables._internal();

  factory GlobalVariables() {
    return _instance;
  }

  GlobalVariables._internal();

  User? user;
}

final globals = GlobalVariables();
