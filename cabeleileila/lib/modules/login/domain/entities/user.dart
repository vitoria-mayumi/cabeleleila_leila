class User {
  final int? id;
  final String username;
  final String password;
  final String userType;
  final String contactNumber;
  final String nickName;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.userType,
    required this.contactNumber,
    required this.nickName,
  });
}
