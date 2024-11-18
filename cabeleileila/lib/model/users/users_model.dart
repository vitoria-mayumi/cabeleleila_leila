class Users {
  int? id;
  String name;
  String contactNumber;
  String userName;
  String password;
  String? userType;

  Users({
    this.id,
    required this.name,
    required this.contactNumber,
    required this.userName,
    required this.password,
    this.userType,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      userName: json['userName'],
      password: json['password'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNumber': contactNumber,
      'userName': userName,
      'password': password,
      'userType': userType,
    };
  }
}
