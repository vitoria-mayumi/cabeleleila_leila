import 'package:cabeleileila/model/users/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  //* cria uma instancia da coleção(tabela) users

  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _usersReference;

  UsersService() {
    _usersReference = _firestore.collection("users").withConverter<Users>(
        fromFirestore: (snapshots, _) => Users.fromJson(snapshots.data()!),
        toFirestore: (users, _) => users.toJson());
  }

  Stream<QuerySnapshot> getAllUsers() {
    return _usersReference.snapshots();
  }

  void addUsers(Users users) async {
    _usersReference.add(users);
  }

  void updateUsers(String idUsers, Users users) {
    _usersReference.doc(idUsers).update(users.toJson());
  }

  void deleteUsers(String idUsers) {
    _usersReference.doc(idUsers).delete();
  }

  Future<int?> getLastId() async {
    final query =
        await _usersReference.orderBy('id', descending: true).limit(1).get();

    final lastUser = query.docs.first.data() as Users;
    return lastUser.id;
  }

  Future<bool> userAuthentication(String userName, String password) async {
    final query = await _usersReference
        .where('userName', isEqualTo: userName)
        .where('password', isEqualTo: password)
        .get();

    return query.docs.isNotEmpty;
  }
}
