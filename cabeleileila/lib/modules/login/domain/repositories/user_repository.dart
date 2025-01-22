import 'package:cabeleileila/modules/login/domain/entities/user.dart';

abstract class UserRepository {
  Future<int> registerUser(User user);
  Future<User?> loginUser(String username, String password);
}
