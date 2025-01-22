import 'package:cabeleileila/modules/login/domain/entities/user.dart';
import 'package:cabeleileila/modules/login/domain/repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String username, String password) {
    return repository.loginUser(username, password);
  }
}
