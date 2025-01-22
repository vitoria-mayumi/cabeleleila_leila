import 'package:cabeleileila/modules/login/data/datasources/sqlite_datasource.dart';
import 'package:cabeleileila/modules/login/domain/entities/user.dart';
import 'package:cabeleileila/modules/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SQLiteDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<int> registerUser(User user) async {
    final db = await datasource.database;

    return db.insert('users', {
      'name': user.nickName,
      'contactNumber': user.contactNumber,
      'username': user.username,
      'password': user.password,
      'userType': user.userType,
    });
  }

  @override
  Future<User?> loginUser(String username, String password) async {
    final db = await datasource.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [
        username,
        password
      ],
    );

    if (result.isNotEmpty) {
      return User(
        id: result.first['id'] as int,
        username: result.first['username'] as String,
        password: result.first['password'] as String,
        userType: result.first['userType'] as String,
        contactNumber: result.first['contactNumber'] as String,
        nickName: result.first['name'] as String,
      );
    }

    return null;
  }
}
