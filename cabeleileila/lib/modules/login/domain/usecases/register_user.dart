import 'package:cabeleileila/modules/login/domain/entities/user.dart';
import 'package:cabeleileila/modules/login/domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<int> call(User user) {
    return repository.registerUser(user);
  }
}
